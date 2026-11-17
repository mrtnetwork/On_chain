import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.addressbook"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A transaction body to delete a node from the network address book.
///  *
///  * - A `NodeDeleteTransactionBody` MUST be signed by one of those keys:
///  *   adminKey, treasure account (2) key, systemAdmin(50) key, or
///  *   addressBookAdmin(55) key.
///  * - Upon success, the address book entry SHALL enter a "pending delete"
///  *   state.
///  * - All address book entries pending deletion SHALL be removed from the
///  *   active network configuration during the next `freeze` transaction with
///  *   the field `freeze_type` set to `PREPARE_UPGRADE`.&lt;br/&gt;
///  * - A deleted address book node SHALL be removed entirely from network state.
///  * - A deleted address book node identifier SHALL NOT be reused.
///  *
///  * ### Block Stream Effects
///  * None.
class HederaNodeDeleteTransactionBody extends HederaProtoMessage with Equality {
  /// *
  ///      * A consensus node identifier in the network state.
  ///      * &lt;p&gt;
  ///      * The node identified MUST exist in the network address book.&lt;br/&gt;
  ///      * The node identified MUST NOT be deleted.&lt;br/&gt;
  ///      * This value is REQUIRED.
  final BigInt? nodeId;

  const HederaNodeDeleteTransactionBody({this.nodeId});

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
  List<Object?> get protoValues => [nodeId];

  HederaNodeDeleteTransactionBody copyWith({BigInt? nodeId}) {
    return HederaNodeDeleteTransactionBody(nodeId: nodeId ?? this.nodeId);
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'node_id': config.encodeBigint(nodeId)};
  }

  factory HederaNodeDeleteTransactionBody.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaNodeDeleteTransactionBody(
      nodeId: json.valueAsBigInt<BigInt?>(
        'node_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaNodeDeleteTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaNodeDeleteTransactionBody(
      nodeId: decode.getBigInt<BigInt?>(1),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiNodeAddressbookNodeDeleteTransactionBody;
}
