import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

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
///  * List of hash algorithms
enum HederaHashAlgorithm implements ProtoEnumVariant {
  hashAlgorithmUnknown(0, 'HASH_ALGORITHM_UNKNOWN'),
  sha384(1, 'SHA_384');

  const HederaHashAlgorithm(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static HederaHashAlgorithm fromValue(int? value) {
    value ??=0;
    return HederaHashAlgorithm.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaHashAlgorithm found for the given value. $value", details: {"name": "HederaHashAlgorithm", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static HederaHashAlgorithm from(Object? value) {
    value ??=0;
    return HederaHashAlgorithm.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaHashAlgorithm found for the given value. $value", details: {"name": "HederaHashAlgorithm", "value": value?.toString()})
    );
  }

}


/// *
///  * Encapsulates an object hash so that additional hash algorithms
///  * can be added in the future without requiring a breaking change.
class HederaHashObject extends HederaProtoMessage with Equality {
    /// *
  ///    * Specifies the hashing algorithm
  final HederaHashAlgorithm? algorithm;

    /// *
  ///    * Hash length
  final int? length;

    /// *
  ///    * Specifies the result of the hashing operation in bytes
  final List<int>? hash;

  const HederaHashObject({
    this.algorithm,
    this.length,
    this.hash,
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
        ProtoFieldConfig.bytes(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        algorithm,
        length,
        hash,
      ];


HederaHashObject copyWith(
{HederaHashAlgorithm? algorithm,

int? length,

List<int>? hash,

}) {
    return HederaHashObject(
algorithm: algorithm ?? this.algorithm,
length: length ?? this.length,
hash: hash ?? this.hash,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'algorithm': config.encodeEnum(algorithm),
      'length': length,
      'hash': config.encodeBinary(hash),
    };
  }


  factory HederaHashObject.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaHashObject(
      algorithm: json.valueTo<HederaHashAlgorithm?, Object?>(
        key: 'algorithm',
        parse: (v) => HederaHashAlgorithm.from(v),
      ),
      length: json.valueAsInt<int?>('length', normalizeKeyLookup: config.normalizeKeys),
      hash: config.decodeBinary<List<int>?>(json.valueAs('hash', normalizeKeyLookup: config.normalizeKeys)),
    );
  }

  factory HederaHashObject.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaHashObject(
      algorithm: decode.getEnum<HederaHashAlgorithm?>(1, HederaHashAlgorithm.values),
      length: decode.getInt<int?>(2),
      hash: decode.getBytes<List<int>?>(3),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoHashObject;

}


