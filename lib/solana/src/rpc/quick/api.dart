import 'dart:async';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/associated_token_account/utils.dart';
import 'package:on_chain/solana/src/instructions/metaplex/core_candy_machine/accounts/accounts.dart';
import 'package:on_chain/solana/src/instructions/metaplex/core_candy_machine/rpcs/rpcs/get_core_candy_guard_account.dart';
import 'package:on_chain/solana/src/instructions/metaplex/core_candy_machine/rpcs/rpcs/get_core_candy_machine_account.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_auth_rules/accounts/accounts.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_auth_rules/rpcs/rpcs/get_buffer_account.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_auth_rules/rpcs/rpcs/get_rule_set_account.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/accounts/accounts/meta_data.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/rpcs/rpcs/get_meta_data_account.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/utils.dart';
import 'package:on_chain/solana/src/instructions/mpl_core/accounts.dart';
import 'package:on_chain/solana/src/instructions/mpl_core/rpcs/rpcs/get_asset_account.dart';
import 'package:on_chain/solana/src/instructions/mpl_core/rpcs/rpcs/get_collection_account.dart';
import 'package:on_chain/solana/src/instructions/mpl_core/rpcs/rpcs/get_group_account.dart';
import 'package:on_chain/solana/src/instructions/spl_token/accounts/accounts/mint_account.dart';
import 'package:on_chain/solana/src/instructions/spl_token/accounts/accounts/token_account.dart';
import 'package:on_chain/solana/src/instructions/spl_token/constant.dart';
import 'package:on_chain/solana/src/instructions/spl_token/rpcs/rpcs/get_mint_account.dart';
import 'package:on_chain/solana/src/instructions/spl_token/rpcs/rpcs/get_token_account.dart';
import 'package:on_chain/solana/src/keypair/keypair.dart';
import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/methods/methods/get_account_info.dart';
import 'package:on_chain/solana/src/rpc/methods/methods/get_block_height.dart';
import 'package:on_chain/solana/src/rpc/methods/methods/get_cluster_nodes.dart';
import 'package:on_chain/solana/src/rpc/methods/methods/get_fee_for_message.dart';
import 'package:on_chain/solana/src/rpc/methods/methods/get_genesis_hash.dart';
import 'package:on_chain/solana/src/rpc/methods/methods/get_lastest_block_hash.dart';
import 'package:on_chain/solana/src/rpc/methods/methods/get_latest_block_hash.dart';
import 'package:on_chain/solana/src/rpc/methods/methods/get_minimum_balance_for_rent_exemption.dart';
import 'package:on_chain/solana/src/rpc/methods/methods/get_recent_prioritization_fees.dart';
import 'package:on_chain/solana/src/rpc/methods/methods/get_signature_for_address.dart';
import 'package:on_chain/solana/src/rpc/methods/methods/get_signature_statuses.dart';
import 'package:on_chain/solana/src/rpc/methods/methods/get_token_accounts_by_owner.dart';
import 'package:on_chain/solana/src/rpc/methods/methods/send_transaction.dart';
import 'package:on_chain/solana/src/rpc/methods/methods/simulate_transaction.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/transaction/transaction/transaction.dart';

import 'models.dart';

mixin SolanaQuickClientApi {
  /// Single RPC provider serving every call.
  IProvider<IServiceProvider, SolanaRequestDetails> get provider;

  /// Native SOL balance of [address] in lamports.
  Future<BigInt> getAccountBalance(SolAddress address) async {
    final accountInfo = await getAccountInfo(address);
    return accountInfo?.lamports ?? BigInt.zero;
  }

  /// Alias of [getAccountBalance].
  Future<BigInt> getBalance(SolAddress address) {
    return getAccountBalance(address);
  }

  /// Full account info, or null when the account does not exist.
  Future<SolanaAccountInfo?> getAccountInfo(SolAddress account) async {
    return provider.request(SolanaRequestGetAccountInfo(account: account));
  }

  /// Parsed SPL token account, or null when it does not exist.
  Future<SolanaTokenAccount?> getTokenAccount(SolAddress account) async {
    return provider.request(SolanaRPCGetTokenAccount(account: account));
  }

  /// Minimum lamports for rent exemption of [space] bytes.
  Future<BigInt> getRent(int space) async {
    return provider.request(
      SolanaRequestGetMinimumBalanceForRentExemption(size: space),
    );
  }

  /// Fee estimate for [transaction], or null when the node cannot estimate.
  Future<BigInt?> getFee(SolanaTransaction transaction) async {
    return provider.request(
      SolanaRequestGetFeeForMessage(
        encodedMessage: StringUtils.decode(
          transaction.message.serialize(),
          encoding: StringEncoding.base64,
        ),
        commitment: Commitment.processed,
      ),
    );
  }

  /// Simulates [transaction] without sending it.
  Future<SimulateTransactionResponse> simulate({
    required SolanaTransaction transaction,
    SolAddress? account,
    bool replaceRecentBlockhash = true,
    bool sigVerify = false,
    Commitment? commitment = Commitment.processed,
    MinContextSlot? minContextSlot,
  }) async {
    return provider.request(
      SolanaRequestSimulateTransaction(
        encodedTransaction: transaction.serializeString(
          encoding: TransactionSerializeEncoding.base64,
        ),
        sigVerify: sigVerify,
        replaceRecentBlockhash: replaceRecentBlockhash,
        encoding: SolanaRequestEncoding.base64,
        commitment: commitment,
        minContextSlot: minContextSlot,
        accounts:
            account == null
                ? null
                : RPCAccountConfig(
                  addresses: [account],
                  encoding: SolanaRequestEncoding.base64,
                ),
      ),
    );
  }

  /// Latest blockhash.
  Future<SolAddress> getBlockHash() async {
    final blockHash = await provider.request(
      const SolanaRequestGetLatestBlockhash(),
    );
    return blockHash.blockhash;
  }

  /// Genesis hash of the connected cluster.
  Future<String> getGenesis() async {
    return provider.request(SolanaRequestGetGenesisHash());
  }

  /// True when the connected cluster matches [expectedGenesis].
  Future<bool> validateNetworkGenesis(String expectedGenesis) async {
    return await getGenesis() == expectedGenesis;
  }

  /// Cluster nodes.
  Future<List<ContactInfo>> clusterNodes() async {
    return provider.request(SolanaRequestGetClusterNodes());
  }

  /// Token balance of a token account [address].
  Future<BigInt> getTokenAddressBalance(SolAddress address) async {
    final account = await provider.request(
      SolanaRPCGetTokenAccount(account: address),
    );
    return account?.amount ?? BigInt.zero;
  }

  /// Mint account, or null when the mint does not exist.
  Future<SolanaMintAccount?> getMintAccount(SolAddress mintAddress) async {
    try {
      return await provider.request(
        SolanaRPCGetMintAccount(account: mintAddress),
      );
    } on BuError {
      return null;
    }
  }

  /// Metaplex metadata account of [mint], or null when the mint has none.
  /// Missing accounts read as null naturally; transport failures throw.
  Future<Metadata?> getTokenMetadataAccount(SolAddress mint) async {
    final metadatPda = MetaplexTokenMetaDataProgramUtils.findMetadataPda(
      mint: mint,
    );
    return provider.request(
      SolanaRPCGetMetadataAccount(account: metadatPda.address),
    );
  }

  /// Parsed MPL Core asset account, or null when it does not
  /// exist. `key` tells the record type; `owner` is the current holder.
  Future<MplCoreAssetAccount?> getMplCoreAssetAccount(SolAddress asset) async {
    return provider.request(SolanaRPCGetMplCoreAssetAccount(account: asset));
  }

  /// Parsed MPL Core collection account, or null when it does
  /// not exist.
  Future<MplCoreCollectionAccount?> getMplCoreCollectionAccount(
    SolAddress collection,
  ) async {
    return provider.request(
      SolanaRPCGetMplCoreCollectionAccount(account: collection),
    );
  }

  /// Parsed MPL Core group account, or null when it does not
  /// exist.
  Future<MplCoreGroupAccount?> getMplCoreGroupAccount(SolAddress group) async {
    return provider.request(SolanaRPCGetMplCoreGroupAccount(account: group));
  }

  /// Core Candy Machine account, or null when it does not exist.
  Future<CoreCandyMachineAccount?> getCoreCandyMachineAccount(
    SolAddress candyMachine,
  ) async {
    return provider.request(
      SolanaRPCGetCoreCandyMachineAccount(account: candyMachine),
    );
  }

  /// Core Candy Guard account, or null when it does not exist.
  Future<CoreCandyGuardAccount?> getCoreCandyGuardAccount(
    SolAddress candyGuard,
  ) async {
    return provider.request(
      SolanaRPCGetCoreCandyGuardAccount(account: candyGuard),
    );
  }

  /// Token Authorization Rules RuleSet PDA, or null when it does
  /// not exist. Needed to validate programmable-NFT transfers.
  Future<TokenAuthRulesRuleSetAccount?> getTokenAuthRulesRuleSetAccount(
    SolAddress ruleSetPda,
  ) async {
    return provider.request(
      SolanaRPCGetTokenAuthRulesRuleSetAccount(account: ruleSetPda),
    );
  }

  /// Token Authorization Rules buffer PDA, or null when it does
  /// not exist.
  Future<TokenAuthRulesBufferAccount?> getTokenAuthRulesBufferAccount(
    SolAddress bufferPda,
  ) async {
    return provider.request(
      SolanaRPCGetTokenAuthRulesBufferAccount(account: bufferPda),
    );
  }

  /// SPL token holdings of [account] for [tokenProgram] (default: SPL Token
  /// program). Missing mints keep null decimals instead of throwing (wallet
  /// parity, hardened).
  Future<List<SolanaSPLTokenBalance>> getAccountSPLTokenBalances(
    SolAddress account, {
    SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
  }) async {
    final tokenAccounts = await provider.request(
      SolanaRequestGetTokenAccountsByOwner(
        account: account,
        programId: tokenProgram,
        encoding: SolanaRequestEncoding.base64,
      ),
    );
    final List<SolanaSPLTokenBalance> balances = [];
    for (final i in tokenAccounts) {
      final mint = await getMintAccount(i.tokenAccount.mint);
      balances.add(
        SolanaSPLTokenBalance(
          mint: i.tokenAccount.mint,
          amount: i.tokenAccount.amount,
          owner: i.tokenAccount.owner,
          tokenAccount: i.pubkey,
          decimals: mint?.decimals,
        ),
      );
    }
    return balances;
  }

  /// Associated token account address for ([account], [mint]).
  ///
  /// When [tokenProgramId] is omitted it is read from the mint account; the
  /// mint must belong to the SPL Token or Token-2022 program.
  Future<SolanaTokenAccountAddress> getTokenAccountAddress({
    required SolAddress account,
    required SolAddress mint,
    SolAddress? tokenProgramId,
  }) async {
    if (tokenProgramId == null) {
      final mintAccount = await getAccountInfo(mint);
      if (mintAccount == null) {
        throw BuError(
          DefaultErrorType.notFound,
          'Mint account not found.',
          details: {'mint': mint.address},
        );
      }
      tokenProgramId = mintAccount.owner;
      if (tokenProgramId != SPLTokenProgramConst.token2022ProgramId &&
          tokenProgramId != SPLTokenProgramConst.tokenProgramId) {
        throw BuError(
          DefaultErrorType.invalidAddress,
          'Invalid mint account owner.',
          details: {'owner': tokenProgramId.address},
        );
      }
    }
    final pda = AssociatedTokenAccountProgramUtils.associatedTokenAccount(
      mint: mint,
      owner: account,
      tokenProgramId: tokenProgramId,
      allowOwnerOffCurve: true,
    );
    return SolanaTokenAccountAddress(
      account: account,
      pdaAddress: pda.address,
      tokenProgramId: tokenProgramId,
    );
  }

  /// Token balance of [account] for [mint].
  Future<BigInt> getTokenBalance({
    required SolAddress account,
    required SolAddress mint,
    SolAddress? tokenProgramId,
  }) async {
    final address = await getTokenAccountAddress(
      account: account,
      mint: mint,
      tokenProgramId: tokenProgramId,
    );
    return getTokenAddressBalance(address.pdaAddress);
  }

  /// Broadcasts [transaction], returning its signature.
  Future<String> sendTransaction(
    SolanaTransaction transaction, {
    int? maxRetries,
    bool skipPreflight = false,
    int? minContextSlot,
    Commitment? commitment,
    SolanaRequestEncoding encoding = SolanaRequestEncoding.base64,
  }) async {
    return provider.request(
      SolanaRequestSendTransaction(
        encodedTransaction: transaction.serializeString(
          encoding:
              encoding == SolanaRequestEncoding.base64
                  ? TransactionSerializeEncoding.base64
                  : TransactionSerializeEncoding.base58,
        ),
        encoding: encoding,
        skipPreflight: skipPreflight,
        maxRetries: maxRetries,
        commitment: skipPreflight ? Commitment.processed : commitment,
        minContextSlot:
            minContextSlot == null
                ? null
                : MinContextSlot(slot: minContextSlot),
      ),
    );
  }

  /// First signature status for [signature], or null when unknown.
  Future<SignatureStatus?> getSignatureStatuses(String signature) async {
    final statuses = await provider.request(
      SolanaRequestGetSignatureStatuses(signatures: [signature]),
    );
    return statuses.isEmpty ? null : statuses.first;
  }

  /// Status of a transaction by signature.
  Future<SolanaTxStatus> transactionStatus(String signature) async {
    final status = await getSignatureStatuses(signature);
    if (status == null) return SolanaTxStatus.unknown;
    if (status.err != null) return SolanaTxStatus.failed;
    if (status.confirmationStatus == TransactionConfirmationStatus.finalized) {
      return SolanaTxStatus.block;
    }
    return SolanaTxStatus.pending;
  }

  /// Polls until [transactionId] finalizes, errors, or [timeout] elapses.
  Future<TransactionConfirmationStatus> trackTransaction({
    required String transactionId,
    Duration timeout = const Duration(minutes: 1),
    Duration periodicTimeOut = const Duration(seconds: 2),
  }) async {
    Timer? timer;
    try {
      final Completer<TransactionConfirmationStatus> completer =
          Completer<TransactionConfirmationStatus>();
      timer = Timer.periodic(periodicTimeOut, (_) async {
        if (completer.isCompleted) {
          timer?.cancel();
          return;
        }
        try {
          final receipt = await getSignatureStatuses(transactionId);
          if (completer.isCompleted) return;
          if (receipt != null) {
            if (receipt.err != null) {
              completer.completeError(
                BuError(
                  OnChainErrorType.solanaPlugin,
                  'Transaction confirmation failed.',
                  details: {'err': receipt.err.toString()},
                ),
              );
              timer?.cancel();
            } else {
              final status = receipt.confirmationStatus;
              if (status == TransactionConfirmationStatus.finalized) {
                completer.complete(status);
                timer?.cancel();
              }
            }
          }
        } catch (_) {
          // Transient poll failure: keep polling until timeout.
        }
      });
      return await completer.future.timeout(timeout);
    } on TimeoutException {
      throw BuError(
        OnChainErrorType.solanaPlugin,
        'Transaction confirmation failed.',
        details: {
          'transactionId': transactionId,
          'timeout': timeout.toString(),
        },
      );
    } finally {
      timer?.cancel();
    }
  }

  /// Latest finalized block height.
  Future<BigInt> getBlockHeight() async {
    final block = await provider.request(
      SolanaRequestGetBlockHeight(commitment: Commitment.finalized),
    );
    return BigInt.from(block);
  }

  Future<List<SolanaSPLTokenBalance>> getAllTokenBalances(
    SolAddress account,
  ) async {
    final List<SolanaSPLTokenBalance> out = [];
    out.addAll(await getAccountSPLTokenBalances(account));
    out.addAll(
      await getAccountSPLTokenBalances(
        account,
        tokenProgram: SPLTokenProgramConst.token2022ProgramId,
      ),
    );
    return out;
  }

  Future<List<RecentPrioritizationFees>> getRecentPrioritizationFees({
    List<SolAddress>? addresses,
  }) async {
    return provider.request(
      SolanaRequestGetRecentPrioritizationFees(addresses: addresses),
    );
  }

  Future<List<ConfirmedSignatureInfo>> getSignaturesForAddress({
    required SolAddress account,
    int limit = 100,
    String? before,
    String? until,
    Commitment? commitment,
  }) async {
    return provider.request(
      SolanaRequestGetSignaturesForAddress(
        account: account,
        limit: limit,
        before: before,
        until: until,
        commitment: commitment,
      ),
    );
  }

  Future<BigInt?> prepareTransaction({
    required SolanaTransaction transaction,
    SolAddress? feePayerAccount,
  }) async {
    final fee = await getFee(transaction);
    final sim = await simulate(
      transaction: transaction,
      account: feePayerAccount,
    );
    if (sim.err != null) {
      throw BuError(
        OnChainErrorType.solanaPlugin,
        'Transaction simulation failed.',
        details: {'err': sim.err.toString()},
      );
    }
    return fee;
  }

  Future<String> signAndSubmit({
    required SolanaTransaction transaction,
    required List<SolanaPrivateKey> signers,
    int? maxRetries,
    bool skipPreflight = false,
    SolanaRequestEncoding encoding = SolanaRequestEncoding.base64,
  }) async {
    transaction.sign(signers);
    return sendTransaction(
      transaction,
      maxRetries: maxRetries,
      skipPreflight: skipPreflight,
      encoding: encoding,
    );
  }

  Future<SignatureStatus?> pollSignature({
    required String signature,
    Duration timeout = const Duration(minutes: 1),
    Duration periodicTimeOut = const Duration(seconds: 2),
  }) async {
    await trackTransaction(
      transactionId: signature,
      timeout: timeout,
      periodicTimeOut: periodicTimeOut,
    );
    return getSignatureStatuses(signature);
  }
}
