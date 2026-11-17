import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/proto_messages/types.dart';
import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';

enum SuiArgumentArgumentKind implements ProtoEnumVariant {
  argumentKindUnknown(0, 'ARGUMENT_KIND_UNKNOWN'),
    /// The gas coin.
  gas(1, 'GAS'),
    /// One of the input objects or primitive values (from
  /// `ProgrammableTransaction` inputs).
  input(2, 'INPUT'),
    /// The result of another command (from `ProgrammableTransaction` commands).
  result(3, 'RESULT');

  const SuiArgumentArgumentKind(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static SuiArgumentArgumentKind fromValue(int? value) {
    value ??=0;
    return SuiArgumentArgumentKind.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching SuiArgumentArgumentKind found for the given value. $value", details: {"name": "SuiArgumentArgumentKind", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static SuiArgumentArgumentKind from(Object? value) {
    value ??=0;
    return SuiArgumentArgumentKind.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching SuiArgumentArgumentKind found for the given value. $value", details: {"name": "SuiArgumentArgumentKind", "value": value?.toString()})
    );
  }

}


/// Copyright (c) Mysten Labs, Inc.
/// SPDX-License-Identifier: Apache-2.0
/// An argument to a programmable transaction command.
class SuiArgument extends SuiProtoMessage {
  final SuiArgumentArgumentKind? kind;

    /// Index of an input when `kind` is `INPUT`.
  final int? input;

    /// Index of a result when `kind` is `RESULT`.
  final int? result;

    /// Used to access a nested result when `kind` is `RESULT`.
  final int? subresult;

  const SuiArgument({
    this.kind,
    this.input,
    this.result,
    this.subresult,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.enumType(1, hasOptionalFlags: true),
        ProtoFieldConfig.uint32(2, hasOptionalFlags: true),
        ProtoFieldConfig.uint32(3, hasOptionalFlags: true),
        ProtoFieldConfig.uint32(4, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        kind,
        input,
        result,
        subresult,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'kind': config.encodeEnum(kind),
      'input': input,
      'result': result,
      'subresult': subresult,
    };
  }


  factory SuiArgument.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiArgument(
      kind: json.valueTo<SuiArgumentArgumentKind?, Object?>(
        key: 'kind',
        parse: (v) => SuiArgumentArgumentKind.from(v),
      ),
      input: json.valueAsInt<int?>('input', normalizeKeyLookup: config.normalizeKeys),
      result: json.valueAsInt<int?>('result', normalizeKeyLookup: config.normalizeKeys),
      subresult: json.valueAsInt<int?>('subresult', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory SuiArgument.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiArgument(
      kind: decode.getEnum<SuiArgumentArgumentKind?>(1, SuiArgumentArgumentKind.values),
      input: decode.getInt<int?>(2),
      result: decode.getInt<int?>(3),
      subresult: decode.getInt<int?>(4),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2Argument;

}


