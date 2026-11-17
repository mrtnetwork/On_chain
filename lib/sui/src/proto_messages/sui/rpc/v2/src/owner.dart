import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/proto_messages/types.dart';
import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';

enum SuiOwnerOwnerKind implements ProtoEnumVariant {
  ownerKindUnknown(0, 'OWNER_KIND_UNKNOWN'),
  address(1, 'ADDRESS'),
  object(2, 'OBJECT'),
  shared(3, 'SHARED'),
  immutable(4, 'IMMUTABLE'),
  consensusAddress(5, 'CONSENSUS_ADDRESS');

  const SuiOwnerOwnerKind(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static SuiOwnerOwnerKind fromValue(int? value) {
    value ??=0;
    return SuiOwnerOwnerKind.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching SuiOwnerOwnerKind found for the given value. $value", details: {"name": "SuiOwnerOwnerKind", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static SuiOwnerOwnerKind from(Object? value) {
    value ??=0;
    return SuiOwnerOwnerKind.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching SuiOwnerOwnerKind found for the given value. $value", details: {"name": "SuiOwnerOwnerKind", "value": value?.toString()})
    );
  }

}


/// Copyright (c) Mysten Labs, Inc.
/// SPDX-License-Identifier: Apache-2.0
/// Enum of different types of ownership for an object.
class SuiOwner extends SuiProtoMessage {
  final SuiOwnerOwnerKind? kind;

    /// Address or ObjectId of the owner
  final String? address;

    /// The `initial_shared_version` if kind is `SHARED` or `start_version` if kind `CONSENSUS_ADDRESS`.
  final BigInt? version;

  const SuiOwner({
    this.kind,
    this.address,
    this.version,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.enumType(1, hasOptionalFlags: true),
        ProtoFieldConfig.string(2, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(3, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        kind,
        address,
        version,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'kind': config.encodeEnum(kind),
      'address': address,
      'version': config.encodeBigint(version),
    };
  }


  factory SuiOwner.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiOwner(
      kind: json.valueTo<SuiOwnerOwnerKind?, Object?>(
        key: 'kind',
        parse: (v) => SuiOwnerOwnerKind.from(v),
      ),
      address: json.valueAsString<String?>('address', normalizeKeyLookup: config.normalizeKeys),
      version: json.valueAsBigInt<BigInt?>('version', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory SuiOwner.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiOwner(
      kind: decode.getEnum<SuiOwnerOwnerKind?>(1, SuiOwnerOwnerKind.values),
      address: decode.getString<String?>(2),
      version: decode.getBigInt<BigInt?>(3),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2Owner;

}


