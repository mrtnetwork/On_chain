import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/hooks/src/hook_types.dart"
    as com_hedera_hapi_node_hooks_hook_types;

/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.hooks"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Adds or removes key/value pairs in the storage of an EVM hook.
///  * Either the hook owner's key, or its admin key, must sign the transaction.
class HederaHookStoreTransactionBody extends HederaProtoMessage with Equality {
  /// *
  ///    * The id of the EVM hook whose storage is being updated.
  final proto_basic_types.HederaHookId? hookId;

  /// *
  ///    * The updates to the storage of the EVM hook.
  final List<com_hedera_hapi_node_hooks_hook_types.HederaEvmHookStorageUpdate>
  storageUpdates;

  const HederaHookStoreTransactionBody({
    this.hookId,
    this.storageUpdates = const [],
  });

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
  List<Object?> get protoValues => [hookId, storageUpdates];

  HederaHookStoreTransactionBody copyWith({
    proto_basic_types.HederaHookId? hookId,

    List<com_hedera_hapi_node_hooks_hook_types.HederaEvmHookStorageUpdate>?
    storageUpdates,
  }) {
    return HederaHookStoreTransactionBody(
      hookId: hookId ?? this.hookId,
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
      'hook_id': config.encodeMessage(hookId),
      'storage_updates':
          storageUpdates.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory HederaHookStoreTransactionBody.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaHookStoreTransactionBody(
      hookId: json.valueTo<proto_basic_types.HederaHookId?, Object>(
        key: 'hook_id',
        parse:
            (v) => proto_basic_types.HederaHookId.fromJson(
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
                (e) => JsonParser.valueTo<
                  com_hedera_hapi_node_hooks_hook_types.HederaEvmHookStorageUpdate,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => com_hedera_hapi_node_hooks_hook_types
                          .HederaEvmHookStorageUpdate.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory HederaHookStoreTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaHookStoreTransactionBody(
      hookId: decode.messageTo<proto_basic_types.HederaHookId?>(
        1,
        (b) => proto_basic_types.HederaHookId.deserialize(b),
      ),
      storageUpdates:
          decode
              .getListOfBytes(2)
              .map(
                (b) => com_hedera_hapi_node_hooks_hook_types
                    .HederaEvmHookStorageUpdate.deserialize(b),
              )
              .toList(),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeHooksHookStoreTransactionBody;
}
