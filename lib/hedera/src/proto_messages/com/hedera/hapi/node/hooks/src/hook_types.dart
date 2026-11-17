import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/google/protobuf/src/wrappers.dart"
    as google_protobuf_wrappers;

/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.hooks"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// **
///  * The Hiero extension points that accept a hook.
enum HederaHookExtensionPoint implements ProtoEnumVariant {
  /// *
  ///    * Used to customize an account's allowances during a CryptoTransfer transaction.
  accountAllowanceHook(0, 'ACCOUNT_ALLOWANCE_HOOK');

  const HederaHookExtensionPoint(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static HederaHookExtensionPoint fromValue(int? value) {
    value ??= 0;
    return HederaHookExtensionPoint.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching HederaHookExtensionPoint found for the given value. $value",
                details: {
                  "name": "HederaHookExtensionPoint",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static HederaHookExtensionPoint from(Object? value) {
    value ??= 0;
    return HederaHookExtensionPoint.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching HederaHookExtensionPoint found for the given value. $value",
                details: {
                  "name": "HederaHookExtensionPoint",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

/// *
///  * Specifies the creation of a new hook at the given id for the given entity.
class HederaHookCreation extends HederaProtoMessage with Equality {
  /// *
  ///    * The id of the hook's entity.
  final proto_basic_types.HederaHookEntityId? entityId;

  /// *
  ///    * The creation details.
  final HederaHookCreationDetails? details;

  /// *
  ///    * If set, the id of the hook following this one in the owner's
  ///    * doubly-linked list of hooks.
  final google_protobuf_wrappers.HederaInt64Value? nextHookId;

  const HederaHookCreation({this.entityId, this.details, this.nextHookId});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.message(9),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [entityId, details, nextHookId];

  HederaHookCreation copyWith({
    proto_basic_types.HederaHookEntityId? entityId,

    HederaHookCreationDetails? details,

    google_protobuf_wrappers.HederaInt64Value? nextHookId,
  }) {
    return HederaHookCreation(
      entityId: entityId ?? this.entityId,
      details: details ?? this.details,
      nextHookId: nextHookId ?? this.nextHookId,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'entity_id': config.encodeMessage(entityId),
      'details': config.encodeMessage(details),
      'next_hook_id': config.encodeMessage(nextHookId),
    };
  }

  factory HederaHookCreation.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaHookCreation(
      entityId: json.valueTo<proto_basic_types.HederaHookEntityId?, Object>(
        key: 'entity_id',
        parse:
            (v) => proto_basic_types.HederaHookEntityId.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      details: json.valueTo<HederaHookCreationDetails?, Object>(
        key: 'details',
        parse:
            (v) => HederaHookCreationDetails.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      nextHookId: json
          .valueTo<google_protobuf_wrappers.HederaInt64Value?, Object>(
            key: 'next_hook_id',
            parse:
                (v) => google_protobuf_wrappers.HederaInt64Value.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
    );
  }

  factory HederaHookCreation.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaHookCreation(
      entityId: decode.messageTo<proto_basic_types.HederaHookEntityId?>(
        1,
        (b) => proto_basic_types.HederaHookEntityId.deserialize(b),
      ),
      details: decode.messageTo<HederaHookCreationDetails?>(
        2,
        (b) => HederaHookCreationDetails.deserialize(b),
      ),
      nextHookId: decode.messageTo<google_protobuf_wrappers.HederaInt64Value?>(
        9,
        (b) => google_protobuf_wrappers.HederaInt64Value.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeHooksHookCreation;
}

/// **
///  * The details of a hook's creation.
class HederaHookCreationDetails extends HederaProtoMessage with Equality {
  /// *
  ///    * The extension point for the hook.
  final HederaHookExtensionPoint? extensionPoint;

  /// *
  ///    * The id to create the hook at.
  final BigInt? hookId;

  /// *
  ///    * The hook implementation.
  /// *
  ///      * A general-purpose hook programmed in EVM bytecode that may access state
  ///      * or interact with external contracts.
  final HederaEvmHook? evmHook;

  /// *
  ///    * If set, a key that that can be used to remove or replace the hook; or (if
  ///    * applicable, as with an EVM hook) do transactions that customize the hook.
  final proto_basic_types.HederaKey? adminKey;

  const HederaHookCreationDetails({
    this.extensionPoint,
    this.hookId,
    this.evmHook,
    this.adminKey,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.enumType(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.message(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [extensionPoint, hookId, evmHook, adminKey];

  HederaHookCreationDetails copyWith({
    HederaHookExtensionPoint? extensionPoint,

    BigInt? hookId,

    HederaEvmHook? evmHook,

    proto_basic_types.HederaKey? adminKey,
  }) {
    return HederaHookCreationDetails(
      extensionPoint: extensionPoint ?? this.extensionPoint,
      hookId: hookId ?? this.hookId,
      evmHook: evmHook ?? this.evmHook,
      adminKey: adminKey ?? this.adminKey,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'extension_point': config.encodeEnum(extensionPoint),
      'hook_id': config.encodeBigint(hookId),
      'evm_hook': config.encodeMessage(evmHook),
      'admin_key': config.encodeMessage(adminKey),
    };
  }

  factory HederaHookCreationDetails.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaHookCreationDetails(
      extensionPoint: json.valueTo<HederaHookExtensionPoint?, Object?>(
        key: 'extension_point',
        parse: (v) => HederaHookExtensionPoint.from(v),
      ),
      hookId: json.valueAsBigInt<BigInt?>(
        'hook_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      evmHook: json.valueTo<HederaEvmHook?, Object>(
        key: 'evm_hook',
        parse:
            (v) =>
                HederaEvmHook.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      adminKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'admin_key',
        parse:
            (v) => proto_basic_types.HederaKey.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaHookCreationDetails.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaHookCreationDetails(
      extensionPoint: decode.getEnum<HederaHookExtensionPoint?>(
        1,
        HederaHookExtensionPoint.values,
      ),
      hookId: decode.getBigInt<BigInt?>(2),
      evmHook: decode.messageTo<HederaEvmHook?>(
        3,
        (b) => HederaEvmHook.deserialize(b),
      ),
      adminKey: decode.messageTo<proto_basic_types.HederaKey?>(
        4,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeHooksHookCreationDetails;
}

/// *
///  * Definition of a general-purpose EVM hook.
class HederaEvmHook extends HederaProtoMessage with Equality {
  /// *
  ///    * The specification for the hook.
  final HederaEvmHookSpec? spec;

  /// *
  ///    * Initial storage updates for the hook, if any.
  final List<HederaEvmHookStorageUpdate> storageUpdates;

  const HederaEvmHook({this.spec, this.storageUpdates = const []});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [spec, storageUpdates];

  HederaEvmHook copyWith({
    HederaEvmHookSpec? spec,

    List<HederaEvmHookStorageUpdate>? storageUpdates,
  }) {
    return HederaEvmHook(
      spec: spec ?? this.spec,
      storageUpdates: storageUpdates ?? this.storageUpdates,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'spec': config.encodeMessage(spec),
      'storage_updates':
          storageUpdates.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory HederaEvmHook.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaEvmHook(
      spec: json.valueTo<HederaEvmHookSpec?, Object>(
        key: 'spec',
        parse:
            (v) => HederaEvmHookSpec.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      storageUpdates:
          (json.valueEnsureAsList<dynamic>(
                'storage_updates',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<HederaEvmHookStorageUpdate, Object>(
                  value: e,
                  parse:
                      (v) => HederaEvmHookStorageUpdate.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory HederaEvmHook.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaEvmHook(
      spec: decode.messageTo<HederaEvmHookSpec?>(
        1,
        (b) => HederaEvmHookSpec.deserialize(b),
      ),
      storageUpdates:
          decode
              .getListOfBytes(2)
              .map((b) => HederaEvmHookStorageUpdate.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeHooksEvmHook;
}

/// *
///  * Shared specifications for an EVM hook. May be used for any extension point.
class HederaEvmHookSpec extends HederaProtoMessage with Equality {
  /// *
  ///    * The source of the EVM bytecode for the hook.
  /// *
  ///      * The id of a contract that implements the extension point API with EVM bytecode.
  final proto_basic_types.HederaContractID? contractId;

  const HederaEvmHookSpec({this.contractId});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.message(1)],
    );
  }

  @override
  List<Object?> get protoValues => [contractId];

  HederaEvmHookSpec copyWith({proto_basic_types.HederaContractID? contractId}) {
    return HederaEvmHookSpec(contractId: contractId ?? this.contractId);
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'contract_id': config.encodeMessage(contractId)};
  }

  factory HederaEvmHookSpec.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaEvmHookSpec(
      contractId: json.valueTo<proto_basic_types.HederaContractID?, Object>(
        key: 'contract_id',
        parse:
            (v) => proto_basic_types.HederaContractID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaEvmHookSpec.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaEvmHookSpec(
      contractId: decode.messageTo<proto_basic_types.HederaContractID?>(
        1,
        (b) => proto_basic_types.HederaContractID.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeHooksEvmHookSpec;
}

/// *
///  * Specifies a key/value pair in the storage of an EVM hook, either by the explicit storage
///  * slot contents; or by a combination of a Solidity mapping's slot key and the key into
///  * that mapping.
class HederaEvmHookStorageUpdate extends HederaProtoMessage with Equality {
  /// *
  ///      * An explicit storage slot update.
  final HederaEvmHookStorageSlot? storageSlot;

  /// *
  ///      * Implicit storage slot updates specified as Solidity mapping entries.
  final HederaEvmHookMappingEntries? mappingEntries;

  const HederaEvmHookStorageUpdate({this.storageSlot, this.mappingEntries});

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
  List<Object?> get protoValues => [storageSlot, mappingEntries];

  HederaEvmHookStorageUpdate copyWith({
    HederaEvmHookStorageSlot? storageSlot,

    HederaEvmHookMappingEntries? mappingEntries,
  }) {
    return HederaEvmHookStorageUpdate(
      storageSlot: storageSlot ?? this.storageSlot,
      mappingEntries: mappingEntries ?? this.mappingEntries,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'storage_slot': config.encodeMessage(storageSlot),
      'mapping_entries': config.encodeMessage(mappingEntries),
    };
  }

  factory HederaEvmHookStorageUpdate.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaEvmHookStorageUpdate(
      storageSlot: json.valueTo<HederaEvmHookStorageSlot?, Object>(
        key: 'storage_slot',
        parse:
            (v) => HederaEvmHookStorageSlot.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      mappingEntries: json.valueTo<HederaEvmHookMappingEntries?, Object>(
        key: 'mapping_entries',
        parse:
            (v) => HederaEvmHookMappingEntries.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaEvmHookStorageUpdate.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaEvmHookStorageUpdate(
      storageSlot: decode.messageTo<HederaEvmHookStorageSlot?>(
        1,
        (b) => HederaEvmHookStorageSlot.deserialize(b),
      ),
      mappingEntries: decode.messageTo<HederaEvmHookMappingEntries?>(
        2,
        (b) => HederaEvmHookMappingEntries.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeHooksEvmHookStorageUpdate;
}

/// *
///  * Specifies storage slot updates via indirection into a Solidity mapping.
///  * &lt;p&gt;
///  * Concretely, if the Solidity mapping is itself at slot `mapping_slot`, then
///  * the * storage slot for key `key` in the mapping is defined by the relationship
///  * `key_storage_slot = keccak256(abi.encodePacked(mapping_slot, key))`.
///  * &lt;p&gt;
///  * This message lets a metaprotocol be specified in terms of changes to a
///  * Solidity mapping's entries. If only raw slots could be updated, then a block
///  * stream consumer following the metaprotocol would have to invert the Keccak256
///  * hash to determine which mapping entry was being updated, which is not possible.
class HederaEvmHookMappingEntries extends HederaProtoMessage with Equality {
  /// *
  ///    * The slot that corresponds to the Solidity mapping itself. Must use a
  ///    * minimal byte representation (no leading zeros).
  final List<int>? mappingSlot;

  /// *
  ///    * The entries in the mapping at the given slot.
  final List<HederaEvmHookMappingEntry> entries;

  const HederaEvmHookMappingEntries({
    this.mappingSlot,
    this.entries = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [mappingSlot, entries];

  HederaEvmHookMappingEntries copyWith({
    List<int>? mappingSlot,

    List<HederaEvmHookMappingEntry>? entries,
  }) {
    return HederaEvmHookMappingEntries(
      mappingSlot: mappingSlot ?? this.mappingSlot,
      entries: entries ?? this.entries,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'mapping_slot': config.encodeBinary(mappingSlot),
      'entries': entries.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory HederaEvmHookMappingEntries.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaEvmHookMappingEntries(
      mappingSlot: config.decodeBinary<List<int>?>(
        json.valueAs('mapping_slot', normalizeKeyLookup: config.normalizeKeys),
      ),
      entries:
          (json.valueEnsureAsList<dynamic>(
                'entries',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<HederaEvmHookMappingEntry, Object>(
                  value: e,
                  parse:
                      (v) => HederaEvmHookMappingEntry.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory HederaEvmHookMappingEntries.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaEvmHookMappingEntries(
      mappingSlot: decode.getBytes<List<int>?>(1),
      entries:
          decode
              .getListOfBytes(2)
              .map((b) => HederaEvmHookMappingEntry.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeHooksEvmHookMappingEntries;
}

/// *
///  * An entry in a Solidity mapping. Very helpful for protocols that apply
///  * `HookStore` to manage the entries of a hook contract's mapping instead
///  * its raw storage slots.
///  * &lt;p&gt;
///  * This is especially attractive when the mapping value itself fits in a single
///  * word; for more complicated value storage layouts it becomes necessary to
///  * combine the mapping update with additional `EvmHookStorageSlot` updates that
///  * specify the complete storage slots of the value type.
class HederaEvmHookMappingEntry extends HederaProtoMessage with Equality {
  /// *
  ///      * The explicit bytes of the mapping entry. Must use a minimal byte representation;
  ///      * may not exceed 32 bytes in length.
  final List<int>? key;

  /// *
  ///      * The bytes that are the preimage of the Keccak256 hash that forms the mapping key.
  ///      * May be longer or shorter than 32 bytes and may have leading zeros, since Solidity
  ///      * supports variable-length keys in mappings.
  final List<int>? preimage;

  /// *
  ///    * If the mapping entry is present and non-zero, its value. May not be longer than
  ///    * 32 bytes in length; must use a minimal byte representation (no leading zeros).
  ///    * Leaving this field empty in an update removes the entry from the mapping.
  final List<int>? value;

  const HederaEvmHookMappingEntry({this.key, this.preimage, this.value});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.bytes(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [key, preimage, value];

  HederaEvmHookMappingEntry copyWith({
    List<int>? key,

    List<int>? preimage,

    List<int>? value,
  }) {
    return HederaEvmHookMappingEntry(
      key: key ?? this.key,
      preimage: preimage ?? this.preimage,
      value: value ?? this.value,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'key': config.encodeBinary(key),
      'preimage': config.encodeBinary(preimage),
      'value': config.encodeBinary(value),
    };
  }

  factory HederaEvmHookMappingEntry.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaEvmHookMappingEntry(
      key: config.decodeBinary<List<int>?>(
        json.valueAs('key', normalizeKeyLookup: config.normalizeKeys),
      ),
      preimage: config.decodeBinary<List<int>?>(
        json.valueAs('preimage', normalizeKeyLookup: config.normalizeKeys),
      ),
      value: config.decodeBinary<List<int>?>(
        json.valueAs('value', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory HederaEvmHookMappingEntry.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaEvmHookMappingEntry(
      key: decode.getBytes<List<int>?>(1),
      preimage: decode.getBytes<List<int>?>(2),
      value: decode.getBytes<List<int>?>(3),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeHooksEvmHookMappingEntry;
}

/// *
///  * A slot in the storage of an EVM hook.
class HederaEvmHookStorageSlot extends HederaProtoMessage with Equality {
  /// *
  ///    * The key of the slot. Must use a minimal byte representation (no
  ///    * leading zeros); may not exceed 32 bytes in length.
  final List<int>? key;

  /// *
  ///    * If the slot is present and non-zero, its value. Must use a minimal
  ///    * byte representation (no leading zeros); may not exceed 32 bytes in
  ///    * length Leaving this field empty in an update removes the slot from
  ///    * storage.
  final List<int>? value;

  const HederaEvmHookStorageSlot({this.key, this.value});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.bytes(1), ProtoFieldConfig.bytes(2)],
    );
  }

  @override
  List<Object?> get protoValues => [key, value];

  HederaEvmHookStorageSlot copyWith({List<int>? key, List<int>? value}) {
    return HederaEvmHookStorageSlot(
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'key': config.encodeBinary(key),
      'value': config.encodeBinary(value),
    };
  }

  factory HederaEvmHookStorageSlot.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaEvmHookStorageSlot(
      key: config.decodeBinary<List<int>?>(
        json.valueAs('key', normalizeKeyLookup: config.normalizeKeys),
      ),
      value: config.decodeBinary<List<int>?>(
        json.valueAs('value', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory HederaEvmHookStorageSlot.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaEvmHookStorageSlot(
      key: decode.getBytes<List<int>?>(1),
      value: decode.getBytes<List<int>?>(2),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeHooksEvmHookStorageSlot;
}
