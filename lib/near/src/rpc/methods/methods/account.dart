import 'package:blockchain_utils/exception/exception/rpc_error.dart';
import 'package:blockchain_utils/helper/helper.dart';
import 'package:blockchain_utils/utils/json/json.dart';
import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';
import 'package:on_chain/near/src/types/types.dart';

class NearNodeRequestQueryViewAccount
    extends
        NearNodeRequest<
          NearRpcRpcQueryResponseAccountView,
          Map<String, dynamic>
        > {
  final NearRpcRpcQueryRequest args;
  const NearNodeRequestQueryViewAccount._(this.args);
  factory NearNodeRequestQueryViewAccount({
    required String accountId,
    NearBlockReference blockReference = NearBlockReference.optimistic,
  }) {
    final type = NearRpcRpcQueryRequestViewAccountRequestType.viewAccount;
    final args = blockReference.fold(
      onBlockId:
          (blockId) => NearRpcRpcQueryRequestViewAccount(
            blockId: blockId,
            accountId: accountId,
            requestType: type,
          ),
      onFinality:
          (finality) => NearRpcRpcQueryRequestViewAccount2(
            finality: finality,
            accountId: accountId,
            requestType: type,
          ),
    );
    return NearNodeRequestQueryViewAccount._(args);
  }

  @override
  String get method => "query";

  @override
  dynamic params() => args.toJson();

  @override
  NearRpcRpcQueryResponseAccountView onResponse(Map<String, dynamic> result) {
    return NearRpcRpcQueryResponseAccountView(
      NearRpcAccountView.fromJson(result),
      blockHash: result['block_hash'].toString(),
      blockHeight: BigInt.from((result['block_height'] as num).toInt()),
    );
  }
}

class NearNodeRequestQueryViewAccessKey
    extends
        NearNodeRequest<
          NearRpcRpcQueryResponseAccessKeyView,
          Map<String, dynamic>
        > {
  final NearRpcRpcQueryRequest args;
  const NearNodeRequestQueryViewAccessKey._(this.args);
  factory NearNodeRequestQueryViewAccessKey({
    required String accountId,
    required String publicKey,
    NearBlockReference blockReference = NearBlockReference.optimistic,
  }) {
    final type = NearRpcRpcQueryRequestViewAccessKeyRequestType.viewAccessKey;
    final args = blockReference.fold(
      onBlockId:
          (blockId) => NearRpcRpcQueryRequestViewAccessKey(
            blockId: blockId,
            accountId: accountId,
            requestType: type,
            publicKey: publicKey,
          ),
      onFinality:
          (finality) => NearRpcRpcQueryRequestViewAccessKey2(
            finality: finality,
            accountId: accountId,
            requestType: type,
            publicKey: publicKey,
          ),
    );
    return NearNodeRequestQueryViewAccessKey._(args);
  }

  @override
  String get method => "query";

  @override
  dynamic params() => args.toJson();

  @override
  NearRpcRpcQueryResponseAccessKeyView onResponse(Map<String, dynamic> result) {
    if (result.hasValue("error")) {
      throw RPCError(
        message: result.valueAsString("error"),
        jsonRpcErrpr: result.clone()..removeWhere((k, v) => k == "error"),
      );
    }
    return NearRpcRpcQueryResponseAccessKeyView(
      NearRpcAccessKeyView.fromJson(result),
      blockHash: result['block_hash'].toString(),
      blockHeight: BigInt.from((result['block_height'] as num).toInt()),
    );
  }
}

class NearNodeRequestQueryViewAccessKeyList
    extends
        NearNodeRequest<
          NearRpcRpcQueryResponseAccessKeyList,
          Map<String, dynamic>
        > {
  final NearRpcRpcQueryRequest args;
  const NearNodeRequestQueryViewAccessKeyList._(this.args);
  factory NearNodeRequestQueryViewAccessKeyList(
    String accountId, {
    NearBlockReference blockReference = NearBlockReference.optimistic,
  }) {
    final type =
        NearRpcRpcQueryRequestViewAccessKeyListRequestType.viewAccessKeyList;
    final args = blockReference.fold(
      onBlockId:
          (blockId) => NearRpcRpcQueryRequestViewAccessKeyList(
            blockId: blockId,
            accountId: accountId,
            requestType: type,
          ),
      onFinality:
          (finality) => NearRpcRpcQueryRequestViewAccessKeyList2(
            finality: finality,
            accountId: accountId,
            requestType: type,
          ),
    );
    return NearNodeRequestQueryViewAccessKeyList._(args);
  }

  @override
  String get method => "query";

  @override
  dynamic params() => args.toJson();

  @override
  NearRpcRpcQueryResponseAccessKeyList onResponse(Map<String, dynamic> result) {
    return NearRpcRpcQueryResponseAccessKeyList(
      NearRpcAccessKeyList.fromJson(result),
      blockHash: result['block_hash'].toString(),
      blockHeight: BigInt.from((result['block_height'] as num).toInt()),
    );
  }
}
