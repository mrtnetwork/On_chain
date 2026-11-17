import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;

/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.state.addressbook"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A single address book node in the network state.
///  *
///  * Each node in the network address book SHALL represent a single actual
///  * consensus node that is eligible to participate in network consensus.
///  *
///  * Address book nodes SHALL NOT be _globally_ uniquely identified. A given node
///  * is only valid within a single realm and shard combination, so the identifier
///  * for a network node SHALL only be unique within a single realm and shard
///  * combination.
class HederaNode extends HederaProtoMessage with Equality {
    /// *
  ///      * A consensus node identifier.
  ///      * &lt;p&gt;
  ///      * Node identifiers SHALL be globally unique for a given ledger.
  final BigInt? nodeId;

    /// *
  ///      * An account identifier.
  ///      * &lt;p&gt;
  ///      * This account SHALL be owned by the entity responsible for the node.&lt;br/&gt;
  ///      * This account SHALL be charged transaction fees for any transactions
  ///      * that are submitted to the network by this node and
  ///      * fail due diligence checks.&lt;br/&gt;
  ///      * This account SHALL be paid the node portion of transaction fees
  ///      * for transactions submitted by this node.
  final proto_basic_types.HederaAccountID? accountId;

    /// *
  ///      * A short description of the node.
  ///      * &lt;p&gt;
  ///      * This value, if set, MUST NOT exceed `transaction.maxMemoUtf8Bytes`
  ///      * (default 100) bytes when encoded as UTF-8.
  final String? description;

    /// *
  ///      * A list of service endpoints for gossip.
  ///      * &lt;p&gt;
  ///      * These endpoints SHALL represent the published endpoints to which other
  ///      * consensus nodes may _gossip_ transactions.&lt;br/&gt;
  ///      * If the network configuration value `gossipFqdnRestricted` is set, then
  ///      * all endpoints in this list SHALL supply only IP address.&lt;br/&gt;
  ///      * If the network configuration value `gossipFqdnRestricted` is _not_ set,
  ///      * then endpoints in this list MAY supply either IP address or FQDN, but
  ///      * SHALL NOT supply both values for the same endpoint.&lt;br/&gt;
  ///      * This list SHALL NOT be empty.&lt;br/&gt;
  ///      * This list SHALL NOT contain more than `10` entries.&lt;br/&gt;
  ///      * The first two entries in this list SHALL be the endpoints published to
  ///      * all consensus nodes.&lt;br/&gt;
  ///      * All other entries SHALL be reserved for future use.
  final List<proto_basic_types.HederaServiceEndpoint> gossipEndpoint;

    /// *
  ///      * A list of service endpoints for client calls.
  ///      * &lt;p&gt;
  ///      * These endpoints SHALL represent the published endpoints to which clients
  ///      * may submit transactions.&lt;br/&gt;
  ///      * These endpoints SHALL specify a port.&lt;br/&gt;
  ///      * Endpoints in this list MAY supply either IP address or FQDN, but SHALL
  ///      * NOT supply both values for the same endpoint.&lt;br/&gt;
  ///      * This list SHALL NOT be empty.&lt;br/&gt;
  ///      * This list SHALL NOT contain more than `8` entries.
  final List<proto_basic_types.HederaServiceEndpoint> serviceEndpoint;

    /// *
  ///      * A certificate used to sign gossip events.
  ///      * &lt;p&gt;
  ///      * This value SHALL be a certificate of a type permitted for gossip
  ///      * signatures.&lt;br/&gt;
  ///      * This value SHALL be the DER encoding of the certificate presented.&lt;br/&gt;
  ///      * This field is REQUIRED and MUST NOT be empty.
  final List<int>? gossipCaCertificate;

    /// *
  ///      * A hash of the node gRPC certificate.
  ///      * &lt;p&gt;
  ///      * This value MAY be used to verify the certificate presented by the node
  ///      * during TLS negotiation for gRPC.&lt;br/&gt;
  ///      * This value SHALL be a SHA-384 hash.&lt;br/&gt;
  ///      * The TLS certificate to be hashed SHALL first be in PEM format and SHALL
  ///      * be encoded with UTF-8 NFKD encoding to a stream of bytes provided to
  ///      * the hash algorithm.&lt;br/&gt;
  ///      * This field is OPTIONAL.
  final List<int>? grpcCertificateHash;

    /// *
  ///      * A consensus weight.
  ///      * &lt;p&gt;
  ///      * Each node SHALL have a weight in consensus calculations.&lt;br/&gt;
  ///      * The consensus weight of a node SHALL be calculated based on the amount
  ///      * of HBAR staked to that node.&lt;br/&gt;
  ///      * Consensus SHALL be calculated based on agreement of greater than `2/3`
  ///      * of the total `weight` value of all nodes on the network.
  ///      * &lt;p&gt;
  ///      * This field is deprecated and SHALL NOT be used when RosterLifecycle
  ///      * is enabled.
  final BigInt? weight;

    /// *
  ///      * A flag indicating this node is deleted.
  ///      * &lt;p&gt;
  ///      * If this field is set, then this node SHALL NOT be included in the next
  ///      * update of the network address book.&lt;br/&gt;
  ///      * If this field is set, then this node SHALL be immutable and SHALL NOT
  ///      * be modified.&lt;br/&gt;
  ///      * If this field is set, then any `nodeUpdate` transaction to modify this
  ///      * node SHALL fail.
  final bool? deleted;

    /// *
  ///      * An administrative key controlled by the node operator.
  ///      * &lt;p&gt;
  ///      * This key MUST sign each transaction to update this node.&lt;br/&gt;
  ///      * This field MUST contain a valid `Key` value.&lt;br/&gt;
  ///      * This field is REQUIRED and MUST NOT be set to an empty `KeyList`.
  final proto_basic_types.HederaKey? adminKey;

    /// *
  ///      * A flag indicating this node declines node rewards distributed at
  ///      * the end of staking period.
  ///      * &lt;p&gt;
  ///      * If this field is set, then this node SHALL NOT receive any node rewards
  ///      * distributed at the end of the staking period.
  final bool? declineReward;

    /// *
  ///      * A web proxy for gRPC from non-gRPC clients.
  ///      * &lt;p&gt;
  ///      * This endpoint SHALL be a Fully Qualified Domain Name (FQDN) using the HTTPS
  ///      * protocol, and SHALL support gRPC-Web for use by browser-based clients.&lt;br/&gt;
  ///      * This endpoint MUST be signed by a trusted certificate authority.&lt;br/&gt;
  ///      * This endpoint MUST use a valid port and SHALL be reachable over TLS.&lt;br/&gt;
  ///      * This field MAY be omitted if the node does not support gRPC-Web access.&lt;br/&gt;
  ///      * This field MUST be updated if the gRPC-Web endpoint changes.&lt;br/&gt;
  ///      * This field SHALL enable frontend clients to avoid hard-coded proxy endpoints.
  final proto_basic_types.HederaServiceEndpoint? grpcProxyEndpoint;

    /// *
  ///      * A list of registered nodes operated by the same entity as this node.&lt;br/&gt;
  ///      * This value may contain a list of "registered nodes" (as described in
  ///      * HIP-1137) that are operated by the same entity that operates this
  ///      * consensus node.
  ///      * &lt;p&gt;
  ///      * This field is OPTIONAL and MAY be empty.&lt;br/&gt;
  ///      * This field MUST NOT contain more than twenty(20) entries.&lt;br/&gt;
  ///      * Every entry in this list MUST be a valid `registered_node_id` for a
  ///      * current registered node.
  final List<BigInt> associatedRegisteredNode;

  const HederaNode({
    this.nodeId,
    this.accountId,
    this.description,
    this.gossipEndpoint = const [],
    this.serviceEndpoint = const [],
    this.gossipCaCertificate,
    this.grpcCertificateHash,
    this.weight,
    this.deleted,
    this.adminKey,
    this.declineReward,
    this.grpcProxyEndpoint,
    this.associatedRegisteredNode = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.string(3),
        ProtoFieldConfig.repeated(
          fieldNumber: 4,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 5,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.bytes(6),
        ProtoFieldConfig.bytes(7),
        ProtoFieldConfig.uint64(8, options: [ProtoOptionBool(name: "deprecated", value: true)]),
        ProtoFieldConfig.bool(9),
        ProtoFieldConfig.message(10),
        ProtoFieldConfig.bool(11),
        ProtoFieldConfig.message(12),
        ProtoFieldConfig.repeated(
          fieldNumber: 13,
          elementType: ProtoFieldType.uint64,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        nodeId,
        accountId,
        description,
        gossipEndpoint,
        serviceEndpoint,
        gossipCaCertificate,
        grpcCertificateHash,
        weight,
        deleted,
        adminKey,
        declineReward,
        grpcProxyEndpoint,
        associatedRegisteredNode,
      ];


HederaNode copyWith(
{BigInt? nodeId,

proto_basic_types.HederaAccountID? accountId,

String? description,

List<proto_basic_types.HederaServiceEndpoint>? gossipEndpoint,

List<proto_basic_types.HederaServiceEndpoint>? serviceEndpoint,

List<int>? gossipCaCertificate,

List<int>? grpcCertificateHash,

BigInt? weight,

bool? deleted,

proto_basic_types.HederaKey? adminKey,

bool? declineReward,

proto_basic_types.HederaServiceEndpoint? grpcProxyEndpoint,

List<BigInt>? associatedRegisteredNode,

}) {
    return HederaNode(
nodeId: nodeId ?? this.nodeId,
accountId: accountId ?? this.accountId,
description: description ?? this.description,
gossipEndpoint: gossipEndpoint ?? this.gossipEndpoint,
serviceEndpoint: serviceEndpoint ?? this.serviceEndpoint,
gossipCaCertificate: gossipCaCertificate ?? this.gossipCaCertificate,
grpcCertificateHash: grpcCertificateHash ?? this.grpcCertificateHash,
weight: weight ?? this.weight,
deleted: deleted ?? this.deleted,
adminKey: adminKey ?? this.adminKey,
declineReward: declineReward ?? this.declineReward,
grpcProxyEndpoint: grpcProxyEndpoint ?? this.grpcProxyEndpoint,
associatedRegisteredNode: associatedRegisteredNode ?? this.associatedRegisteredNode,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'node_id': config.encodeBigint(nodeId),
      'account_id': config.encodeMessage(accountId),
      'description': description,
      'gossip_endpoint': gossipEndpoint.map((e) => config.encodeMessage(e)).toList(),
      'service_endpoint': serviceEndpoint.map((e) => config.encodeMessage(e)).toList(),
      'gossip_ca_certificate': config.encodeBinary(gossipCaCertificate),
      'grpc_certificate_hash': config.encodeBinary(grpcCertificateHash),
      'weight': config.encodeBigint(weight),
      'deleted': deleted,
      'admin_key': config.encodeMessage(adminKey),
      'decline_reward': declineReward,
      'grpc_proxy_endpoint': config.encodeMessage(grpcProxyEndpoint),
      'associated_registered_node': associatedRegisteredNode.map((e) => config.encodeBigint(e)).toList(),
    };
  }


  factory HederaNode.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaNode(
      nodeId: json.valueAsBigInt<BigInt?>('node_id', normalizeKeyLookup: config.normalizeKeys),
      accountId: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'account_id',
        parse: (v) => proto_basic_types.HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      description: json.valueAsString<String?>('description', normalizeKeyLookup: config.normalizeKeys),
      gossipEndpoint: (json.valueEnsureAsList<dynamic>('gossip_endpoint', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<proto_basic_types.HederaServiceEndpoint, Object>(
          value: e,
          parse: (v) => proto_basic_types.HederaServiceEndpoint.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
      serviceEndpoint: (json.valueEnsureAsList<dynamic>('service_endpoint', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<proto_basic_types.HederaServiceEndpoint, Object>(
          value: e,
          parse: (v) => proto_basic_types.HederaServiceEndpoint.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
      gossipCaCertificate: config.decodeBinary<List<int>?>(json.valueAs('gossip_ca_certificate', normalizeKeyLookup: config.normalizeKeys)),
      grpcCertificateHash: config.decodeBinary<List<int>?>(json.valueAs('grpc_certificate_hash', normalizeKeyLookup: config.normalizeKeys)),
      weight: json.valueAsBigInt<BigInt?>('weight', normalizeKeyLookup: config.normalizeKeys),
      deleted: json.valueAsBool<bool?>('deleted', normalizeKeyLookup: config.normalizeKeys),
      adminKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'admin_key',
        parse: (v) => proto_basic_types.HederaKey.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      declineReward: json.valueAsBool<bool?>('decline_reward', normalizeKeyLookup: config.normalizeKeys),
      grpcProxyEndpoint: json.valueTo<proto_basic_types.HederaServiceEndpoint?, Object>(
        key: 'grpc_proxy_endpoint',
        parse: (v) => proto_basic_types.HederaServiceEndpoint.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      associatedRegisteredNode: (json.valueEnsureAsList<dynamic>('associated_registered_node', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueAsBigInt<BigInt>(e)).toList(),
    );
  }

  factory HederaNode.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaNode(
      nodeId: decode.getBigInt<BigInt?>(1),
      accountId: decode.messageTo<proto_basic_types.HederaAccountID?>(2, (b) => proto_basic_types.HederaAccountID.deserialize(b)),
      description: decode.getString<String?>(3),
      gossipEndpoint: decode.getListOfBytes(4).map((b) => proto_basic_types.HederaServiceEndpoint.deserialize(b)).toList(),
      serviceEndpoint: decode.getListOfBytes(5).map((b) => proto_basic_types.HederaServiceEndpoint.deserialize(b)).toList(),
      gossipCaCertificate: decode.getBytes<List<int>?>(6),
      grpcCertificateHash: decode.getBytes<List<int>?>(7),
      weight: decode.getBigInt<BigInt?>(8),
      deleted: decode.getBool<bool?>(9),
      adminKey: decode.messageTo<proto_basic_types.HederaKey?>(10, (b) => proto_basic_types.HederaKey.deserialize(b)),
      declineReward: decode.getBool<bool?>(11),
      grpcProxyEndpoint: decode.messageTo<proto_basic_types.HederaServiceEndpoint?>(12, (b) => proto_basic_types.HederaServiceEndpoint.deserialize(b)),
      associatedRegisteredNode: decode.getListOrEmpty<BigInt>(13),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiNodeStateAddressbookNode;

}


