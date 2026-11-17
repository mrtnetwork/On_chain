import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/rpc/core/request.dart';
import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';

class SuiGrpcRequestMessage<RESPONSE extends SuiProtoMessage>
    extends SuiGrpcRequest<RESPONSE> {
  final ISuiProtoServiceMessage<RESPONSE> message;

  const SuiGrpcRequestMessage(this.message);

  @override
  String get method => message.serviceUrl();

  @override
  RESPONSE onResponse(List<int> result) {
    return message.onServiceResponse(result);
  }

  @override
  BuBytes toBuffer() {
    return message.toBuffer().asImmutableBytes;
  }
}
