import 'dart:async';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/aptos/src/address/address.dart';
import 'package:on_chain/aptos/src/provider/api/models/api_models.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/methods/account/get_account.dart';
import 'package:on_chain/aptos/src/provider/methods/account/get_account_asset_resources.dart';
import 'package:on_chain/aptos/src/provider/methods/general/get_ledger_info.dart';
import 'package:on_chain/aptos/src/provider/methods/graphql/get_account_owned_tokens.dart';
import 'package:on_chain/aptos/src/provider/methods/graphql/get_account_owned_tokens_by_token_data.dart';
import 'package:on_chain/aptos/src/provider/methods/graphql/get_all_delegation_pools.dart';
import 'package:on_chain/aptos/src/provider/methods/graphql/get_current_fungible_asset_balances.dart';
import 'package:on_chain/aptos/src/provider/methods/graphql/get_delegator_distinct_pools.dart';
import 'package:on_chain/aptos/src/provider/methods/graphql/get_fungible_asset_metadata.dart';
import 'package:on_chain/aptos/src/provider/methods/graphql/get_top_delegation_pools.dart';
import 'package:on_chain/aptos/src/provider/methods/transaction/estimate_gas_price.dart';
import 'package:on_chain/aptos/src/provider/methods/transaction/simulate_transaction.dart';
import 'package:on_chain/aptos/src/provider/methods/transaction/submit_transaction.dart';
import 'package:on_chain/aptos/src/provider/methods/transaction/wait_for_transaction_by_hash.dart';
import 'package:on_chain/aptos/src/provider/methods/view/execute_view_function_of_a_module.dart';
import 'package:on_chain/aptos/src/provider/models/fullnode/types.dart';
import 'package:on_chain/aptos/src/provider/models/graphql/queries/queries.dart';
import 'package:on_chain/aptos/src/transaction/constants/const.dart';
import 'package:on_chain/aptos/src/transaction/types/types.dart';
import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/serialization/bcs/move/types/types.dart';

/// Quick client API: one method per top request, each mapped to the correct
/// backend and returning a single unified result type.
///
mixin AptosQuickClientApi {
  /// Fullnode provider: accounts, view functions, ledger, simulation,
  /// submission, waits.
  IProvider<IServiceProvider, AptosRequestDetails> get fullNodeProvider;

  /// Indexer GraphQL provider: fungible-asset balances/metadata, chain id.
  IProvider<IServiceProvider, AptosRequestDetails> get graphQlProvider;

  /// Maximum paginated fungible-asset entries per account (wallet parity).
  static const int maxAccountTokens = 1000;

  /// Native APT balance of [address] via `coin::balance` view function.
  Future<BigInt> getAccountBalance(AptosAddress address) async {
    final r = await fullNodeProvider.request(
      AptosRequestExecuteViewFunctionOfaModule<BigInt>.bcs(
        entry: AptosTransactionEntryFunction(
          moduleId: AptosModuleId(address: AptosAddress.one, name: 'coin'),
          functionName: 'balance',
          typeArgs: [
            AptosTypeTagStruct(
              AptosStructTag(
                address: AptosAddress.one,
                moduleName: 'aptos_coin',
                name: 'AptosCoin',
              ),
            ),
          ],
          args: [address],
        ),
      ),
    );
    return r.first;
  }

  /// Fungible-asset balances of [address], one indexer page ([limit] rows)
  /// per event. Indexer results win; every requested [assetTypes] entry
  /// missing from the indexer is backfilled with a fullnode resource read
  /// and yielded last (wallet parity). Indexer failures end the stream
  /// silently with whatever was already yielded; backfill transport
  /// failures throw.
  Stream<List<AptosFungibleAssetBalance>> watchAccountTokenBalances({
    required AptosAddress address,
    List<String> assetTypes = const [],
    int limit = 50,
  }) async* {
    final seen = <String>{};
    int offset = 0;
    while (true) {
      final r = await graphQlProvider.request(
        AptosGraphQLRequestGetCurrentFungibleAssetBalances(
          variables: AptosGraphQLPaginatedVariablesParams(
            whereCondition: {
              'owner_address': {'_eq': address.address},
              'asset_type': {
                if (assetTypes.isNotEmpty) '_in': assetTypes,
                '_nin': seen.toList(),
              },
            },
            limit: limit,
            offset: offset,
          ),
        ),
      );
      final page = <AptosFungibleAssetBalance>[];
      for (final i in r) {
        final amount = BigintUtils.tryParse(i.amount);
        final assetType = i.assetType;
        if (amount == null || assetType == null) continue;
        if (i.ownerAddress != address.address) {
          final ownerAddress = AptosAddress(i.ownerAddress);
          if (ownerAddress != address) continue;
        }
        seen.add(assetType);
        page.add(
          AptosFungibleAssetBalance(
            balance: amount,
            frozen: i.isFrozen,
            assetType: assetType,
          ),
        );
      }
      if (page.isNotEmpty) yield page;
      if (r.length < limit || offset * limit > maxAccountTokens) break;
      offset++;
    }
    if (assetTypes.isEmpty) return;
    final missing = assetTypes.where((e) => !seen.contains(e)).toList();
    for (final i in missing) {
      final balance = await fullNodeProvider.request(
        AptosRequestGetAccountAssetResources(address: address, assetType: i),
      );
      yield [
        AptosFungibleAssetBalance(
          balance: balance,
          frozen: false,
          assetType: i,
        ),
      ];
    }
  }

  /// Non-APT fungible tokens of [address] with metadata joined in, one
  /// indexer page ([limit] rows) per event.
  ///
  /// Rows whose amount is not an integer (the indexer may render huge
  /// balances in exponent form, which JSON decodes to double) are skipped
  /// instead of throwing — strictly more defensive than the wallet, which
  /// parses them with the throwing [BigintUtils.parse].
  Stream<List<AptosFungibleTokenBalance>> watchAccountFungibleTokens(
    AptosAddress address, {
    int limit = 50,
  }) async* {
    int offset = 0;
    final List<String> nIn = [AptosConstants.aptosCoinAssetType];
    while (true) {
      final r = await graphQlProvider.request(
        AptosGraphQLRequestGetCurrentFungibleAssetBalances(
          variables: AptosGraphQLPaginatedVariablesParams(
            whereCondition: {
              'owner_address': {'_eq': address.address},
              'asset_type': {'_nin': nIn},
            },
            limit: limit,
            offset: offset,
          ),
        ),
      );
      final metadata = await graphQlProvider.request(
        AptosGraphQLRequestGetFungibleAssetMetadata(
          variables: AptosGraphQLPaginatedVariablesParams(
            whereCondition: {
              'asset_type': {'_in': r.map((e) => e.assetType).toList()},
            },
          ),
        ),
      );
      final page = <AptosFungibleTokenBalance>[];
      for (final i in metadata) {
        AptosGraphQLFungibleAssetBalance? token;
        for (final e in r) {
          if (e.assetType == i.assetType) {
            token = e;
            break;
          }
        }
        if (token == null ||
            token.assetType == AptosConstants.aptosCoinAssetType) {
          continue;
        }
        final balance = _parseBalanceAmount(token.amount);
        if (balance == null) continue;
        page.add(
          AptosFungibleTokenBalance(
            balance: balance,
            assetType: i.assetType,
            isFrozen: token.isFrozen,
            name: i.name,
            symbol: i.symbol,
            decimals: i.decimals,
            iconUri: i.iconUri,
          ),
        );
      }
      if (page.isNotEmpty) yield page;
      if (r.length < limit || offset * limit > maxAccountTokens) break;
      offset++;
      nIn.addAll([
        for (final e in r)
          if (e.assetType != null) e.assetType!,
      ]);
    }
  }

  /// Sequence number of [address].
  Future<BigInt> getAccountSequence(AptosAddress address) async {
    final r = await fullNodeProvider.request(
      AptosRequestGetAccount(address: address),
    );
    return r.sequenceNumber;
  }

  /// Current gas unit price estimate.
  Future<BigInt> getGasUnitPrice() async {
    final r = await fullNodeProvider.request(AptosRequestEstimateGasPrice());
    return BigInt.from(r.gasEstimate);
  }

  /// Chain id from the fullnode ledger info.
  Future<int> getChainId() async {
    final info = await fullNodeProvider.request(AptosRequestGetLedgerInfo());
    return info.chainId;
  }

  /// Fullnode ledger info (chain id, epoch, versions, ...).
  Future<AptosApiLedgerInfo> getLedgerInfo() async {
    return fullNodeProvider.request(AptosRequestGetLedgerInfo());
  }

  /// Simulates [rawTransaction]; returns the first simulated user
  /// transaction (wallet parity).
  Future<AptosApiUserTransaction> simulateTransaction({
    required AptosRawTransaction rawTransaction,
    required AptosTransactionAuthenticator authenticator,
    AptosAddress? feePayer,
    List<AptosAddress>? secondarySignerAddresses,
  }) async {
    final signedTransaction = AptosSignedTransaction(
      rawTransaction: rawTransaction,
      authenticator: authenticator,
    );
    final r = await fullNodeProvider.request(
      AptosRequestSimulateTransaction(
        signedTransactionData: signedTransaction.toBcs(),
        estimateMaxGasAmount: true,
        estimateGasUnitPrice: true,
      ),
    );
    return r.first;
  }

  /// Submits [signedTx]; answers the server hash (or the locally computed
  /// hash when the response carries none) plus whether it was accepted.
  /// Undecodable bodies fall back to the local hash; transport failures
  /// throw.
  Future<AptosSubmitResult> submitTransaction(
    AptosSignedTransaction signedTx,
  ) async {
    try {
      final r = await fullNodeProvider.request(
        AptosRequestSubmitTransaction(signedTransactionData: signedTx.toBcs()),
      );
      return AptosSubmitResult(hash: r.hash, submitted: true);
    } on BuError catch (e) {
      if (e.type != DefaultErrorType.badJson) rethrow;
      return AptosSubmitResult(hash: signedTx.txHash(), submitted: false);
    }
  }

  /// Status of a transaction by hash: failed when the looked-up user
  /// transaction reports `success: false`, block otherwise (wallet parity).
  /// Malformed responses throw instead of degrading to block.
  Future<AptosTxStatus> transactionStatus(String txHash) async {
    final tx = await fullNodeProvider.request(
      AptosRequestWaitForTransactionByHash(txHash),
    );
    if (tx is AptosApiUserTransaction && !tx.success) {
      return AptosTxStatus.failed;
    }
    return AptosTxStatus.block;
  }

  /// Coin balance of [owner] for [assetType] via fullnode resource read.
  Future<BigInt> getCoinBalance({
    required AptosAddress owner,
    required String assetType,
  }) async {
    return fullNodeProvider.request(
      AptosRequestGetAccountAssetResources(
        address: owner,
        assetType: assetType,
      ),
    );
  }

  /// Latest block height, or null when the ledger info carries no parseable
  /// height.
  Future<BigInt?> getBlockHeight() async {
    final info = await getLedgerInfo();
    return BigintUtils.tryParse(info.blockHeight);
  }

  /// Builds an unsigned [AptosRawTransaction] for [entry], fetching sequence,
  /// chain id and (unless given) gas price concurrently. Expiry defaults to
  /// 10 minutes from now.
  Future<AptosRawTransaction> buildTransaction({
    required AptosAddress sender,
    required AptosTransactionEntryFunction entry,
    BigInt? maxGasAmount,
    BigInt? gasPrice,
    BigInt? expirationTimestampSecs,
  }) async {
    final results = await Future.wait([
      getAccountSequence(sender),
      getChainId(),
      if (gasPrice == null) getGasUnitPrice(),
    ]);
    final sequence = results[0] as BigInt;
    final chainId = results[1] as int;
    final price = gasPrice ?? results[2] as BigInt;
    return AptosRawTransaction(
      sender: sender,
      sequenceNumber: sequence,
      transactionPayload: AptosTransactionPayloadEntryFunction(
        entryFunction: entry,
      ),
      maxGasAmount: maxGasAmount ?? AptosConstants.defaultMaxGasAmount,
      gasUnitPrice: price,
      expirationTimestampSecs:
          expirationTimestampSecs ??
          BigInt.from(DateTime.now().millisecondsSinceEpoch ~/ 1000 + 600),
      chainId: chainId,
    );
  }

  /// Polls until [transactionId] succeeds, throwing with the `vmStatus` when
  /// it fails or on [timeout].
  Future<void> trackTransaction({
    required String transactionId,
    Duration timeout = const Duration(minutes: 2),
    Duration periodicTimeOut = const Duration(seconds: 3),
  }) async {
    Timer? timer;
    try {
      final Completer<void> completer = Completer<void>();
      timer = Timer.periodic(periodicTimeOut, (_) async {
        if (completer.isCompleted) return;
        try {
          final receipt = await fullNodeProvider.request(
            AptosRequestWaitForTransactionByHash(transactionId),
          );
          if (receipt is AptosApiUserTransaction) {
            if (receipt.success) {
              completer.complete();
            } else {
              completer.completeError(
                BuError(
                  OnChainErrorType.aptosPlugin,
                  'Aptos transaction failed.',
                  details: {'vmStatus': receipt.vmStatus},
                ),
              );
            }
          }
        } catch (_) {}
      });
      await completer.future.timeout(timeout);
    } on TimeoutException {
      throw BuError(
        OnChainErrorType.aptosPlugin,
        'Transaction confirmation failed within the allotted timeout.',
        details: {'transactionId': transactionId},
      );
    } finally {
      timer?.cancel();
      timer = null;
    }
  }

  /// Fungible-asset metadata for [assetType], or null when the asset has no
  /// indexed metadata. Transport failures throw.
  Future<AptosFungibleAssetMetadata?> getFungibleAssetMetadata(
    String assetType,
  ) async {
    final r = await graphQlProvider.request(
      AptosGraphQLRequestGetFungibleAssetMetadata(
        variables: AptosGraphQLPaginatedVariablesParams(
          whereCondition: {
            'asset_type': {'_eq': assetType},
          },
          limit: 1,
        ),
      ),
    );
    final info = _metadataForAsset(r, assetType);
    if (info == null) return null;
    return AptosFungibleAssetMetadata(
      assetType: info.assetType,
      name: info.name,
      symbol: info.symbol,
      decimals: info.decimals,
      iconUri: info.iconUri,
    );
  }

  /// Digital Asset NFT discovery: v2 singly-held non-fungible ownerships
  /// of [owner], one indexer page ([limit] rows) per event. Fungible assets
  /// and entries without token data stay out.
  Stream<List<AptosAccountNFT>> watchAccountNFTs(
    AptosAddress owner, {
    int limit = 50,
  }) async* {
    int offset = 0;
    while (true) {
      final r = await graphQlProvider.request(
        AptosGraphQLRequestGetAccountOwnedTokens(
          variables: AptosGraphQLPaginatedWithOrderVariablesParams(
            whereCondition: {
              'owner_address': {'_eq': owner.address},
              'token_standard': {'_eq': 'v2'},
              'amount': {'_gt': 0},
            },
            limit: limit,
            offset: offset,
          ),
        ),
      );
      final page = <AptosAccountNFT>[];
      for (final ownership in r) {
        final amount = BigintUtils.tryParse(ownership.amount.toString());
        if (amount != BigInt.one) continue;
        if (ownership.isFungibleV2 ?? false) continue;
        final data = ownership.currentTokenData;
        if (data == null) continue;
        page.add(
          AptosAccountNFT(
            tokenDataId: ownership.tokenDataId,
            tokenName: data.tokenName,
            collectionName: data.currentCollection?.collectionName ?? '',
          ),
        );
      }
      if (page.isNotEmpty) yield page;
      if (r.length < limit || offset * limit > maxAccountTokens) break;
      offset++;
    }
  }

  /// Pools the account currently participates in (indexer view): the
  /// enumeration source for chain positions. Unlike raw activities this
  /// never lists pools the account has fully exited.
  Future<List<String>> getDelegatorPools(AptosAddress owner) async {
    final r = await graphQlProvider.request(
      AptosGraphQLRequestGetDelegatorDistinctPools(
        variables: AptosGraphQLWhereConditionVariablesParams(
          whereCondition: {
            'delegator_address': {'_eq': owner.address},
          },
        ),
      ),
    );
    return r.map((e) => e.poolAddress).whereType<String>().toSet().toList();
  }

  /// Largest delegation pools by total stake: the stake picker source for
  /// first-time stakers, who have no history to suggest from.
  Future<List<AptosDelegationPoolInfo>> getTopDelegationPools({
    int limit = 20,
  }) async {
    final r = await graphQlProvider.request(
      AptosGraphQLRequestGetTopDelegationPools(
        variables: AptosGraphQLPaginatedWithOrderVariablesParams(
          orderBy: [
            {'total_coins': 'desc'},
          ],
          limit: limit,
        ),
      ),
    );
    return r
        .map(
          (e) => AptosDelegationPoolInfo(
            pool: e.poolAddress ?? '',
            totalCoins: BigintUtils.tryParse(e.totalCoins) ?? BigInt.zero,
            commissionPercentage:
                BigintUtils.tryParse(e.commissionPercentage) ?? BigInt.zero,
          ),
        )
        .where((e) => e.pool.isNotEmpty)
        .toList();
  }

  /// Live delegation positions: for every pool the account has touched, the
  /// on-chain (active, inactive, pending_inactive) split via the
  /// `delegation_pool::get_stake` view. Zero-total pools are dropped, so
  /// unlike raw activities this reflects what can actually be unstaked or
  /// withdrawn right now.
  Future<List<AptosDelegationPosition>> getChainDelegations(
    AptosAddress owner,
  ) async {
    final pools = await getDelegatorPools(owner);
    final positions = <AptosDelegationPosition>[];
    for (final pool in pools) {
      final amounts = await fullNodeProvider.request(
        AptosRequestExecuteViewFunctionOfaModule<BigInt>.bcs(
          entry: AptosTransactionEntryFunction(
            moduleId: AptosModuleId(
              address: AptosAddress.one,
              name: 'delegation_pool',
            ),
            functionName: 'get_stake',
            args: [AptosAddress(pool), owner],
          ),
        ),
      );
      if (amounts.length != 3) continue;
      final position = AptosDelegationPosition(
        pool: pool,
        active: amounts[0],
        inactive: amounts[1],
        pendingInactive: amounts[2],
      );
      if (position.total == BigInt.zero) continue;
      positions.add(position);
    }
    return positions;
  }

  /// Every delegation pool ever created (address only): fallback discovery
  /// when the balances table is empty.
  Future<List<String>> getAllDelegationPools({int limit = 50}) async {
    final r = await graphQlProvider.request(
      AptosGraphQLRequestGetAllDelegationPools(
        variables: AptosGraphQLPaginatedWithOrderVariablesParams(limit: limit),
      ),
    );
    return r.map((e) => e.poolAddress).whereType<String>().toSet().toList();
  }

  /// Live object address of a tracked v2 NFT holding [tokenDataId] of
  /// [owner], or null when not held (the tracked model carries no object
  /// address and the listed one may be stale).
  Future<AptosAddress?> getNftObjectAddress({
    required AptosAddress owner,
    required String tokenDataId,
    int limit = 10,
  }) async {
    final r = await graphQlProvider.request(
      AptosGraphQLRequestGetAccountOwnedTokensByTokenData(
        variables: AptosGraphQLPaginatedWithOrderVariablesParams(
          whereCondition: {
            'owner_address': {'_eq': owner.address},
            'token_data_id': {'_eq': tokenDataId},
            'amount': {'_gt': 0},
          },
          limit: limit,
        ),
      ),
    );
    for (final ownership in r) {
      if (ownership.isFungibleV2 ?? false) continue;
      final amount = BigintUtils.tryParse(ownership.amount.toString());
      if (amount != BigInt.one) continue;
      return AptosAddress(ownership.storageId);
    }
    return null;
  }

  /// Entry-function builders (pure: no provider use). They centralize every
  /// payload encoding previously inlined across wallet transaction types, so
  /// payload shapes stay identical for all consumers.

  /// `primary_fungible_store::transfer` entry for [amount] of [assetType]
  /// metadata to [recipient].
  AptosTransactionEntryFunction fungibleAssetTransferEntry({
    required AptosAddress assetType,
    required AptosAddress recipient,
    required BigInt amount,
  }) {
    return AptosTransactionEntryFunction(
      moduleId: AptosConstants.primaryFungibleStoreModule,
      functionName: AptosConstants.transferFunctionName,
      typeArgs: [AptosConstants.fungibleAssetMetadataTypeTag],
      args: [assetType, recipient, MoveU64(amount)],
    );
  }

  /// `object::transfer` entry moving the v2 NFT [object] to [recipient].
  AptosTransactionEntryFunction objectTransferEntry({
    required AptosAddress object,
    required AptosAddress recipient,
  }) {
    return AptosTransactionEntryFunction(
      moduleId: AptosModuleId(address: AptosAddress.one, name: 'object'),
      functionName: 'transfer',
      typeArgs: [
        AptosTypeTagStruct(
          AptosStructTag(
            address: AptosAddress('0x4'),
            moduleName: 'token',
            name: 'Token',
          ),
        ),
      ],
      args: [object, recipient],
    );
  }

  AptosTransactionEntryFunction _delegationPoolEntry({
    required AptosAddress pool,
    required BigInt amount,
    required String function,
  }) {
    return AptosTransactionEntryFunction(
      moduleId: AptosModuleId(
        address: AptosAddress.one,
        name: 'delegation_pool',
      ),
      functionName: function,
      args: [pool, MoveU64(amount)],
    );
  }

  /// `delegation_pool::add_stake` entry.
  AptosTransactionEntryFunction delegationStakeEntry({
    required AptosAddress pool,
    required BigInt amount,
  }) => _delegationPoolEntry(pool: pool, amount: amount, function: 'add_stake');

  /// `delegation_pool::unlock` entry.
  AptosTransactionEntryFunction delegationUnstakeEntry({
    required AptosAddress pool,
    required BigInt amount,
  }) => _delegationPoolEntry(pool: pool, amount: amount, function: 'unlock');

  /// `delegation_pool::withdraw` entry.
  AptosTransactionEntryFunction delegationWithdrawEntry({
    required AptosAddress pool,
    required BigInt amount,
  }) => _delegationPoolEntry(pool: pool, amount: amount, function: 'withdraw');

  /// First metadata row matching [assetType], or null.
  static AptosGraphQLFungibleAssetMetadata? _metadataForAsset(
    List<AptosGraphQLFungibleAssetMetadata> rows,
    String assetType,
  ) {
    for (final e in rows) {
      if (e.assetType == assetType) return e;
    }
    return null;
  }

  /// Parses an indexer `amount` (string int, hex, int, BigInt) into [BigInt].
  ///
  /// Huge balances may arrive in exponent form, which JSON decodes to double:
  /// convert exactly via [BigRational.fromDouble] and keep only whole units,
  /// skipping fractional rows instead of throwing.
  static BigInt? _parseBalanceAmount(dynamic amount) {
    if (amount is double) {
      try {
        final rational = BigRational.fromDouble(amount);
        if (rational.denominator == BigInt.one) return rational.numerator;
      } catch (_) {}
      return null;
    }
    return BigintUtils.tryParse(amount);
  }
}
