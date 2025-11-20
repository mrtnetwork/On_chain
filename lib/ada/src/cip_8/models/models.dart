import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/cip_8/utils/utils.dart';
import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';

class COSESerializationConfig {
  final CborIterableEncodingType encoding;
  const COSESerializationConfig(
      {this.encoding = CborIterableEncodingType.definite});

  factory COSESerializationConfig.fromJson(Map<String, dynamic> json) {
    return COSESerializationConfig(
        encoding: json["encoding"] == null
            ? CborIterableEncodingType.set
            : CborIterableEncodingType.fromName(json["encoding"]));
  }
  Map<String, dynamic> toJson() {
    return {"encoding": encoding.name};
  }

  CborObject toCbor(List<CborObject> items) {
    switch (encoding) {
      case CborIterableEncodingType.definite:
        return CborListValue<CborObject>.definite(items);
      case CborIterableEncodingType.inDefinite:
        return CborListValue<CborObject>.inDefinite(items);
      case CborIterableEncodingType.set:
        return CborSetValue(items);
    }
  }
}

enum COSELabelType {
  int,
  string;

  static COSELabelType fromName(String? name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () =>
            throw ADAPluginException('Invalid COSELabelType "$name". '));
  }
}

abstract class COSELabel with InternalCborSerialization {
  final COSELabelType type;
  const COSELabel({required this.type});
  factory COSELabel.deserialize(CborObject object) {
    if (object.hasType<CborNumeric>()) {
      return COSELabelInt(object.as<CborNumeric>().toBigInt());
    }
    return COSELabelString(object.as<CborStringValue>().value);
  }
  factory COSELabel.fromJson(Map<String, dynamic> json) {
    final type = COSELabelType.fromName(json.keys.firstOrNull);
    return switch (type) {
      COSELabelType.int => COSELabelInt.fromJson(json),
      COSELabelType.string => COSELabelString.fromJson(json)
    };
  }
}

class COSELabelInt extends COSELabel {
  final BigInt value;
  COSELabelInt(this.value) : super(type: COSELabelType.int);
  factory COSELabelInt.fromInt(int value) {
    return COSELabelInt(BigInt.from(value));
  }
  factory COSELabelInt.fromJson(Map<String, dynamic> json) {
    return COSELabelInt(BigintUtils.parse(json[COSELabelType.int.name]));
  }

  @override
  CborObject toCbor() {
    return CborSafeIntValue(value);
  }

  @override
  Map<String, dynamic> toJson() {
    return {type.name: value.toString()};
  }

  @override
  operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! COSELabelInt) return false;
    return other.value == value;
  }

  @override
  int get hashCode => HashCodeGenerator.generateHashCode([type, value]);
}

class COSELabelString extends COSELabel {
  final String value;
  COSELabelString(this.value) : super(type: COSELabelType.string);
  factory COSELabelString.fromJson(Map<String, dynamic> json) {
    return COSELabelString(json[COSELabelType.string.name]);
  }
  @override
  CborObject toCbor() {
    return CborStringValue(value);
  }

  @override
  Map<String, dynamic> toJson() {
    return {type.name: value.toString()};
  }

  @override
  operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! COSELabelString) return false;
    return other.value == value;
  }

  @override
  int get hashCode => HashCodeGenerator.generateHashCode([type, value]);
}

class COSELabels with InternalCborSerialization {
  final List<COSELabel> labels;
  final COSESerializationConfig serializationConfig;
  COSELabels(
      {required List<COSELabel> labels,
      this.serializationConfig = const COSESerializationConfig()})
      : labels = labels.immutable;
  factory COSELabels.deserialize(CborIterableObject value) {
    return COSELabels(
        labels: value
            .valueAsListOf<CborObject>()
            .map((e) => COSELabel.deserialize(e))
            .toList(),
        serializationConfig: COSESerializationConfig(encoding: value.encoding));
  }
  factory COSELabels.fromJson(Map<String, dynamic> json) {
    return COSELabels(
        labels:
            (json["labels"] as List).map((e) => COSELabel.fromJson(e)).toList(),
        serializationConfig:
            COSESerializationConfig.fromJson(json["serialization_config"]));
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite(labels.map((e) => e.toCbor()).toList());
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "labels": labels.map((e) => e.toJson()).toList(),
      "serialization_config": serializationConfig.toJson()
    };
  }
}

class COSEProtectedHeaderMap with InternalCborSerialization {
  final List<int> data;
  COSEProtectedHeaderMap([List<int> data = const []])
      : data = data.asImmutableBytes;
  factory COSEProtectedHeaderMap.deserialize(CborBytesValue cbor) {
    return COSEProtectedHeaderMap(cbor.value);
  }
  factory COSEProtectedHeaderMap.fromJson(Map<String, dynamic> json) {
    return COSEProtectedHeaderMap(BytesUtils.fromHexString(json["data"]));
  }
  COSEProtectedHeaderMap copyWith({List<int>? data}) {
    return COSEProtectedHeaderMap(data ?? this.data);
  }

  @override
  CborObject toCbor() {
    return CborBytesValue(data);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "data": BytesUtils.toHexString(data),
    };
  }
}

class COSEHeaders with InternalCborSerialization {
  final COSEProtectedHeaderMap protected;
  final COSEHeaderMap unprotected;
  const COSEHeaders({required this.protected, required this.unprotected});
  factory COSEHeaders.deserialize(CborListValue cbor) {
    return COSEHeaders(
        protected: COSEProtectedHeaderMap.deserialize(
            cbor.elementAt<CborBytesValue>(0)),
        unprotected: COSEHeaderMap.deserialize(cbor.elementAt(1)));
  }
  factory COSEHeaders.fromJson(Map<String, dynamic> json) {
    return COSEHeaders(
        protected: COSEProtectedHeaderMap.fromJson(json["protected"]),
        unprotected: COSEHeaderMap.fomJson(json["unprotected"]));
  }
  @override
  CborObject toCbor() {
    return CborListValue.definite([
      protected.toCbor(),
      unprotected.toCbor(),
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "protected": protected.toJson(),
      "unprotected": unprotected.toJson()
    };
  }
}

class COSESignature with InternalCborSerialization {
  final COSEHeaders headers;
  final List<int> signature;
  final COSESerializationConfig serializationConfig;
  COSESignature(
      {required this.headers,
      required List<int> signatures,
      this.serializationConfig = const COSESerializationConfig()})
      : signature = signatures.immutable;
  factory COSESignature.deserialize(CborIterableObject cbor) {
    return COSESignature(
        headers: COSEHeaders(
            protected: COSEProtectedHeaderMap.deserialize(
                cbor.elementAt<CborBytesValue>(0)),
            unprotected:
                COSEHeaderMap.deserialize(cbor.elementAt<CborMapValue>(1))),
        signatures: cbor.elementAt<CborBytesValue>(2).value,
        serializationConfig: COSESerializationConfig(encoding: cbor.encoding));
  }
  factory COSESignature.fromJson(Map<String, dynamic> json) {
    return COSESignature(
        headers: COSEHeaders.fromJson(json["headers"]),
        signatures: BytesUtils.fromHexString(json["signature"]),
        serializationConfig: COSESerializationConfig.fromJson(
            json["serialization_config"] ?? {}));
  }

  @override
  CborObject toCbor() {
    return serializationConfig.toCbor([
      headers.protected.toCbor(),
      headers.unprotected.toCbor(),
      CborBytesValue(signature)
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "headers": headers.toJson(),
      "signature": BytesUtils.toHexString(signature),
      "serialization_config": serializationConfig.toJson()
    };
  }
}

class COSESignatures with InternalCborSerialization {
  final List<COSESignature> signatures;
  final COSESerializationConfig serializationConfig;
  factory COSESignatures.deserialize(CborIterableObject cbor) {
    return COSESignatures(
        signatures: cbor
            .valueAsListOf<CborListValue>()
            .map((e) => COSESignature.deserialize(e))
            .toList(),
        serializationConfig: COSESerializationConfig(encoding: cbor.encoding));
  }
  factory COSESignatures.fromJson(Map<String, dynamic> json) {
    return COSESignatures(
        signatures: (json["signatures"] as List)
            .map((e) => COSESignature.fromJson(e))
            .toList(),
        serializationConfig:
            COSESerializationConfig.fromJson(json["serialization_config"]));
  }
  COSESignatures(
      {required List<COSESignature> signatures,
      this.serializationConfig = const COSESerializationConfig()})
      : signatures = signatures.immutable;

  @override
  CborObject toCbor() {
    return serializationConfig
        .toCbor(signatures.map((e) => e.toCbor()).toList());
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "signatures": signatures.map((e) => e.toJson()).toList(),
      "serialization_config": serializationConfig.toJson()
    };
  }
}

class COSECounterSignature with InternalCborSerialization {
  final List<COSESignature> signatures;
  final COSESerializationConfig? serializationConfig;
  COSECounterSignature(
      {required List<COSESignature> signatures, this.serializationConfig})
      : signatures = signatures.immutable;
  factory COSECounterSignature.deserialize(CborIterableObject cbor) {
    if (cbor.isEmpty) {
      return COSECounterSignature(signatures: []);
    }
    if (cbor.valueIsListOf<CborIterableObject>()) {
      return COSECounterSignature(
          signatures: cbor
              .valueAsListOf<CborIterableObject>()
              .map((e) => COSESignature.deserialize(e))
              .toList(),
          serializationConfig:
              COSESerializationConfig(encoding: cbor.encoding));
    }
    return COSECounterSignature(signatures: [COSESignature.deserialize(cbor)]);
  }

  factory COSECounterSignature.fromJson(Map<String, dynamic> json) {
    return COSECounterSignature(
        signatures: (json["signatures"] as List)
            .map((e) => COSESignature.fromJson(e))
            .toList(),
        serializationConfig: json["serialization_config"] == null
            ? null
            : COSESerializationConfig.fromJson(json["serialization_config"]));
  }

  @override
  CborObject toCbor() {
    if (serializationConfig != null) {
      return serializationConfig!
          .toCbor(signatures.map((e) => e.toCbor()).toList());
    }
    if (signatures.length == 1) {
      return signatures.first.toCbor();
    }
    return CborListValue.definite(signatures.map((e) => e.toCbor()).toList());
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "signatures": signatures.map((e) => e.toJson()).toList(),
      "serialization_config": serializationConfig?.toJson()
    };
  }
}

class COSEHeaderMap with InternalCborSerialization {
  final COSELabel? algorithmId;
  final COSELabels? criticality;
  final COSELabel? contentType;
  final List<int>? keyId;
  final List<int>? initVector;
  final List<int>? partialInitVector;
  final COSECounterSignature? counterSignature;
  final Map<COSELabel, CborObject>? otherHeaders;

  COSEHeaderMap(
      {this.algorithmId,
      this.criticality,
      this.contentType,
      List<int>? keyId,
      List<int>? initVector,
      List<int>? partialInitVector,
      this.counterSignature,
      Map<COSELabel, CborObject>? otherHeaders})
      : keyId = keyId?.immutable,
        initVector = initVector?.immutable,
        partialInitVector = partialInitVector?.immutable,
        otherHeaders = otherHeaders?.immutable;

  factory COSEHeaderMap.deserialize(CborMapValue cbor) {
    final data = cbor.value.clone()
      ..removeWhere((k, v) {
        return k is CborIntValue && k.value > 0 && k.value < 8;
      });
    return COSEHeaderMap(
        algorithmId: cbor
            .getIntValueAs<CborObject?>(1)
            ?.convertTo<COSELabel, CborObject>((e) => COSELabel.deserialize(e)),
        criticality: cbor
            .getIntValueAs<CborObject?>(2)
            ?.convertTo<COSELabels, CborIterableObject>(
                (e) => COSELabels.deserialize(e)),
        contentType: cbor
            .getIntValueAs<CborObject?>(3)
            ?.convertTo<COSELabel, CborObject>((e) => COSELabel.deserialize(e)),
        keyId: cbor
            .getIntValueAs<CborBytesValue?>(4)
            ?.convertTo<List<int>, CborBytesValue>((e) => e.value),
        initVector: cbor
            .getIntValueAs<CborBytesValue?>(5)
            ?.convertTo<List<int>, CborBytesValue>((e) => e.value),
        partialInitVector: cbor
            .getIntValueAs<CborBytesValue?>(6)
            ?.convertTo<List<int>, CborBytesValue>((e) => e.value),
        counterSignature: cbor
            .getIntValueAs<CborListValue?>(7)
            ?.convertTo<COSECounterSignature, CborListValue>(
                (e) => COSECounterSignature.deserialize(e)),
        otherHeaders: {
          for (final i in data.entries) COSELabel.deserialize(i.key): i.value
        });
  }

  factory COSEHeaderMap.fomJson(Map<String, dynamic> json) {
    return COSEHeaderMap(
        algorithmId: json["algorithm_id"] == null
            ? null
            : COSELabel.fromJson(json["algorithm_id"]),
        criticality: json["criticality"] == null
            ? null
            : COSELabels.fromJson(json["criticality"]),
        contentType: json["content_type"] == null
            ? null
            : COSELabel.fromJson(json["content_type"]),
        keyId: BytesUtils.tryFromHexString(json["key_id"]),
        initVector: BytesUtils.tryFromHexString(json["init_vector"]),
        partialInitVector:
            BytesUtils.tryFromHexString(json["partial_init_vector"]),
        counterSignature: json["counter_signature"] == null
            ? null
            : COSECounterSignature.fromJson(json["counter_signature"]),
        otherHeaders: (json["other_headers"] as Map?)?.map((k, v) =>
            MapEntry(COSELabel.fromJson(k), CborObject.fromCborHex(v))));
  }

  COSEHeaderMap copyWith({
    COSELabel? algorithmId,
    COSELabels? criticality,
    COSELabel? contentType,
    List<int>? keyId,
    List<int>? initVector,
    List<int>? partialInitVector,
    COSECounterSignature? counterSignature,
    Map<COSELabel, CborObject<dynamic>>? otherHeaders,
  }) {
    return COSEHeaderMap(
        algorithmId: algorithmId ?? this.algorithmId,
        criticality: criticality ?? this.criticality,
        contentType: contentType ?? this.contentType,
        keyId: keyId ?? this.keyId,
        initVector: initVector ?? this.initVector,
        partialInitVector: partialInitVector ?? this.partialInitVector,
        counterSignature: counterSignature ?? this.counterSignature,
        otherHeaders: otherHeaders ?? this.otherHeaders);
  }

  @override
  CborObject toCbor() {
    return CborMapValue<CborObject, CborObject>.definite({
      if (algorithmId != null) CborIntValue(1): algorithmId!.toCbor(),
      if (criticality != null) CborIntValue(2): criticality!.toCbor(),
      if (contentType != null) CborIntValue(3): contentType!.toCbor(),
      if (keyId != null) CborIntValue(4): CborBytesValue(keyId!),
      if (initVector != null) CborIntValue(5): CborBytesValue(initVector!),
      if (partialInitVector != null)
        CborIntValue(6): CborBytesValue(partialInitVector!),
      if (counterSignature != null) CborIntValue(7): counterSignature!.toCbor(),
      if (otherHeaders != null)
        for (final i in otherHeaders!.entries) i.key.toCbor(): i.value
    });
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "algorithm_id": algorithmId?.toJson(),
      "criticality": criticality?.toJson(),
      "content_type": contentType?.toJson(),
      "key_id": BytesUtils.tryToHexString(keyId),
      "init_vector": BytesUtils.tryToHexString(initVector),
      "partial_init_vector": BytesUtils.tryToHexString(partialInitVector),
      "counter_signature": counterSignature?.toJson(),
      "other_headers":
          otherHeaders?.map((k, v) => MapEntry(k.toJson(), v.toCborHex()))
    };
  }
}

enum COSESignedMessageType {
  coseSign1,
  coseSign;

  static COSESignedMessageType fromName(String? name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () => throw ADAPluginException(
            'Invalid COSESignedMessageType "$name". '));
  }
}

abstract class COSESignedMessage with InternalCborSerialization {
  final COSESignedMessageType type;
  const COSESignedMessage({required this.type});
  factory COSESignedMessage.fromJson(Map<String, dynamic> json) {
    final type = COSESignedMessageType.fromName(json.keys.firstOrNull);
    return switch (type) {
      COSESignedMessageType.coseSign => COSESign.fromJson(json),
      COSESignedMessageType.coseSign1 => COSESign1.fromJson(json)
    };
  }
  factory COSESignedMessage.fromCborBytes(List<int> bytes) {
    return COSESignedMessage.deserialize(
        CborObject.fromCbor(bytes).as<CborListValue>());
  }
  factory COSESignedMessage.deserialize(CborListValue cbor) {
    if (cbor.value.length < 3) {
      throw ADAPluginException('Invalid COSESignedMessage CBOR');
    }
    if (cbor.elementAt<CborObject>(3).hasType<CborListValue>()) {
      return COSESign.deserialize(cbor);
    }
    return COSESign1.deserialize(cbor);
  }
  factory COSESignedMessage.fromUserFacingEncoding(String signedMessage) {
    if (!signedMessage.startsWith("cms_")) {
      throw ADAPluginException('Invalid signed message prefix.', details: {
        "expected": "cms_",
        "prefix": signedMessage.substring(IntUtils.min(4, signedMessage.length))
      });
    }
    String payload = signedMessage.substring(4);
    if (payload.length < 8) {
      throw ADAPluginException('Invalid signed message.');
    }
    payload = payload.replaceAll(RegExp(r'=+$'), '');
    final bodyB64 = payload.substring(0, payload.length - 6);
    final checksumB64 = signedMessage.substring(4 + bodyB64.length);
    final body =
        StringUtils.encode(bodyB64, type: StringEncoding.base64UrlSafe);
    final checksum =
        StringUtils.encode(checksumB64, type: StringEncoding.base64UrlSafe);
    final checksumBytes = COSEUtils.fnv32aBytes(body);
    if (!BytesUtils.bytesEqual(checksum, checksumBytes)) {
      throw ADAPluginException('Invalid signed message checksum');
    }
    return COSESignedMessage.fromCborBytes(body);
  }

  String toUserFacingEncoding() {
    final toBytes = toCbor().encode();
    final checksumData = StringUtils.decode(COSEUtils.fnv32aBytes(toBytes),
        type: StringEncoding.base64UrlSafe);
    return "cms_${StringUtils.decode(toBytes, type: StringEncoding.base64UrlSafe)}$checksumData";
  }

  @override
  Map<String, dynamic> toJson();
}

class COSESign1 extends COSESignedMessage {
  final COSEHeaders headers;
  final List<int>? payload;
  final List<int> signature;
  final COSESerializationConfig serializationConfig;
  COSESign1(
      {required this.headers,
      List<int>? payload,
      required List<int> signature,
      this.serializationConfig = const COSESerializationConfig()})
      : payload = payload?.asImmutableBytes,
        signature = signature.asImmutableBytes,
        super(type: COSESignedMessageType.coseSign1);
  factory COSESign1.deserialize(CborIterableObject cbor) {
    return COSESign1(
        headers: COSEHeaders(
            protected: COSEProtectedHeaderMap.deserialize(
                cbor.elementAt<CborBytesValue>(0)),
            unprotected:
                COSEHeaderMap.deserialize(cbor.elementAt<CborMapValue>(1))),
        payload: cbor.elementAtBytes<List<int>?>(2),
        signature: cbor.elementAtBytes<List<int>>(3),
        serializationConfig: COSESerializationConfig(encoding: cbor.encoding));
  }
  factory COSESign1.fromJson(Map<String, dynamic> json) {
    json = json[COSESignedMessageType.coseSign1.name] ?? json;
    return COSESign1(
        headers: COSEHeaders.fromJson(json["headers"]),
        payload: BytesUtils.tryFromHexString(json["payload"]),
        signature: BytesUtils.fromHexString(json["signature"]),
        serializationConfig: COSESerializationConfig.fromJson(
            json["serialization_config"] ?? {}));
  }

  @override
  CborObject toCbor() {
    return serializationConfig.toCbor([
      headers.protected.toCbor(),
      headers.unprotected.toCbor(),
      if (payload == null) const CborNullValue() else CborBytesValue(payload!),
      CborBytesValue(signature)
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: {
        "headers": headers.toJson(),
        "payload": BytesUtils.tryToHexString(payload),
        "signature": BytesUtils.toHexString(signature),
        "serialization_config": serializationConfig.toJson()
      }
    };
  }
}

class COSESign extends COSESignedMessage {
  final COSEHeaders headers;
  final List<int>? payload;
  final COSESignatures signatures;
  final COSESerializationConfig serializationConfig;
  COSESign(
      {required this.headers,
      List<int>? payload,
      required this.signatures,
      this.serializationConfig = const COSESerializationConfig()})
      : payload = payload?.asImmutableBytes,
        super(type: COSESignedMessageType.coseSign);
  factory COSESign.fromJson(Map<String, dynamic> json) {
    json = json[COSESignedMessageType.coseSign.name] ?? json;
    return COSESign(
        headers: COSEHeaders.fromJson(json["headers"]),
        signatures: COSESignatures.fromJson(json["signatures"]),
        payload: BytesUtils.tryFromHexString(json["payload"]),
        serializationConfig: COSESerializationConfig.fromJson(
            json["serialization_config"] ?? {}));
  }
  factory COSESign.deserialize(CborIterableObject cbor) {
    return COSESign(
        headers: COSEHeaders(
            protected: COSEProtectedHeaderMap.deserialize(
                cbor.elementAt<CborBytesValue>(0)),
            unprotected:
                COSEHeaderMap.deserialize(cbor.elementAt<CborMapValue>(1))),
        payload: cbor.elementAtBytes<List<int>?>(2),
        signatures:
            COSESignatures.deserialize(cbor.elementAt<CborListValue>(3)),
        serializationConfig: COSESerializationConfig(encoding: cbor.encoding));
  }

  @override
  CborObject toCbor() {
    return serializationConfig.toCbor([
      headers.protected.toCbor(),
      headers.unprotected.toCbor(),
      if (payload == null) const CborNullValue() else CborBytesValue(payload!),
      signatures.toCbor(),
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: {
        "headers": headers.toJson(),
        "signatures": signatures.toJson(),
        "payload": BytesUtils.tryToHexString(payload),
        "serialization_config": serializationConfig.toJson()
      }
    };
  }
}

enum COSESigContext {
  signature("Signature"),
  signature1("Signature1"),
  counterSignature("COSECounterSignature");

  final String value;
  const COSESigContext(this.value);
  static COSESigContext fromValue(String? name) {
    return values.firstWhere((e) => e.value == name,
        orElse: () =>
            throw ADAPluginException('Invalid COSESigContext "$name". '));
  }
}

class COSESigStructure with InternalCborSerialization {
  final COSESigContext context;
  final COSEProtectedHeaderMap bodyProtected;
  final COSEProtectedHeaderMap? signProtected;
  final List<int> externalAAD;
  final List<int> payload;
  final COSESerializationConfig serializationConfig;
  const COSESigStructure(
      {required this.context,
      required this.bodyProtected,
      this.signProtected,
      required this.externalAAD,
      required this.payload,
      this.serializationConfig = const COSESerializationConfig()});
  factory COSESigStructure.deserialize(CborIterableObject cbor) {
    int index = 0;
    return COSESigStructure(
        context: COSESigContext.fromValue(cbor.elementAtString(index++)),
        bodyProtected: COSEProtectedHeaderMap.deserialize(
            cbor.elementAt<CborBytesValue>(index++)),
        signProtected: cbor.value.length == 4
            ? null
            : COSEProtectedHeaderMap.deserialize(
                cbor.elementAt<CborBytesValue>(index++)),
        externalAAD: cbor.elementAtBytes(index++),
        payload: cbor.elementAtBytes(index++),
        serializationConfig: COSESerializationConfig(encoding: cbor.encoding));
  }
  factory COSESigStructure.fromJson(Map<String, dynamic> json) {
    return COSESigStructure(
        context: COSESigContext.fromValue(json["context"]),
        bodyProtected: COSEProtectedHeaderMap.fromJson(json["body_protected"]),
        signProtected: json["sign_protected"] == null
            ? null
            : COSEProtectedHeaderMap.fromJson(json["sign_protected"]),
        externalAAD: BytesUtils.fromHexString(json["external_aad"]),
        payload: BytesUtils.fromHexString(json["payload"]),
        serializationConfig: COSESerializationConfig.fromJson(
            json["serialization_config"] ?? {}));
  }

  @override
  CborObject toCbor() {
    return serializationConfig.toCbor([
      CborStringValue(context.value),
      bodyProtected.toCbor(),
      if (signProtected != null) signProtected!.toCbor(),
      CborBytesValue(externalAAD),
      CborBytesValue(payload)
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "context": context.value,
      "body_protected": bodyProtected.toJson(),
      "sign_protected": signProtected?.toJson(),
      "external_aad": BytesUtils.toHexString(externalAAD),
      "payload": BytesUtils.toHexString(payload),
      "serialization_config": serializationConfig.toJson()
    };
  }
}

class COSEEncrypt0 with InternalCborSerialization {
  final COSEHeaders headers;
  final List<int>? ciphertext;
  final COSESerializationConfig serializationConfig;
  COSEEncrypt0(
      {required this.headers,
      List<int>? ciphertext,
      this.serializationConfig = const COSESerializationConfig()})
      : ciphertext = ciphertext?.asImmutableBytes;
  factory COSEEncrypt0.deserialize(CborIterableObject cbor) {
    return COSEEncrypt0(
        headers: COSEHeaders(
            protected: COSEProtectedHeaderMap.deserialize(
                cbor.elementAt<CborBytesValue>(0)),
            unprotected:
                COSEHeaderMap.deserialize(cbor.elementAt<CborMapValue>(1))),
        ciphertext: cbor.elementAtBytes<List<int>?>(2),
        serializationConfig: COSESerializationConfig(encoding: cbor.encoding));
  }
  factory COSEEncrypt0.fromJson(Map<String, dynamic> json) {
    return COSEEncrypt0(
        headers: COSEHeaders.fromJson(json["headers"]),
        serializationConfig:
            COSESerializationConfig.fromJson(json["serialization_config"]));
  }

  @override
  CborObject toCbor() {
    return serializationConfig.toCbor([
      headers.protected.toCbor(),
      headers.unprotected.toCbor(),
      if (ciphertext == null)
        const CborNullValue()
      else
        CborBytesValue(ciphertext!),
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "headers": headers.toJson(),
      "serialization_config": serializationConfig.toJson()
    };
  }
}

class COSEPasswordEncryption extends COSEEncrypt0 {
  static const List<int> tags = [16];
  COSEPasswordEncryption(
      {required super.headers, super.ciphertext, super.serializationConfig});
  factory COSEPasswordEncryption.deserialize(CborTagValue cbor) {
    if (!BytesUtils.bytesEqual(tags, cbor.tags)) {
      throw ADAPluginException("Invalid COSEPasswordEncryption CBOR tag.",
          details: {"expected": tags, "tags": cbor.tags});
    }
    final values = cbor.valueAs<CborIterableObject>('COSEPasswordEncryption');
    return COSEPasswordEncryption(
        headers: COSEHeaders(
            protected: COSEProtectedHeaderMap.deserialize(
                values.elementAt<CborBytesValue>(0)),
            unprotected:
                COSEHeaderMap.deserialize(values.elementAt<CborMapValue>(1))),
        ciphertext: values.elementAtBytes<List<int>?>(2),
        serializationConfig:
            COSESerializationConfig(encoding: values.encoding));
  }
  factory COSEPasswordEncryption.fromJson(Map<String, dynamic> json) {
    return COSEPasswordEncryption(
        headers: COSEHeaders.fromJson(json["headers"]),
        serializationConfig:
            COSESerializationConfig.fromJson(json["serialization_config"]));
  }

  @override
  CborObject toCbor() {
    return CborTagValue(super.toCbor(), tags);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "headers": headers.toJson(),
      "serialization_config": serializationConfig.toJson()
    };
  }
}

class COSERecipient with InternalCborSerialization {
  final COSEHeaders headers;
  final List<int>? ciphertext;
  final COSESerializationConfig serializationConfig;
  COSERecipient(
      {required this.headers,
      List<int>? ciphertext,
      this.serializationConfig = const COSESerializationConfig()})
      : ciphertext = ciphertext?.asImmutableBytes;
  factory COSERecipient.fromJson(Map<String, dynamic> json) {
    return COSERecipient(
        headers: COSEHeaders.fromJson(json["headers"]),
        ciphertext: BytesUtils.tryFromHexString(json["ciphertext"]),
        serializationConfig: COSESerializationConfig.fromJson(
            json["serialization_config"] ?? {}));
  }
  factory COSERecipient.deserialize(CborIterableObject cbor) {
    return COSERecipient(
        headers: COSEHeaders(
            protected: COSEProtectedHeaderMap.deserialize(
                cbor.elementAt<CborBytesValue>(0)),
            unprotected:
                COSEHeaderMap.deserialize(cbor.elementAt<CborMapValue>(1))),
        ciphertext: cbor.elementAtBytes<List<int>?>(2),
        serializationConfig: COSESerializationConfig(encoding: cbor.encoding));
  }

  @override
  @override
  CborObject toCbor() {
    return serializationConfig.toCbor([
      headers.protected.toCbor(),
      headers.unprotected.toCbor(),
      if (ciphertext == null)
        const CborNullValue()
      else
        CborBytesValue(ciphertext!),
    ]);
  }

  @override
  toJson() {
    return {
      "headers": headers.toJson(),
      "ciphertext": BytesUtils.tryToHexString(ciphertext),
      "serialization_config": serializationConfig.toJson()
    };
  }
}

class COSERecipients with InternalCborSerialization {
  final List<COSERecipient> recipients;
  final COSESerializationConfig serializationConfig;
  COSERecipients(
      {required this.recipients,
      this.serializationConfig = const COSESerializationConfig()});
  factory COSERecipients.deserialize(CborIterableObject cbor) {
    return COSERecipients(
        recipients: cbor
            .valueAsListOf<CborListValue>()
            .map((e) => COSERecipient.deserialize(e))
            .toList(),
        serializationConfig: COSESerializationConfig(encoding: cbor.encoding));
  }
  factory COSERecipients.fromJson(Map<String, dynamic> json) {
    return COSERecipients(
        recipients: (json["recipients"] as List)
            .map((e) => COSERecipient.fromJson(e))
            .toList(),
        serializationConfig: COSESerializationConfig.fromJson(
            json["serialization_config"] ?? {}));
  }

  @override
  CborObject toCbor() {
    return serializationConfig
        .toCbor(recipients.map((e) => e.toCbor()).toList());
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "serialization_config": serializationConfig.toJson(),
      "recipients": recipients.map((e) => e.toJson()).toList()
    };
  }
}

class COSEEncrypt with InternalCborSerialization {
  final COSEHeaders headers;
  final List<int>? ciphertext;
  final COSERecipients recipients;
  final COSESerializationConfig serializationConfig;
  COSEEncrypt(
      {required this.headers,
      List<int>? ciphertext,
      required this.recipients,
      this.serializationConfig = const COSESerializationConfig()})
      : ciphertext = ciphertext?.asImmutableBytes;
  factory COSEEncrypt.deserialize(CborIterableObject cbor) {
    return COSEEncrypt(
        headers: COSEHeaders(
            protected: COSEProtectedHeaderMap.deserialize(
                cbor.elementAt<CborBytesValue>(0)),
            unprotected:
                COSEHeaderMap.deserialize(cbor.elementAt<CborMapValue>(1))),
        ciphertext: cbor.elementAtBytes<List<int>?>(2),
        recipients:
            COSERecipients.deserialize(cbor.elementAt<CborListValue>(3)),
        serializationConfig: COSESerializationConfig(encoding: cbor.encoding));
  }

  factory COSEEncrypt.fromJson(Map<String, dynamic> json) {
    return COSEEncrypt(
        headers: COSEHeaders.fromJson(json["headers"]),
        ciphertext: BytesUtils.tryFromHexString(json["ciphertext"]),
        recipients: COSERecipients.fromJson(json["recipients"]),
        serializationConfig: COSESerializationConfig.fromJson(
            json["serialization_config"] ?? {}));
  }
  @override
  CborObject toCbor() {
    return serializationConfig.toCbor([
      headers.protected.toCbor(),
      headers.unprotected.toCbor(),
      if (ciphertext == null)
        const CborNullValue()
      else
        CborBytesValue(ciphertext!),
      recipients.toCbor(),
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "headers": headers.toJson(),
      "ciphertext": BytesUtils.tryToHexString(ciphertext),
      "recipients": recipients.toJson(),
      "serialization_config": serializationConfig.toJson()
    };
  }
}

class COSEPubKeyEncryption extends COSEEncrypt {
  static const List<int> tags = [96];
  COSEPubKeyEncryption(
      {required super.headers, super.ciphertext, required super.recipients});

  factory COSEPubKeyEncryption.deserialize(CborTagValue cbor) {
    if (!BytesUtils.bytesEqual(tags, cbor.tags)) {
      throw ADAPluginException("Invalid COSEPubKeyEncryption CBOR tag.",
          details: {"expected": tags, "tags": cbor.tags});
    }
    final values = cbor.valueAs<CborListValue>('COSEPubKeyEncryption');
    return COSEPubKeyEncryption(
        headers: COSEHeaders(
            protected: COSEProtectedHeaderMap.deserialize(
                values.elementAt<CborBytesValue>(0)),
            unprotected:
                COSEHeaderMap.deserialize(values.elementAt<CborMapValue>(1))),
        ciphertext: values.elementAtBytes<List<int>?>(2),
        recipients: COSERecipients.deserialize(values.elementAt(3)));
  }

  @override
  CborObject toCbor() {
    return CborTagValue(super.toCbor(), tags);
  }
}

class COSEKey with InternalCborSerialization {
  final COSELabel? keyType;
  final List<int>? keyId;
  final COSELabel? algorithmId;
  final COSELabels? keyOps;
  final List<int>? baseInitVector;
  final Map<COSELabel, CborObject>? otherHeaders;

  COSEKey(
      {this.keyType,
      this.keyOps,
      List<int>? keyId,
      this.algorithmId,
      List<int>? baseInitVector,
      Map<COSELabel, CborObject>? otherHeaders})
      : keyId = keyId?.immutable,
        baseInitVector = baseInitVector?.immutable,
        otherHeaders = otherHeaders?.immutable;

  factory COSEKey.deserialize(CborMapValue cbor) {
    final data = cbor.value.clone()
      ..removeWhere((k, v) {
        return k is CborIntValue && k.value > 0 && k.value < 6;
      });
    return COSEKey(
        keyType: cbor
            .getIntValueAs<CborObject?>(1)
            ?.convertTo<COSELabel, CborObject>((e) => COSELabel.deserialize(e)),
        keyId: cbor
            .getIntValueAs<CborBytesValue?>(2)
            ?.convertTo<List<int>, CborBytesValue>((e) => e.value),
        algorithmId: cbor
            .getIntValueAs<CborObject?>(3)
            ?.convertTo<COSELabel, CborObject>((e) => COSELabel.deserialize(e)),
        keyOps: cbor
            .getIntValueAs<CborObject?>(4)
            ?.convertTo<COSELabels, CborIterableObject>(
                (e) => COSELabels.deserialize(e)),
        baseInitVector: cbor
            .getIntValueAs<CborBytesValue?>(5)
            ?.convertTo<List<int>, CborBytesValue>((e) => e.value),
        otherHeaders: {
          for (final i in data.entries) COSELabel.deserialize(i.key): i.value
        });
  }
  factory COSEKey.fromJson(Map<String, dynamic> json) {
    return COSEKey(
        algorithmId: json["algorithm_id"] == null
            ? null
            : COSELabel.fromJson(json["algorithm_id"]),
        baseInitVector: BytesUtils.tryFromHexString(json["base_init_vector"]),
        keyId: BytesUtils.tryFromHexString(json["key_id"]),
        keyOps: json["key_ops"] == null
            ? null
            : COSELabels.fromJson(json["key_ops"]),
        keyType: json["key_type"] == null
            ? null
            : COSELabel.fromJson(json["key_type"]),
        otherHeaders: (json["other_headers"] as Map?)?.map((k, v) =>
            MapEntry(COSELabel.fromJson(k), CborObject.fromCborHex(v))));
  }
  factory COSEKey.fromEd25519Keypair(
      {List<int>? publicKey,
      List<int>? privateKey,
      bool forSigning = false,
      bool forVerifying = false}) {
    return COSEKey(
      keyType: COSELabelInt.fromInt(COSEKeyType.okp.value),
      algorithmId: COSELabelInt.fromInt(COSEAlgorithmId.eddsa.value),
      keyOps: forSigning || forVerifying
          ? COSELabels(labels: [
              if (forSigning) COSELabelInt.fromInt(COSEKeyOperation.sign.value),
              if (forVerifying)
                COSELabelInt.fromInt(COSEKeyOperation.verify.value)
            ])
          : null,
      otherHeaders: {
        COSELabelInt.fromInt(COSEECKey.crv.value):
            CborIntValue(COSECurveType.ed25519.value),
        if (publicKey != null)
          COSELabelInt.fromInt(COSEECKey.x.value): CborBytesValue(publicKey),
        if (privateKey != null)
          COSELabelInt.fromInt(COSEECKey.d.value): CborBytesValue(privateKey),
      },
    );
  }
  factory COSEKey.fromCborBytes(List<int> bytes) {
    return COSEKey.deserialize(CborObject.fromCbor(bytes).as("COSEKey"));
  }
  @override
  CborObject toCbor() {
    return CborMapValue<CborObject, CborObject>.definite({
      if (keyType != null) CborIntValue(1): keyType!.toCbor(),
      if (keyId != null) CborIntValue(2): CborBytesValue(keyId!),
      if (algorithmId != null) CborIntValue(3): algorithmId!.toCbor(),
      if (keyOps != null) CborIntValue(4): keyOps!.toCbor(),
      if (baseInitVector != null)
        CborIntValue(5): CborBytesValue(baseInitVector!),
      if (otherHeaders != null)
        for (final i in otherHeaders!.entries) i.key.toCbor(): i.value
    });
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "key_type": keyType?.toJson(),
      "key_id": BytesUtils.tryToHexString(keyId),
      "algorithm_id": algorithmId?.toJson(),
      "key_ops": keyOps?.toJson(),
      "base_init_vector": BytesUtils.tryToHexString(baseInitVector),
      "other_headers":
          otherHeaders?.map((k, v) => MapEntry(k.toJson(), v.toCborHex()))
    };
  }
}

enum COSEAlgorithmId {
  eddsa(-8),
  chaCha20Poly1305(24);

  final int value;
  const COSEAlgorithmId(this.value);
}

enum COSEKeyType {
  okp(1),
  ec2(2),
  symmetric(4);

  final int value;
  const COSEKeyType(this.value);
}

enum COSEECKey {
  crv(-1),
  x(-2),
  y(-3),
  d(-4);

  final int value;
  const COSEECKey(this.value);
}

enum COSECurveType {
  p256(1),
  p384(2),
  p521(3),
  x25519(4),
  x448(5),
  ed25519(6),
  ed448(7);

  final int value;
  const COSECurveType(this.value);
}

enum COSEKeyOperation {
  sign(1),
  verify(2),
  encrypt(3),
  decrypt(4),
  wrapKey(5),
  unwrapKey(6),
  deriveKey(7),
  deriveBits(8);

  final int value;
  const COSEKeyOperation(this.value);
}

class COSESign1Builder {
  final COSEHeaders headers;
  final List<int> payload;
  final List<int>? externalAad;
  COSESign1Builder._(
      {required this.headers,
      required List<int> payload,
      required List<int>? externalAad})
      : payload = payload.asImmutableBytes,
        externalAad = externalAad?.asImmutableBytes;
  factory COSESign1Builder(
      {required COSEHeaders headers,
      required List<int> payload,
      List<int>? externalAad,
      bool hashPayload = false}) {
    final newHeaders = COSEHeaders(
        protected: headers.protected,
        unprotected: headers.unprotected.copyWith(otherHeaders: {
          ...headers.unprotected.otherHeaders ?? {},
          COSELabelString("hashed"): CborBoleanValue(hashPayload)
        }));
    return COSESign1Builder._(
        headers: newHeaders,
        payload: hashPayload ? QuickCrypto.blake2b224Hash(payload) : payload,
        externalAad: externalAad);
  }

  COSESigStructure toSigStruct() {
    return COSESigStructure(
        context: COSESigContext.signature1,
        bodyProtected: headers.protected,
        externalAAD: externalAad ?? [],
        payload: payload);
  }

  List<int> toSignMessageBytes() {
    return toSigStruct().toCbor().encode();
  }

  COSESign1 toSign(List<int> signature, {bool payloadExternal = false}) {
    return COSESign1(
        headers: headers,
        signature: signature,
        payload: payloadExternal ? null : payload);
  }

  List<int> toSignBytes(List<int> signature, {bool payloadExternal = false}) {
    return toSign(signature, payloadExternal: payloadExternal)
        .toCbor()
        .encode();
  }

  String toSignHex(List<int> signature, {bool payloadExternal = false}) {
    return toSign(signature, payloadExternal: payloadExternal)
        .toCbor()
        .toCborHex();
  }
}

class COSESignBuilder {
  final COSEHeaders headers;
  final List<int> payload;
  final List<int>? externalAad;
  COSESignBuilder._(
      {required this.headers,
      required List<int> payload,
      required List<int>? externalAad})
      : payload = payload.asImmutableBytes,
        externalAad = externalAad?.asImmutableBytes;
  factory COSESignBuilder(
      {required COSEHeaders headers,
      required List<int> payload,
      required List<int>? externalAad,
      bool hashPayload = false}) {
    return COSESignBuilder._(
        headers: headers,
        payload: hashPayload ? QuickCrypto.blake2b224Hash(payload) : payload,
        externalAad: externalAad);
  }

  COSESigStructure toSigStruct() {
    return COSESigStructure(
        context: COSESigContext.signature,
        bodyProtected: headers.protected,
        externalAAD: externalAad ?? [],
        payload: payload);
  }

  List<int> toSignMessageBytes() {
    return toSigStruct().toCbor().encode();
  }

  COSESign1 toSign(List<int> signature, {bool payloadExternal = false}) {
    return COSESign1(
        headers: headers,
        signature: signature,
        payload: payloadExternal ? null : payload);
  }

  List<int> toSignBytes(List<int> signature, {bool payloadExternal = false}) {
    return toSign(signature, payloadExternal: payloadExternal)
        .toCbor()
        .encode();
  }

  String toSignHex(List<int> signature, {bool payloadExternal = false}) {
    return toSign(signature, payloadExternal: payloadExternal)
        .toCbor()
        .toCborHex();
  }
}
