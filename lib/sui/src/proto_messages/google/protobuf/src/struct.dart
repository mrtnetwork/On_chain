import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/proto_messages/types.dart';
import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';

/// `NullValue` is a singleton enumeration to represent the null value for the
/// `Value` type union.
///
/// The JSON representation for `NullValue` is JSON `null`.
enum SuiNullValue implements ProtoEnumVariant {
    /// Null value.
  nullValue(0, 'NULL_VALUE');

  const SuiNullValue(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static SuiNullValue fromValue(int? value) {
    value ??=0;
    return SuiNullValue.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching SuiNullValue found for the given value. $value", details: {"name": "SuiNullValue", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static SuiNullValue from(Object? value) {
    value ??=0;
    return SuiNullValue.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching SuiNullValue found for the given value. $value", details: {"name": "SuiNullValue", "value": value?.toString()})
    );
  }

}


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
/// `Struct` represents a structured data value, consisting of fields
/// which map to dynamically typed values. In some languages, `Struct`
/// might be supported by a native representation. For example, in
/// scripting languages like JS a struct is represented as an
/// object. The details of that representation are described together
/// with the proto support for the language.
///
/// The JSON representation for `Struct` is JSON object.
class SuiStruct extends SuiProtoMessage {
    /// Unordered map of dynamically typed values.
  final Map<String, SuiValue> fields;

  const SuiStruct({
    this.fields = const {},
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.map(
          fieldNumber: 1,
          keyType: ProtoFieldType.string,
          valueType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        fields,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'fields': config.encodeMap(fields,(k, v) => MapEntry(k, config.encodeMessage(v))),
    };
  }


  factory SuiStruct.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiStruct(
      fields: config.decodeMap(json.valueAs('fields', normalizeKeyLookup: config.normalizeKeys),(k, v) => MapEntry(JsonParser.valueAsString<String>(k), JsonParser.valueTo<SuiValue, Object>(
          value: v,
          parse: (v) => SuiValue.fromJson(JsonParser.valueAs(v), config: config),
        ))),
    );
  }

  factory SuiStruct.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiStruct(
      fields: decode.getMapField<String, SuiValue>(        fieldNumber: 1,
        keyMapper: (v) => JsonParser.valueAs<String>(v),
        valueMapper: (v) => SuiValue.deserialize(JsonParser.valueAsBytes<List<int>>(v)))
,
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.googleProtobufStruct;

}


/// `Value` represents a dynamically typed value which can be either
/// null, a number, a string, a boolean, a recursive struct value, or a
/// list of values. A producer of value is expected to set one of these
/// variants. Absence of any variant indicates an error.
///
/// The JSON representation for `Value` is JSON value.
class SuiValue extends SuiProtoMessage {
    /// The kind of value.
  /// Represents a null value.
  final SuiNullValue? nullValue;

    /// Represents a double value.
  final double? numberValue;

    /// Represents a string value.
  final String? stringValue;

    /// Represents a boolean value.
  final bool? boolValue;

    /// Represents a structured value.
  final SuiStruct? structValue;

    /// Represents a repeated `Value`.
  final SuiListValue? listValue;

  const SuiValue({
    this.nullValue,
    this.numberValue,
    this.stringValue,
    this.boolValue,
    this.structValue,
    this.listValue,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.enumType(1),
        ProtoFieldConfig.double(2),
        ProtoFieldConfig.string(3),
        ProtoFieldConfig.bool(4),
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.message(6),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        nullValue,
        numberValue,
        stringValue,
        boolValue,
        structValue,
        listValue,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'null_value': config.encodeEnum(nullValue),
      'number_value': numberValue,
      'string_value': stringValue,
      'bool_value': boolValue,
      'struct_value': config.encodeMessage(structValue),
      'list_value': config.encodeMessage(listValue),
    };
  }


  factory SuiValue.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiValue(
      nullValue: json.valueTo<SuiNullValue?, Object?>(
        key: 'null_value',
        parse: (v) => SuiNullValue.from(v),
      ),
      numberValue: json.valueAsDouble<double?>('number_value', normalizeKeyLookup: config.normalizeKeys),
      stringValue: json.valueAsString<String?>('string_value', normalizeKeyLookup: config.normalizeKeys),
      boolValue: json.valueAsBool<bool?>('bool_value', normalizeKeyLookup: config.normalizeKeys),
      structValue: json.valueTo<SuiStruct?, Object>(
        key: 'struct_value',
        parse: (v) => SuiStruct.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      listValue: json.valueTo<SuiListValue?, Object>(
        key: 'list_value',
        parse: (v) => SuiListValue.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory SuiValue.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiValue(
      nullValue: decode.getEnum<SuiNullValue?>(1, SuiNullValue.values),
      numberValue: decode.getDouble<double?>(2),
      stringValue: decode.getString<String?>(3),
      boolValue: decode.getBool<bool?>(4),
      structValue: decode.messageTo<SuiStruct?>(5, (b) => SuiStruct.deserialize(b)),
      listValue: decode.messageTo<SuiListValue?>(6, (b) => SuiListValue.deserialize(b)),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.googleProtobufValue;

}


/// `ListValue` is a wrapper around a repeated field of values.
///
/// The JSON representation for `ListValue` is JSON array.
class SuiListValue extends SuiProtoMessage {
    /// Repeated field of dynamically typed values.
  final List<SuiValue> values;

  const SuiListValue({
    this.values = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        values,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'values': values.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory SuiListValue.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiListValue(
      values: (json.valueEnsureAsList<dynamic>('values', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<SuiValue, Object>(
          value: e,
          parse: (v) => SuiValue.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory SuiListValue.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiListValue(
      values: decode.getListOfBytes(1).map((b) => SuiValue.deserialize(b)).toList(),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.googleProtobufListValue;

}


