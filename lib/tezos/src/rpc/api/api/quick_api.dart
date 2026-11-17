import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tezos/src/address/address.dart';
import 'package:on_chain/tezos/src/rpc/api/types/account.dart';
import 'package:on_chain/tezos/src/rpc/core/core.dart';
import 'package:on_chain/tezos/src/rpc/methods/methods.dart';
import 'package:on_chain/tezos/src/rpc/types/types.dart';
import 'package:on_chain/tezos/src/rpc/api/utils/extensions.dart';
import 'package:on_chain/tezos/src/rpc/api/types/client_config.dart';
import 'package:on_chain/tezos/src/utils/utils.dart';

abstract mixin class TezosQuickApi {
  /// Defaults for chain / version / confirmation polling.
  TezosClientConfig get config;

  IProvider<IServiceProvider, OctezRequestDetails> get provider;

  // ---------------------------------------------------------------------------
  // Account / contract (protocol)
  // ---------------------------------------------------------------------------

  Future<BigInt> getBalance(TezosAddress address) async {
    final result = await provider.request(
      OctezUshuaiaRequestContextContractsContractIdBalance(
        contractId: address.address,
      ),
    );
    return BigintUtils.parse(result);
  }

  Future<BigInt> getCounter(TezosAddress address) async {
    final raw = await provider.request(
      OctezUshuaiaRequestContextContractsContractIdCounter(
        contractId: address.address,
      ),
    );
    return BigintUtils.parse(raw);
  }

  Future<String?> getManagerKey(TezosAddress address) async {
    return await provider.request(
      OctezUshuaiaRequestContextContractsContractIdManagerKey(
        contractId: address.address,
      ),
    );
  }

  Future<OctezUshuaiaResponseContextContractsContractId> getContract(
    TezosAddress address, {
    String? normalizeTypes,
  }) async {
    return await provider.request(
      OctezUshuaiaRequestContextContractsContractId(
        contractId: address.address,
        normalizeTypes: normalizeTypes,
      ),
    );
  }

  Future<OctezUshuaiaResponseContextConstants> getConstants() async {
    return await provider.request(const OctezUshuaiaRequestContextConstants());
  }

  Future<OctezUshuaiaResponseContextDelegatesPkhMinDelegatedInCurrentCycleLevel>
  getCurrentLevel({String offset = '0'}) async {
    return await provider.request(
      OctezUshuaiaRequestHelpersCurrentLevel(offset: offset),
    );
  }

  /// Network chain id, e.g. `NetXdQprcVkpaWU`.
  Future<String> getChainId({String? chain}) async {
    final result = await provider.request(
      OctezShellRequestChainsChainIdChainId(chainId: chain ?? config.chain),
    );
    return result;
  }

  /// Head block hash when protocol base is `…/blocks/head`.
  Future<String> getBranchHash() async {
    final result = await provider.request(OctezUshuaiaRequestHash());
    return result.fold(onString: (v) => v, onBytes: TezosUtils.encodeBlockHash);
  }

  /// Inject signed operation hex via **shell** `/injection/operation`.
  Future<String> injectOperation(
    List<int> signedOperation, {
    String? chain,
    bool? async_,
  }) async {
    final result = await provider.request(
      OctezShellRequestInjectionOperation(
        requestBody: BytesUtils.toHexString(signedOperation),
        chain: chain,
        async_:
            async_ == null
                ? null
                : async_
                ? 'true'
                : 'false',
      ),
    );
    return result;
  }

  Future<OctezUshuaiaResponseHelpersScriptsRunOperation> runOperation(
    Map<String, dynamic> body,
  ) async {
    final rBody = OctezUshuaiaHelpersScriptsRunOperationBody.fromJson(body);
    final result = await provider.request(
      OctezUshuaiaRequestHelpersScriptsRunOperation(requestBody: rBody),
    );
    return result;
  }

  Future<TezosAccountState> getAccountState(TezosAddress address) async {
    final balance = await getBalance(address);
    final counter = await getCounter(address);
    final managerKey = await getManagerKey(address);
    return TezosAccountState(
      address: address,
      balance: balance,
      counter: counter,
      managerKey: managerKey,
      needsReveal: managerKey == null || managerKey.isEmpty,
    );
  }
}
