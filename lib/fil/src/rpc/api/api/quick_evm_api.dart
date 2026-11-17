import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/ethereum/src/address/evm_address.dart';
import 'package:on_chain/ethereum/src/rpc/methds/contracts/erc1155_transfer_logs.dart';
import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/fil/fil.dart';
import 'package:on_chain/solidity/address/core.dart';
import 'package:on_chain/solidity/helper/helper.dart';

/// FRC-42 hashed method number of the EVM contract actor's
/// `InvokeContract` (`frc42_dispatch::method_hash!("InvokeEVM")` in
/// builtin-actors): `blake2b_512("1|InvokeEVM")[0:4]` as u32 BE.
/// Verified against the actors source, not assumed sequential: method 2
/// is `Resurrect`.
abstract final class FilEvmMethods {
  static final BigInt invokeContract = BigInt.from(3844450837);
}

/// Revert of a read-only EVM call (`StateCall` exit code != 0, including
/// the EVM revert code 33).
///
/// Only reverts count as negative probes (not a contract, unknown
/// selector, unheld NFT). Any other failure (RPC/transport/node)
/// propagates and must never prune or zero cached state.
///
/// One probed query method: display name plus whether the `StateCall`
/// exited OK with a decodable return of the expected shape. Only
/// read-only queries are probed; state-changing methods (transfer,
/// approve, ...) are exercised through real messages instead.
class FilEvmMethodProbe {
  final String method;
  final bool supported;
  const FilEvmMethodProbe(this.method, this.supported);
}

/// Standard support for one contract: whether it matches the probed
/// standard plus the per-method probe matrix shown in the import preview.
class FilEvmSupport {
  final bool matches;
  final List<FilEvmMethodProbe> methods;
  const FilEvmSupport({required this.matches, required this.methods});

  bool methodSupported(String method) =>
      methods.where((e) => e.method == method).firstOrNull?.supported ?? false;
}

/// ERC-20-style token metadata read through FEVM (wallet `Token` parity
/// without the wallet wrapper: `decimals` is required).
class FilEvmTokenMetadata {
  final String name;
  final String symbol;
  final int decimals;
  const FilEvmTokenMetadata({
    required this.name,
    required this.symbol,
    required this.decimals,
  });
}

/// Resume state for a tip-first 1155 id walk: ids verified through
/// [completedTip]; repeat walks fetch only newer epochs.
class _FilErc1155Resume {
  BigInt completedTip;
  final Set<BigInt> known = {};
  _FilErc1155Resume({required this.completedTip});
}

/// Filecoin FEVM token reads over Lotus `StateCall` with native messages.
///
/// Every call targets the contract actor with method `InvokeContract` and
/// CBOR byte-string params holding the raw EVM calldata; the receipt
/// return is a CBOR byte string wrapping the raw EVM returndata, which
/// is then ABI-decoded. Writes reuse the same message shape through the
/// regular native message flow (estimate/gas/sign/push), so Filecoin
/// native signing just works.
///
/// Error contract: revert-shaped failures map to the documented negative
/// value (`null` / `false` / zero / unsupported probe); any other failure
/// (RPC/transport/node) throws.
mixin FilQuickEvmApi {
  static const ERC20AllowanceEncoder _erc20AllowanceEncoder =
      ERC20AllowanceEncoder();

  static const ERC721IsApprovedForAllEncoder _erc721IsApprovedForAllEncoder =
      ERC721IsApprovedForAllEncoder();

  static final Map<String, _FilErc1155Resume> _filErc1155Resume = {};

  /// Epoch window per GetLogs call. Filecoin epochs are 30s; this covers
  /// ~17h per request without tripping node range caps.
  static const int _filErc1155LogChunk = 2000;

  /// Network configuration (actor CIDs, address prefix, …).
  FilNetworkConfig get network;

  /// Single Lotus provider serving every call.
  IProvider<IServiceProvider, BaseServiceRequestParams> get provider;

  /// Runs [calldata] against [contract] without persisting changes and
  /// returns the raw EVM returndata. `from` is the contract itself: it is
  /// always instantiated, while a fresh owner account may not resolve yet.
  /// Nonzero exits (including EVM revert 33) throw [BuError].
  Future<List<int>> _evmCall({
    required FilAddress contract,
    required List<int> calldata,
  }) async {
    final result = await provider.request(
      LotusFullNodeRequestStateCall(
        message: FilMessage(
          to: contract,
          from: contract,
          nonce: BigInt.zero,
          value: FilTokenAmount.zero(),
          gasLimit: BigInt.zero,
          gasFeeCap: FilTokenAmount.zero(),
          gasPremium: FilTokenAmount.zero(),
          method: FilEvmMethods.invokeContract,
          params: calldata.toCborBytes().encode(),
        ),
      ),
    );
    final receipt = result?.msgRct;
    if (receipt == null || receipt.exitCode != BigInt.zero) {
      throw BuError(
        OnChainErrorType.filEvmRevert,
        'EVM call reverted with exit code ${receipt?.exitCode}.',
        details: {'calldataLength': '${calldata.length}'},
      );
    }
    final raw = receipt.returnValue ?? [];
    if (raw.isEmpty) {
      throw const BuError(
        OnChainErrorType.filEvmRevert,
        'Empty receipt return data.',
      );
    }
    final obj = CborObject.fromCbor(raw);
    final inner = List<int>.from((obj as CborBytesValue).value);
    if (inner.isEmpty) {
      throw const BuError(
        OnChainErrorType.filEvmRevert,
        'Empty inner return data.',
      );
    }
    return inner;
  }

  /// ABI-decodes [raw] returndata through [encoder]. Malformed output
  /// counts as a negative probe like a revert, never as transport truth,
  /// so decode failures surface as [BuError] for the probe
  /// and import flows to absorb.
  O _decodeWith<I extends Object?, O extends Object?>(
    List<int> raw,
    SolidityFunctionEncoder<I, O> encoder,
    String method,
  ) {
    try {
      return encoder.decodeOutput(raw);
    } catch (_) {
      throw BuError(
        OnChainErrorType.filEvmRevert,
        'Failed to decode $method return data.',
        details: {'method': method, 'length': '${raw.length}'},
      );
    }
  }

  /// Normalizes user input to the contract actor address: `0x` through
  /// `EthAddressToFilecoinAddress`, anything else as a Filecoin address.
  /// Throws on invalid input and RPC failure alike.
  Future<FilAddress> filContractAddress(String input) async {
    final trimmed = input.trim();
    if (trimmed.startsWith('0x') || trimmed.startsWith('0X')) {
      ETHAddress(trimmed);
      final faddr = await provider.request(
        LotusFullNodeRequestEthAddressToFilecoinAddress(ethAddress: trimmed),
      );
      return FilAddress(faddr);
    }
    return FilAddress(trimmed);
  }

  /// Resolves any Filecoin address to its `0x` form for ABI encoding.
  Future<String> filToEthAddress(FilAddress address) async {
    final eth = await provider.request(
      LotusFullNodeRequestFilecoinAddressToEthAddress(
        params: [address.address, 'finalized'],
      ),
    );
    return ETHAddress(eth).address;
  }

  /// Resolves any address to its EVM form for ABI encoding: `0x` views
  /// pass through untouched, native addresses go through
  /// `FilecoinAddressToEthAddress`.
  Future<FilEthereumAddress> filResolveEthAddress(
    BaseFilAddress address,
  ) async {
    if (address is FilEthereumAddress) return address;
    final eth = await filToEthAddress(address as FilAddress);
    return FilEthereumAddress(eth);
  }

  Future<String?> _evmString({
    required FilAddress contract,
    required SolidityFunctionEncoder<Null, String> encoder,
  }) async {
    try {
      final raw = await _evmCall(
        contract: contract,
        calldata: encoder.encodeCall(),
      );
      try {
        return encoder.decodeOutput(raw);
      } catch (_) {
        return null;
      }
    } on BuError catch (e) {
      if (e.type != OnChainErrorType.filEvmRevert) rethrow;
      return null;
    }
  }

  /// ERC-20 metadata. `decimals` is required (amounts are meaningless
  /// without it); name/symbol fall back to the actor address, mirroring
  /// the ethereum client. Null only on revert.
  Future<FilEvmTokenMetadata?> fetchErc20Metadata(FilAddress contract) async {
    int? decimals;
    try {
      final raw = await _evmCall(
        contract: contract,
        calldata: const ERC20DecimalsEncoder().encodeCall(),
      );
      final decimalsValue = _decodeWith(
        raw,
        const ERC20DecimalsEncoder(),
        'decimals',
      );
      decimals = decimalsValue.toInt();
    } on BuError catch (e) {
      if (e.type != OnChainErrorType.filEvmRevert) rethrow;
      return null;
    }
    final name = await _evmString(
      contract: contract,
      encoder: const ERC20NameEncoder(),
    );
    final symbol = await _evmString(
      contract: contract,
      encoder: const ERC20SymbolEncoder(),
    );
    final label = name ?? symbol ?? contract.address;
    return FilEvmTokenMetadata(
      name: label,
      symbol: symbol ?? label,
      decimals: decimals,
    );
  }

  /// ERC-20 `balanceOf`. Throws on revert and RPC failure alike; callers
  /// map reverts to negative probes and keep cached state on RPC errors.
  Future<BigInt> fetchErc20Balance({
    required FilAddress contract,
    required String ownerEth,
  }) async {
    final raw = await _evmCall(
      contract: contract,
      calldata: const ERC20BalanceOfEncoder().encode(SolidityAddress(ownerEth)),
    );
    return const ERC20BalanceOfEncoder().decodeOutput(raw);
  }

  /// ERC-20 `allowance`. Revert reads as zero (no allowance support);
  /// RPC failures throw.
  Future<BigInt> fetchErc20Allowance({
    required FilAddress contract,
    required String ownerEth,
    required String spenderEth,
  }) async {
    try {
      final raw = await _evmCall(
        contract: contract,
        calldata: FilQuickEvmApi._erc20AllowanceEncoder.encode((
          owner: SolidityAddress(ownerEth),
          spender: SolidityAddress(spenderEth),
        )),
      );
      return await _decodeWith(
        raw,
        FilQuickEvmApi._erc20AllowanceEncoder,
        'allowance',
      );
    } on BuError catch (e) {
      if (e.type != OnChainErrorType.filEvmRevert) rethrow;
      return BigInt.zero;
    }
  }

  /// ERC-165 `supportsInterface(bytes4)`. Revert reads as unsupported;
  /// RPC failures throw.
  Future<bool> filSupportsInterface({
    required FilAddress contract,
    required String interfaceId,
  }) async {
    const encoder = SupportsInterfaceEncoder();
    try {
      final raw = await _evmCall(
        contract: contract,
        calldata: encoder.encode(BytesUtils.fromHexString(interfaceId)),
      );
      return await _decodeWith(raw, encoder, 'supportsInterface');
    } on BuError catch (e) {
      if (e.type != OnChainErrorType.filEvmRevert) rethrow;
      return false;
    }
  }

  /// ERC-1155 `balanceOf`. Throws on revert and RPC failure alike; callers
  /// map reverts to negative probes and keep cached state on RPC errors.
  Future<BigInt> fetchErc1155Balance({
    required FilAddress contract,
    required String ownerEth,
    required BigInt tokenId,
  }) async {
    const encoder = ERC1155BalanceOfEncoder();
    final raw = await _evmCall(
      contract: contract,
      calldata: encoder.encode((
        account: SolidityAddress(ownerEth),
        id: tokenId,
      )),
    );
    return _decodeWith(raw, encoder, 'balanceOf');
  }

  /// ERC-721 collection metadata. Null only on revert.
  Future<FilEvmTokenMetadata?> fetchErc721Metadata(FilAddress contract) async {
    final name = await _evmString(
      contract: contract,
      encoder: const ERC20NameEncoder(),
    );
    final symbol = await _evmString(
      contract: contract,
      encoder: const ERC20SymbolEncoder(),
    );
    if (name == null && symbol == null) return null;
    final label = name ?? symbol ?? contract.address;
    return FilEvmTokenMetadata(
      name: label,
      symbol: symbol ?? label,
      decimals: 0,
    );
  }

  /// ERC-721 `balanceOf` (NFT count held). Throws like [fetchErc20Balance].
  Future<BigInt> fetchErc721Balance({
    required FilAddress contract,
    required String ownerEth,
  }) async {
    const encoder = ERC20BalanceOfEncoder();
    final raw = await _evmCall(
      contract: contract,
      calldata: encoder.encode(SolidityAddress(ownerEth)),
    );
    return _decodeWith(raw, encoder, 'balanceOf');
  }

  /// ERC-721 `ownerOf` as the EVM address type. Null on revert
  /// (unknown/burnt token); RPC failures throw.
  Future<FilEthereumAddress?> fetchErc721Owner({
    required FilAddress contract,
    required BigInt tokenId,
  }) async {
    const encoder = ERC721OwnerOfEncoder();
    try {
      final raw = await _evmCall(
        contract: contract,
        calldata: encoder.encode(tokenId),
      );
      final owner = _decodeWith(raw, encoder, 'ownerOf');
      return FilEthereumAddress(owner.toEthereumAddress().address);
    } on BuError catch (e) {
      if (e.type != OnChainErrorType.filEvmRevert) rethrow;
      return null;
    }
  }

  /// ERC-721 `isApprovedForAll`. Revert reads as false; RPC failures
  /// throw.
  Future<bool> fetchErc721IsApprovedForAll({
    required FilAddress contract,
    required String ownerEth,
    required String operatorEth,
  }) async {
    try {
      final raw = await _evmCall(
        contract: contract,
        calldata: FilQuickEvmApi._erc721IsApprovedForAllEncoder.encode((
          owner: SolidityAddress(ownerEth),
          operator: SolidityAddress(operatorEth),
        )),
      );
      return await _decodeWith(
        raw,
        FilQuickEvmApi._erc721IsApprovedForAllEncoder,
        'isApprovedForAll',
      );
    } on BuError catch (e) {
      if (e.type != OnChainErrorType.filEvmRevert) rethrow;
      return false;
    }
  }

  /// ERC-20 support probe over read-only queries: name/symbol/decimals
  /// plus `balanceOf` verify the token shape, `allowance` verifies
  /// operator support. Reverts read as unsupported; RPC failures throw
  /// and abort the probe.
  Future<FilEvmSupport> filProbeErc20({
    required FilAddress contract,
    required String ownerEth,
  }) async {
    Future<bool> query<I extends Object?, O extends Object?>(
      String label,
      SolidityFunctionEncoder<I, O> encoder,
      Future<List<int>> Function() call,
    ) async {
      try {
        final raw = await call();
        _decodeWith(raw, encoder, label);
        return true;
      } on BuError catch (e) {
        if (e.type != OnChainErrorType.filEvmRevert) rethrow;
        return false;
      }
    }

    const nameEncoder = ERC20NameEncoder();
    const symbolEncoder = ERC20SymbolEncoder();
    const decimalsEncoder = ERC20DecimalsEncoder();
    const balanceEncoder = ERC20BalanceOfEncoder();
    final nameOk = await query(
      'name',
      nameEncoder,
      () => _evmCall(contract: contract, calldata: nameEncoder.encodeCall()),
    );
    final symbolOk = await query(
      'symbol',
      symbolEncoder,
      () => _evmCall(contract: contract, calldata: symbolEncoder.encodeCall()),
    );
    bool decimalsOk = false;
    try {
      final raw = await _evmCall(
        contract: contract,
        calldata: decimalsEncoder.encodeCall(),
      );
      _decodeWith(raw, decimalsEncoder, 'decimals');
      decimalsOk = true;
    } on BuError catch (e) {
      if (e.type != OnChainErrorType.filEvmRevert) rethrow;
      decimalsOk = false;
    }
    bool balanceOk = false;
    try {
      final raw = await _evmCall(
        contract: contract,
        calldata: balanceEncoder.encode(SolidityAddress(ownerEth)),
      );
      _decodeWith(raw, balanceEncoder, 'balanceOf');
      balanceOk = true;
    } on BuError catch (e) {
      if (e.type != OnChainErrorType.filEvmRevert) rethrow;
      balanceOk = false;
    }
    final allowanceOk = await query(
      'allowance',
      FilQuickEvmApi._erc20AllowanceEncoder,
      () => _evmCall(
        contract: contract,
        calldata: FilQuickEvmApi._erc20AllowanceEncoder.encode((
          owner: SolidityAddress(ownerEth),
          spender: SolidityAddress(ownerEth),
        )),
      ),
    );
    final isToken = decimalsOk && balanceOk;
    return FilEvmSupport(
      matches: isToken,
      methods: [
        FilEvmMethodProbe('name', nameOk),
        FilEvmMethodProbe('symbol', symbolOk),
        FilEvmMethodProbe('decimals', decimalsOk),
        FilEvmMethodProbe('balanceOf', balanceOk),
        FilEvmMethodProbe('allowance', allowanceOk),
      ],
    );
  }

  /// ERC-721 support probe: name/symbol plus `balanceOf` verify the
  /// collection shape, `ownerOf` verifies the token and its owner,
  /// `isApprovedForAll` verifies operator support. Reverts read as
  /// unsupported; RPC failures throw.
  Future<FilEvmSupport> filProbeErc721({
    required FilAddress contract,
    required String ownerEth,
    required BigInt tokenId,
  }) async {
    const nameEncoder = ERC20NameEncoder();
    const symbolEncoder = ERC20SymbolEncoder();
    const balanceEncoder = ERC20BalanceOfEncoder();
    final name = await _evmString(contract: contract, encoder: nameEncoder);
    final symbol = await _evmString(contract: contract, encoder: symbolEncoder);
    bool balanceOk = false;
    try {
      final raw = await _evmCall(
        contract: contract,
        calldata: balanceEncoder.encode(SolidityAddress(ownerEth)),
      );
      _decodeWith(raw, balanceEncoder, 'balanceOf');
      balanceOk = true;
    } on BuError catch (e) {
      if (e.type != OnChainErrorType.filEvmRevert) rethrow;
      balanceOk = false;
    }
    final owner = await fetchErc721Owner(contract: contract, tokenId: tokenId);
    final approved = await fetchErc721IsApprovedForAll(
      contract: contract,
      ownerEth: ownerEth,
      operatorEth: ownerEth,
    );
    final owns =
        owner != null && owner.address.toLowerCase() == ownerEth.toLowerCase();
    final isCollection = (name != null || symbol != null) && balanceOk;
    return FilEvmSupport(
      matches: isCollection && owns,
      methods: [
        FilEvmMethodProbe('name', name != null),
        FilEvmMethodProbe('symbol', symbol != null),
        FilEvmMethodProbe('balanceOf', balanceOk),
        FilEvmMethodProbe('ownerOf', owns),
        FilEvmMethodProbe('isApprovedForAll', approved),
      ],
    );
  }

  /// ERC-1155 fungible support probe for [contract] + [tokenId]: the
  /// ERC-165 interface id must match and `balanceOf` must read. Name and
  /// symbol are best-effort (decimals stay zero), so gaps mark the token
  /// unknown for the editable review page. Reverts read as unsupported;
  /// RPC failures throw and abort the probe.
  Future<FilEvmSupport> filProbeErc1155({
    required FilAddress contract,
    required String ownerEth,
    required BigInt tokenId,
  }) async {
    final iface = await filSupportsInterface(
      contract: contract,
      interfaceId: '0xd9b67a26',
    );
    const balanceEncoder = ERC1155BalanceOfEncoder();
    bool balanceOk = false;
    try {
      final raw = await _evmCall(
        contract: contract,
        calldata: balanceEncoder.encode((
          account: SolidityAddress(ownerEth),
          id: tokenId,
        )),
      );
      _decodeWith(raw, balanceEncoder, 'balanceOf');
      balanceOk = true;
    } on BuError catch (e) {
      if (e.type != OnChainErrorType.filEvmRevert) rethrow;
      balanceOk = false;
    }
    final name = await _evmString(
      contract: contract,
      encoder: const ERC20NameEncoder(),
    );
    final symbol = await _evmString(
      contract: contract,
      encoder: const ERC20SymbolEncoder(),
    );
    return FilEvmSupport(
      matches: iface && balanceOk,
      methods: [
        FilEvmMethodProbe('supportsInterface', iface),
        FilEvmMethodProbe('name', name != null),
        FilEvmMethodProbe('symbol', symbol != null),
        FilEvmMethodProbe('balanceOf', balanceOk),
      ],
    );
  }

  /// Streams the ERC-1155 token ids [ownerEth] holds on [contract],
  /// newest epochs first: each chunk's fresh inbound ids are verified
  /// against the live `balanceOf` (ground truth regardless of scan
  /// position) and emitted immediately, so recent holdings appear without
  /// waiting for the full history walk.
  /// Repeat scans resume: cached ids are re-verified live and only epochs
  /// after the previous walk are fetched. Transport failures throw;
  /// cancellation is a [isCanceled] callback.
  Stream<List<BigInt>> watchFilErc1155TokenIds({
    required FilEthereumAddress contract,
    required String ownerEth,
    bool Function()? isCanceled,
  }) async* {
    final actor = contract.toFilAddress(network: network.network);
    final tip = await provider.request(LotusFullNodeRequestEthBlockNumber());
    final owner = ownerEth.toLowerCase();
    final key =
        '${network.network.name}:${contract.address.toLowerCase()}:$owner';
    final resume = FilQuickEvmApi._filErc1155Resume[key];
    final seen = <BigInt>{};
    final emitted = <BigInt>{};
    // A previous walk already covered everything through [completedTip]:
    // re-verify the cached ids live, then walk only the epochs mined since.
    if (resume != null) {
      final cached = resume.known.toList();
      final still = <BigInt>[];
      for (final id in cached) {
        if (isCanceled?.call() == true) return;
        BigInt? balance;
        try {
          balance = await fetchErc1155Balance(
            contract: actor,
            ownerEth: ownerEth,
            tokenId: id,
          );
        } on BuError catch (e) {
          if (e.type != OnChainErrorType.filEvmRevert) rethrow;
          balance = null;
        }
        if ((balance ?? BigInt.zero) > BigInt.zero) {
          still.add(id);
        } else {
          resume.known.remove(id);
        }
      }
      if (still.isNotEmpty) yield still;
    }
    final BigInt end =
        resume != null ? resume.completedTip + BigInt.one : BigInt.zero;
    BigInt to = tip;
    while (to >= end && isCanceled?.call() != true) {
      BigInt from = to - BigInt.from(FilQuickEvmApi._filErc1155LogChunk);
      if (from < end) from = end;
      final logs = await provider.request(
        LotusFullNodeRequestEthGetLogs(
          ethFilterSpec: LotusParamsEthFilterSpec(
            address: [contract.address],
            topics: [
              [
                const ERC1155TransferSingleDecoder().signatureHex,
                const ERC1155TransferBatchDecoder().signatureHex,
              ],
            ],
            fromBlock: from.toHexaDecimal,
            toBlock: to.toHexaDecimal,
          ),
        ),
      );
      final fresh = <BigInt>{};
      for (final log in EthereumRequestERC1155TransferLogs.decodeLogs(logs)) {
        if (log.to.address.toLowerCase() == owner && seen.add(log.tokenId)) {
          fresh.add(log.tokenId);
        }
      }
      final newly = <BigInt>[];
      for (final id in fresh) {
        if (isCanceled?.call() == true) return;
        BigInt? balance;
        try {
          balance = await fetchErc1155Balance(
            contract: actor,
            ownerEth: ownerEth,
            tokenId: id,
          );
        } on BuError catch (e) {
          if (e.type != OnChainErrorType.filEvmRevert) rethrow;
          continue;
        }
        if (balance > BigInt.zero && emitted.add(id)) {
          newly.add(id);
        }
      }
      if (newly.isNotEmpty) yield newly;
      if (from == end) break;
      to = from - BigInt.one;
    }
    if (isCanceled?.call() == true) return;
    final state = FilQuickEvmApi._filErc1155Resume.putIfAbsent(
      key,
      () => _FilErc1155Resume(completedTip: tip),
    );
    state.completedTip = tip;
    state.known.addAll(emitted);
  }

  /// Native message skeleton invoking [calldata] on [contract] through
  /// the EVM actor. Gas is estimated downstream; value stays zero.
  FilMessage filInvokeMessage({
    required FilAddress contract,
    required FilAddress from,
    required List<int> calldata,
  }) {
    return FilMessage(
      to: contract,
      from: from,
      nonce: BigInt.zero,
      value: FilTokenAmount.zero(),
      gasLimit: BigInt.zero,
      gasFeeCap: FilTokenAmount.zero(),
      gasPremium: FilTokenAmount.zero(),
      method: FilEvmMethods.invokeContract,
      params: calldata.toCborBytes().encode(),
    );
  }
}

/// Pure calldata builders for FEVM writes (no RPC).
///
abstract final class FilQuickEvmApiUtils {
  /// ERC-20 `transfer(to, amount)` calldata.
  static List<int> filErc20TransferCalldata({
    required String toEth,
    required BigInt amount,
  }) {
    return const ERC20TransferEncoder().encode((
      to: SolidityAddress(toEth),
      value: amount,
    ));
  }

  /// ERC-20 `approve(spender, amount)` calldata.
  static List<int> filErc20ApproveCalldata({
    required String spenderEth,
    required BigInt amount,
  }) {
    return const ERC20ApproveEncoder().encode((
      spender: SolidityAddress(spenderEth),
      value: amount,
    ));
  }

  /// ERC-721 `transferFrom(from, to, tokenId)` calldata.
  static List<int> filErc721TransferCalldata({
    required String fromEth,
    required String toEth,
    required BigInt tokenId,
  }) {
    return const ERC721TransferFromEncoder().encode((
      from: SolidityAddress(fromEth),
      to: SolidityAddress(toEth),
      tokenId: tokenId,
    ));
  }

  /// ERC-721 `approve(to, tokenId)` calldata.
  static List<int> filErc721ApproveCalldata({
    required String toEth,
    required BigInt tokenId,
  }) {
    return const ERC721ApproveEncoder().encode((
      to: SolidityAddress(toEth),
      tokenId: tokenId,
    ));
  }

  /// ERC-721 `setApprovalForAll(operator, approved)` calldata.
  static List<int> filErc721SetApprovalForAllCalldata({
    required String operatorEth,
    required bool approved,
  }) {
    return const ERC1155SetApprovalForAllEncoder().encode((
      operator: SolidityAddress(operatorEth),
      approved: approved,
    ));
  }
}
