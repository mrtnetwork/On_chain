import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/proto_messages/types.dart';
import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';
import "package:on_chain/sui/src/proto_messages/google/protobuf/src/struct.dart"
    as google_protobuf_struct;

enum SuiInputInputKind implements ProtoEnumVariant {
  inputKindUnknown(0, 'INPUT_KIND_UNKNOWN'),

  /// A move value serialized as BCS.
  pure(1, 'PURE'),

  /// A Move object that is either immutable or address owned.
  immutableOrOwned(2, 'IMMUTABLE_OR_OWNED'),

  /// A Move object whose owner is "Shared".
  shared(3, 'SHARED'),

  /// A Move object that is attempted to be received in this transaction.
  receiving(4, 'RECEIVING'),

  /// Reservation to withdraw balance from a funds accumulator
  fundsWithdrawal(5, 'FUNDS_WITHDRAWAL');

  const SuiInputInputKind(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static SuiInputInputKind fromValue(int? value) {
    value ??= 0;
    return SuiInputInputKind.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiInputInputKind found for the given value. $value",
                details: {
                  "name": "SuiInputInputKind",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static SuiInputInputKind from(Object? value) {
    value ??= 0;
    return SuiInputInputKind.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiInputInputKind found for the given value. $value",
                details: {
                  "name": "SuiInputInputKind",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

enum SuiInputMutability implements ProtoEnumVariant {
  mutabilityUnknown(0, 'MUTABILITY_UNKNOWN'),
  immutable(1, 'IMMUTABLE'),
  mutable(2, 'MUTABLE'),

  /// Non-exclusive write is used to allow multiple transactions to
  /// simultaneously add disjoint dynamic fields to an object.
  /// (Currently only used by settlement transactions).
  nonExclusiveWrite(3, 'NON_EXCLUSIVE_WRITE');

  const SuiInputMutability(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static SuiInputMutability fromValue(int? value) {
    value ??= 0;
    return SuiInputMutability.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiInputMutability found for the given value. $value",
                details: {
                  "name": "SuiInputMutability",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static SuiInputMutability from(Object? value) {
    value ??= 0;
    return SuiInputMutability.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiInputMutability found for the given value. $value",
                details: {
                  "name": "SuiInputMutability",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

enum SuiFundsWithdrawalSource implements ProtoEnumVariant {
  sourceUnknown(0, 'SOURCE_UNKNOWN'),
  sender(1, 'SENDER'),
  sponsor(2, 'SPONSOR'),

  /// Withdraw from `funder`'s balance under the `allowance` object, granted
  /// to the sender of the transaction.
  senderAllowance(3, 'SENDER_ALLOWANCE');

  const SuiFundsWithdrawalSource(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static SuiFundsWithdrawalSource fromValue(int? value) {
    value ??= 0;
    return SuiFundsWithdrawalSource.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiFundsWithdrawalSource found for the given value. $value",
                details: {
                  "name": "SuiFundsWithdrawalSource",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static SuiFundsWithdrawalSource from(Object? value) {
    value ??= 0;
    return SuiFundsWithdrawalSource.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiFundsWithdrawalSource found for the given value. $value",
                details: {
                  "name": "SuiFundsWithdrawalSource",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

/// Copyright (c) Mysten Labs, Inc.
/// SPDX-License-Identifier: Apache-2.0
/// An input to a user transaction.
class SuiInput extends SuiProtoMessage {
  final SuiInputInputKind? kind;

  /// A move value serialized as BCS.
  ///
  /// For normal operations this is required to be a move primitive type and not contain structs
  /// or objects.
  final BuBytes? pure;

  /// `ObjectId` of the object input.
  final String? objectId;

  /// Requested version of the input object when `kind` is `IMMUTABLE_OR_OWNED`
  /// or `RECEIVING` or if `kind` is `SHARED` this is the initial version of the
  /// object when it was shared
  final BigInt? version;

  /// The digest of this object.
  final String? digest;

  /// Controls whether the caller asks for a mutable reference to the shared
  /// object.
  final bool? mutable;

  /// NOTE: For backwards compatibility purposes the addition of the new
  /// `NON_EXCLUSIVE_WRITE` mutability variant requires providing a new field.
  /// The old `mutable` field will continue to be populated and respected as an
  /// input for the time being.
  final SuiInputMutability? mutability;

  /// Fund Reservation information if `kind` is `FUNDS_WITHDRAWAL`.
  final SuiFundsWithdrawal? fundsWithdrawal;

  /// A literal value
  ///
  /// INPUT ONLY
  final google_protobuf_struct.SuiValue? literal;

  SuiInput({
    this.kind,
    List<int>? pure,
    this.objectId,
    this.version,
    this.digest,
    this.mutable,
    this.mutability,
    this.fundsWithdrawal,
    this.literal,
  }) : pure = pure?.asImmutableBytes;

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.enumType(1, hasOptionalFlags: true),
        ProtoFieldConfig.bytes(2, hasOptionalFlags: true),
        ProtoFieldConfig.string(3, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(4, hasOptionalFlags: true),
        ProtoFieldConfig.string(5, hasOptionalFlags: true),
        ProtoFieldConfig.bool(6, hasOptionalFlags: true),
        ProtoFieldConfig.enumType(7, hasOptionalFlags: true),
        ProtoFieldConfig.message(8, hasOptionalFlags: true),
        ProtoFieldConfig.message(1000, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    kind,
    pure,
    objectId,
    version,
    digest,
    mutable,
    mutability,
    fundsWithdrawal,
    literal,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'kind': config.encodeEnum(kind),
      'pure': config.encodeBinary(pure),
      'object_id': objectId,
      'version': config.encodeBigint(version),
      'digest': digest,
      'mutable': mutable,
      'mutability': config.encodeEnum(mutability),
      'funds_withdrawal': config.encodeMessage(fundsWithdrawal),
      'literal': config.encodeMessage(literal),
    };
  }

  factory SuiInput.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiInput(
      kind: json.valueTo<SuiInputInputKind?, Object?>(
        key: 'kind',
        parse: (v) => SuiInputInputKind.from(v),
      ),
      pure: config.decodeBinary<List<int>?>(
        json.valueAs('pure', normalizeKeyLookup: config.normalizeKeys),
      ),
      objectId: json.valueAsString<String?>(
        'object_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      version: json.valueAsBigInt<BigInt?>(
        'version',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      digest: json.valueAsString<String?>(
        'digest',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      mutable: json.valueAsBool<bool?>(
        'mutable',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      mutability: json.valueTo<SuiInputMutability?, Object?>(
        key: 'mutability',
        parse: (v) => SuiInputMutability.from(v),
      ),
      fundsWithdrawal: json.valueTo<SuiFundsWithdrawal?, Object>(
        key: 'funds_withdrawal',
        parse:
            (v) => SuiFundsWithdrawal.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      literal: json.valueTo<google_protobuf_struct.SuiValue?, Object>(
        key: 'literal',
        parse:
            (v) => google_protobuf_struct.SuiValue.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiInput.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiInput(
      kind: decode.getEnum<SuiInputInputKind?>(1, SuiInputInputKind.values),
      pure: decode.getBytes<List<int>?>(2),
      objectId: decode.getString<String?>(3),
      version: decode.getBigInt<BigInt?>(4),
      digest: decode.getString<String?>(5),
      mutable: decode.getBool<bool?>(6),
      mutability: decode.getEnum<SuiInputMutability?>(
        7,
        SuiInputMutability.values,
      ),
      fundsWithdrawal: decode.messageTo<SuiFundsWithdrawal?>(
        8,
        (b) => SuiFundsWithdrawal.deserialize(b),
      ),
      literal: decode.messageTo<google_protobuf_struct.SuiValue?>(
        1000,
        (b) => google_protobuf_struct.SuiValue.deserialize(b),
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2Input;
}

class SuiFundsWithdrawal extends SuiProtoMessage {
  final BigInt? amount;

  final String? coinType;

  final SuiFundsWithdrawalSource? source;

  /// The address whose balance is debited if `source` is `SENDER_ALLOWANCE`.
  final String? funder;

  /// `ObjectId` of the allowance object authorizing the withdrawal if `source`
  /// is `SENDER_ALLOWANCE`.
  final String? allowance;

  const SuiFundsWithdrawal({
    this.amount,
    this.coinType,
    this.source,
    this.funder,
    this.allowance,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1, hasOptionalFlags: true),
        ProtoFieldConfig.string(2, hasOptionalFlags: true),
        ProtoFieldConfig.enumType(3, hasOptionalFlags: true),
        ProtoFieldConfig.string(4, hasOptionalFlags: true),
        ProtoFieldConfig.string(5, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    amount,
    coinType,
    source,
    funder,
    allowance,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'amount': config.encodeBigint(amount),
      'coin_type': coinType,
      'source': config.encodeEnum(source),
      'funder': funder,
      'allowance': allowance,
    };
  }

  factory SuiFundsWithdrawal.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiFundsWithdrawal(
      amount: json.valueAsBigInt<BigInt?>(
        'amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      coinType: json.valueAsString<String?>(
        'coin_type',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      source: json.valueTo<SuiFundsWithdrawalSource?, Object?>(
        key: 'source',
        parse: (v) => SuiFundsWithdrawalSource.from(v),
      ),
      funder: json.valueAsString<String?>(
        'funder',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      allowance: json.valueAsString<String?>(
        'allowance',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiFundsWithdrawal.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiFundsWithdrawal(
      amount: decode.getBigInt<BigInt?>(1),
      coinType: decode.getString<String?>(2),
      source: decode.getEnum<SuiFundsWithdrawalSource?>(
        3,
        SuiFundsWithdrawalSource.values,
      ),
      funder: decode.getString<String?>(4),
      allowance: decode.getString<String?>(5),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2FundsWithdrawal;
}
