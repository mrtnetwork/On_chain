import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;

/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.addressbook"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A transaction body to add a new consensus node to the network address book.
///  *
///  * This transaction body SHALL be considered a "privileged transaction".
///  *
///  * This message supports a transaction to create a new node in the network
///  * address book. The transaction, once complete, enables a new consensus node
///  * to join the network, and requires governing council authorization.
///  *
///  * - A `NodeCreateTransactionBody` MUST be signed by the `Key` assigned to the
///  *   `admin_key` field and one of those keys: treasure account (2) key,
///  *   systemAdmin(50) key, or addressBookAdmin(55) key.
///  * - This transaction MUST also be signed by the `Key` on the account
///  *   identified by `account_id`.
///  * - The newly created node information SHALL be added to the network address
///  *   book information in the network state.
///  * - The new entry SHALL be created in "state" but SHALL NOT participate in
///  *   network consensus and SHALL NOT be present in network "configuration"
///  *   until the next "upgrade" transaction (as noted below).
///  * - All new address book entries SHALL be added to the active network
///  *   configuration during the next `freeze` transaction with the field
///  *   `freeze_type` set to `PREPARE_UPGRADE`.
///  *
///  * ### Block Stream Effects
///  * Upon completion the newly assigned `node_id` SHALL be recorded in
///  * the transaction receipt.&lt;br/&gt;
///  * This value SHALL be the next available node identifier.&lt;br/&gt;
///  * Node identifiers SHALL NOT be reused.
class HederaNodeCreateTransactionBody extends HederaProtoMessage with Equality {
    /// *
  ///      * A Node account identifier.
  ///      * &lt;p&gt;
  ///      * This account identifier MUST be in the "account number" form.&lt;br/&gt;
  ///      * This account identifier MUST NOT use the alias field.&lt;br/&gt;
  ///      * If the identified account does not exist, this transaction SHALL fail.&lt;br/&gt;
  ///      * Each account_id MUST NOT be associated with more than one node.&lt;br/&gt;
  ///      * This field is REQUIRED.
  final proto_basic_types.HederaAccountID? accountId;

    /// *
  ///      * A short description of the node.
  ///      * &lt;p&gt;
  ///      * This value, if set, MUST NOT exceed `transaction.maxMemoUtf8Bytes`
  ///      * (default 100) bytes when encoded as UTF-8.&lt;br/&gt;
  ///      * This field is OPTIONAL.
  final String? description;

    /// *
  ///      * A list of service endpoints for gossip.
  ///      * &lt;p&gt;
  ///      * These endpoints SHALL represent the published endpoints to which other
  ///      * consensus nodes may _gossip_ transactions.&lt;br/&gt;
  ///      * These endpoints MUST specify a port.&lt;br/&gt;
  ///      * This list MUST NOT be empty.&lt;br/&gt;
  ///      * This list MUST NOT contain more than `10` entries.&lt;br/&gt;
  ///      * The first two entries in this list SHALL be the endpoints published to
  ///      * all consensus nodes.&lt;br/&gt;
  ///      * All other entries SHALL be reserved for future use.
  ///      * &lt;p&gt;
  ///      * Each network may have additional requirements for these endpoints.
  ///      * A client MUST check network-specific documentation for those
  ///      * details.&lt;br/&gt;
  ///      * If the network configuration value `gossipFqdnRestricted` is set, then
  ///      * all endpoints in this list MUST supply only IP address.&lt;br/&gt;
  ///      * If the network configuration value `gossipFqdnRestricted` is _not_ set,
  ///      * then endpoints in this list MAY supply either IP address or FQDN, but
  ///      * MUST NOT supply both values for the same endpoint.
  final List<proto_basic_types.HederaServiceEndpoint> gossipEndpoint;

    /// *
  ///      * A list of service endpoints for gRPC calls.
  ///      * &lt;p&gt;
  ///      * These endpoints SHALL represent the published gRPC endpoints to which
  ///      * clients may submit transactions.&lt;br/&gt;
  ///      * These endpoints MUST specify a port.&lt;br/&gt;
  ///      * Endpoints in this list MAY supply either IP address or FQDN, but MUST
  ///      * NOT supply both values for the same endpoint.&lt;br/&gt;
  ///      * This list MUST NOT be empty.&lt;br/&gt;
  ///      * This list MUST NOT contain more than `8` entries.
  final List<proto_basic_types.HederaServiceEndpoint> serviceEndpoint;

    /// *
  ///      * A certificate used to sign gossip events.
  ///      * &lt;p&gt;
  ///      * This value MUST be a certificate of a type permitted for gossip
  ///      * signatures.&lt;br/&gt;
  ///      * This value MUST be the DER encoding of the certificate presented.&lt;br/&gt;
  ///      * This field is REQUIRED and MUST NOT be empty.
  final List<int>? gossipCaCertificate;

    /// *
  ///      * A hash of the node gRPC TLS certificate.
  ///      * &lt;p&gt;
  ///      * This value MAY be used to verify the certificate presented by the node
  ///      * during TLS negotiation for gRPC.&lt;br/&gt;
  ///      * This value MUST be a SHA-384 hash.&lt;br/&gt;
  ///      * The TLS certificate to be hashed MUST first be in PEM format and MUST be
  ///      * encoded with UTF-8 NFKD encoding to a stream of bytes provided to
  ///      * the hash algorithm.&lt;br/&gt;
  ///      * This field is OPTIONAL.
  final List<int>? grpcCertificateHash;

    /// *
  ///      * An administrative key controlled by the node operator.
  ///      * &lt;p&gt;
  ///      * This key MUST sign this transaction.&lt;br/&gt;
  ///      * This key MUST sign each transaction to update this node.&lt;br/&gt;
  ///      * This field MUST contain a valid `Key` value.&lt;br/&gt;
  ///      * This field is REQUIRED and MUST NOT be set to an empty `KeyList`.
  final proto_basic_types.HederaKey? adminKey;

    /// *
  ///      * A boolean flag indicating whether the node operator declines to receive
  ///      * node rewards.
  ///      * &lt;p&gt;
  ///      * If this flag is set to `true`, the node operator declines to receive
  ///      * node rewards.&lt;br/&gt;
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

  const HederaNodeCreateTransactionBody({
    this.accountId,
    this.description,
    this.gossipEndpoint = const [],
    this.serviceEndpoint = const [],
    this.gossipCaCertificate,
    this.grpcCertificateHash,
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
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.string(2),
        ProtoFieldConfig.repeated(
          fieldNumber: 3,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 4,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.bytes(5),
        ProtoFieldConfig.bytes(6),
        ProtoFieldConfig.message(7),
        ProtoFieldConfig.bool(8),
        ProtoFieldConfig.message(9),
        ProtoFieldConfig.repeated(
          fieldNumber: 10,
          elementType: ProtoFieldType.uint64,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        accountId,
        description,
        gossipEndpoint,
        serviceEndpoint,
        gossipCaCertificate,
        grpcCertificateHash,
        adminKey,
        declineReward,
        grpcProxyEndpoint,
        associatedRegisteredNode,
      ];


HederaNodeCreateTransactionBody copyWith(
{proto_basic_types.HederaAccountID? accountId,

String? description,

List<proto_basic_types.HederaServiceEndpoint>? gossipEndpoint,

List<proto_basic_types.HederaServiceEndpoint>? serviceEndpoint,

List<int>? gossipCaCertificate,

List<int>? grpcCertificateHash,

proto_basic_types.HederaKey? adminKey,

bool? declineReward,

proto_basic_types.HederaServiceEndpoint? grpcProxyEndpoint,

List<BigInt>? associatedRegisteredNode,

}) {
    return HederaNodeCreateTransactionBody(
accountId: accountId ?? this.accountId,
description: description ?? this.description,
gossipEndpoint: gossipEndpoint ?? this.gossipEndpoint,
serviceEndpoint: serviceEndpoint ?? this.serviceEndpoint,
gossipCaCertificate: gossipCaCertificate ?? this.gossipCaCertificate,
grpcCertificateHash: grpcCertificateHash ?? this.grpcCertificateHash,
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
      'account_id': config.encodeMessage(accountId),
      'description': description,
      'gossip_endpoint': gossipEndpoint.map((e) => config.encodeMessage(e)).toList(),
      'service_endpoint': serviceEndpoint.map((e) => config.encodeMessage(e)).toList(),
      'gossip_ca_certificate': config.encodeBinary(gossipCaCertificate),
      'grpc_certificate_hash': config.encodeBinary(grpcCertificateHash),
      'admin_key': config.encodeMessage(adminKey),
      'decline_reward': declineReward,
      'grpc_proxy_endpoint': config.encodeMessage(grpcProxyEndpoint),
      'associated_registered_node': associatedRegisteredNode.map((e) => config.encodeBigint(e)).toList(),
    };
  }


  factory HederaNodeCreateTransactionBody.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaNodeCreateTransactionBody(
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

  factory HederaNodeCreateTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaNodeCreateTransactionBody(
      accountId: decode.messageTo<proto_basic_types.HederaAccountID?>(1, (b) => proto_basic_types.HederaAccountID.deserialize(b)),
      description: decode.getString<String?>(2),
      gossipEndpoint: decode.getListOfBytes(3).map((b) => proto_basic_types.HederaServiceEndpoint.deserialize(b)).toList(),
      serviceEndpoint: decode.getListOfBytes(4).map((b) => proto_basic_types.HederaServiceEndpoint.deserialize(b)).toList(),
      gossipCaCertificate: decode.getBytes<List<int>?>(5),
      grpcCertificateHash: decode.getBytes<List<int>?>(6),
      adminKey: decode.messageTo<proto_basic_types.HederaKey?>(7, (b) => proto_basic_types.HederaKey.deserialize(b)),
      declineReward: decode.getBool<bool?>(8),
      grpcProxyEndpoint: decode.messageTo<proto_basic_types.HederaServiceEndpoint?>(9, (b) => proto_basic_types.HederaServiceEndpoint.deserialize(b)),
      associatedRegisteredNode: decode.getListOrEmpty<BigInt>(10),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiNodeAddressbookNodeCreateTransactionBody;

}


