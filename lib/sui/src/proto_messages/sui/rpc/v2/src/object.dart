import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/proto_messages/types.dart';
import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/bcs.dart"
    as sui_rpc_v2_bcs;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/owner.dart"
    as sui_rpc_v2_owner;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/move_package.dart"
    as sui_rpc_v2_move_package;
import "package:on_chain/sui/src/proto_messages/google/protobuf/src/struct.dart"
    as google_protobuf_struct;

/// Copyright (c) Mysten Labs, Inc.
/// SPDX-License-Identifier: Apache-2.0
/// An object on the Sui blockchain.
class SuiObject extends SuiProtoMessage {
  /// This Object serialized as BCS.
  final sui_rpc_v2_bcs.SuiBcs? bcs;

  /// `ObjectId` for this object.
  final String? objectId;

  /// Version of the object.
  final BigInt? version;

  /// The digest of this Object.
  final String? digest;

  /// Owner of the object.
  final sui_rpc_v2_owner.SuiOwner? owner;

  /// The type of this object.
  ///
  /// This will be 'package' for packages and a StructTag for move structs.
  final String? objectType;

  /// DEPRECATED this field is no longer used to determine whether a tx can transfer this
  /// object. Instead, it is always calculated from the objects type when loaded in execution.
  ///
  /// Only set for Move structs
  final bool? hasPublicTransfer;

  /// BCS bytes of a Move struct value.
  ///
  /// Only set for Move structs
  final sui_rpc_v2_bcs.SuiBcs? contents;

  /// Package information for Move Packages
  final sui_rpc_v2_move_package.SuiPackage? package;

  /// The digest of the transaction that created or last mutated this object
  final String? previousTransaction;

  /// The amount of SUI to rebate if this object gets deleted.
  /// This number is re-calculated each time the object is mutated based on
  /// the present storage gas price.
  final BigInt? storageRebate;

  /// JSON rendering of the object.
  final google_protobuf_struct.SuiValue? json;

  /// Current balance if this object is a `0x2::coin::Coin&lt;T&gt;`
  final BigInt? balance;

  /// JSON rendering of the object based on an on-chain template.
  /// This will not be set if the value's type does not have an associated `Display` template.
  final SuiDisplay? display;

  const SuiObject({
    this.bcs,
    this.objectId,
    this.version,
    this.digest,
    this.owner,
    this.objectType,
    this.hasPublicTransfer,
    this.contents,
    this.package,
    this.previousTransaction,
    this.storageRebate,
    this.json,
    this.balance,
    this.display,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
        ProtoFieldConfig.string(2, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(3, hasOptionalFlags: true),
        ProtoFieldConfig.string(4, hasOptionalFlags: true),
        ProtoFieldConfig.message(5, hasOptionalFlags: true),
        ProtoFieldConfig.string(6, hasOptionalFlags: true),
        ProtoFieldConfig.bool(7, hasOptionalFlags: true),
        ProtoFieldConfig.message(8, hasOptionalFlags: true),
        ProtoFieldConfig.message(9, hasOptionalFlags: true),
        ProtoFieldConfig.string(10, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(11, hasOptionalFlags: true),
        ProtoFieldConfig.message(100, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(101, hasOptionalFlags: true),
        ProtoFieldConfig.message(102, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    bcs,
    objectId,
    version,
    digest,
    owner,
    objectType,
    hasPublicTransfer,
    contents,
    package,
    previousTransaction,
    storageRebate,
    json,
    balance,
    display,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'bcs': config.encodeMessage(bcs),
      'object_id': objectId,
      'version': config.encodeBigint(version),
      'digest': digest,
      'owner': config.encodeMessage(owner),
      'object_type': objectType,
      'has_public_transfer': hasPublicTransfer,
      'contents': config.encodeMessage(contents),
      'package': config.encodeMessage(package),
      'previous_transaction': previousTransaction,
      'storage_rebate': config.encodeBigint(storageRebate),
      'json': config.encodeMessage(json),
      'balance': config.encodeBigint(balance),
      'display': config.encodeMessage(display),
    };
  }

  factory SuiObject.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiObject(
      bcs: json.valueTo<sui_rpc_v2_bcs.SuiBcs?, Object>(
        key: 'bcs',
        parse:
            (v) => sui_rpc_v2_bcs.SuiBcs.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
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
      owner: json.valueTo<sui_rpc_v2_owner.SuiOwner?, Object>(
        key: 'owner',
        parse:
            (v) => sui_rpc_v2_owner.SuiOwner.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      objectType: json.valueAsString<String?>(
        'object_type',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      hasPublicTransfer: json.valueAsBool<bool?>(
        'has_public_transfer',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      contents: json.valueTo<sui_rpc_v2_bcs.SuiBcs?, Object>(
        key: 'contents',
        parse:
            (v) => sui_rpc_v2_bcs.SuiBcs.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      package: json.valueTo<sui_rpc_v2_move_package.SuiPackage?, Object>(
        key: 'package',
        parse:
            (v) => sui_rpc_v2_move_package.SuiPackage.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      previousTransaction: json.valueAsString<String?>(
        'previous_transaction',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      storageRebate: json.valueAsBigInt<BigInt?>(
        'storage_rebate',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      json: json.valueTo<google_protobuf_struct.SuiValue?, Object>(
        key: 'json',
        parse:
            (v) => google_protobuf_struct.SuiValue.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      balance: json.valueAsBigInt<BigInt?>(
        'balance',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      display: json.valueTo<SuiDisplay?, Object>(
        key: 'display',
        parse:
            (v) => SuiDisplay.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiObject.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiObject(
      bcs: decode.messageTo<sui_rpc_v2_bcs.SuiBcs?>(
        1,
        (b) => sui_rpc_v2_bcs.SuiBcs.deserialize(b),
      ),
      objectId: decode.getString<String?>(2),
      version: decode.getBigInt<BigInt?>(3),
      digest: decode.getString<String?>(4),
      owner: decode.messageTo<sui_rpc_v2_owner.SuiOwner?>(
        5,
        (b) => sui_rpc_v2_owner.SuiOwner.deserialize(b),
      ),
      objectType: decode.getString<String?>(6),
      hasPublicTransfer: decode.getBool<bool?>(7),
      contents: decode.messageTo<sui_rpc_v2_bcs.SuiBcs?>(
        8,
        (b) => sui_rpc_v2_bcs.SuiBcs.deserialize(b),
      ),
      package: decode.messageTo<sui_rpc_v2_move_package.SuiPackage?>(
        9,
        (b) => sui_rpc_v2_move_package.SuiPackage.deserialize(b),
      ),
      previousTransaction: decode.getString<String?>(10),
      storageRebate: decode.getBigInt<BigInt?>(11),
      json: decode.messageTo<google_protobuf_struct.SuiValue?>(
        100,
        (b) => google_protobuf_struct.SuiValue.deserialize(b),
      ),
      balance: decode.getBigInt<BigInt?>(101),
      display: decode.messageTo<SuiDisplay?>(
        102,
        (b) => SuiDisplay.deserialize(b),
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2Object;
}

/// Set of Objects
class SuiObjectSet extends SuiProtoMessage {
  /// Objects are sorted by the key `(object_id, version)`.
  final List<SuiObject> objects;

  const SuiObjectSet({this.objects = const []});

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
  List<Object?> get protoValues => [objects];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'objects': objects.map((e) => config.encodeMessage(e)).toList()};
  }

  factory SuiObjectSet.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiObjectSet(
      objects:
          (json.valueEnsureAsList<dynamic>(
                'objects',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<SuiObject, Object>(
                  value: e,
                  parse:
                      (v) => SuiObject.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory SuiObjectSet.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiObjectSet(
      objects:
          decode
              .getListOfBytes(1)
              .map((b) => SuiObject.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2ObjectSet;
}

/// A rendered JSON blob based on an on-chain template.
class SuiDisplay extends SuiProtoMessage {
  /// Output for all successfully substituted display fields. Unsuccessful
  /// fields will be `null`, and will be accompanied by a field in `errors`,
  /// explaining the error.
  final google_protobuf_struct.SuiValue? output;

  /// If any fields failed to render, this will contain a mapping from failed
  /// field names to error messages. If all fields succeed, this will either be
  /// `null` or not set.
  final google_protobuf_struct.SuiValue? errors;

  const SuiDisplay({this.output, this.errors});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
        ProtoFieldConfig.message(2, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [output, errors];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'output': config.encodeMessage(output),
      'errors': config.encodeMessage(errors),
    };
  }

  factory SuiDisplay.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiDisplay(
      output: json.valueTo<google_protobuf_struct.SuiValue?, Object>(
        key: 'output',
        parse:
            (v) => google_protobuf_struct.SuiValue.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      errors: json.valueTo<google_protobuf_struct.SuiValue?, Object>(
        key: 'errors',
        parse:
            (v) => google_protobuf_struct.SuiValue.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiDisplay.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiDisplay(
      output: decode.messageTo<google_protobuf_struct.SuiValue?>(
        1,
        (b) => google_protobuf_struct.SuiValue.deserialize(b),
      ),
      errors: decode.messageTo<google_protobuf_struct.SuiValue?>(
        2,
        (b) => google_protobuf_struct.SuiValue.deserialize(b),
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2Display;
}
