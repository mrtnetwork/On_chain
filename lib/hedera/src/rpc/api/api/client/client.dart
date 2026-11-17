import 'dart:async';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/models.dart';
import 'package:on_chain/on_chain.dart';

/// Base client combining query, node submit, and mirror REST.
///
/// Shared read methods use [backend] to pick mirror vs node.
abstract class HederaClient
    with HederaQuickQueryApi, HederaQuickNodeApi, HederaQuickMirrorApi {
  /// Default backend preference for dual-path methods.
  @override
  HederaClientSterategy get strategy;

  HederaNetwork get network;

  /// Account balance: mirror first (free) or node query.
  Future<HederaAccountBalanceSnapshot> getBalance(
    HederaAddress account, {
    // HederaApiBackend? backend,
    HederaAddress? payer,
    HederaSigner? signer,
  }) async {
    Future<HederaAccountBalanceSnapshot> fromMirror() async {
      return await getMirrorBalance(account);
    }

    Future<HederaAccountBalanceSnapshot> fromNode() async {
      return await getNodeBalance(account);
    }

    return _withBackend(fromMirror, fromNode);
  }

  /// Account info from node or mirror, normalized to [HederaAccountSnapshot].
  Future<HederaAccountSnapshot> getAccount(HederaAddress account) {
    return _withBackend(
      () async {
        final m = await getMirrorAccount(account);
        return HederaAccountSnapshot.fromMirror(
          response: m,
          fallbackAccount: account,
        );
      },
      () async {
        final r = await getNodeAccount(account: account);
        return HederaAccountSnapshot.fromNode(
          response: r,
          fallbackAccount: account,
        );
      },
    );
  }

  Future<ETHAddress> resolveEvmAddress(HederaAddress account) async {
    final evm = account.toNonLongZeroEthereumAddress();
    if (evm != null) return evm;
    final ETHAddress? addr = await _withBackend(
      () async {
        final m = await getMirrorAccount(account);
        final evm = m.evmAddress;
        if (evm != null) {
          return ETHAddress(evm);
        }
        return null;
      },
      () async {
        final r = await getNodeAccount(account: account);
        return HederaAddress.fromAccountId(
          r.accountInfo?.accountID ?? HederaAccountID(),
        ).toNonLongZeroEthereumAddress();
      },
    );
    if (addr == null) {
      throw OnChainErrors.hederaTx(
        "resolveEvmAddress",
        reason: "Failed to resolve Ethereum address.",
        details: {"address": account.address},
      );
    }
    return addr;
  }

  Future<HederaAddress> resolveOnChainAdddress(HederaAddress account) async {
    if (account.isOnChainAccount()) return account;
    final HederaAddress? addr = await _withBackend(
      () async {
        final m = await getMirrorAccount(account);
        final addr = m.account;
        if (addr != null) {
          return HederaAddress(addr).toOnChainAddress();
        }
        return null;
      },
      () async {
        final r = await getNodeAccount(account: account);
        return HederaAddress.fromAccountId(
          r.accountInfo?.accountID ?? HederaAccountID(),
        ).toOnChainAddress();
      },
    );
    if (addr == null) {
      throw OnChainErrors.hederaTx(
        "resolveEvmAddress",
        reason: "Failed to resolve on-chain account ID.",
        details: {"address": account.address},
      );
    }
    return addr;
  }

  Future<BigInt> ethereumNonce(HederaAddress account) {
    return _withBackend(
      () async {
        final m = await getMirrorAccount(account);
        return m.ethereumNonce ?? BigInt.zero;
      },
      () async {
        final r = await getNodeAccount(account: account);
        return r.accountInfo?.ethereumNonce ?? BigInt.zero;
      },
    );
  }

  /// Contract call: mirror eth_call, or node ContractCallLocal.
  Future<HederaContractCallResult> callContract({
    required HederaAddress to,
    String? data,
    HederaAddress? from,
    BigInt? gas,
    BigInt? value,
    bool estimate = false,
    HederaContractID? contractId,
  }) async {
    Future<HederaContractCallResult> fromMirror() => mirrorContractCall(
      to: to,
      data: data,
      from: from,
      gas: gas,
      value: value,
      estimate: estimate,
    );

    Future<HederaContractCallResult> fromNode() async {
      if (contractId == null) {
        throw OnChainErrors.hederaPlugin(
          "callContract",
          reason: 'Node ContractCallLocal requires contractId and payer.',
        );
      }
      final resp = await getNodeContractCall(
        contractId: contractId,
        functionParameters: BytesUtils.fromHexString(data ?? ''),
        gas: gas ?? BigInt.from(15_000_000),
      );

      // Adapt node response fields to shared result — adjust to your proto.
      final bytes = resp.functionResult?.contractCallResult;
      return HederaContractCallResult(
        resultHex: bytes == null ? null : BytesUtils.toHexString(bytes),
        gasEstimate: resp.functionResult?.gasUsed ?? BigInt.zero,
      );
    }

    if (estimate) {
      // Gas estimate is mirror-only in this client.
      return fromMirror();
    }

    return _withBackend(fromMirror, fromNode);
  }

  /// Estimate contract gas (mirror `/contracts/call?estimate=true`).
  Future<HederaContractCallResult> estimateGas({
    required HederaAddress to,
    String? data,
    HederaAddress? from,
    BigInt? value,
    BigInt? gas,
  }) {
    return _withBackend(
      () async {
        return mirrorContractCall(
          to: to,
          data: data,
          from: from,
          value: value,
          gas: gas,
          estimate: true,
        );
      },
      () async {
        throw OnChainErrors.hederaPlugin(
          "estimateGas",
          reason: 'Estimate gas not supported by node.',
        );
      },
    );
  }

  /// Token authority keys (admin/supply/wipe/…) via strategy (mirror or node).
  Future<HederaTokenKeysSnapshot> getTokenKeys(HederaTokenID tokenId) {
    return _withBackend(
      () async {
        final m = await getMirrorToken(tokenId);
        return HederaTokenKeysSnapshot.fromMirror(m);
      },
      () async {
        final r = await getNodeToken(tokenId: tokenId);
        return HederaTokenKeysSnapshot.fromNode(r);
      },
    );
  }

  /// Contract admin key via strategy (mirror or node).
  Future<HederaContractKeysSnapshot> getContractKeys(
    HederaAddress contract, {
    HederaContractID? contractId,
  }) {
    return _withBackend(
      () async {
        final m = await getMirrorContract(contract);
        return HederaContractKeysSnapshot.fromMirror(m);
      },
      () async {
        final id = contractId;
        if (id == null) {
          throw OnChainErrors.hederaPlugin(
            'getContractKeys',
            reason: 'Node ContractGetInfo requires contractId.',
          );
        }
        final r = await getNodeContract(contractId: id);
        return HederaContractKeysSnapshot.fromNode(r);
      },
    );
  }

  /// Topic admin/submit keys via strategy (mirror or node).
  Future<HederaTopicKeysSnapshot> getTopicKeys(HederaTopicID topicId) {
    return _withBackend(
      () async {
        final m = await getMirrorTopic(topicId);
        return HederaTopicKeysSnapshot.fromMirror(m);
      },
      () async {
        final r = await getNodeTopic(topicId: topicId);
        return HederaTopicKeysSnapshot.fromNode(r);
      },
    );
  }

  /// Token info: mirror REST or node TokenGetInfo (strategy-aware).
  Future<Object> getToken(HederaTokenID tokenId) {
    return _withBackend(() => getMirrorToken(tokenId), () async {
      return getNodeToken(tokenId: tokenId);
    });
  }

  /// Contract info: mirror or node (strategy-aware).
  Future<Object> getContract(
    HederaAddress contract, {
    HederaContractID? contractId,
  }) {
    return _withBackend(() => getMirrorContract(contract), () async {
      final id =
          contractId ??
          (contract.isOnChainAccount()
              ? HederaContractID(
                shardNum: contract.toAccoutId().shardNum,
                realmNum: contract.toAccoutId().realmNum,
                contractNum: contract.toAccoutId().accountNum,
              )
              : null);
      if (id == null) {
        throw OnChainErrors.hederaPlugin(
          'getContract',
          reason: 'Node ContractGetInfo requires contractId.',
        );
      }
      return getNodeContract(contractId: id);
    });
  }

  /// Topic info: node only when mirror has no full topic-info dual path.
  Future<HederaConsensusGetTopicInfoResponse> getTopic({
    required HederaTopicID topicId,
  }) {
    // Topic keys are on node TopicGetInfo; mirror topic messages API is different.
    return getNodeTopic(topicId: topicId);
  }

  /// Token balance of [owner] for [tokenId]; missing associations read as
  /// zero (data, not error mapping).
  Future<BigInt> getTokenBalance({
    required HederaAddress tokenId,
    required HederaAddress owner,
  }) async {
    final snapshot = await getBalance(owner);
    for (final e in snapshot.tokens) {
      if (e.tokenId == tokenId) return e.balance;
    }
    return BigInt.zero;
  }

  /// One-shot token balances: a single mirror balance snapshot mapped by
  /// token id. Missing ids read as zero (not associated); a failed snapshot
  /// throws so callers keep cached balances instead of zeroing them.
  Future<Map<HederaAddress, BigInt>> getAccountTokenBalances(
    HederaAddress owner,
  ) async {
    final snapshot = await getBalance(owner);
    return {for (final e in snapshot.tokens) e.tokenId: e.balance};
  }

  /// Mirror token info of [tokenId].
  Future<HederaMirrorTypesTokenInfo> getTokenInfo(HederaAddress tokenId) {
    return getMirrorToken(tokenId.toTokenId());
  }

  /// Fungible token metadata of [tokenId], or null when it is not a
  /// fungible-common token. Transport failures throw.
  Future<HederaTokenMetadata?> getFungibleTokenMetadata(
    HederaAddress tokenId,
  ) async {
    final info = await getTokenInfo(tokenId);
    if (info.type != HederaMirrorTypesTokenInfoType.fUNGIBLECOMMON) {
      return null;
    }
    final name = info.name ?? tokenId.address;
    final symbol = info.symbol ?? tokenId.address;
    return HederaTokenMetadata(
      name: name,
      symbol: symbol,
      decimals: IntUtils.tryParse(info.decimals) ?? 0,
    );
  }

  /// First page of non-deleted NFTs of [address] with serial numbers.
  /// (The typed mirror layer exposes no followable cursor, so large
  /// collections truncate to [limit].)
  Future<List<HederaMirrorTypesNft>> getAccountNfts(
    HederaAddress address, {
    int limit = 100,
  }) async {
    final response = await mirrorRequest(
      HederaMirrorRequestGetNftsByAccountId(
        idOrAliasOrEvmAddress: address.toMirrorEntityId(),
        limit: limit,
      ),
    );
    return response.nfts
            ?.where((e) => e.deleted != true && e.serialNumber != null)
            .toList() ??
        [];
  }

  /// Mirror network nodes (address-book source).
  Future<List<HederaMirrorTypesNetworkNode>> getNetworkNodes({
    int limit = 100,
  }) async {
    final response = await mirrorRequest(
      HederaMirrorRequestGetNetworkNodes(limit: limit),
    );
    return response.nodes;
  }

  /// Mirror account info of [address], or null only on 404 (e.g. unfunded
  /// hollow accounts). Any other failure rethrows.
  Future<HederaMirrorTypesAccountInfo?> getAccountInfo(
    HederaAddress address,
  ) async {
    try {
      return await mirrorRequest(
        HederaMirrorRequestGetAccountInfo(
          idOrAliasOrEvmAddress: address.toMirrorEntityId(),
        ),
      );
    } on RPCError catch (e) {
      if (e.statusCode == 404) return null;
      rethrow;
    }
  }

  /// Mirror-resolve alias/EVM forms to a numeric 0.0.x id; null when the
  /// account does not exist on-chain yet (e.g. unfunded hollow).
  Future<HederaAddress?> resolveAccountId(HederaAddress address) async {
    final info = await getAccountInfo(address);
    final accountId = info?.account;
    if (accountId == null) return null;
    return HederaAddress(accountId);
  }

  /// Mirror fee estimate (free): POST /api/v1/network/fees takes a
  /// protobuf-encoded HAPI Transaction (NOT the bare body — that 400s),
  /// returns tinycents converted with the mirror exchange rate.
  /// Fee depends on serialized size including signatures, so placeholder
  /// sig pairs sized by totalSignature are injected. [feeMultiplier] is a
  /// ceiling margin (wallet practice: 10 on mainnet, 15 elsewhere — the
  /// mirror INTRINSIC estimate excludes live congestion pricing, and
  /// consensus has charged 10x-500x base on testnet). The cap is a ceiling
  /// only — consensus charges just the required fee.
  Future<BigInt> estimateBodyFee({
    required HederaTransactionBody body,
    required int totalSignature,
    int feeMultiplier = 10,
  }) async {
    final n = totalSignature < 1 ? 1 : totalSignature;
    final placeholderPairs = List<HederaSignaturePair>.generate(
      n,
      (i) => HederaSignaturePair(
        pubKeyPrefix: List<int>.filled(32, i + 1),
        ed25519: List<int>.filled(64, i + 2),
      ),
    );
    final tx = HederaTransaction(
      signedTransactionBytes:
          HederaSignedTransaction(
            bodyBytes: body.toBuffer(),
            sigMap: HederaSignatureMap(sigPair: placeholderPairs),
          ).toBuffer(),
    );
    final estimate = await mirrorRequest(
      HederaMirrorRequestEstimateFees(txBody: tx.toBuffer()),
    );
    final rates = await getMirrorExchangeRateSet();
    final rate = rates.currentRate ?? rates.nextRate;
    final hbarEquiv = rate?.hbarEquiv;
    final centEquiv = rate?.centEquiv;
    if (hbarEquiv == null || centEquiv == null || centEquiv == 0) {
      throw OnChainErrors.hederaPlugin(
        'estimateBodyFee',
        reason: 'Missing mirror exchange rate.',
      );
    }
    final raw =
        (estimate.total * BigInt.from(hbarEquiv)) ~/ BigInt.from(centEquiv);
    return (raw * BigInt.from(feeMultiplier)) + BigInt.one;
  }

  /// Cost-answer query for file contents of [id].
  Future<BigInt> quoteFileContentsCost(HederaFileID id) async {
    final costQuery = HederaFileGetContentsQuery(
      header: HederaQueryHeader(responseType: HederaResponseType.costAnswer),
      fileID: id,
    );
    final response = await query(query: costQuery);
    return response.header?.cost ?? BigInt.zero;
  }

  /// File contents of [id] paid by [payment].
  Future<List<int>> readFileContents({
    required HederaFileID id,
    required HederaTransaction payment,
  }) async {
    final fileQuery = HederaFileGetContentsQuery(
      fileID: id,
      header: HederaQueryHeader(
        payment: payment,
        responseType: HederaResponseType.answerOnly,
      ),
    );
    final response = await query(query: fileQuery);
    return response.fileContents?.contents ?? [];
  }

  /// Status of [txId]: unparseable ids read as unknown (local, not node);
  /// unknown mirror transactions read as pending (not indexed yet);
  /// success reflects the execution result; any other failure rethrows.
  Future<HederaTxStatus> getTransactionStatus(String txId) async {
    late final HederaTransactionID id;
    try {
      id = HederaTransactionBuilderUtils.fromExplorerOrMirrorTxId(txId);
    } catch (_) {
      return HederaTxStatus.unknown;
    }
    final mirrorTxId = HederaTransactionBuilderUtils.toMirrorTxId(id);
    late final HederaMirrorTypesTransactionByIdResponse tx;
    try {
      tx = await getMirrorTransaction(transactionId: mirrorTxId);
    } catch (e) {
      if (e is RPCError && e.statusCode == 404) {
        return HederaTxStatus.pending;
      }
      rethrow;
    }
    final result = tx.transactions?.firstOrNull?.result;
    if (result == null) return HederaTxStatus.pending;
    if (result.toLowerCase().contains('success')) {
      return HederaTxStatus.block;
    }
    return HederaTxStatus.failed;
  }

  /// Full flow: submit signed tx and wait for receipt.
  Future<HederaSubmitResult> sendAndWait({
    required HederaTransaction transaction,
    required HederaTransactionID transactionId,
    required HederaTransactionBody body,
    Duration timeout = const Duration(seconds: 60),
  }) {
    return submitTransactionAndWait(
      transaction: transaction,
      body: body,
      transactionId: transactionId,
      timeout: timeout,
      useMirrorFallback: strategy.mirror != null,
    );
  }

  /// Prefer mirror when enabled, otherwise node when enabled.
  Future<T> _withBackend<T>(
    Future<T> Function() mirror,
    Future<T> Function() node,
  ) async {
    final hasMirror = strategy.mirror != null;
    final hasNode = strategy.node != null;
    if (hasMirror) return mirror();
    if (hasNode) return node();
    throw OnChainErrors.hederaPlugin(
      'HederaClient',
      reason: 'Neither mirror nor node is enabled by client strategy.',
    );
  }
}

/// Concrete default node-oriented client (single signer).
class DefaultHederaClient extends HederaClient {
  @override
  final HederaAccountID nodeAccountId;

  @override
  final HederaNetwork network;

  @override
  final IGrpcProvider<
    IServiceProvider,
    BaseHederaServiceRequestParams,
    BaseGRPCServiceRequestParams
  >
  internalProvider;
  @override
  final HederaClientSterategy strategy;

  DefaultHederaClient({
    required this.nodeAccountId,
    required this.internalProvider,
    required this.network,
    this.strategy = const HederaClientSterategy(),
  });
}

/// Fungible token metadata (wallet `fetchTokenMetadata` parity without the
/// wallet `Token` wrapper).
class HederaTokenMetadata {
  final String name;
  final String symbol;
  final int decimals;
  const HederaTokenMetadata({
    required this.name,
    required this.symbol,
    required this.decimals,
  });
}

/// Unified transaction status (wallet `WalletTransactionStatus` parity for
/// the Hedera cases).
enum HederaTxStatus {
  /// Mirror execution result reflects success.
  block,

  /// Mirror execution result reflects failure.
  failed,

  /// The transaction is unknown to the mirror (not indexed yet).
  pending,

  /// The transaction id is unparseable locally.
  unknown,
}
