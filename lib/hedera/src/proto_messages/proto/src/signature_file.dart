import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/hash_object.dart"
    as proto_hash_object;

/// *
///  * The signature type
enum HederaSignatureType implements ProtoEnumVariant {
  signatureTypeUnknown(0, 'SIGNATURE_TYPE_UNKNOWN'),
  sha384WithRsa(1, 'SHA_384_WITH_RSA');

  const HederaSignatureType(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static HederaSignatureType fromValue(int? value) {
    value ??= 0;
    return HederaSignatureType.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching HederaSignatureType found for the given value. $value",
                details: {
                  "name": "HederaSignatureType",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static HederaSignatureType from(Object? value) {
    value ??= 0;
    return HederaSignatureType.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching HederaSignatureType found for the given value. $value",
                details: {
                  "name": "HederaSignatureType",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

/// -
///  * ‌
///  * Hedera Network Services Protobuf
///  * ​
///  * Copyright (C) 2018 - 2022 Hedera Hashgraph, LLC
///  * ​
///  * Licensed under the Apache License, Version 2.0 (the "License");
///  * you may not use this file except in compliance with the License.
///  * You may obtain a copy of the License at
///  *
///  *      http://www.apache.org/licenses/LICENSE-2.0
///  *
///  * Unless required by applicable law or agreed to in writing, software
///  * distributed under the License is distributed on an "AS IS" BASIS,
///  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
///  * See the License for the specific language governing permissions and
///  * limitations under the License.
///  * ‍
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.streams"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * The record signature file which is created for each record stream file
///  * that signs the hash of the entire corresponding stream file.
class HederaSignatureFile extends HederaProtoMessage with Equality {
  /// *
  ///    * Signature for the file
  final HederaSignatureObject? fileSignature;

  /// *
  ///    * Metadata signature
  final HederaSignatureObject? metadataSignature;

  const HederaSignatureFile({this.fileSignature, this.metadataSignature});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.message(1), ProtoFieldConfig.message(2)],
    );
  }

  @override
  List<Object?> get protoValues => [fileSignature, metadataSignature];

  HederaSignatureFile copyWith({
    HederaSignatureObject? fileSignature,

    HederaSignatureObject? metadataSignature,
  }) {
    return HederaSignatureFile(
      fileSignature: fileSignature ?? this.fileSignature,
      metadataSignature: metadataSignature ?? this.metadataSignature,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'file_signature': config.encodeMessage(fileSignature),
      'metadata_signature': config.encodeMessage(metadataSignature),
    };
  }

  factory HederaSignatureFile.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaSignatureFile(
      fileSignature: json.valueTo<HederaSignatureObject?, Object>(
        key: 'file_signature',
        parse:
            (v) => HederaSignatureObject.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      metadataSignature: json.valueTo<HederaSignatureObject?, Object>(
        key: 'metadata_signature',
        parse:
            (v) => HederaSignatureObject.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaSignatureFile.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaSignatureFile(
      fileSignature: decode.messageTo<HederaSignatureObject?>(
        1,
        (b) => HederaSignatureObject.deserialize(b),
      ),
      metadataSignature: decode.messageTo<HederaSignatureObject?>(
        2,
        (b) => HederaSignatureObject.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoSignatureFile;
}

/// *
///  * A Signature defined by its type, length, checksum and signature bytes and the hash that is signed
class HederaSignatureObject extends HederaProtoMessage with Equality {
  /// *
  ///    * The signature type
  final HederaSignatureType? type;

  /// *
  ///    * Signature length
  final int? length;

  /// *
  ///    * Signature checksum
  final int? checksum;

  /// *
  ///    * Signature bytes
  final List<int>? signature;

  /// *
  ///    * The hash that is signed by this signature
  final proto_hash_object.HederaHashObject? hashObject;

  const HederaSignatureObject({
    this.type,
    this.length,
    this.checksum,
    this.signature,
    this.hashObject,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.enumType(1),
        ProtoFieldConfig.int32(2),
        ProtoFieldConfig.int32(3),
        ProtoFieldConfig.bytes(4),
        ProtoFieldConfig.message(5),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    type,
    length,
    checksum,
    signature,
    hashObject,
  ];

  HederaSignatureObject copyWith({
    HederaSignatureType? type,

    int? length,

    int? checksum,

    List<int>? signature,

    proto_hash_object.HederaHashObject? hashObject,
  }) {
    return HederaSignatureObject(
      type: type ?? this.type,
      length: length ?? this.length,
      checksum: checksum ?? this.checksum,
      signature: signature ?? this.signature,
      hashObject: hashObject ?? this.hashObject,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'type': config.encodeEnum(type),
      'length': length,
      'checksum': checksum,
      'signature': config.encodeBinary(signature),
      'hash_object': config.encodeMessage(hashObject),
    };
  }

  factory HederaSignatureObject.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaSignatureObject(
      type: json.valueTo<HederaSignatureType?, Object?>(
        key: 'type',
        parse: (v) => HederaSignatureType.from(v),
      ),
      length: json.valueAsInt<int?>(
        'length',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      checksum: json.valueAsInt<int?>(
        'checksum',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      signature: config.decodeBinary<List<int>?>(
        json.valueAs('signature', normalizeKeyLookup: config.normalizeKeys),
      ),
      hashObject: json.valueTo<proto_hash_object.HederaHashObject?, Object>(
        key: 'hash_object',
        parse:
            (v) => proto_hash_object.HederaHashObject.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaSignatureObject.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaSignatureObject(
      type: decode.getEnum<HederaSignatureType?>(1, HederaSignatureType.values),
      length: decode.getInt<int?>(2),
      checksum: decode.getInt<int?>(3),
      signature: decode.getBytes<List<int>?>(4),
      hashObject: decode.messageTo<proto_hash_object.HederaHashObject?>(
        5,
        (b) => proto_hash_object.HederaHashObject.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoSignatureObject;
}
