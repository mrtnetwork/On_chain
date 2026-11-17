import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.addressbook"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A transaction body to delete a registered node from the network
///  * address book.
///  *
///  * This transaction, once complete, SHALL remove the identified registered
///  * node from the network state.
///  * This transaction MUST be signed by the existing entry `admin_key` or
///  * authorized by the Hiero network governance structure.
///  *
///  * ### Block Stream Effects
///  * None.
class HederaRegisteredNodeDeleteTransactionBody extends HederaProtoMessage
    with Equality {
  /// *
  ///      * A registered node identifier in the network state.
  ///      * &lt;p&gt;
  ///      * The node identified MUST exist in the registered address book.&lt;br/&gt;
  ///      * The node identified MUST NOT be deleted.&lt;br/&gt;
  ///      * This value is REQUIRED.
  ///      * &lt;p&gt;
  ///      * A given value for `registered_node_id` SHALL be unique within a given
  ///      * shard or realm.&lt;br/&gt;
  ///      * A given value for `registered_node_id` SHALL NOT be reused, even if the
  ///      * corresponding entry is deleted.
  final BigInt? registeredNodeId;

  const HederaRegisteredNodeDeleteTransactionBody({this.registeredNodeId});

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
  List<Object?> get protoValues => [registeredNodeId];

  HederaRegisteredNodeDeleteTransactionBody copyWith({
    BigInt? registeredNodeId,
  }) {
    return HederaRegisteredNodeDeleteTransactionBody(
      registeredNodeId: registeredNodeId ?? this.registeredNodeId,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'registered_node_id': config.encodeBigint(registeredNodeId)};
  }

  factory HederaRegisteredNodeDeleteTransactionBody.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaRegisteredNodeDeleteTransactionBody(
      registeredNodeId: json.valueAsBigInt<BigInt?>(
        'registered_node_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaRegisteredNodeDeleteTransactionBody.deserialize(
    List<int> bytes,
  ) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaRegisteredNodeDeleteTransactionBody(
      registeredNodeId: decode.getBigInt<BigInt?>(1),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiNodeAddressbookRegisteredNodeDeleteTransactionBody;
}
