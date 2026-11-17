import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/serialization/protobuf/proto.dart';

class TronGrpcRequestMessage<RESPONSE extends TronProtoMessage>
    extends TronGrpcRequest<RESPONSE> {
  final ITronProtoServiceMessage<RESPONSE> message;

  const TronGrpcRequestMessage(this.message);

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
