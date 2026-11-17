import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/address/tron_address.dart';

abstract class TronProtoMessage extends IProtoMessage<TronProtoJsonConfig> {
  const TronProtoMessage();

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
    return "$runtimeType${toJson()}";
  }

  TronProtoTypeUrl get declarationId;

  String typeUrl() {
    return "type.googleapis.com${declarationId.typeUrl}";
  }

  ProtoGoogleAny toAny() => ProtoGoogleAny.binary(typeUrl(), toBuffer());
  ProtoGoogleAny toAnyJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) => ProtoGoogleAny.json(typeUrl(), {"value": toJson(config: config)});
  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  });
}

mixin ITronProtoServiceMessage<RESPONSE extends TronProtoMessage>
    on TronProtoMessage {
  RESPONSE onServiceResponse(List<int> bytes);
  RESPONSE onServiceResponseJson(Map<String, dynamic> json);

  String serviceUrl() {
    final service = declarationId.serviceUrl;
    if (service == null) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        "Missing service URL.",
        details: {"declaration": declarationId.toString()},
      );
    }
    return service;
  }
}

abstract class TronProtoTypeUrl {
  abstract final String typeUrl;
  abstract final String? serviceUrl;
  String getServiceUrl();
}

enum TronJsonEncoding { proto, tron }

class TronProtoJsonConfig extends DefaultProtoJsonConfig {
  const TronProtoJsonConfig({
    this.visible = false,
    super.binaryEncoding = StringEncoding.hex,
    super.defaultOnMissing,
    super.normalizeKeys,
    this.encoding = TronJsonEncoding.tron,
  });
  final bool visible;
  final TronJsonEncoding encoding;
  static const TronProtoJsonConfig config = TronProtoJsonConfig();

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

  @override
  Map<K, V> decodeMap<K, V>(
    Object? obj,
    MapEntry<K, V> Function(Object? k, Object? v) keyMapper,
  ) {
    if (obj == null && defaultOnMissing) return <K, V>{};
    if (obj is List) {
      final entries = JsonParser.valueEnsureAsList<Map<dynamic, dynamic>>(obj);
      return Map<K, V>.fromEntries(
        entries.map((e) => keyMapper(e.valueAs("key"), e.valueAs("value"))),
      );
    }
    return JsonParser.valueEnsureAsMap<dynamic, dynamic>(obj).map(keyMapper);
  }

  @override
  Object? encodeMap<K, V>(
    Map<K, V>? obj,
    MapEntry<dynamic, dynamic> Function(K k, V v) keyMapper,
  ) {
    if (obj == null) return null;
    if (encoding == TronJsonEncoding.proto) {
      return super.encodeMap(obj, keyMapper);
    }
    final entries =
        obj.entries.map((k) {
          final result = keyMapper(k.key, k.value);
          return {"key": result.key, "value": result.value};
        }).toList();
    return entries;
  }

  @override
  T decodeBinary<T extends List<int>?>(Object? obj) {
    try {
      if (obj == null) return null as T;
      return JsonParser.valueAsBytes<T>(obj, encoding: binaryEncoding);
    } catch (_) {
      if (obj is String) {
        try {
          return TronAddress(obj).toBytes() as T;
        } catch (_) {}
      }
      throw BuError(
        DefaultErrorType.invalidArgument,
        "Failed to decode object as binary.",
        details: {"type": "$T", "value": "$obj"},
      );
    }
  }

  TronProtoJsonConfig copyWith({
    bool? visible,
    StringEncoding? binaryEncoding,
    bool? defaultOnMissing,
    bool? normalizeKeys,
    TronJsonEncoding? encoding,
  }) {
    return TronProtoJsonConfig(
      visible: visible ?? this.visible,
      binaryEncoding: binaryEncoding ?? this.binaryEncoding,
      defaultOnMissing: defaultOnMissing ?? this.defaultOnMissing,
      normalizeKeys: normalizeKeys ?? this.normalizeKeys,
      encoding: encoding ?? this.encoding,
    );
  }
}
