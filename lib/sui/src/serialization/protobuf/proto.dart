import 'package:blockchain_utils/blockchain_utils.dart';

abstract class SuiProtoMessage extends IProtoMessage<SuiProtoJsonConfig> {
  const SuiProtoMessage();

  static ProtoBufferDecoderResult decode(
    List<int> bytes,
    ProtoMessageConfig config,
  ) {
    final result = ProtoBufferDecoder.decode(
      bytes: bytes,
      messageConfig: config,
    );
    return result;
  }

  @override
  String toString() {
    return "$runtimeType${toJson(config: SuiProtoJsonConfig.config)}";
  }

  SuiProtoTypeUrl get declarationId;

  String typeUrl() {
    return "type.googleapis.com${declarationId.typeUrl}";
  }

  ProtoGoogleAny toAny() => ProtoGoogleAny.binary(typeUrl(), toBuffer());
  ProtoGoogleAny toAnyJson({
    SuiProtoJsonConfig config = SuiProtoJsonConfig.config,
  }) => ProtoGoogleAny.json(typeUrl(), {"value": toJson(config: config)});
  @override
  Map<String, dynamic> toJson({
    SuiProtoJsonConfig config = SuiProtoJsonConfig.config,
  });
}

mixin ISuiProtoServiceMessage<RESPONSE extends SuiProtoMessage>
    on SuiProtoMessage {
  RESPONSE onServiceResponse(List<int> bytes);
  RESPONSE onServiceResponseJson(Map<String, dynamic> json);

  String serviceUrl() {
    final service = declarationId.serviceUrl;
    if (service == null) {
      throw BuError(DefaultErrorType.invalidArgument, "Missing service URL.");
    }
    return service;
  }
}

abstract class SuiProtoTypeUrl {
  abstract final String typeUrl;
  abstract final String? serviceUrl;
  String getServiceUrl();
}

class SuiProtoJsonConfig extends DefaultProtoJsonConfig {
  const SuiProtoJsonConfig({
    super.binaryEncoding = StringEncoding.base64,
    super.defaultOnMissing,
    super.normalizeKeys,
  });
  static const SuiProtoJsonConfig config = SuiProtoJsonConfig();

  @override
  Object? encodeBigint(BigInt? big) {
    if (big == null) return null;
    if (big.isSafeInt()) return big.toInt();
    return big;
  }

  @override
  Map<String, dynamic>? encodeMessage(IProtoMessage? message) {
    return message?.toJson(config: this);
  }
}
