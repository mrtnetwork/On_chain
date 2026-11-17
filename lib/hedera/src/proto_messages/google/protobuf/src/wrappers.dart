import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

/// Protocol Buffers - Google's data interchange format
/// Copyright 2008 Google Inc.  All rights reserved.
/// https://developers.google.com/protocol-buffers/
///
/// Redistribution and use in source and binary forms, with or without
/// modification, are permitted provided that the following conditions are
/// met:
///
/// * Redistributions of source code must retain the above copyright
/// notice, this list of conditions and the following disclaimer.
/// * Redistributions in binary form must reproduce the above
/// copyright notice, this list of conditions and the following disclaimer
/// in the documentation and/or other materials provided with the
/// distribution.
/// * Neither the name of Google Inc. nor the names of its
/// contributors may be used to endorse or promote products derived from
/// this software without specific prior written permission.
///
/// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
/// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
/// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
/// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
/// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
/// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
/// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
/// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
/// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
/// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
/// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
///
/// Wrappers for primitive (non-message) types. These types were needed
/// for legacy reasons and are not recommended for use in new APIs.
///
/// Historically these wrappers were useful to have presence on proto3 primitive
/// fields, but proto3 syntax has been updated to support the `optional` keyword.
/// Using that keyword is now the strongly preferred way to add presence to
/// proto3 primitive fields.
///
/// A secondary usecase was to embed primitives in the `google.protobuf.Any`
/// type: it is now recommended that you embed your value in your own wrapper
/// message which can be specifically documented.
///
/// These wrappers have no meaningful use within repeated fields as they lack
/// the ability to detect presence on individual elements.
/// These wrappers have no meaningful use within a map or a oneof since
/// individual entries of a map or fields of a oneof can already detect presence.
/// Wrapper message for `double`.
///
/// The JSON representation for `DoubleValue` is JSON number.
///
/// Not recommended for use in new APIs, but still useful for legacy APIs and
/// has no plan to be removed.
class HederaDoubleValue extends HederaProtoMessage with Equality {
  /// The double value.
  final double? value;

  const HederaDoubleValue({this.value});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.double(1)],
    );
  }

  @override
  List<Object?> get protoValues => [value];

  HederaDoubleValue copyWith({double? value}) {
    return HederaDoubleValue(value: value ?? this.value);
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'value': value};
  }

  factory HederaDoubleValue.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaDoubleValue(
      value: json.valueAsDouble<double?>(
        'value',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaDoubleValue.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaDoubleValue(value: decode.getDouble<double?>(1));
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.googleProtobufDoubleValue;
}

/// Wrapper message for `float`.
///
/// The JSON representation for `FloatValue` is JSON number.
///
/// Not recommended for use in new APIs, but still useful for legacy APIs and
/// has no plan to be removed.
class HederaFloatValue extends HederaProtoMessage with Equality {
  /// The float value.
  final double? value;

  const HederaFloatValue({this.value});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.float(1)],
    );
  }

  @override
  List<Object?> get protoValues => [value];

  HederaFloatValue copyWith({double? value}) {
    return HederaFloatValue(value: value ?? this.value);
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'value': value};
  }

  factory HederaFloatValue.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaFloatValue(
      value: json.valueAsDouble<double?>(
        'value',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaFloatValue.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaFloatValue(value: decode.getDouble<double?>(1));
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.googleProtobufFloatValue;
}

/// Wrapper message for `int64`.
///
/// The JSON representation for `Int64Value` is JSON string.
///
/// Not recommended for use in new APIs, but still useful for legacy APIs and
/// has no plan to be removed.
class HederaInt64Value extends HederaProtoMessage with Equality {
  /// The int64 value.
  final BigInt? value;

  const HederaInt64Value({this.value});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.int64(1)],
    );
  }

  @override
  List<Object?> get protoValues => [value];

  HederaInt64Value copyWith({BigInt? value}) {
    return HederaInt64Value(value: value ?? this.value);
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'value': config.encodeBigint(value)};
  }

  factory HederaInt64Value.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaInt64Value(
      value: json.valueAsBigInt<BigInt?>(
        'value',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaInt64Value.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaInt64Value(value: decode.getBigInt<BigInt?>(1));
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.googleProtobufInt64Value;
}

/// Wrapper message for `uint64`.
///
/// The JSON representation for `UInt64Value` is JSON string.
///
/// Not recommended for use in new APIs, but still useful for legacy APIs and
/// has no plan to be removed.
class HederaUInt64Value extends HederaProtoMessage with Equality {
  /// The uint64 value.
  final BigInt? value;

  const HederaUInt64Value({this.value});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.uint64(1)],
    );
  }

  @override
  List<Object?> get protoValues => [value];

  HederaUInt64Value copyWith({BigInt? value}) {
    return HederaUInt64Value(value: value ?? this.value);
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'value': config.encodeBigint(value)};
  }

  factory HederaUInt64Value.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaUInt64Value(
      value: json.valueAsBigInt<BigInt?>(
        'value',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaUInt64Value.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaUInt64Value(value: decode.getBigInt<BigInt?>(1));
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.googleProtobufUInt64Value;
}

/// Wrapper message for `int32`.
///
/// The JSON representation for `Int32Value` is JSON number.
///
/// Not recommended for use in new APIs, but still useful for legacy APIs and
/// has no plan to be removed.
class HederaInt32Value extends HederaProtoMessage with Equality {
  /// The int32 value.
  final int? value;

  const HederaInt32Value({this.value});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.int32(1)],
    );
  }

  @override
  List<Object?> get protoValues => [value];

  HederaInt32Value copyWith({int? value}) {
    return HederaInt32Value(value: value ?? this.value);
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'value': value};
  }

  factory HederaInt32Value.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaInt32Value(
      value: json.valueAsInt<int?>(
        'value',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaInt32Value.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaInt32Value(value: decode.getInt<int?>(1));
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.googleProtobufInt32Value;
}

/// Wrapper message for `uint32`.
///
/// The JSON representation for `UInt32Value` is JSON number.
///
/// Not recommended for use in new APIs, but still useful for legacy APIs and
/// has no plan to be removed.
class HederaUInt32Value extends HederaProtoMessage with Equality {
  /// The uint32 value.
  final int? value;

  const HederaUInt32Value({this.value});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.uint32(1)],
    );
  }

  @override
  List<Object?> get protoValues => [value];

  HederaUInt32Value copyWith({int? value}) {
    return HederaUInt32Value(value: value ?? this.value);
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'value': value};
  }

  factory HederaUInt32Value.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaUInt32Value(
      value: json.valueAsInt<int?>(
        'value',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaUInt32Value.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaUInt32Value(value: decode.getInt<int?>(1));
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.googleProtobufUInt32Value;
}

/// Wrapper message for `bool`.
///
/// The JSON representation for `BoolValue` is JSON `true` and `false`.
///
/// Not recommended for use in new APIs, but still useful for legacy APIs and
/// has no plan to be removed.
class HederaBoolValue extends HederaProtoMessage with Equality {
  /// The bool value.
  final bool? value;

  const HederaBoolValue({this.value});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.bool(1)],
    );
  }

  @override
  List<Object?> get protoValues => [value];

  HederaBoolValue copyWith({bool? value}) {
    return HederaBoolValue(value: value ?? this.value);
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'value': value};
  }

  factory HederaBoolValue.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaBoolValue(
      value: json.valueAsBool<bool?>(
        'value',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaBoolValue.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaBoolValue(value: decode.getBool<bool?>(1));
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.googleProtobufBoolValue;
}

/// Wrapper message for `string`.
///
/// The JSON representation for `StringValue` is JSON string.
///
/// Not recommended for use in new APIs, but still useful for legacy APIs and
/// has no plan to be removed.
class HederaStringValue extends HederaProtoMessage with Equality {
  /// The string value.
  final String? value;

  const HederaStringValue({this.value});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.string(1)],
    );
  }

  @override
  List<Object?> get protoValues => [value];

  HederaStringValue copyWith({String? value}) {
    return HederaStringValue(value: value ?? this.value);
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'value': value};
  }

  factory HederaStringValue.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaStringValue(
      value: json.valueAsString<String?>(
        'value',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaStringValue.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaStringValue(value: decode.getString<String?>(1));
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.googleProtobufStringValue;
}

/// Wrapper message for `bytes`.
///
/// The JSON representation for `BytesValue` is JSON string.
///
/// Not recommended for use in new APIs, but still useful for legacy APIs and
/// has no plan to be removed.
class HederaBytesValue extends HederaProtoMessage with Equality {
  /// The bytes value.
  final List<int>? value;

  const HederaBytesValue({this.value});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.bytes(1)],
    );
  }

  @override
  List<Object?> get protoValues => [value];

  HederaBytesValue copyWith({List<int>? value}) {
    return HederaBytesValue(value: value ?? this.value);
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'value': config.encodeBinary(value)};
  }

  factory HederaBytesValue.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaBytesValue(
      value: config.decodeBinary<List<int>?>(
        json.valueAs('value', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory HederaBytesValue.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaBytesValue(value: decode.getBytes<List<int>?>(1));
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.googleProtobufBytesValue;
}
