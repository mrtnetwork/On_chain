import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/tezos/src/abi/src/abi.dart';
import 'package:on_chain/tezos/src/address/address.dart';
import 'package:on_chain/tezos/src/operations/entry_point/entry_point.dart';
import 'package:on_chain/tezos/src/operations/operations/content.dart';
import 'package:on_chain/tezos/src/rpc/api/types/inject_result.dart';
import 'package:on_chain/tezos/src/micheline/micheline.dart';
import 'package:on_chain/tezos/src/rpc/api/api/confirmation.dart';
import 'package:on_chain/tezos/src/rpc/api/api/pipeline_api.dart';
import 'package:on_chain/tezos/src/rpc/api/api/quick_api.dart';
import 'package:on_chain/tezos/src/rpc/methods/methods.dart';
import 'package:on_chain/tezos/src/rpc/types/types.dart';
import 'package:on_chain/tezos/src/rpc/api/types/source.dart';

mixin TezosContractApi on TezosQuickApi, TezosConfirmation, TezosPipelineApi {
  /// Current storage MichelineExpr JSON → [MichelineExpr].
  Future<MichelineExpr> getContractStorage(TezosAddress contract) async {
    try {
      final json = await provider.requestDynamic(
        OctezUshuaiaRequestContextContractsContractIdStorage(
          contractId: contract.address,
        ),
      );
      return MichelineExpr.deserializeJson(json);
    } on RPCError {
      rethrow;
    } catch (e) {
      throw OnChainErrors.tezosPlugin(
        'getContractStorage',
        reason: 'Failed to fetch storage.',
        internalError: e,
        details: {'contract': contract.address},
      );
    }
  }

  /// Entrypoints map: `{ "entrypoints": { "name": <type MichelineExpr>, ... } }`.
  Future<Map<String, MichelineExpr>> getContractEntrypoints(
    TezosAddress contract,
  ) async {
    try {
      final result = await provider.request(
        OctezUshuaiaRequestContextContractsContractIdEntrypoints(
          contractId: contract.address,
        ),
      );
      return result.entrypoints.map(
        (k, v) => MapEntry(k, MichelineExpr.deserializeJson(v.toJson())),
      );
    } on RPCError {
      rethrow;
    } catch (e) {
      throw OnChainErrors.tezosPlugin(
        'getContractEntrypoints',
        reason: 'Failed to fetch entrypoints.',
        internalError: e,
        details: {'contract': contract.address},
      );
    }
  }

  /// Full script `{ code, storage }` JSON.
  Future<TezosScript> getContractScript(TezosAddress contract) async {
    try {
      final result = await provider.requestDynamic(
        OctezUshuaiaRequestContextContractsContractIdScript(
          contractId: contract.address,
        ),
      );
      return TezosScript.fromJson(result);
    } on RPCError {
      rethrow;
    } catch (e) {
      throw OnChainErrors.tezosPlugin(
        'getContractScript',
        reason: 'Failed to fetch script.',
        internalError: e,
        details: {'contract': contract.address},
      );
    }
  }

  /// On-chain view via `/helpers/scripts/run_script_view`.
  Future<MichelineExpr> runScriptView({
    required TezosAddress contract,
    required String view,
    required MichelineExpr input,
    String? chainId,
    TezosAddress? source,
    TezosAddress? payer,
    OctezUshuaiaContextBigMapsBigMapIdScriptExprNormalizedBodyUnparsingMode
        unparsingMode =
        OctezUshuaiaContextBigMapsBigMapIdScriptExprNormalizedBodyUnparsingMode
            .readable,
    bool unlimitedGas = true,
  }) async {
    try {
      chainId ??= (config.chainId ?? await getChainId());
      // Raw JSON — typed body fromJson can null out fields.
      final raw = await provider.request(
        OctezUshuaiaRequestHelpersScriptsRunScriptView(
          requestBody: OctezUshuaiaHelpersScriptsRunScriptViewBody(
            contract: OctezUshuaiaUnistringStringValue(contract.address),
            view: OctezUshuaiaUnistringStringValue(view),
            input:
                OctezUshuaiaMicheline025PsUshuaiMichelsonV1Expression.fromJson(
                  input.toJson(),
                ),
            chainId: OctezUshuaiaUnistringStringValue(chainId),
            unparsingMode: unparsingMode,
            payer:
                payer == null
                    ? null
                    : OctezUshuaiaUnistringStringValue(payer.address),
            unlimitedGas: unlimitedGas,
            source:
                source == null
                    ? null
                    : OctezUshuaiaUnistringStringValue(source.address),
          ),
        ),
      );
      return MichelineExpr.deserializeJson(raw.data.toJson());
    } on RPCError {
      rethrow;
    } catch (e) {
      if (e is BuError) rethrow;
      throw OnChainErrors.tezosPlugin(
        'runScriptView',
        reason: 'Script view execution failed.',
        internalError: e,
        details: {'contract': contract.address, 'view': view},
      );
    }
  }

  Future<T> runScriptViewWithAbi<T>({
    required TezosAddress contract,
    required TezosContractAbi abi,
    required String view,
    Object? input,
    String? chainId,
    TezosAddress? source,
    TezosAddress? payer,
    OctezUshuaiaContextBigMapsBigMapIdScriptExprNormalizedBodyUnparsingMode
        unparsingMode =
        OctezUshuaiaContextBigMapsBigMapIdScriptExprNormalizedBodyUnparsingMode
            .readable,
    bool unlimitedGas = true,
  }) async {
    try {
      chainId ??= (config.chainId ?? await getChainId());
      final request = OctezUshuaiaHelpersScriptsRunScriptViewBody(
        contract: OctezUshuaiaUnistringStringValue(contract.address),
        view: OctezUshuaiaUnistringStringValue(view),
        input: OctezUshuaiaMicheline025PsUshuaiMichelsonV1Expression.fromJson(
          abi.encodeViewInput(view, input).toJson(),
        ),
        chainId: OctezUshuaiaUnistringStringValue(chainId),
        unparsingMode: unparsingMode,
        payer:
            payer == null
                ? null
                : OctezUshuaiaUnistringStringValue(payer.address),
        unlimitedGas: unlimitedGas,
        source:
            source == null
                ? null
                : OctezUshuaiaUnistringStringValue(source.address),
      );
      // Raw JSON — typed body fromJson can null out fields.
      final raw = await provider.request(
        OctezUshuaiaRequestHelpersScriptsRunScriptView(requestBody: request),
      );
      return await abi.decodeViewOutput(
        view,
        MichelineExpr.deserializeJson(raw.data.toJson()),
      );
    } on RPCError {
      rethrow;
    } catch (e) {
      if (e is BuError) rethrow;
      throw OnChainErrors.tezosPlugin(
        'runScriptView',
        reason: 'Script view execution failed.',
        internalError: e,
        details: {'contract': contract.address, 'view': view},
      );
    }
  }

  /// Build + sign + inject a contract call.
  Future<TezosInjectResult> callContract({
    required TezosOperationSource source,
    required TezosAddress contract,
    TezosContractParameters? parameters,
    BigInt? amount,
    bool wait = true,
  }) async {
    final op = TezosTransactionOperation(
      source: source.address,
      fee: BigInt.zero,
      counter: BigInt.zero,
      gasLimit: BigInt.zero,
      storageLimit: BigInt.zero,
      amount: amount ?? BigInt.zero,
      destination: contract,
      parameters: parameters,
    );

    return await injectOperations(contents: [op], source: source, wait: wait);
  }

  Future<TezosInjectResult> callContractWithAbi({
    required TezosOperationSource source,
    required TezosAddress contract,
    required TezosContractAbi abi,
    required String entrypoint,
    Object? input,
    BigInt? amount,
    bool wait = true,
  }) async {
    final parameters = abi.encodeTxParameter(entrypoint, input);
    final op = TezosTransactionOperation(
      source: source.address,
      fee: BigInt.zero,
      counter: BigInt.zero,
      gasLimit: BigInt.zero,
      storageLimit: BigInt.zero,
      amount: amount ?? BigInt.zero,
      destination: contract,
      parameters: parameters,
    );
    return await injectOperations(contents: [op], source: source, wait: wait);
  }

  /// Originate a contract from MichelineExpr code + initial storage.
  Future<TezosInjectResult> originateContract({
    required TezosOperationSource source,
    required TezosScript script,
    BigInt? balance,
    TezosAddress? delegate,
  }) async {
    final op = TezosOriginationOperation(
      source: source.address,
      fee: BigInt.zero,
      counter: BigInt.zero,
      gasLimit: BigInt.zero,
      storageLimit: BigInt.zero,
      balance: balance ?? BigInt.zero,
      script: script,
      delegate: delegate,
    );
    return await injectOperations(contents: [op], source: source, wait: true);
  }

  /// Read a big_map value by id + expr hash (expr… Base58).
  Future<MichelineExpr> getBigMapValue({
    required String bigMapId,
    required String scriptExpr,
  }) async {
    try {
      final json = await provider.requestDynamic(
        OctezUshuaiaRequestContextBigMapsBigMapIdScriptExpr(
          bigMapId: bigMapId,
          scriptExpr: scriptExpr,
        ),
      );
      return MichelineExpr.deserializeJson(json);
    } on RPCError {
      rethrow;
    } catch (e) {
      throw OnChainErrors.tezosPlugin(
        'getBigMapValue',
        reason: 'Failed to read big_map value.',
        internalError: e,
        details: {'bigMapId': bigMapId, 'scriptExpr': scriptExpr},
      );
    }
  }

  /// Read a big_map value by id + expr hash (expr… Base58).
  Future<T> getBigMapValueWithAbi<T>({
    required TezosContractAbi abi,
    required TezosAddress contractAddress,
    String path = 'ledger',
    Object? keyValue,
  }) async {
    try {
      final storage = await getContractStorage(contractAddress);
      final id = abi.bigMapKeyLookup(storage, path, keyValue);
      final json = await provider.requestDynamic(
        OctezUshuaiaRequestContextBigMapsBigMapIdScriptExpr(
          bigMapId: id.bigMapId.toString(),
          scriptExpr: id.scriptExpr,
        ),
      );
      return abi.decodeBigMapResult<T>(
        path,
        MichelineExpr.deserializeJson(json),
      );
    } on BuError {
      // Includes RPCError (subtype): pass backend errors through untouched.
      rethrow;
    } catch (e) {
      throw OnChainErrors.tezosPlugin(
        'getBigMapValue',
        reason: 'Failed to read big_map value.',
        internalError: e,
      );
    }
  }
}
