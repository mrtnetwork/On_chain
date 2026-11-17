import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

class HederaGrpcRequestMessage<Response extends HederaProtoMessage>
    extends HederaGrpcRequest<Response> {
  HederaGrpcRequestMessage({required this.request});

  final IHederaServiceMessage<Response> request;

  @override
  List<int> toBuffer() {
    return request.toBuffer();
  }

  @override
  String get method => request.declarationId.getServiceUrl();

  @override
  Response onResponse(List<int> result) {
    return request.onServiceResponse(result);
  }
}
