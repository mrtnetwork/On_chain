import 'dart:async';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/address/evm_address.dart';
import 'package:on_chain/ethereum/src/models/block_tag.dart';
import 'package:on_chain/ethereum/src/models/fee_history.dart';
import 'package:on_chain/ethereum/src/models/transaction_receipt.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/methds/contracts/erc1155_balance_of.dart';
import 'package:on_chain/ethereum/src/rpc/methds/contracts/erc1155_transfer_logs.dart';
import 'package:on_chain/ethereum/src/rpc/methds/contracts/erc1155_uri.dart';
import 'package:on_chain/ethereum/src/rpc/methds/contracts/erc20_allowance.dart';
import 'package:on_chain/ethereum/src/rpc/methds/contracts/erc20_balance.dart';
import 'package:on_chain/ethereum/src/rpc/methds/contracts/erc20_decimals.dart';
import 'package:on_chain/ethereum/src/rpc/methds/contracts/erc20_name.dart';
import 'package:on_chain/ethereum/src/rpc/methds/contracts/erc20_symbol.dart';
import 'package:on_chain/ethereum/src/rpc/methds/contracts/erc721_owner_of.dart';
import 'package:on_chain/ethereum/src/rpc/methds/contracts/erc721_token_of_owner_by_index.dart';
import 'package:on_chain/ethereum/src/rpc/methds/contracts/erc721_token_uri.dart';
import 'package:on_chain/ethereum/src/rpc/methds/contracts/erc721_total_supply.dart';
import 'package:on_chain/ethereum/src/rpc/methds/contracts/erc721_transfer_logs.dart';
import 'package:on_chain/ethereum/src/rpc/methds/contracts/inbound_transfer_logs.dart';
import 'package:on_chain/ethereum/src/rpc/methds/contracts/supports_interface.dart';
import 'package:on_chain/ethereum/src/rpc/methds/ethereum/dynamic.dart';
import 'package:on_chain/ethereum/src/rpc/methds/ethereum/estimate_gas.dart';
import 'package:on_chain/ethereum/src/rpc/methds/ethereum/fee_history.dart';
import 'package:on_chain/ethereum/src/rpc/methds/ethereum/get_balance.dart';
import 'package:on_chain/ethereum/src/rpc/methds/ethereum/get_block_number.dart';
import 'package:on_chain/ethereum/src/rpc/methds/ethereum/get_chain_id.dart';
import 'package:on_chain/ethereum/src/rpc/methds/ethereum/get_code.dart';
import 'package:on_chain/ethereum/src/rpc/methds/ethereum/get_gas_price.dart';
import 'package:on_chain/ethereum/src/rpc/methds/ethereum/get_transaction_count.dart';
import 'package:on_chain/ethereum/src/rpc/methds/ethereum/get_transaction_receipt.dart';
import 'package:on_chain/ethereum/src/rpc/methds/ethereum/send_raw_transaction.dart';
import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/solidity/address/core.dart';
import 'package:on_chain/solidity/helper/erc1155.dart';
import 'package:on_chain/solidity/helper/erc20.dart';
import 'package:on_chain/solidity/helper/erc721.dart';

import 'models.dart';

/// Resume checkpoint of a fully-walked per-contract replay. Lets a reopened
/// import skip history: cached ids are re-verified against live balances,
/// then only blocks after [completedTip] are walked.
class _ReplayResumeState {
  int completedTip;
  final Set<BigInt> known;
  _ReplayResumeState({required this.completedTip, Set<BigInt>? known})
    : known = known ?? <BigInt>{};
}

/// Quick client API: one method per top request, each mapped to the Ethereum
/// JSON-RPC backend and returning a single unified result type.
///
abstract mixin class EthereumQuickClientApi {
  /// Single RPC provider serving every call.
  IProvider<IServiceProvider, EthereumRequestDetails> get provider;

  /// Resume checkpoints of fully-walked per-contract replays, keyed by
  /// contract + owner. A reopened import re-verifies the cached ids live
  /// and walks only blocks mined since, instead of all history again.
  /// Session-scoped: they die with the client, a fresh client rescans.
  final Map<String, _ReplayResumeState> _erc1155Resume = {};
  final Map<String, _ReplayResumeState> _erc721Resume = {};

  /// Node `eth_getLogs` range cap learned by probing, cached for the
  /// client's lifetime.
  int? _logRangeCap;

  /// True when [e] is a contract-call revert (negative probe), never a
  /// transport failure.
  static bool isEvmReverted(Object e) {
    if (e is RPCError) {
      return e.message.toLowerCase().contains('revert');
    }
    return false;
  }

  /// Range-limit rejections (node-specific block-range caps) resolve by
  /// splitting, never by surfacing: only these retry, anything else
  /// propagates immediately.
  static bool isEvmRangeLimitError(Object e) {
    if (e is RPCError) {
      return e.errorCode == -32701 ||
          e.message.toLowerCase().contains('block range');
    }
    return false;
  }

  /// Runs [call]; a revert maps to null, any other failure propagates.
  Future<T?> _revertable<T>(Future<T> Function() call) async {
    try {
      return await call();
    } catch (e) {
      if (isEvmReverted(e)) return null;
      rethrow;
    }
  }

  /// Median historical fee levels (slow/normal/high + base fee).
  Future<FeeHistorical> getHistoricalFee() async {
    final historical = await provider.request(
      EthereumRequestGetFeeHistory(
        blockCount: 10,
        newestBlock: BlockTagOrNumber.latest,
        rewardPercentiles: [30, 60, 99],
      ),
    );
    return historical!.toFee();
  }

  /// Same as [getHistoricalFee] but sampled against the pending block so the
  /// returned baseFee is not already one block stale. Use this for building
  /// transactions to avoid underpriced rejections.
  Future<FeeHistorical> getPendingHistoricalFee() async {
    final historical = await provider.request(
      EthereumRequestGetFeeHistory(
        blockCount: 10,
        newestBlock: BlockTagOrNumber.pending,
        rewardPercentiles: [30, 60, 99],
      ),
    );
    return historical!.toFee();
  }

  /// Chain id plus whether the endpoint serves EIP-1559 fee history. Only a
  /// "method not found" failure degrades to `supportsEIP1559: false`
  /// (pre-1559 nodes); any other RPC failure rethrows.
  Future<({BigInt chainId, bool supportsEIP1559})> getNetworkInfo() async {
    final BigInt chainId = await provider.request(EthereumRequestGetChainId());
    try {
      final eip = await provider.request(
        EthereumRequestGetFeeHistory(
          blockCount: 25,
          newestBlock: BlockTagOrNumber.pending,
          rewardPercentiles: [25, 50, 90],
        ),
      );
      return (chainId: chainId, supportsEIP1559: eip != null);
    } on RPCError catch (e) {
      final message = e.message.toLowerCase();
      if (e.errorCode == -32601 ||
          message.contains('not found') ||
          message.contains('not supported') ||
          message.contains('does not exist')) {
        return (chainId: chainId, supportsEIP1559: false);
      }
      rethrow;
    }
  }

  /// Current gas price.
  Future<BigInt> gasPrice() async {
    return provider.request(EthereumRequestGetGasPrice());
  }

  /// Gas estimate for [estimateDetails] (raw `eth_estimateGas` params).
  Future<BigInt> estimateGasLimit(Map<String, dynamic> estimateDetails) async {
    return provider.request(
      EthereumRequestEstimateGas(transaction: estimateDetails),
    );
  }

  /// Transaction count (nonce) of [account].
  Future<int> getAccountNonce(ETHAddress account) async {
    return provider.request(
      EthereumRequestGetTransactionCount(address: account.address),
    );
  }

  /// Broadcasts a signed [digest], returning its hash.
  Future<String> sendRawTransaction(String digest) async {
    return provider.request(
      EthereumRequestSendRawTransaction(transaction: digest),
    );
  }

  /// True when [address] holds contract code.
  Future<bool> isContract(SolidityAddress address) async {
    final code = await provider.request(
      EthereumRequestGetCode(address: address.toSolidityHex()),
    );
    return code != null;
  }

  /// Raw pass-through call for methods without a typed request.
  Future<T> dynamicCall<T>({
    required String method,
    List<dynamic> params = const [],
  }) async {
    final result = await provider.requestDynamic<T, Object?>(
      EthereumRequestDynamic<T>(methodName: method, params: params),
    );
    return result as T;
  }

  /// ERC-20 `decimals`/`name`/`symbol` of [contract], or null when the
  /// contract does not serve metadata (revert). Transport failures throw.
  Future<ERC20TokenMetadata?> getERC20Details(SolidityAddress contract) async {
    final decimals = await _revertable<int?>(
      () => provider.request(EthereumRequestERC20Decimals(contract)),
    );
    if (decimals == null) return null;
    String? symbol = await _revertable<String?>(
      () => provider.request(EthereumRequestERC20Symbol(contract)),
    );
    String? name = await _revertable<String?>(
      () => provider.request(EthereumRequestERC20Name(contract)),
    );
    name ??= symbol;
    symbol ??= name;
    return ERC20TokenMetadata(
      name: name ?? 'Unknown',
      symbol: symbol ?? 'Unknown',
      decimals: decimals,
    );
  }

  /// ERC-20 holding of [account] at [contract], or null when the contract
  /// does not serve metadata (revert). Transport failures throw.
  Future<ERC20TokenBalance?> getAccountERC20Token(
    SolidityAddress account,
    SolidityAddress contract,
  ) async {
    final metadata = await getERC20Details(contract);
    if (metadata == null) return null;
    final balance = await provider.request(
      EthereumRequestERC20Balance(contract.toSolidityHex(), account),
    );
    return ERC20TokenBalance(
      contract: contract.address,
      balance: balance,
      name: metadata.name,
      symbol: metadata.symbol,
      decimals: metadata.decimals,
    );
  }

  /// Chain id of the connected network.
  Future<BigInt> getChainId() async {
    return provider.request(EthereumRequestGetChainId());
  }

  /// True when the connected network matches [expectedChainId].
  Future<bool> validateChainId({required BigInt expectedChainId}) async {
    return await getChainId() == expectedChainId;
  }

  /// ERC-20 `allowance` of [spender] over [owner]'s balance at [contract].
  Future<BigInt> getAllowance({
    required SolidityAddress contract,
    required SolidityAddress owner,
    required SolidityAddress spender,
  }) async {
    return provider.request(
      EthereumRequestERC20Allowance(contract, owner, spender),
    );
  }

  /// Native balance of [address].
  Future<BigInt> getBalance(ETHAddress address) async {
    return provider.request(
      EthereumRequestGetBalance(address: address.address),
    );
  }

  /// Token balance of [address] for [contract]: ERC-1155 `balanceOf` when
  /// [tokenId] is set, otherwise ERC-20 `balanceOf`.
  Future<BigInt> getTokenBalance({
    required SolidityAddress address,
    required SolidityAddress contract,
    BigInt? tokenId,
  }) async {
    final id = tokenId;
    if (id != null) {
      return getERC1155Balance(
        address: address,
        contract: contract,
        tokenId: id,
      );
    }
    return provider.request(
      EthereumRequestERC20Balance(contract.toSolidityHex(), address),
    );
  }

  /// ERC-20 `name`. Null on revert; transport failures throw.
  Future<String?> getERC20Name(SolidityAddress contract) {
    return _revertable<String?>(
      () => provider.request(EthereumRequestERC20Name(contract)),
    );
  }

  /// ERC-20 `symbol`. Null on revert; transport failures throw.
  Future<String?> getERC20Symbol(SolidityAddress contract) {
    return _revertable<String?>(
      () => provider.request(EthereumRequestERC20Symbol(contract)),
    );
  }

  /// Owner of an ERC-721 token, or null when the call reverts (unknown
  /// contract or token id). Transport failures throw.
  Future<ETHAddress?> getERC721Owner({
    required SolidityAddress contract,
    required BigInt tokenId,
  }) {
    return _revertable<ETHAddress?>(
      () => provider.request(EthereumRequestERC721OwnerOf(contract, tokenId)),
    );
  }

  /// ERC-721 `tokenURI`. Null on revert or empty result; transport failures
  /// throw.
  Future<String?> getERC721TokenUri({
    required SolidityAddress contract,
    required BigInt tokenId,
  }) {
    return _revertable<String?>(
      () => provider.request(EthereumRequestERC721TokenUri(contract, tokenId)),
    );
  }

  /// ERC-1155 `uri`. Null on revert or empty result; transport failures
  /// throw. May contain the `{id}` placeholder.
  Future<String?> getERC1155Uri({
    required SolidityAddress contract,
    required BigInt tokenId,
  }) {
    return _revertable<String?>(
      () => provider.request(EthereumRequestERC1155Uri(contract, tokenId)),
    );
  }

  /// ERC-1155 `balanceOf` of [address] for [tokenId].
  Future<BigInt> getERC1155Balance({
    required SolidityAddress address,
    required SolidityAddress contract,
    required BigInt tokenId,
  }) async {
    return provider.request(
      EthereumRequestERC1155BalanceOf(contract, address, tokenId),
    );
  }

  /// ERC-165 `supportsInterface`. Reverts count as unsupported; transport
  /// failures throw.
  Future<bool> supportsInterface({
    required EthereumContractStandard standard,
    required SolidityAddress contract,
    required SolidityAddress from,
  }) async {
    try {
      return await provider.request(
        EthereumRequestSupportsInterface(
          interfaceId: standard.interfaceId,
          contractAddress: contract,
          from: from,
        ),
      );
    } catch (e) {
      if (isEvmReverted(e)) return false;
      rethrow;
    }
  }

  /// Detects the NFT standard of [contract]: ERC-165 interface ids first,
  /// then direct function probing with [tokenId] (`ownerOf` for ERC-721,
  /// `balanceOf` for ERC-1155). Null when nothing matches. Only reverts
  /// count as negative probes; other failures throw.
  Future<EthereumContractStandard?> detectContractStandard({
    required SolidityAddress contract,
    required SolidityAddress from,
    BigInt? tokenId,
  }) async {
    for (final standard in [
      EthereumContractStandard.erc721,
      EthereumContractStandard.erc1155,
    ]) {
      if (await supportsInterface(
        standard: standard,
        contract: contract,
        from: from,
      )) {
        return standard;
      }
    }
    if (tokenId != null) {
      final owner = await getERC721Owner(contract: contract, tokenId: tokenId);
      if (owner != null) return EthereumContractStandard.erc721;
      final balance = await _revertable<BigInt?>(
        () => getERC1155Balance(
          address: from,
          contract: contract,
          tokenId: tokenId,
        ),
      );
      if (balance != null) return EthereumContractStandard.erc1155;
    }
    return null;
  }

  /// Whether [contract] implements ERC-721 Enumerable. Only a revert counts
  /// as "not implemented"; transport failures throw.
  Future<bool> isERC721Enumerable({
    required SolidityAddress contract,
    required SolidityAddress from,
  }) {
    return supportsInterface(
      standard: EthereumContractStandard.erc721Enumerable,
      contract: contract,
      from: from,
    );
  }

  /// Receipt of [transactionHash], or null when unknown.
  Future<TransactionReceipt?> getTransactionReceipt(String transactionHash) {
    return provider.request(
      EthereumRequestGetTransactionReceipt(transactionHash: transactionHash),
    );
  }

  /// Status of a transaction by hash.
  Future<EthTxStatus> transactionStatus(String transactionHash) async {
    final receipt = await getTransactionReceipt(transactionHash);
    if (receipt == null) return EthTxStatus.unknown;
    final status = receipt.status;
    if (status != null && !status) return EthTxStatus.failed;
    return EthTxStatus.block;
  }

  /// Polls until the receipt of [transactionId] lands or [timeout] elapses.
  Future<TransactionReceipt> trackTransaction({
    required String transactionId,
    Duration timeout = const Duration(minutes: 5),
    Duration periodicTimeOut = const Duration(seconds: 3),
  }) async {
    Timer? timer;
    try {
      final Completer<TransactionReceipt> completer =
          Completer<TransactionReceipt>();
      timer = Timer.periodic(periodicTimeOut, (_) async {
        TransactionReceipt? receipt;
        try {
          receipt = await getTransactionReceipt(transactionId);
        } catch (_) {
          receipt = null;
        }
        if (receipt != null && !completer.isCompleted) {
          completer.complete(receipt);
        }
      });
      return await completer.future.timeout(timeout);
    } on TimeoutException {
      throw BuError(
        OnChainErrorType.ethereumPlugin,
        'Transaction confirmation failed within the allotted timeout.',
        details: {'transactionId': transactionId},
      );
    } finally {
      timer?.cancel();
    }
  }

  /// Latest block number.
  Future<BigInt?> getBlockHeight() async {
    final block = await provider.request(EthereumRequestGetBlockNumber());
    return BigInt.from(block);
  }

  /// Calldata encoders (pure: no provider use). They centralize every
  /// transfer/approval encoding previously inlined across the wallet, the
  /// filecoin EVM client and the swap, so calldata shapes stay identical
  /// for all consumers. Results assign directly to `List<int>` fields.

  /// ERC-20 `transfer(to, value)` calldata.
  BuBytes erc20TransferCalldata({
    required SolidityAddress to,
    required BigInt value,
  }) {
    return const ERC20TransferEncoder().encode((to: to, value: value));
  }

  /// ERC-20 `approve(spender, value)` calldata.
  BuBytes erc20ApproveCalldata({
    required SolidityAddress spender,
    required BigInt value,
  }) {
    return const ERC20ApproveEncoder().encode((spender: spender, value: value));
  }

  /// ERC-721 `transferFrom(from, to, tokenId)` calldata.
  BuBytes erc721TransferCalldata({
    required SolidityAddress from,
    required SolidityAddress to,
    required BigInt tokenId,
  }) {
    return const ERC721TransferFromEncoder().encode((
      from: from,
      to: to,
      tokenId: tokenId,
    ));
  }

  /// ERC-721 `approve(to, tokenId)` calldata.
  BuBytes erc721ApproveCalldata({
    required SolidityAddress to,
    required BigInt tokenId,
  }) {
    return const ERC721ApproveEncoder().encode((to: to, tokenId: tokenId));
  }

  /// ERC-1155 `safeTransferFrom(from, to, id, value, data)` calldata.
  BuBytes erc1155SafeTransferFromCalldata({
    required SolidityAddress from,
    required SolidityAddress to,
    required BigInt id,
    required BigInt value,
    List<int> data = const [],
  }) {
    return const ERC1155SafeTransferFromEncoder().encode((
      from: from,
      to: to,
      id: id,
      value: value,
      data: data,
    ));
  }

  /// `setApprovalForAll(operator, approved)` calldata (ERC-1155 and
  /// operator-wide ERC-721 approvals).
  BuBytes setApprovalForAllCalldata({
    required SolidityAddress operator,
    required bool approved,
  }) {
    return const ERC1155SetApprovalForAllEncoder().encode((
      operator: operator,
      approved: approved,
    ));
  }

  /// Upper bound for dense id-space probing. Sequential collections beyond
  /// this fall through to log replay.
  static const int maxProbeTokenIds = 500;

  /// Per-contract Transfer-log replay chunk probe size.
  static const int transferLogChunkSize = 1000000;

  /// Global inbound-scan chunk size, concurrency and split-and-retry bounds.
  static const int inboundScanChunkSize = 100000;
  static const int inboundScanConcurrency = 8;
  static const int inboundScanMaxSplitDepth = 8;
  static const int inboundScanMinChunkSize = 1000;

  static String _replayKey(SolidityAddress contract, SolidityAddress owner) =>
      '${contract.toSolidityHex().toLowerCase()}:'
      '${owner.toSolidityHex().toLowerCase()}';

  /// Node `eth_getLogs` range cap learned by probing, cached for the
  /// client's lifetime. Lets scans chunk at the cap instead of discovering
  /// it through hundreds of rejected oversized requests. Non-range failures
  /// throw immediately.
  Future<int> _resolveLogRangeCap({
    required Future<void> Function(BigInt from, BigInt to) fetch,
    required int tip,
    bool Function()? isCanceled,
  }) async {
    final cached = _logRangeCap;
    if (cached != null) return cached;
    int span = transferLogChunkSize;
    while (span > inboundScanMinChunkSize && isCanceled?.call() != true) {
      BigInt from = BigInt.from(tip - span);
      if (from < BigInt.zero) from = BigInt.zero;
      try {
        await fetch(from, BigInt.from(tip));
      } catch (e) {
        if (!isEvmRangeLimitError(e)) rethrow;
        span ~/= 2;
        continue;
      }
      _logRangeCap = span;
      return span;
    }
    _logRangeCap = span;
    return span;
  }

  /// Fetches per-contract logs over [from]..[to], splitting in half and
  /// retrying while the node rejects the range width. Bounded by [maxDepth]
  /// and [inboundScanMinChunkSize]; non-range failures throw immediately so
  /// partial holdings never look complete.
  Future<List<T>> _fetchLogRange<T>({
    required BigInt from,
    required BigInt to,
    required Future<List<T>> Function(BigInt from, BigInt to) fetch,
    bool Function()? isCanceled,
    int maxDepth = 12,
    int depth = 0,
  }) async {
    if (isCanceled?.call() == true) return <T>[];
    try {
      return await fetch(from, to);
    } catch (e) {
      final span = to - from;
      if (depth >= maxDepth ||
          span <= BigInt.from(inboundScanMinChunkSize) ||
          !isEvmRangeLimitError(e)) {
        rethrow;
      }
    }
    final mid = from + ((to - from) ~/ BigInt.two);
    final left = await _fetchLogRange(
      from: from,
      to: mid,
      fetch: fetch,
      isCanceled: isCanceled,
      maxDepth: maxDepth,
      depth: depth + 1,
    );
    if (isCanceled?.call() == true) return left;
    final right = await _fetchLogRange(
      from: mid + BigInt.one,
      to: to,
      fetch: fetch,
      isCanceled: isCanceled,
      maxDepth: maxDepth,
      depth: depth + 1,
    );
    return [...left, ...right];
  }

  /// Discovers the ERC-721 token ids owned by [owner], cheapest first:
  /// Enumerable enumeration, dense id-space probing through totalSupply,
  /// then Transfer log replay. Emits empty legs never; each strategy throws
  /// on transport failure, only reverts fall through to the next strategy.
  /// Streams the ids cheapest-first with resume support (see
  /// [_ReplayResumeState]).
  Stream<List<BigInt>> watchERC721TokenIds({
    required SolidityAddress contract,
    required SolidityAddress owner,
    required SolidityAddress from,
    bool Function()? isCanceled,
  }) async* {
    if (await isERC721Enumerable(contract: contract, from: from)) {
      final ids = await _enumerateOwnerTokens(
        contract: contract,
        owner: owner,
        isCanceled: isCanceled,
      );
      if (ids.isNotEmpty) {
        yield ids;
        return;
      }
    }
    final probed = await _probeSequentialTokenIds(
      contract: contract,
      owner: owner,
      isCanceled: isCanceled,
    );
    if (probed.isNotEmpty) {
      yield probed;
      return;
    }
    yield* watchERC721Holdings(
      contract: contract,
      owner: owner,
      isCanceled: isCanceled,
    );
  }

  Future<List<BigInt>> _enumerateOwnerTokens({
    required SolidityAddress contract,
    required SolidityAddress owner,
    bool Function()? isCanceled,
  }) async {
    final count = await _revertable<BigInt?>(
      () => getTokenBalance(address: owner, contract: contract),
    );
    if (count == null || count <= BigInt.zero) return const [];
    final capped =
        count > BigInt.from(maxProbeTokenIds)
            ? BigInt.from(maxProbeTokenIds)
            : count;
    final ids = <BigInt>[];
    for (
      BigInt i = BigInt.zero;
      i < capped && isCanceled?.call() != true;
      i += BigInt.from(25)
    ) {
      final chunk = <Future<BigInt?>>[];
      for (
        BigInt j = i;
        j < capped && j < i + BigInt.from(25);
        j += BigInt.one
      ) {
        chunk.add(
          _revertable<BigInt?>(
            () => provider.request(
              EthereumRequestERC721TokenOfOwnerByIndex(contract, owner, j),
            ),
          ),
        );
      }
      for (final r in await Future.wait(chunk)) {
        if (r != null) ids.add(r);
      }
    }
    return ids;
  }

  Future<List<BigInt>> _probeSequentialTokenIds({
    required SolidityAddress contract,
    required SolidityAddress owner,
    bool Function()? isCanceled,
  }) async {
    final total = await _revertable<BigInt?>(
      () => provider.request(EthereumRequestERC721TotalSupply(contract)),
    );
    if (total == null || total <= BigInt.zero) return const [];
    final capped =
        total > BigInt.from(maxProbeTokenIds)
            ? BigInt.from(maxProbeTokenIds)
            : total;
    final ownerAccount = owner.toEthereumAddress();
    final ids = <BigInt>[];
    for (
      BigInt i = BigInt.zero;
      i < capped && isCanceled?.call() != true;
      i += BigInt.from(25)
    ) {
      final chunk = <Future<ETHAddress?>>[];
      for (
        BigInt j = i;
        j < capped && j < i + BigInt.from(25);
        j += BigInt.one
      ) {
        chunk.add(getERC721Owner(contract: contract, tokenId: j));
      }
      var k = 0;
      for (final currentOwner in await Future.wait(chunk)) {
        if (currentOwner == ownerAccount) ids.add(i + BigInt.from(k));
        k++;
      }
    }
    return ids;
  }

  /// Streams the ERC-1155 token ids [owner] still holds, newest blocks
  /// first: each chunk's fresh inbound ids are verified against the live
  /// `balanceOf` (ground truth regardless of scan position) and emitted
  /// immediately, so recent holdings appear without waiting for the full
  /// history walk. Repeat scans resume: cached ids are re-verified live and
  /// only blocks after the previous walk are fetched.
  Stream<List<BigInt>> watchERC1155TokenIds({
    required SolidityAddress contract,
    required SolidityAddress owner,
    bool Function()? isCanceled,
  }) async* {
    final tip = await provider.request(EthereumRequestGetBlockNumber());
    final ownerAccount = owner.toEthereumAddress();
    final chunkSize = await _resolveLogRangeCap(
      fetch: (from, to) async {
        await provider.request(
          EthereumRequestERC1155TransferLogs(
            contract,
            fromBlock: from,
            toBlock: to,
          ),
        );
      },
      tip: tip,
      isCanceled: isCanceled,
    );
    final key = _replayKey(contract, owner);
    final resume = _erc1155Resume[key];
    final seen = <BigInt>{};
    final emitted = <BigInt>{};
    // A previous walk already covered everything through [completedTip]:
    // re-verify the cached ids live, then walk only the blocks mined since.
    if (resume != null) {
      final cached = resume.known.toList();
      final still = <BigInt>[];
      for (final id in cached) {
        if (isCanceled?.call() == true) return;
        final balance = await _revertable<BigInt?>(
          () => getERC1155Balance(
            address: owner,
            contract: contract,
            tokenId: id,
          ),
        );
        if ((balance ?? BigInt.zero) > BigInt.zero) {
          still.add(id);
        } else {
          resume.known.remove(id);
        }
      }
      if (still.isNotEmpty) yield still;
    }
    final BigInt end =
        resume != null
            ? BigInt.from(resume.completedTip) + BigInt.one
            : BigInt.zero;
    BigInt to = BigInt.from(tip);
    while (to >= end && isCanceled?.call() != true) {
      BigInt from = to - BigInt.from(chunkSize);
      if (from < end) from = end;
      final logs = await _fetchLogRange(
        from: from,
        to: to,
        isCanceled: isCanceled,
        fetch:
            (from, to) => provider.request(
              EthereumRequestERC1155TransferLogs(
                contract,
                fromBlock: from,
                toBlock: to,
              ),
            ),
      );
      final fresh = <BigInt>{};
      for (final log in logs) {
        if (log.to == ownerAccount && seen.add(log.tokenId)) {
          fresh.add(log.tokenId);
        }
      }
      final newly = <BigInt>[];
      for (final id in fresh) {
        if (isCanceled?.call() == true) return;
        final balance = await _revertable<BigInt?>(
          () => getERC1155Balance(
            address: owner,
            contract: contract,
            tokenId: id,
          ),
        );
        if ((balance ?? BigInt.zero) > BigInt.zero && emitted.add(id)) {
          newly.add(id);
        }
      }
      if (newly.isNotEmpty) yield newly;
      if (from == end) break;
      to = from - BigInt.one;
    }
    if (isCanceled?.call() == true) return;
    final state = _erc1155Resume.putIfAbsent(
      key,
      () => _ReplayResumeState(completedTip: tip),
    );
    state.completedTip = tip;
    state.known.addAll(emitted);
  }

  /// Streams Transfer-log replay of [contract], newest blocks first: each
  /// chunk's fresh inbound ids are verified against the live `ownerOf`
  /// (ground truth regardless of scan position) and emitted immediately.
  /// Universal fallback: works without Enumerable or dense ids at the
  /// cost of one chunked log scan.
  Stream<List<BigInt>> watchERC721Holdings({
    required SolidityAddress contract,
    required SolidityAddress owner,
    bool Function()? isCanceled,
  }) async* {
    final tip = await provider.request(EthereumRequestGetBlockNumber());
    final ownerAccount = owner.toEthereumAddress();
    final chunkSize = await _resolveLogRangeCap(
      fetch: (from, to) async {
        await provider.request(
          EthereumRequestERC721TransferLogs(
            contract,
            fromBlock: from,
            toBlock: to,
          ),
        );
      },
      tip: tip,
      isCanceled: isCanceled,
    );
    final key = _replayKey(contract, owner);
    final resume = _erc721Resume[key];
    final seen = <BigInt>{};
    final emitted = <BigInt>{};
    // A previous walk already covered everything through [completedTip]:
    // re-verify the cached ids live, then walk only the blocks mined since.
    if (resume != null) {
      final cached = resume.known.toList();
      final still = <BigInt>[];
      for (final id in cached) {
        if (isCanceled?.call() == true) return;
        final currentOwner = await getERC721Owner(
          contract: contract,
          tokenId: id,
        );
        if (currentOwner == ownerAccount) {
          still.add(id);
        } else {
          resume.known.remove(id);
        }
      }
      if (still.isNotEmpty) yield still;
    }
    final BigInt end =
        resume != null
            ? BigInt.from(resume.completedTip) + BigInt.one
            : BigInt.zero;
    BigInt to = BigInt.from(tip);
    while (to >= end && isCanceled?.call() != true) {
      BigInt from = to - BigInt.from(chunkSize);
      if (from < end) from = end;
      final logs = await _fetchLogRange(
        from: from,
        to: to,
        isCanceled: isCanceled,
        fetch:
            (from, to) => provider.request(
              EthereumRequestERC721TransferLogs(
                contract,
                fromBlock: from,
                toBlock: to,
              ),
            ),
      );
      final fresh = <BigInt>{};
      for (final log in logs) {
        if (log.to == ownerAccount && seen.add(log.tokenId)) {
          fresh.add(log.tokenId);
        }
      }
      final newly = <BigInt>[];
      for (final id in fresh) {
        if (isCanceled?.call() == true) return;
        final currentOwner = await getERC721Owner(
          contract: contract,
          tokenId: id,
        );
        if (currentOwner == ownerAccount && emitted.add(id)) {
          newly.add(id);
        }
      }
      if (newly.isNotEmpty) yield newly;
      if (from == end) break;
      to = from - BigInt.one;
    }
    if (isCanceled?.call() == true) return;
    final state = _erc721Resume.putIfAbsent(
      key,
      () => _ReplayResumeState(completedTip: tip),
    );
    state.completedTip = tip;
    state.known.addAll(emitted);
  }

  /// Global inbound-transfer scan for [owner], classified by standard.
  ///
  /// Two log filters per chunk cover all three standards: 3-topic
  /// `Transfer` (ERC-20-shaped) plus 4-topic `Transfer` (ERC-721) in one,
  /// `TransferSingle`/`TransferBatch` (ERC-1155) in the other. Ranges
  /// partition `[0, tip]` without overlap, so each log is read exactly
  /// once; contracts and token ids merge into sets, so repeated logs from
  /// the same sender are classified once and verified once downstream.
  /// Nodes that cap the log range below [inboundScanChunkSize] trigger
  /// split-and-retry down to [inboundScanMinChunkSize]; any other log
  /// failure throws since partial holdings must never look complete.
  Future<EvmInboundHoldings> findInboundHoldings({
    required ETHAddress owner,
    bool Function()? isCanceled,
  }) async {
    final tip = await provider.request(EthereumRequestGetBlockNumber());
    final cap = await _resolveLogRangeCap(
      fetch: (from, to) async {
        await provider.request(
          EthereumRequestERC20ERC721InboundTransferLogs(
            owner: owner,
            fromBlock: from,
            toBlock: to,
          ),
        );
        await provider.request(
          EthereumRequestERC1155InboundTransferLogs(
            owner: owner,
            fromBlock: from,
            toBlock: to,
          ),
        );
      },
      tip: tip,
      isCanceled: isCanceled,
    );
    final chunkSize = cap > inboundScanChunkSize ? inboundScanChunkSize : cap;
    final ranges = <(BigInt, BigInt)>[];
    BigInt from = BigInt.zero;
    final bigTip = BigInt.from(tip);
    while (from <= bigTip) {
      BigInt to = from + BigInt.from(chunkSize);
      if (to > bigTip) to = bigTip;
      ranges.add((from, to));
      if (to >= bigTip) break;
      from = to + BigInt.one;
    }
    final erc20 = <String>{};
    final erc721 = <String, Set<BigInt>>{};
    final erc1155 = <String, Set<BigInt>>{};
    void merge(
      Set<String> contracts,
      Map<String, Set<BigInt>> erc721legs,
      List<({String contract, Erc1155TransferLog leg})> legs,
    ) {
      erc20.addAll(contracts);
      erc721legs.forEach(
        (contract, ids) =>
            erc721.putIfAbsent(contract, () => <BigInt>{}).addAll(ids),
      );
      for (final entry in legs) {
        erc1155
            .putIfAbsent(entry.contract, () => <BigInt>{})
            .add(entry.leg.tokenId);
      }
    }

    for (
      int i = 0;
      i < ranges.length && isCanceled?.call() != true;
      i += inboundScanConcurrency
    ) {
      final batch = ranges.skip(i).take(inboundScanConcurrency);
      final results = await Future.wait(
        batch.map(
          (r) => _fetchInboundRange(
            owner: owner,
            from: r.$1,
            to: r.$2,
            isCanceled: isCanceled,
          ),
        ),
      );
      if (isCanceled?.call() == true) break;
      for (final r in results) {
        merge(r.erc20Contracts, r.erc721, r.erc1155);
      }
    }
    return EvmInboundHoldings(
      erc20Contracts: erc20,
      erc721: erc721,
      erc1155: erc1155,
    );
  }

  /// Fetches one scan range, splitting in half and retrying while the node
  /// rejects the range width. Bounded by [inboundScanMaxSplitDepth] and
  /// [inboundScanMinChunkSize]; non-range failures throw immediately.
  Future<
    ({
      Set<String> erc20Contracts,
      Map<String, Set<BigInt>> erc721,
      List<({String contract, Erc1155TransferLog leg})> erc1155,
    })
  >
  _fetchInboundRange({
    required ETHAddress owner,
    required BigInt from,
    required BigInt to,
    bool Function()? isCanceled,
    int depth = 0,
  }) async {
    if (isCanceled?.call() == true) {
      return (
        erc20Contracts: <String>{},
        erc721: <String, Set<BigInt>>{},
        erc1155: <({String contract, Erc1155TransferLog leg})>[],
      );
    }
    try {
      final transfers = await provider.request(
        EthereumRequestERC20ERC721InboundTransferLogs(
          owner: owner,
          fromBlock: from,
          toBlock: to,
        ),
      );
      final nftTransfers = await provider.request(
        EthereumRequestERC1155InboundTransferLogs(
          owner: owner,
          fromBlock: from,
          toBlock: to,
        ),
      );
      return (
        erc20Contracts: transfers.erc20Contracts,
        erc721: transfers.erc721,
        erc1155: nftTransfers,
      );
    } catch (e) {
      final span = to - from;
      if (depth >= inboundScanMaxSplitDepth ||
          span <= BigInt.from(inboundScanMinChunkSize) ||
          !isEvmRangeLimitError(e)) {
        rethrow;
      }
    }
    final mid = from + ((to - from) ~/ BigInt.two);
    final left = await _fetchInboundRange(
      owner: owner,
      from: from,
      to: mid,
      isCanceled: isCanceled,
      depth: depth + 1,
    );
    if (isCanceled?.call() == true) return left;
    final right = await _fetchInboundRange(
      owner: owner,
      from: mid + BigInt.one,
      to: to,
      isCanceled: isCanceled,
      depth: depth + 1,
    );
    final l = left;
    final r = right;
    final erc721 = <String, Set<BigInt>>{};
    l.erc721.forEach(
      (contract, ids) =>
          erc721.putIfAbsent(contract, () => <BigInt>{}).addAll(ids),
    );
    r.erc721.forEach(
      (contract, ids) =>
          erc721.putIfAbsent(contract, () => <BigInt>{}).addAll(ids),
    );
    return (
      erc20Contracts: {...l.erc20Contracts, ...r.erc20Contracts},
      erc721: erc721,
      erc1155: [...l.erc1155, ...r.erc1155],
    );
  }
}
