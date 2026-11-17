import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

/// *
///  * # Primitives
///  * Primitive value wrapper messages.
///  *
///  * These SHALL be used only for situations where the entire value to be stored
///  * in state is a single primitive. These MUST NOT ever be used as components of
///  * another message; use the protobuf type instead.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in [RFC2119](https://www.ietf.org/rfc/rfc2119)
///  * and clarified in [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.state.primitives"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A single 64-bit number with no particular meaning.
class HederaProtoLong extends HederaProtoMessage with Equality {
  final BigInt? value;

  const HederaProtoLong({
    this.value,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        value,
      ];


HederaProtoLong copyWith(
{BigInt? value,

}) {
    return HederaProtoLong(
value: value ?? this.value,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'value': config.encodeBigint(value),
    };
  }


  factory HederaProtoLong.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaProtoLong(
      value: json.valueAsBigInt<BigInt?>('value', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaProtoLong.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaProtoLong(
      value: decode.getBigInt<BigInt?>(1),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoProtoLong;

}


/// *
///  * A single 32-bit number with no particular meaning.
class HederaProtoInteger extends HederaProtoMessage with Equality {
  final int? value;

  const HederaProtoInteger({
    this.value,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int32(1),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        value,
      ];


HederaProtoInteger copyWith(
{int? value,

}) {
    return HederaProtoInteger(
value: value ?? this.value,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'value': value,
    };
  }


  factory HederaProtoInteger.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaProtoInteger(
      value: json.valueAsInt<int?>('value', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaProtoInteger.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaProtoInteger(
      value: decode.getInt<int?>(1),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoProtoInteger;

}


/// *
///  * A single boolean with no particular meaning.
class HederaProtoBoolean extends HederaProtoMessage with Equality {
  final bool? value;

  const HederaProtoBoolean({
    this.value,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bool(1),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        value,
      ];


HederaProtoBoolean copyWith(
{bool? value,

}) {
    return HederaProtoBoolean(
value: value ?? this.value,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'value': value,
    };
  }


  factory HederaProtoBoolean.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaProtoBoolean(
      value: json.valueAsBool<bool?>('value', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaProtoBoolean.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaProtoBoolean(
      value: decode.getBool<bool?>(1),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoProtoBoolean;

}


/// *
///  * A single string with no particular meaning.
class HederaProtoString extends HederaProtoMessage with Equality {
  final String? value;

  const HederaProtoString({
    this.value,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        value,
      ];


HederaProtoString copyWith(
{String? value,

}) {
    return HederaProtoString(
value: value ?? this.value,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'value': value,
    };
  }


  factory HederaProtoString.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaProtoString(
      value: json.valueAsString<String?>('value', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaProtoString.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaProtoString(
      value: decode.getString<String?>(1),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoProtoString;

}


/// *
///  * A single byte array with no particular meaning.
class HederaProtoBytes extends HederaProtoMessage with Equality {
  final List<int>? value;

  const HederaProtoBytes({
    this.value,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        value,
      ];


HederaProtoBytes copyWith(
{List<int>? value,

}) {
    return HederaProtoBytes(
value: value ?? this.value,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'value': config.encodeBinary(value),
    };
  }


  factory HederaProtoBytes.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaProtoBytes(
      value: config.decodeBinary<List<int>?>(json.valueAs('value', normalizeKeyLookup: config.normalizeKeys)),
    );
  }

  factory HederaProtoBytes.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaProtoBytes(
      value: decode.getBytes<List<int>?>(1),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoProtoBytes;

}


