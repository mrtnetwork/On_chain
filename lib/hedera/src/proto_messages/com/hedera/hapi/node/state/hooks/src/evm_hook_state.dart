import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/hooks/src/hook_types.dart" as com_hedera_hapi_node_hooks_hook_types;
import "package:on_chain/hedera/src/proto_messages/google/protobuf/src/wrappers.dart" as google_protobuf_wrappers;

/// *
///  * The type of a hook.
enum HederaHookType implements ProtoEnumVariant {
    /// *
  ///    * A general-purpose EVM hook.
  evmHook(0, 'EVM_HOOK');

  const HederaHookType(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static HederaHookType fromValue(int? value) {
    value ??=0;
    return HederaHookType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaHookType found for the given value. $value", details: {"name": "HederaHookType", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static HederaHookType from(Object? value) {
    value ??=0;
    return HederaHookType.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaHookType found for the given value. $value", details: {"name": "HederaHookType", "value": value?.toString()})
    );
  }

}


/// *
///  * # EVM Bytecode
///  * The verified bytecode of an EVM contract for the Hedera Smart Contract service.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in [RFC2119](https://www.ietf.org/rfc/rfc2119)
///  * and clarified in [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.state.hooks"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * The representation of an EVM hook in state, including the previous and next hook ids in its owner's list.
class HederaEvmHookState extends HederaProtoMessage with Equality {
    /// *
  ///    * For state proofs, the id of this hook.
  final proto_basic_types.HederaHookId? hookId;

    /// *
  ///    * The type of the EVM hook.
  final HederaHookType? type;

    /// *
  ///    * The type of the extension point the hook implements.
  final com_hedera_hapi_node_hooks_hook_types.HederaHookExtensionPoint? extensionPoint;

    /// *
  ///    * The id of the contract with this hook's bytecode.
  final proto_basic_types.HederaContractID? hookContractId;

    /// *
  ///    * If set, a key that that can be used to remove or replace the hook; or (if
  ///    * applicable, as with an EVM hook) perform transactions that customize the hook.
  final proto_basic_types.HederaKey? adminKey;

    /// *
  ///    * For an EVM hook, its first storage key. Must be the minimal
  ///    * bytes representation (no leading zeros). An EVM hook with
  ///    * no storage slots and an EVM hook whose last-written storage
  ///    * slot was at the zero key can be differentiated by checking
  ///    * the `num_storage_slots` field.
  final List<int>? firstContractStorageKey;

    /// *
  ///    * If set, the id of the hook preceding this one in the owner's
  ///    * doubly-linked list of hooks.
  final google_protobuf_wrappers.HederaInt64Value? previousHookId;

    /// *
  ///    * If set, the id of the hook following this one in the owner's
  ///    * doubly-linked list of hooks.
  final google_protobuf_wrappers.HederaInt64Value? nextHookId;

    /// *
  ///    * The number of storage slots an EVM hook is using.
  final int? numStorageSlots;

  const HederaEvmHookState({
    this.hookId,
    this.type,
    this.extensionPoint,
    this.hookContractId,
    this.adminKey,
    this.firstContractStorageKey,
    this.previousHookId,
    this.nextHookId,
    this.numStorageSlots,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.enumType(2),
        ProtoFieldConfig.enumType(3),
        ProtoFieldConfig.message(4),
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.bytes(6),
        ProtoFieldConfig.message(7),
        ProtoFieldConfig.message(8),
        ProtoFieldConfig.uint32(9),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        hookId,
        type,
        extensionPoint,
        hookContractId,
        adminKey,
        firstContractStorageKey,
        previousHookId,
        nextHookId,
        numStorageSlots,
      ];


HederaEvmHookState copyWith(
{proto_basic_types.HederaHookId? hookId,

HederaHookType? type,

com_hedera_hapi_node_hooks_hook_types.HederaHookExtensionPoint? extensionPoint,

proto_basic_types.HederaContractID? hookContractId,

proto_basic_types.HederaKey? adminKey,

List<int>? firstContractStorageKey,

google_protobuf_wrappers.HederaInt64Value? previousHookId,

google_protobuf_wrappers.HederaInt64Value? nextHookId,

int? numStorageSlots,

}) {
    return HederaEvmHookState(
hookId: hookId ?? this.hookId,
type: type ?? this.type,
extensionPoint: extensionPoint ?? this.extensionPoint,
hookContractId: hookContractId ?? this.hookContractId,
adminKey: adminKey ?? this.adminKey,
firstContractStorageKey: firstContractStorageKey ?? this.firstContractStorageKey,
previousHookId: previousHookId ?? this.previousHookId,
nextHookId: nextHookId ?? this.nextHookId,
numStorageSlots: numStorageSlots ?? this.numStorageSlots,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'hook_id': config.encodeMessage(hookId),
      'type': config.encodeEnum(type),
      'extension_point': config.encodeEnum(extensionPoint),
      'hook_contract_id': config.encodeMessage(hookContractId),
      'admin_key': config.encodeMessage(adminKey),
      'first_contract_storage_key': config.encodeBinary(firstContractStorageKey),
      'previous_hook_id': config.encodeMessage(previousHookId),
      'next_hook_id': config.encodeMessage(nextHookId),
      'num_storage_slots': numStorageSlots,
    };
  }


  factory HederaEvmHookState.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaEvmHookState(
      hookId: json.valueTo<proto_basic_types.HederaHookId?, Object>(
        key: 'hook_id',
        parse: (v) => proto_basic_types.HederaHookId.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      type: json.valueTo<HederaHookType?, Object?>(
        key: 'type',
        parse: (v) => HederaHookType.from(v),
      ),
      extensionPoint: json.valueTo<com_hedera_hapi_node_hooks_hook_types.HederaHookExtensionPoint?, Object?>(
        key: 'extension_point',
        parse: (v) => com_hedera_hapi_node_hooks_hook_types.HederaHookExtensionPoint.from(v),
      ),
      hookContractId: json.valueTo<proto_basic_types.HederaContractID?, Object>(
        key: 'hook_contract_id',
        parse: (v) => proto_basic_types.HederaContractID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      adminKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'admin_key',
        parse: (v) => proto_basic_types.HederaKey.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      firstContractStorageKey: config.decodeBinary<List<int>?>(json.valueAs('first_contract_storage_key', normalizeKeyLookup: config.normalizeKeys)),
      previousHookId: json.valueTo<google_protobuf_wrappers.HederaInt64Value?, Object>(
        key: 'previous_hook_id',
        parse: (v) => google_protobuf_wrappers.HederaInt64Value.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      nextHookId: json.valueTo<google_protobuf_wrappers.HederaInt64Value?, Object>(
        key: 'next_hook_id',
        parse: (v) => google_protobuf_wrappers.HederaInt64Value.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      numStorageSlots: json.valueAsInt<int?>('num_storage_slots', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaEvmHookState.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaEvmHookState(
      hookId: decode.messageTo<proto_basic_types.HederaHookId?>(1, (b) => proto_basic_types.HederaHookId.deserialize(b)),
      type: decode.getEnum<HederaHookType?>(2, HederaHookType.values),
      extensionPoint: decode.getEnum<com_hedera_hapi_node_hooks_hook_types.HederaHookExtensionPoint?>(3, com_hedera_hapi_node_hooks_hook_types.HederaHookExtensionPoint.values),
      hookContractId: decode.messageTo<proto_basic_types.HederaContractID?>(4, (b) => proto_basic_types.HederaContractID.deserialize(b)),
      adminKey: decode.messageTo<proto_basic_types.HederaKey?>(5, (b) => proto_basic_types.HederaKey.deserialize(b)),
      firstContractStorageKey: decode.getBytes<List<int>?>(6),
      previousHookId: decode.messageTo<google_protobuf_wrappers.HederaInt64Value?>(7, (b) => google_protobuf_wrappers.HederaInt64Value.deserialize(b)),
      nextHookId: decode.messageTo<google_protobuf_wrappers.HederaInt64Value?>(8, (b) => google_protobuf_wrappers.HederaInt64Value.deserialize(b)),
      numStorageSlots: decode.getInt<int?>(9),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiNodeStateHooksEvmHookState;

}


/// *
///  * The key of an EVM hook's storage slot.
///  *
///  * For each EVM hook, its storage is a mapping of 256-bit keys (or "words")
///  * to 256-bit values.
class HederaEvmHookSlotKey extends HederaProtoMessage with Equality {
    /// *
  ///    * The id of the EVM hook that owns this slot.
  final proto_basic_types.HederaHookId? hookId;

    /// *
  ///    * The EVM key of this slot. Must be the minimal bytes representation
  ///    * (no leading zeros).
  final List<int>? key;

  const HederaEvmHookSlotKey({
    this.hookId,
    this.key,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.bytes(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        hookId,
        key,
      ];


HederaEvmHookSlotKey copyWith(
{proto_basic_types.HederaHookId? hookId,

List<int>? key,

}) {
    return HederaEvmHookSlotKey(
hookId: hookId ?? this.hookId,
key: key ?? this.key,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'hook_id': config.encodeMessage(hookId),
      'key': config.encodeBinary(key),
    };
  }


  factory HederaEvmHookSlotKey.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaEvmHookSlotKey(
      hookId: json.valueTo<proto_basic_types.HederaHookId?, Object>(
        key: 'hook_id',
        parse: (v) => proto_basic_types.HederaHookId.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      key: config.decodeBinary<List<int>?>(json.valueAs('key', normalizeKeyLookup: config.normalizeKeys)),
    );
  }

  factory HederaEvmHookSlotKey.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaEvmHookSlotKey(
      hookId: decode.messageTo<proto_basic_types.HederaHookId?>(1, (b) => proto_basic_types.HederaHookId.deserialize(b)),
      key: decode.getBytes<List<int>?>(2),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiNodeStateHooksEvmHookSlotKey;

}


