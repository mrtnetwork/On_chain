import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';

import 'certificate.dart';

class CertificatesSerializationConfig {
  final CborIterableEncodingType encoding;
  final List<int>? tags;
  const CertificatesSerializationConfig(
      {this.encoding = CborIterableEncodingType.set, this.tags});

  factory CertificatesSerializationConfig.fromJson(Map<String, dynamic> json) {
    return CertificatesSerializationConfig(
        tags: (json["tags"] as List?)?.cast(),
        encoding: json["encoding"] == null
            ? CborIterableEncodingType.set
            : CborIterableEncodingType.fromName(json["encoding"]));
  }
  Map<String, dynamic> toJson() {
    return {"encoding": encoding.name, "tags": tags};
  }
}

class Certificates with InternalCborSerialization {
  final List<Certificate> certificates;
  final CertificatesSerializationConfig serializationConfig;
  Certificates(List<Certificate> certificates,
      {this.serializationConfig = const CertificatesSerializationConfig()})
      : certificates = certificates.immutable;
  factory Certificates.deserialize(CborObject cbor) {
    if (cbor.hasType<CborTagValue>()) {
      final tag = cbor.as<CborTagValue>("Certificates");
      final list = tag.valueAs<CborIterableObject>("Certificate");
      return Certificates(
          list
              .valueAsListOf<CborListValue>("Certificate")
              .map((e) => Certificate.deserialize(e))
              .toList(),
          serializationConfig: CertificatesSerializationConfig(
              tags: tag.tags, encoding: list.encoding));
    }
    final list = cbor.as<CborIterableObject>("Certificate");
    return Certificates(
        list
            .valueAsListOf<CborListValue>("Certificate")
            .map((e) => Certificate.deserialize(e))
            .toList(),
        serializationConfig:
            CertificatesSerializationConfig(encoding: list.encoding));
  }
  factory Certificates.fromJson(Map<String, dynamic> json) {
    return Certificates(
        (json["certificates"] as List)
            .map((e) => Certificate.fromJson(e))
            .toList(),
        serializationConfig: CertificatesSerializationConfig.fromJson(
            json["serialization_config"] ?? {}));
  }

  @override
  CborObject toCbor() {
    final obj = switch (serializationConfig.encoding) {
      CborIterableEncodingType.inDefinite =>
        CborListValue.inDefinite(certificates.map((e) => e.toCbor()).toList()),
      CborIterableEncodingType.definite =>
        CborListValue.definite(certificates.map((e) => e.toCbor()).toList()),
      CborIterableEncodingType.set =>
        CborSetValue(certificates.map((e) => e.toCbor())),
    } as CborObject;
    final tags = serializationConfig.tags;
    if (tags != null) {
      return CborTagValue(obj, tags);
    }
    return obj;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "certificates": certificates.map((e) => e.toJson()).toList(),
      "serialization_config": serializationConfig.toJson()
    };
  }
}
