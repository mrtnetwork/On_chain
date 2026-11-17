import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';
import 'package:on_chain/near/src/types/types.dart';

class NearNodeRequestQueryViewContractCode
    extends
        NearNodeRequest<
          NearRpcRpcQueryResponseContractCodeView,
          Map<String, dynamic>
        > {
  final NearRpcRpcQueryRequest args;
  const NearNodeRequestQueryViewContractCode._(this.args);
  factory NearNodeRequestQueryViewContractCode({
    required String accountId,
    NearBlockReference blockReference = NearBlockReference.optimistic,
  }) {
    final type = NearRpcRpcQueryRequestViewCodeRequestType.viewCode;
    NearRpcRpcQueryRequest args = blockReference.fold(
      onBlockId:
          (blockId) => NearRpcRpcQueryRequestViewCode(
            blockId: blockId,
            accountId: accountId,
            requestType: type,
          ),
      onFinality:
          (finality) => NearRpcRpcQueryRequestViewCode2(
            finality: finality,
            accountId: accountId,
            requestType: type,
          ),
    );

    return NearNodeRequestQueryViewContractCode._(args);
  }
  factory NearNodeRequestQueryViewContractCode.globalContractByCodeHash({
    required String codeHash,
    NearBlockReference blockReference = NearBlockReference.optimistic,
  }) {
    final type =
        NearRpcRpcQueryRequestViewGlobalContractCodeRequestType
            .viewGlobalContractCode;
    NearRpcRpcQueryRequest args = blockReference.fold(
      onBlockId:
          (blockId) => NearRpcRpcQueryRequestViewGlobalContractCode(
            blockId: blockId,
            codeHash: codeHash,
            requestType: type,
          ),
      onFinality:
          (finality) => NearRpcRpcQueryRequestViewGlobalContractCode2(
            finality: finality,
            codeHash: codeHash,
            requestType: type,
          ),
    );

    return NearNodeRequestQueryViewContractCode._(args);
  }
  factory NearNodeRequestQueryViewContractCode.globalContractByAccountId({
    required String accountId,
    NearBlockReference blockReference = NearBlockReference.optimistic,
  }) {
    final type =
        NearRpcRpcQueryRequestViewGlobalContractCodeByAccountIdRequestType
            .viewGlobalContractCodeByAccountId;
    NearRpcRpcQueryRequest args = blockReference.fold(
      onBlockId:
          (blockId) => NearRpcRpcQueryRequestViewGlobalContractCodeByAccountId(
            blockId: blockId,
            accountId: accountId,
            requestType: type,
          ),
      onFinality:
          (finality) =>
              NearRpcRpcQueryRequestViewGlobalContractCodeByAccountId2(
                finality: finality,
                accountId: accountId,
                requestType: type,
              ),
    );

    return NearNodeRequestQueryViewContractCode._(args);
  }

  @override
  String get method => "query";

  @override
  dynamic params() => args.toJson();

  @override
  NearRpcRpcQueryResponseContractCodeView onResponse(
    Map<String, dynamic> result,
  ) {
    return NearRpcRpcQueryResponseContractCodeView(
      NearRpcContractCodeView.fromJson(result),
      blockHash: result['block_hash'].toString(),
      blockHeight: BigInt.from((result['block_height'] as num).toInt()),
    );
  }
}

class NearNodeRequestQueryViewContractState
    extends
        NearNodeRequest<
          NearRpcRpcQueryResponseViewStateResult,
          Map<String, dynamic>
        > {
  final NearRpcRpcQueryRequest args;
  const NearNodeRequestQueryViewContractState._(this.args);
  factory NearNodeRequestQueryViewContractState({
    required String accountId,
    required String prefixBase64,
    NearBlockReference blockReference = NearBlockReference.optimistic,
    bool? includeProof,
  }) {
    final type = NearRpcRpcQueryRequestViewStateRequestType.viewState;
    NearRpcRpcQueryRequest args = blockReference.fold(
      onBlockId:
          (blockId) => NearRpcRpcQueryRequestViewState(
            blockId: blockId,
            accountId: accountId,
            requestType: type,
            prefixBase64: prefixBase64,
            includeProof: includeProof,
          ),
      onFinality:
          (finality) => NearRpcRpcQueryRequestViewState2(
            finality: finality,
            accountId: accountId,
            requestType: type,
            prefixBase64: prefixBase64,
            includeProof: includeProof,
          ),
    );

    return NearNodeRequestQueryViewContractState._(args);
  }
  @override
  String get method => "query";

  @override
  dynamic params() => args.toJson();

  @override
  NearRpcRpcQueryResponseViewStateResult onResponse(
    Map<String, dynamic> result,
  ) {
    return NearRpcRpcQueryResponseViewStateResult(
      NearRpcViewStateResult.fromJson(result),
      blockHash: result['block_hash'].toString(),
      blockHeight: BigInt.from((result['block_height'] as num).toInt()),
    );
  }
}

class NearNodeRequestQueryCallFunction
    extends
        NearNodeRequest<
          NearRpcRpcQueryResponseCallResult,
          Map<String, dynamic>
        > {
  final NearRpcRpcQueryRequest args;
  const NearNodeRequestQueryCallFunction._(this.args);
  factory NearNodeRequestQueryCallFunction({
    required String accountId,
    required String argsBase64,
    required String methodName,
    NearBlockReference blockReference = NearBlockReference.optimistic,
  }) {
    final type = NearRpcRpcQueryRequestCallFunctionRequestType.callFunction;
    NearRpcRpcQueryRequest args = blockReference.fold(
      onBlockId:
          (blockId) => NearRpcRpcQueryRequestCallFunction(
            blockId: blockId,
            accountId: accountId,
            requestType: type,
            argsBase64: argsBase64,
            methodName: methodName,
          ),
      onFinality:
          (finality) => NearRpcRpcQueryRequestCallFunction2(
            finality: finality,
            accountId: accountId,
            requestType: type,
            argsBase64: argsBase64,
            methodName: methodName,
          ),
    );
    return NearNodeRequestQueryCallFunction._(args);
  }
  @override
  String get method => "query";

  @override
  dynamic params() => args.toJson();

  @override
  NearRpcRpcQueryResponseCallResult onResponse(Map<String, dynamic> result) {
    return NearRpcRpcQueryResponseCallResult(
      NearRpcCallResult.fromJson(result),
      blockHash: result['block_hash'].toString(),
      blockHeight: BigInt.from((result['block_height'] as num).toInt()),
    );
  }
}
