import 'package:blockchain_utils/encoding/encoding.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/hedera/src/rpc/api/api/utils/utils.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/src/query.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/src/query_header.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/src/response.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/src/response_header.dart';

abstract class HederaProtoMessage extends IProtoMessage<HederaProtoJsonConfig> {
  const HederaProtoMessage();

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

  HederaProtoTypeUrl get declarationId;

  @override
  Map<String, dynamic> toJson({
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  });
}

mixin IHederaServiceMessage<RESPONSE extends HederaProtoMessage>
    on HederaProtoMessage {
  RESPONSE onServiceResponse(List<int> bytes);
}
mixin IHederaQuery<QUERYRESPONSE extends IHederaQueryRespone>
    on HederaProtoMessage {
  HederaQueryHeader? get header;
  HederaQuery toQueryRequest({HederaQueryHeader? header});
  IHederaQuery<QUERYRESPONSE> copyWith({HederaQueryHeader? header});

  QUERYRESPONSE getResponse(HederaResponse response) {
    final c = HederaClientUtils.extractQueryResponse(this, response);
    if (c is! QUERYRESPONSE) {
      throw OnChainErrors.hederaPlugin(
        "getResponse",
        reason: "Invalid query response.",
        details: {'actual': '${c.runtimeType}'},
      );
    }
    return c;
  }
}
mixin IHederaQueryRespone on HederaProtoMessage {
  HederaResponseHeader? get header;
}

abstract class HederaProtoTypeUrl {
  abstract final String typeUrl;
  abstract final String? serviceUrl;
  String getServiceUrl();
}

class HederaProtoJsonConfig extends DefaultProtoJsonConfig {
  const HederaProtoJsonConfig({
    super.binaryEncoding,
    super.defaultOnMissing,
    super.normalizeKeys = true,
  });
  static const HederaProtoJsonConfig defaultConfig = HederaProtoJsonConfig();
}
