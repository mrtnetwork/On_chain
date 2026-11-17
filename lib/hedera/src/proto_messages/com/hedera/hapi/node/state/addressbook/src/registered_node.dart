import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/addressbook/src/registered_service_endpoint.dart"
    as com_hedera_hapi_node_addressbook_registered_service_endpoint;

/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.state.addressbook"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A single registered node in the network state.
///  *
///  * Each registered node in the network state SHALL represent a single
///  * non-consensus node that is registered on the network.
///  *
///  * Registered node identifiers SHALL only be unique within a single
///  * realm and shard combination.
class HederaRegisteredNode extends HederaProtoMessage with Equality {
  /// *
  ///      * A registered node identifier.
  ///      * &lt;p&gt;
  ///      * This value SHALL be set.&lt;br/&gt;
  ///      * This value SHALL be unique within a given network.&lt;br/&gt;
  ///      * This value SHALL NOT match any consensus node ID in the same network.
  ///      * &lt;p&gt;
  ///      * A given value for `registered_node_id` MUST be unique within a given
  ///      * shard or realm.&lt;br/&gt;
  ///      * A given value for `registered_node_id` MUST NOT be reused, even if the
  ///      * corresponding entry is later deleted.
  final BigInt? registeredNodeId;

  /// *
  ///      * An administrative key controlled by the node operator.
  ///      * &lt;p&gt;
  ///      * This key MUST sign each transaction to update this node.&lt;br/&gt;
  ///      * This field SHALL contain a valid `Key` value.&lt;br/&gt;
  ///      * This field SHALL NOT be set to an empty `KeyList`.&lt;br/&gt;
  ///      * It is RECOMMENDED that this key be composed of one or more unique public
  ///      * keys that are not associated with any network account.&lt;br/&gt;
  ///      * This key MAY be a complex key containing `KeyList` or `ThresholdKey`
  ///      * elements, but SHOULD NOT be a contract ID key.
  final proto_basic_types.HederaKey? adminKey;

  /// *
  ///      * A short description of the node.
  ///      * &lt;p&gt;
  ///      * This value SHALL NOT exceed 100 bytes when encoded as UTF-8.
  final String? description;

  /// *
  ///      * A list of service endpoints for client calls.
  ///      * &lt;p&gt;
  ///      * These endpoints SHALL represent the published endpoints to which
  ///      * clients may submit requests.&lt;br/&gt;
  ///      * One Registered Node MAY expose endpoints for multiple service types.&lt;br/&gt;
  ///      * This list SHALL NOT be empty.&lt;br/&gt;
  ///      * This list SHALL NOT contain more than `50` entries.
  final List<
    com_hedera_hapi_node_addressbook_registered_service_endpoint.HederaRegisteredServiceEndpoint
  >
  serviceEndpoint;

  const HederaRegisteredNode({
    this.registeredNodeId,
    this.adminKey,
    this.description,
    this.serviceEndpoint = const [],
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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    registeredNodeId,
    adminKey,
    description,
    serviceEndpoint,
  ];

  HederaRegisteredNode copyWith({
    BigInt? registeredNodeId,

    proto_basic_types.HederaKey? adminKey,

    String? description,

    List<
      com_hedera_hapi_node_addressbook_registered_service_endpoint.HederaRegisteredServiceEndpoint
    >?
    serviceEndpoint,
  }) {
    return HederaRegisteredNode(
      registeredNodeId: registeredNodeId ?? this.registeredNodeId,
      adminKey: adminKey ?? this.adminKey,
      description: description ?? this.description,
      serviceEndpoint: serviceEndpoint ?? this.serviceEndpoint,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'registered_node_id': config.encodeBigint(registeredNodeId),
      'admin_key': config.encodeMessage(adminKey),
      'description': description,
      'service_endpoint':
          serviceEndpoint.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory HederaRegisteredNode.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaRegisteredNode(
      registeredNodeId: json.valueAsBigInt<BigInt?>(
        'registered_node_id',
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
      description: json.valueAsString<String?>(
        'description',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      serviceEndpoint:
          (json.valueEnsureAsList<dynamic>(
                'service_endpoint',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  com_hedera_hapi_node_addressbook_registered_service_endpoint.HederaRegisteredServiceEndpoint,
                  Object
                >(
                  value: e,
                  parse:
                      (v) =>
                          com_hedera_hapi_node_addressbook_registered_service_endpoint
                              .HederaRegisteredServiceEndpoint.fromJson(
                            JsonParser.valueAs(v),
                            config: config,
                          ),
                ),
              )
              .toList(),
    );
  }

  factory HederaRegisteredNode.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaRegisteredNode(
      registeredNodeId: decode.getBigInt<BigInt?>(1),
      adminKey: decode.messageTo<proto_basic_types.HederaKey?>(
        2,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      description: decode.getString<String?>(3),
      serviceEndpoint:
          decode
              .getListOfBytes(4)
              .map(
                (b) =>
                    com_hedera_hapi_node_addressbook_registered_service_endpoint
                        .HederaRegisteredServiceEndpoint.deserialize(b),
              )
              .toList(),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeStateAddressbookRegisteredNode;
}
