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
///  * Dispatches a hook action to an appropriate service.
class HederaHookDispatchTransactionBody extends HederaProtoMessage
    with Equality {
  /// *
  ///      * The id of the hook to delete.
  final proto_basic_types.HederaHookId? hookIdToDelete;

  /// *
  ///      * Creation details for a new hook.
  final com_hedera_hapi_node_hooks_hook_types.HederaHookCreation? creation;

  /// *
  ///      * Execution details of an existing hook.
  final HederaHookExecution? execution;

  const HederaHookDispatchTransactionBody({
    this.hookIdToDelete,
    this.creation,
    this.execution,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.message(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [hookIdToDelete, creation, execution];

  HederaHookDispatchTransactionBody copyWith({
    proto_basic_types.HederaHookId? hookIdToDelete,

    com_hedera_hapi_node_hooks_hook_types.HederaHookCreation? creation,

    HederaHookExecution? execution,
  }) {
    return HederaHookDispatchTransactionBody(
      hookIdToDelete: hookIdToDelete ?? this.hookIdToDelete,
      creation: creation ?? this.creation,
      execution: execution ?? this.execution,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'hook_id_to_delete': config.encodeMessage(hookIdToDelete),
      'creation': config.encodeMessage(creation),
      'execution': config.encodeMessage(execution),
    };
  }

  factory HederaHookDispatchTransactionBody.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaHookDispatchTransactionBody(
      hookIdToDelete: json.valueTo<proto_basic_types.HederaHookId?, Object>(
        key: 'hook_id_to_delete',
        parse:
            (v) => proto_basic_types.HederaHookId.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      creation: json.valueTo<
        com_hedera_hapi_node_hooks_hook_types.HederaHookCreation?,
        Object
      >(
        key: 'creation',
        parse:
            (v) => com_hedera_hapi_node_hooks_hook_types
                .HederaHookCreation.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      execution: json.valueTo<HederaHookExecution?, Object>(
        key: 'execution',
        parse:
            (v) => HederaHookExecution.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaHookDispatchTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaHookDispatchTransactionBody(
      hookIdToDelete: decode.messageTo<proto_basic_types.HederaHookId?>(
        1,
        (b) => proto_basic_types.HederaHookId.deserialize(b),
      ),
      creation: decode
          .messageTo<com_hedera_hapi_node_hooks_hook_types.HederaHookCreation?>(
            2,
            (b) => com_hedera_hapi_node_hooks_hook_types
                .HederaHookCreation.deserialize(b),
          ),
      execution: decode.messageTo<HederaHookExecution?>(
        3,
        (b) => HederaHookExecution.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiNodeHooksHookDispatchTransactionBody;
}

/// *
///  * Details the execution of a hook.
class HederaHookExecution extends HederaProtoMessage with Equality {
  /// *
  ///    * The id of the hook's entity.
  final proto_basic_types.HederaHookEntityId? hookEntityId;

  /// *
  ///    * The details of the call, including which hook id to call.
  final proto_basic_types.HederaHookCall? call;

  const HederaHookExecution({this.hookEntityId, this.call});

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
  List<Object?> get protoValues => [hookEntityId, call];

  HederaHookExecution copyWith({
    proto_basic_types.HederaHookEntityId? hookEntityId,

    proto_basic_types.HederaHookCall? call,
  }) {
    return HederaHookExecution(
      hookEntityId: hookEntityId ?? this.hookEntityId,
      call: call ?? this.call,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'hook_entity_id': config.encodeMessage(hookEntityId),
      'call': config.encodeMessage(call),
    };
  }

  factory HederaHookExecution.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaHookExecution(
      hookEntityId: json.valueTo<proto_basic_types.HederaHookEntityId?, Object>(
        key: 'hook_entity_id',
        parse:
            (v) => proto_basic_types.HederaHookEntityId.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      call: json.valueTo<proto_basic_types.HederaHookCall?, Object>(
        key: 'call',
        parse:
            (v) => proto_basic_types.HederaHookCall.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaHookExecution.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaHookExecution(
      hookEntityId: decode.messageTo<proto_basic_types.HederaHookEntityId?>(
        1,
        (b) => proto_basic_types.HederaHookEntityId.deserialize(b),
      ),
      call: decode.messageTo<proto_basic_types.HederaHookCall?>(
        2,
        (b) => proto_basic_types.HederaHookCall.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeHooksHookExecution;
}
