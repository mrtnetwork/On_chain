import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/models/credential/models/credential.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';

class CredentialsSerializationConfig {
  final CborIterableEncodingType encoding;
  final List<int>? tags;
  const CredentialsSerializationConfig(
      {this.encoding = CborIterableEncodingType.set, this.tags});
}

class Credentials with InternalCborSerialization {
  final List<Credential> credentials;
  final CredentialsSerializationConfig serializationConfig;
  Credentials(List<Credential> credentials,
      {this.serializationConfig = const CredentialsSerializationConfig()})
      : credentials = credentials.immutable;
  factory Credentials.deserialize(CborObject cbor) {
    if (cbor.hasType<CborTagValue>()) {
      final tag = cbor.as<CborTagValue>("Credentials");
      final list = tag.valueAs<CborIterableObject>("Credential");
      return Credentials(
          list
              .valueAsListOf<CborListValue>("Credential")
              .map((e) => Credential.deserialize(e))
              .toList(),
          serializationConfig: CredentialsSerializationConfig(
              tags: tag.tags, encoding: list.encoding));
    }
    final list = cbor.as<CborIterableObject>("Credential");
    return Credentials(
        list
            .valueAsListOf<CborListValue>("Credential")
            .map((e) => Credential.deserialize(e))
            .toList(),
        serializationConfig:
            CredentialsSerializationConfig(encoding: list.encoding));
  }
  factory Credentials.fromJson(Map<String, dynamic> json) {
    return Credentials((json["credentials"] as List)
        .map((e) => Credential.fromJson(e))
        .toList());
  }

  @override
  CborObject toCbor() {
    final obj = () {
      switch (serializationConfig.encoding) {
        case CborIterableEncodingType.inDefinite:
          return CborListValue.inDefinite(
              credentials.map((e) => e.toCbor()).toList());
        case CborIterableEncodingType.definite:
          return CborListValue.definite(
              credentials.map((e) => e.toCbor()).toList());
        case CborIterableEncodingType.set:
          return CborSetValue(credentials.map((e) => e.toCbor()));
      }
    }() as CborObject;
    final tags = serializationConfig.tags;
    if (tags != null) {
      return CborTagValue(obj, tags);
    }
    return obj;
  }

  @override
  Map<String, dynamic> toJson() {
    return {"credentials": credentials.map((e) => e.toJson()).toList()};
  }
}
