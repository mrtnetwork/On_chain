import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/google/protobuf/src/wrappers.dart"
    as google_protobuf_wrappers;

/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.addressbook"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Transaction body to modify address book node attributes.
///  *
///  * - This transaction SHALL enable the node operator, as identified by the
///  *   `admin_key`, to modify operational attributes of the node.
///  * - This transaction MUST be signed by the active `admin_key` for the node.
///  * - If this transaction sets a new value for the `admin_key`, then both the
///  *   current `admin_key`, and the new `admin_key` MUST sign this transaction.
///  * - This transaction SHALL NOT change any field that is not set (is null) in
///  *   this transaction body.
///  * - This SHALL create a pending update to the node, but the change SHALL NOT
///  *   be immediately applied to the active configuration.
///  * - All pending node updates SHALL be applied to the active network
///  *   configuration during the next `freeze` transaction with the field
///  *   `freeze_type` set to `PREPARE_UPGRADE`.
///  *
///  * ### Block Stream Effects
///  * None.
class HederaNodeUpdateTransactionBody extends HederaProtoMessage with Equality {
  /// *
  ///      * A consensus node identifier in the network state.
  ///      * &lt;p&gt;
  ///      * The node identified MUST exist in the network address book.&lt;br/&gt;
  ///      * The node identified MUST NOT be deleted.&lt;br/&gt;
  ///      * This value is REQUIRED.
  final BigInt? nodeId;

  /// *
  ///      * An account identifier.
  ///      * &lt;p&gt;
  ///      * If set, this SHALL replace the node account identifier.&lt;br/&gt;
  ///      * If set to a valid, non-zero account identifier, this transaction MUST
  ///      * be signed by the `Key` for the new account. Additionally, when only
  ///      * the `account_id` is updated (no other fields changed), the transaction
  ///      * MUST also be signed by either the current node account `Key` or
  ///      * the node `admin_key`. When other fields are also changed, the node
  ///      * `admin_key` MUST sign (as required for any non-account field update).&lt;br/&gt;
  ///      * If set to the sentinel value `0.0.0`, the node account association
  ///      * SHALL be removed, and this transaction MUST be signed by either
  ///      * the current node account `Key` or the node `admin_key`.&lt;br/&gt;
  ///      * Each `account_id` MUST NOT be associated with more than one node.
  final proto_basic_types.HederaAccountID? accountId;

  /// *
  ///      * A short description of the node.
  ///      * &lt;p&gt;
  ///      * This value, if set, MUST NOT exceed `transaction.maxMemoUtf8Bytes`
  ///      * (default 100) bytes when encoded as UTF-8.&lt;br/&gt;
  ///      * If set, this value SHALL replace the previous value.
  final google_protobuf_wrappers.HederaStringValue? description;

  /// *
  ///      * A list of service endpoints for gossip.
  ///      * &lt;p&gt;
  ///      * If set, this list MUST meet the following requirements.
  ///      * &lt;hr/&gt;
  ///      * These endpoints SHALL represent the published endpoints to which other
  ///      * consensus nodes may _gossip_ transactions.&lt;br/&gt;
  ///      * These endpoints SHOULD NOT specify both address and DNS name.&lt;br/&gt;
  ///      * This list MUST NOT be empty.&lt;br/&gt;
  ///      * This list MUST NOT contain more than `10` entries.&lt;br/&gt;
  ///      * The first two entries in this list SHALL be the endpoints published to
  ///      * all consensus nodes.&lt;br/&gt;
  ///      * All other entries SHALL be reserved for future use.
  ///      * &lt;p&gt;
  ///      * Each network may have additional requirements for these endpoints.
  ///      * A client MUST check network-specific documentation for those
  ///      * details.&lt;br/&gt;
  ///      * &lt;blockquote&gt;Example&lt;blockquote&gt;
  ///      * Hedera Mainnet _requires_ that address be specified, and does not
  ///      * permit DNS name (FQDN) to be specified.
  ///      * &lt;/blockquote&gt;
  ///      * &lt;blockquote&gt;
  ///      * Solo, however, _requires_ DNS name (FQDN) but also permits
  ///      * address.
  ///      * &lt;/blockquote&gt;&lt;/blockquote&gt;
  ///      * &lt;p&gt;
  ///      * If set, the new list SHALL replace the existing list.
  final List<proto_basic_types.HederaServiceEndpoint> gossipEndpoint;

  /// *
  ///      * A list of service endpoints for gRPC calls.
  ///      * &lt;p&gt;
  ///      * If set, this list MUST meet the following requirements.
  ///      * &lt;hr/&gt;
  ///      * These endpoints SHALL represent the published endpoints to which clients
  ///      * may submit transactions.&lt;br/&gt;
  ///      * These endpoints SHOULD specify address and port.&lt;br/&gt;
  ///      * These endpoints MAY specify a DNS name.&lt;br/&gt;
  ///      * These endpoints SHOULD NOT specify both address and DNS name.&lt;br/&gt;
  ///      * This list MUST NOT be empty.&lt;br/&gt;
  ///      * This list MUST NOT contain more than `8` entries.
  ///      * &lt;p&gt;
  ///      * Each network may have additional requirements for these endpoints.
  ///      * A client MUST check network-specific documentation for those
  ///      * details.
  ///      * &lt;p&gt;
  ///      * If set, the new list SHALL replace the existing list.
  final List<proto_basic_types.HederaServiceEndpoint> serviceEndpoint;

  /// *
  ///      * A certificate used to sign gossip events.
  ///      * &lt;p&gt;
  ///      * This value MUST be a certificate of a type permitted for gossip
  ///      * signatures.&lt;br/&gt;
  ///      * This value MUST be the DER encoding of the certificate presented.
  ///      * &lt;p&gt;
  ///      * If set, the new value SHALL replace the existing bytes value.
  final google_protobuf_wrappers.HederaBytesValue? gossipCaCertificate;

  /// *
  ///      * A hash of the node gRPC TLS certificate.
  ///      * &lt;p&gt;
  ///      * This value MAY be used to verify the certificate presented by the node
  ///      * during TLS negotiation for gRPC.&lt;br/&gt;
  ///      * This value MUST be a SHA-384 hash.&lt;br/&gt;
  ///      * The TLS certificate to be hashed MUST first be in PEM format and MUST be
  ///      * encoded with UTF-8 NFKD encoding to a stream of bytes provided to
  ///      * the hash algorithm.&lt;br/&gt;
  ///      * &lt;p&gt;
  ///      * If set, the new value SHALL replace the existing hash value.
  final google_protobuf_wrappers.HederaBytesValue? grpcCertificateHash;

  /// *
  ///      * An administrative key controlled by the node operator.
  ///      * &lt;p&gt;
  ///      * This field is OPTIONAL.&lt;br/&gt;
  ///      * If set, this key MUST sign this transaction.&lt;br/&gt;
  ///      * If set, this key MUST sign each subsequent transaction to
  ///      * update this node.&lt;br/&gt;
  ///      * If set, this field MUST contain a valid `Key` value.&lt;br/&gt;
  ///      * If set, this field MUST NOT be set to an empty `KeyList`.
  final proto_basic_types.HederaKey? adminKey;

  /// *
  ///      * A boolean indicating that this node has chosen to decline node rewards
  ///      * distributed at the end of staking period.
  ///      * &lt;p&gt;
  ///      * This node SHALL NOT receive reward if this value is set, and `true`.
  final google_protobuf_wrappers.HederaBoolValue? declineReward;

  /// *
  ///      * A web proxy for gRPC from non-gRPC clients.
  ///      * &lt;p&gt;
  ///      * This endpoint SHALL be a Fully Qualified Domain Name (FQDN) using the HTTPS
  ///      * protocol, and SHALL support gRPC-Web for use by browser-based clients.&lt;br/&gt;
  ///      * This endpoint MUST be signed by a trusted certificate authority.&lt;br/&gt;
  ///      * This endpoint MUST use a valid port and SHALL be reachable over TLS.&lt;br/&gt;
  ///      * This field MAY be omitted if the node does not support gRPC-Web access.&lt;br/&gt;
  ///      * This field MUST be updated if the gRPC-Web endpoint changes.&lt;br/&gt;
  ///      * This field SHALL enable frontend clients to avoid hard-coded proxy endpoints.&lt;br/&gt;
  ///      * This field MAY be set to `ServiceEndpoint.DEFAULT` to remove a previously-valid
  ///      * web proxy.
  final proto_basic_types.HederaServiceEndpoint? grpcProxyEndpoint;

  /// *
  ///      * A list of registered nodes operated by the same entity as this node.&lt;br/&gt;
  ///      * This value may contain a list of "registered nodes" (as described in
  ///      * HIP-1137) that are operated by the same entity that operates this
  ///      * consensus node.
  ///      * &lt;p&gt;
  ///      * This field is OPTIONAL.&lt;br/&gt;
  ///      * If this field is not set, the current list SHALL NOT change.&lt;br/&gt;
  ///      * If this field is set, but contains an empty list, any existing
  ///      * associated registered nodes SHALL be removed.&lt;br/&gt;
  ///      * This field MUST NOT contain more than twenty(20) entries.&lt;br/&gt;
  ///      * Every entry in this list MUST be a valid `registered_node_id` for a
  ///      * current registered node.
  final HederaAssociatedRegisteredNodeList? associatedRegisteredNodeList;

  const HederaNodeUpdateTransactionBody({
    this.nodeId,
    this.accountId,
    this.description,
    this.gossipEndpoint = const [],
    this.serviceEndpoint = const [],
    this.gossipCaCertificate,
    this.grpcCertificateHash,
    this.adminKey,
    this.declineReward,
    this.grpcProxyEndpoint,
    this.associatedRegisteredNodeList,
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
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.repeated(
          fieldNumber: 4,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 5,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.message(6),
        ProtoFieldConfig.message(7),
        ProtoFieldConfig.message(8),
        ProtoFieldConfig.message(9),
        ProtoFieldConfig.message(10),
        ProtoFieldConfig.message(11),
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
    adminKey,
    declineReward,
    grpcProxyEndpoint,
    associatedRegisteredNodeList,
  ];

  HederaNodeUpdateTransactionBody copyWith({
    BigInt? nodeId,

    proto_basic_types.HederaAccountID? accountId,

    google_protobuf_wrappers.HederaStringValue? description,

    List<proto_basic_types.HederaServiceEndpoint>? gossipEndpoint,

    List<proto_basic_types.HederaServiceEndpoint>? serviceEndpoint,

    google_protobuf_wrappers.HederaBytesValue? gossipCaCertificate,

    google_protobuf_wrappers.HederaBytesValue? grpcCertificateHash,

    proto_basic_types.HederaKey? adminKey,

    google_protobuf_wrappers.HederaBoolValue? declineReward,

    proto_basic_types.HederaServiceEndpoint? grpcProxyEndpoint,

    HederaAssociatedRegisteredNodeList? associatedRegisteredNodeList,
  }) {
    return HederaNodeUpdateTransactionBody(
      nodeId: nodeId ?? this.nodeId,
      accountId: accountId ?? this.accountId,
      description: description ?? this.description,
      gossipEndpoint: gossipEndpoint ?? this.gossipEndpoint,
      serviceEndpoint: serviceEndpoint ?? this.serviceEndpoint,
      gossipCaCertificate: gossipCaCertificate ?? this.gossipCaCertificate,
      grpcCertificateHash: grpcCertificateHash ?? this.grpcCertificateHash,
      adminKey: adminKey ?? this.adminKey,
      declineReward: declineReward ?? this.declineReward,
      grpcProxyEndpoint: grpcProxyEndpoint ?? this.grpcProxyEndpoint,
      associatedRegisteredNodeList:
          associatedRegisteredNodeList ?? this.associatedRegisteredNodeList,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'node_id': config.encodeBigint(nodeId),
      'account_id': config.encodeMessage(accountId),
      'description': config.encodeMessage(description),
      'gossip_endpoint':
          gossipEndpoint.map((e) => config.encodeMessage(e)).toList(),
      'service_endpoint':
          serviceEndpoint.map((e) => config.encodeMessage(e)).toList(),
      'gossip_ca_certificate': config.encodeMessage(gossipCaCertificate),
      'grpc_certificate_hash': config.encodeMessage(grpcCertificateHash),
      'admin_key': config.encodeMessage(adminKey),
      'decline_reward': config.encodeMessage(declineReward),
      'grpc_proxy_endpoint': config.encodeMessage(grpcProxyEndpoint),
      'associated_registered_node_list': config.encodeMessage(
        associatedRegisteredNodeList,
      ),
    };
  }

  factory HederaNodeUpdateTransactionBody.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaNodeUpdateTransactionBody(
      nodeId: json.valueAsBigInt<BigInt?>(
        'node_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      accountId: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'account_id',
        parse:
            (v) => proto_basic_types.HederaAccountID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      description: json
          .valueTo<google_protobuf_wrappers.HederaStringValue?, Object>(
            key: 'description',
            parse:
                (v) => google_protobuf_wrappers.HederaStringValue.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      gossipEndpoint:
          (json.valueEnsureAsList<dynamic>(
                'gossip_endpoint',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  proto_basic_types.HederaServiceEndpoint,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => proto_basic_types.HederaServiceEndpoint.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      serviceEndpoint:
          (json.valueEnsureAsList<dynamic>(
                'service_endpoint',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  proto_basic_types.HederaServiceEndpoint,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => proto_basic_types.HederaServiceEndpoint.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      gossipCaCertificate: json
          .valueTo<google_protobuf_wrappers.HederaBytesValue?, Object>(
            key: 'gossip_ca_certificate',
            parse:
                (v) => google_protobuf_wrappers.HederaBytesValue.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      grpcCertificateHash: json
          .valueTo<google_protobuf_wrappers.HederaBytesValue?, Object>(
            key: 'grpc_certificate_hash',
            parse:
                (v) => google_protobuf_wrappers.HederaBytesValue.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
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
      declineReward: json
          .valueTo<google_protobuf_wrappers.HederaBoolValue?, Object>(
            key: 'decline_reward',
            parse:
                (v) => google_protobuf_wrappers.HederaBoolValue.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      grpcProxyEndpoint: json
          .valueTo<proto_basic_types.HederaServiceEndpoint?, Object>(
            key: 'grpc_proxy_endpoint',
            parse:
                (v) => proto_basic_types.HederaServiceEndpoint.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      associatedRegisteredNodeList: json
          .valueTo<HederaAssociatedRegisteredNodeList?, Object>(
            key: 'associated_registered_node_list',
            parse:
                (v) => HederaAssociatedRegisteredNodeList.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
    );
  }

  factory HederaNodeUpdateTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaNodeUpdateTransactionBody(
      nodeId: decode.getBigInt<BigInt?>(1),
      accountId: decode.messageTo<proto_basic_types.HederaAccountID?>(
        2,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      description: decode
          .messageTo<google_protobuf_wrappers.HederaStringValue?>(
            3,
            (b) => google_protobuf_wrappers.HederaStringValue.deserialize(b),
          ),
      gossipEndpoint:
          decode
              .getListOfBytes(4)
              .map(
                (b) => proto_basic_types.HederaServiceEndpoint.deserialize(b),
              )
              .toList(),
      serviceEndpoint:
          decode
              .getListOfBytes(5)
              .map(
                (b) => proto_basic_types.HederaServiceEndpoint.deserialize(b),
              )
              .toList(),
      gossipCaCertificate: decode
          .messageTo<google_protobuf_wrappers.HederaBytesValue?>(
            6,
            (b) => google_protobuf_wrappers.HederaBytesValue.deserialize(b),
          ),
      grpcCertificateHash: decode
          .messageTo<google_protobuf_wrappers.HederaBytesValue?>(
            7,
            (b) => google_protobuf_wrappers.HederaBytesValue.deserialize(b),
          ),
      adminKey: decode.messageTo<proto_basic_types.HederaKey?>(
        8,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      declineReward: decode
          .messageTo<google_protobuf_wrappers.HederaBoolValue?>(
            9,
            (b) => google_protobuf_wrappers.HederaBoolValue.deserialize(b),
          ),
      grpcProxyEndpoint: decode
          .messageTo<proto_basic_types.HederaServiceEndpoint?>(
            10,
            (b) => proto_basic_types.HederaServiceEndpoint.deserialize(b),
          ),
      associatedRegisteredNodeList: decode
          .messageTo<HederaAssociatedRegisteredNodeList?>(
            11,
            (b) => HederaAssociatedRegisteredNodeList.deserialize(b),
          ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiNodeAddressbookNodeUpdateTransactionBody;
}

/// *
///  * A wrapper around a list of associated registered node identifiers.&lt;br/&gt;
///  * This wrapper exists to enable an update transaction to differentiate
///  * between a field that is not set and an empty list of values.
///  * &lt;p&gt;
///  * An _unset_ field of this type SHALL NOT modify existing values.&lt;br/&gt;
///  * A _set_ field of this type with an empty list SHALL remove any
///  * existing values.
class HederaAssociatedRegisteredNodeList extends HederaProtoMessage
    with Equality {
  /// *
  ///      * A list of registered node identifiers.
  final List<BigInt> associatedRegisteredNode;

  const HederaAssociatedRegisteredNodeList({
    this.associatedRegisteredNode = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.uint64,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [associatedRegisteredNode];

  HederaAssociatedRegisteredNodeList copyWith({
    List<BigInt>? associatedRegisteredNode,
  }) {
    return HederaAssociatedRegisteredNodeList(
      associatedRegisteredNode:
          associatedRegisteredNode ?? this.associatedRegisteredNode,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'associated_registered_node':
          associatedRegisteredNode.map((e) => config.encodeBigint(e)).toList(),
    };
  }

  factory HederaAssociatedRegisteredNodeList.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaAssociatedRegisteredNodeList(
      associatedRegisteredNode:
          (json.valueEnsureAsList<dynamic>(
            'associated_registered_node',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => JsonParser.valueAsBigInt<BigInt>(e)).toList(),
    );
  }

  factory HederaAssociatedRegisteredNodeList.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaAssociatedRegisteredNodeList(
      associatedRegisteredNode: decode.getListOrEmpty<BigInt>(1),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiNodeAddressbookAssociatedRegisteredNodeList;
}
