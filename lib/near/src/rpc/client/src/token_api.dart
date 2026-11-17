import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/near/src/address/address.dart';
import 'package:on_chain/near/src/contract/src/types.dart';
import 'package:on_chain/near/src/rpc/rpc.dart';
import 'package:on_chain/near/src/transaction/src/transaction.dart';

export 'package:on_chain/near/src/rpc/client/src/models.dart';

/// Token-level NEAR reads over [NearQuickNodeApi]. Consumers mix this in
/// alongside that mixin.
///
/// Error contract: reads throw on transport failure; only the documented
/// probe fallbacks apply — view-method presence checks map
/// missing-method/account errors to false, unknown NEP-171 ids read as
/// null naturally. Malformed data is never mistaken for absence.
mixin NearTokenQuickApi on NearQuickNodeApi {
  /// Native balance of [address].
  Future<BigInt> getAccountBalance(BaseNearAddress address) async {
    final account = await viewAccount(address);
    return BigintUtils.parse(account.value.amount);
  }

  /// True when [address] exists on-chain. Only a does-not-exist error
  /// reads as missing; any other failure rethrows.
  Future<bool> accountExists(BaseNearAddress address) async {
    try {
      await viewAccount(address);
      return true;
    } catch (e) {
      if (e is RPCError && NearRpcError.isDoesNotExistsError(e.message)) {
        return false;
      }
      rethrow;
    }
  }

  /// Current gas price response.
  Future<NearRpcRpcGasPriceResponse> getGasPrice() {
    return gasPrice();
  }

  /// Protocol config (deterministic fee inputs).
  Future<NearRpcRpcProtocolConfigResponse> getProtocolConfig() {
    return protocolConfig();
  }

  /// NEP-141 `ft_metadata` of [contract].
  Future<({String name, String symbol, int decimals})> getFtMetadata(
    BaseNearAddress contract,
  ) async {
    final result = await readFunctionResponse(
      contractId: contract,
      args: null,
      function: const NearContractJsonFunction<Map<String, dynamic>>(
        'ft_metadata',
      ),
    );
    final name = result['name']?.toString() ?? contract.address;
    final symbol =
        result['symbol']?.toString() ?? contract.address.split('.').first;
    final decimals =
        IntUtils.tryParse(result['decimals']?.toString() ?? '') ?? 0;
    return (name: name, symbol: symbol, decimals: decimals);
  }

  /// NEP-141 `ft_balance_of` of [owner] at [contract]. Transport failures
  /// throw; unparseable reads throw (unknown, never silent zero).
  Future<BigInt> getFtBalance({
    required BaseNearAddress contract,
    required BaseNearAddress owner,
  }) async {
    final result = await readFunctionResponse(
      contractId: contract,
      args: {'account_id': owner.address},
      function: const NearContractJsonFunction<String>('ft_balance_of'),
    );
    final balance = BigintUtils.tryParse(result);
    if (balance == null) {
      throw OnChainErrors.nearPlugin(
        'getFtBalance',
        reason: 'Unparseable balance response.',
        details: {'response': result.toString()},
      );
    }
    return balance;
  }

  /// Nullable NEP-141 balance read: RPC/method failures throw so refresh
  /// keeps cached balances; unparseable reads as null (also keep cached).
  Future<BigInt?> getFtBalanceOrNull({
    required BaseNearAddress contract,
    required BaseNearAddress owner,
  }) async {
    try {
      return await getFtBalance(contract: contract, owner: owner);
    } on BuError catch (e) {
      if (e.type != OnChainErrorType.nearPlugin) rethrow;
      return null;
    }
  }

  /// NEP standard probe via view methods (NEP-141 `ft_metadata`, NEP-171
  /// `nft_metadata`, NEP-245 `mt_metadata_base_by_token_id`). Only a
  /// missing method/account reads as negative; any other RPC failure
  /// propagates so callers never mistake downtime for "not a token".
  /// `methods` carries the standard-mandated set (transfer included, since
  /// each NEP mandates its transfer method) for UI action gating.
  Future<({bool isFt, bool isMt, bool isNft, List<String> methods})>
  probeNearStandards(BaseNearAddress contract) async {
    final methods = <String>[];
    bool isFt = false, isMt = false, isNft = false;
    if (await _hasNearView(contract, 'ft_metadata', null)) {
      isFt = true;
      methods.addAll(['ft_balance_of', 'ft_metadata', 'ft_transfer']);
    }
    if (await _hasNearView(contract, 'nft_metadata', null)) {
      isNft = true;
      methods.addAll(['nft_metadata', 'nft_token', 'nft_transfer']);
    }
    if (await _hasNearView(contract, 'mt_metadata_base_by_token_id', const {
      'token_ids': [],
    })) {
      isMt = true;
      methods.addAll([
        'mt_balance_of',
        'mt_metadata_base_by_token_id',
        'mt_transfer',
      ]);
    }
    methods.sort();
    return (isFt: isFt, isMt: isMt, isNft: isNft, methods: methods);
  }

  /// View-method presence check: missing method/account reads as false,
  /// everything else (including node-side panics) rethrows.
  Future<bool> _hasNearView(
    BaseNearAddress contract,
    String method, [
    Map<String, dynamic>? args,
  ]) async {
    try {
      await readFunctionResponse(
        contractId: contract,
        args: args,
        function: NearContractJsonFunction<dynamic>(method),
      );
      return true;
    } on RPCError catch (e) {
      final msg = e.message;
      if (msg.contains('MethodNotFound') ||
          msg.contains('METHOD_NOT_FOUND') ||
          NearRpcError.isDoesNotExistsError(msg)) {
        return false;
      }
      rethrow;
    }
  }

  /// NEP-171 token owner: the `owner_id`, or null when the token does not
  /// exist. Transport failures throw so sync keeps tracked NFTs instead
  /// of mistaking downtime for absence.
  Future<String?> getNftOwnerOrNull({
    required BaseNearAddress contract,
    required String tokenId,
  }) async {
    final result = await readFunctionResponse(
      contractId: contract,
      args: {'token_id': tokenId},
      function: const NearContractJsonFunction<Map<String, dynamic>?>(
        'nft_token',
      ),
    );
    final owner = result?['owner_id']?.toString();
    if (owner == null || owner.isEmpty) return null;
    return owner;
  }

  /// NEP-141 `storage_balance_of` of [account] at [contract].
  Future<Map<String, dynamic>?> getStorageBalanceOf({
    required BaseNearAddress contract,
    required BaseNearAddress account,
  }) {
    return readFunctionResponse(
      contractId: contract,
      args: {'account_id': account.address},
      function: const NearContractJsonFunction<Map<String, dynamic>?>(
        'storage_balance_of',
      ),
    );
  }

  /// NEP-141 storage-deposit `min` of [contract]. A missing/unparseable
  /// `min` throws: unlike an explicit zero, it is unknown, and a zero
  /// deposit would read as "no top-up needed".
  Future<BigInt> getStorageBoundsMin(BaseNearAddress contract) async {
    final result = await readFunctionResponse(
      contractId: contract,
      args: null,
      function: const NearContractJsonFunction<Map<String, dynamic>>(
        'storage_balance_bounds',
      ),
    );

    final min = BigintUtils.tryParse(result['min']?.toString() ?? '');
    if (min == null || min.isNegative) {
      throw OnChainErrors.nearPlugin(
        'getStorageBoundsMin',
        reason: 'Missing storage deposit bound.',
        details: {'min': '${result['min']}'},
      );
    }
    return min;
  }

  /// Lenient full bounds for the deposit fallback chain: unparseable or
  /// negative entries become zero (unknown), and the caller picks the first
  /// positive figure (`min`, then `max`, then a registered account's
  /// `total`) instead of trusting any hardcoded constant.
  Future<({BigInt min, BigInt max})> getStorageBalanceBounds(
    BaseNearAddress contract,
  ) async {
    final result = await readFunctionResponse(
      contractId: contract,
      args: null,
      function: const NearContractJsonFunction<Map<String, dynamic>>(
        'storage_balance_bounds',
      ),
    );
    BigInt bound(Object? value) {
      if (value == null) return BigInt.zero;
      BigInt? parsed;
      if (value is BigInt) {
        parsed = value;
      } else if (value is int) {
        parsed = BigInt.from(value);
      } else if (value is String) {
        parsed = BigInt.tryParse(value);
      }
      if (parsed == null || parsed.isNegative) return BigInt.zero;
      return parsed;
    }

    return (min: bound(result['min']), max: bound(result['max']));
  }

  /// NEP-245 `mt_metadata_base_by_token_id` of [tokenId] at [contract].
  /// Malformed entries throw (unknown, never silent defaults).
  Future<({String name, String symbol, int decimals})> getMtMetadata({
    required BaseNearAddress contract,
    required String tokenId,
  }) async {
    final result = await readFunctionResponse(
      contractId: contract,
      args: {
        'token_ids': [tokenId],
      },
      function: const NearContractJsonFunction<List<dynamic>>(
        'mt_metadata_base_by_token_id',
      ),
    );
    final first = (result.isNotEmpty ? result.first : null);
    if (first is! Map) {
      throw OnChainErrors.nearPlugin(
        'getMtMetadata',
        reason: 'Missing token metadata.',
        details: {'contract': contract.address, 'tokenId': tokenId},
      );
    }
    final meta = first.cast<String, dynamic>();
    final name = meta['name']?.toString() ?? tokenId;
    final symbol =
        meta['symbol']?.toString() ?? tokenId.split(':').firstOrNull ?? tokenId;

    final decimals = IntUtils.tryParse(meta['decimals']) ?? 0;
    return (name: name, symbol: symbol, decimals: decimals);
  }

  /// NEP-245 `mt_balance_of` of [owner] for [tokenId] at [contract].
  /// Transport failures throw; unparseable reads throw (unknown, never
  /// silent zero).
  Future<BigInt> getMtBalance({
    required BaseNearAddress contract,
    required BaseNearAddress owner,
    required String tokenId,
  }) async {
    final result = await readFunctionResponse(
      contractId: contract,
      args: {'account_id': owner.address, 'token_id': tokenId},
      function: const NearContractJsonFunction<String>('mt_balance_of'),
    );

    final balance = BigintUtils.tryParse(result);
    if (balance == null) {
      throw OnChainErrors.nearPlugin(
        'getMtBalance',
        reason: 'Unparseable balance response.',
        details: {'response': result.toString()},
      );
    }
    return balance;
  }

  /// Nullable NEP-245 balance read: RPC/method failures throw so refresh
  /// keeps cached balances; unparseable reads as null (also keep cached).
  Future<BigInt?> getMtBalanceOrNull({
    required BaseNearAddress contract,
    required BaseNearAddress owner,
    required String tokenId,
  }) async {
    try {
      return await getMtBalance(
        contract: contract,
        owner: owner,
        tokenId: tokenId,
      );
    } on BuError catch (e) {
      if (e.type != OnChainErrorType.nearPlugin) rethrow;
      return null;
    }
  }

  /// key does not exist. Any other failure rethrows.
  Future<NearRpcAccessKeyView?> getAccessKeyView({
    required BaseNearAddress accountId,
    required String publicKey,
  }) async {
    try {
      final response = await viewAccessKey(
        accountId: accountId,
        publicKey: publicKey,
      );
      return response.value;
    } catch (e) {
      if (e case RPCError err) {
        if (NearRpcError.isDoesNotExistsError(err.message)) {
          return null;
        }
      }
      rethrow;
    }
  }

  /// First page of the account's access keys (paginated listings are not
  /// followed yet; large key sets truncate to the first page).
  Future<NearRpcAccessKeyList> getAccessKeyList(BaseNearAddress accountId) {
    return viewAccessKeyList(accountId).then((response) => response.value);
  }

  /// Latest block hash (base58-decoded).
  Future<List<int>> getLatestBlockHash() async {
    final block = await this.block();
    return Base58Decoder.decode(block.header.hash);
  }

  /// Current validators response.
  Future<NearRpcRpcValidatorResponse> getValidators() {
    return validators();
  }

  /// Submits [transaction], returning the outcome transaction id.
  Future<String> sendTransaction({
    required NearSignedTransaction transaction,
  }) async {
    final response = await sendTransactionUntil(transaction: transaction);
    return switch (response) {
      NearRpcRpcTransactionResponseFinalExecutionOutcomeView(:final value) =>
        value.transactionOutcome.id,
      NearRpcRpcTransactionResponseFinalExecutionOutcomeWithReceiptView(
        :final value,
      ) =>
        value.transactionOutcome.id,
      NearRpcRpcTransactionResponseVariant2(:final value) =>
        value?.toString() ??
            transaction.transaction.toSerializeBytes().toString(),
    };
  }

  /// Status of ([txId], [accountId]): failed on any failure outcome,
  /// pending while starting/started or on does-not-exist errors (not yet
  /// indexed), block once executed. Any other failure rethrows.
  Future<NearTxStatus> getTransactionStatus({
    required String txId,
    required BaseNearAddress accountId,
  }) async {
    late final NearRpcRpcTransactionResponse response;
    try {
      response = await transactionStatus(txId: txId, accountId: accountId);
    } catch (e) {
      if (e is RPCError && NearRpcError.isDoesNotExistsError(e.message)) {
        return NearTxStatus.pending;
      }
      rethrow;
    }
    NearRpcFinalExecutionStatus? status;
    List<NearRpcExecutionOutcomeWithIdView> receipts = const [];
    switch (response) {
      case NearRpcRpcTransactionResponseFinalExecutionOutcomeView(:final value):
        status = value.status;
        receipts = value.receiptsOutcome;
      case NearRpcRpcTransactionResponseFinalExecutionOutcomeWithReceiptView(
        :final value,
      ):
        status = value.status;
        receipts = value.receiptsOutcome;
      default:
        return NearTxStatus.block;
    }
    if (status is NearRpcFinalExecutionStatusFailure) {
      return NearTxStatus.failed;
    }
    for (final receipt in receipts) {
      if (receipt.outcome.status is NearRpcExecutionStatusViewFailure) {
        return NearTxStatus.failed;
      }
    }
    if (status is NearRpcFinalExecutionStatusNotStarted ||
        status is NearRpcFinalExecutionStatusStarted) {
      return NearTxStatus.pending;
    }
    return NearTxStatus.block;
  }
}
