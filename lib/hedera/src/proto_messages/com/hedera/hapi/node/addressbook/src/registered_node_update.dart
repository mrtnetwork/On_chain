import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/google/protobuf/src/wrappers.dart"
    as google_protobuf_wrappers;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/addressbook/src/registered_service_endpoint.dart"
    as com_hedera_hapi_node_addressbook_registered_service_endpoint;

/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.addressbook"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A transaction body to update an existing registered node in the network
///  * address book.
///  *
///  * This transaction, once complete, SHALL modify the identified registered
///  * node state as requested.
///  *
///  * ### Block Stream Effects
///  * None.
class HederaRegisteredNodeUpdateTransactionBody extends HederaProtoMessage
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

  /// *
  ///      * An administrative key controlled by the node operator.
  ///      * &lt;p&gt;
  ///      * This field is OPTIONAL.&lt;br/&gt;
  ///      * If set, this key MUST sign this transaction.&lt;br/&gt;
  ///      * If set, this key MUST sign each subsequent transaction to
  ///      * update this node.&lt;br/&gt;
  ///      * If set, this field MUST contain a valid `Key` value.&lt;br/&gt;
  ///      * If set, this field MUST NOT be set to an empty `KeyList`.&lt;br/&gt;
  ///      * It is RECOMMENDED that this key be composed of one or more unique public
  ///      * keys that are not associated with any network account.&lt;br/&gt;
  ///      * This key MAY be a complex key containing `KeyList` or `ThresholdKey`
  ///      * elements, but SHOULD NOT be a contract ID key.
  final proto_basic_types.HederaKey? adminKey;

  /// *
  ///      * A short description of the node.
  ///      * &lt;p&gt;
  ///      * This field is OPTIONAL.&lt;br/&gt;
  ///      * This value, if set, MUST NOT exceed 100 bytes when encoded as UTF-8.&lt;br/&gt;
  ///      * If set, this value SHALL replace the previous value.
  final google_protobuf_wrappers.HederaStringValue? description;

  /// *
  ///      * A list of service endpoints for client calls.
  ///      * &lt;p&gt;
  ///      * This field is OPTIONAL.&lt;br/&gt;
  ///      * These endpoints SHALL represent the published endpoints to which
  ///      * clients may submit requests.&lt;br/&gt;
  ///      * Endpoints in this list MAY supply either IP address or FQDN, but MUST
  ///      * NOT supply both values for the same endpoint.&lt;br/&gt;
  ///      * One Registered Node MAY expose endpoints for multiple service types.&lt;br/&gt;
  ///      * If set, this list MUST NOT be empty.&lt;br/&gt;
  ///      * If set, this list MUST NOT contain more than `50` entries.&lt;br/&gt;
  ///      * If set, this list SHALL _replace_ the previous list.
  final List<
    com_hedera_hapi_node_addressbook_registered_service_endpoint.HederaRegisteredServiceEndpoint
  >
  serviceEndpoint;

  const HederaRegisteredNodeUpdateTransactionBody({
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
        ProtoFieldConfig.message(3),
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

  HederaRegisteredNodeUpdateTransactionBody copyWith({
    BigInt? registeredNodeId,

    proto_basic_types.HederaKey? adminKey,

    google_protobuf_wrappers.HederaStringValue? description,

    List<
      com_hedera_hapi_node_addressbook_registered_service_endpoint.HederaRegisteredServiceEndpoint
    >?
    serviceEndpoint,
  }) {
    return HederaRegisteredNodeUpdateTransactionBody(
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
      'description': config.encodeMessage(description),
      'service_endpoint':
          serviceEndpoint.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory HederaRegisteredNodeUpdateTransactionBody.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaRegisteredNodeUpdateTransactionBody(
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

  factory HederaRegisteredNodeUpdateTransactionBody.deserialize(
    List<int> bytes,
  ) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaRegisteredNodeUpdateTransactionBody(
      registeredNodeId: decode.getBigInt<BigInt?>(1),
      adminKey: decode.messageTo<proto_basic_types.HederaKey?>(
        2,
        (b) => proto_basic_types.HederaKey.deserialize(b),
      ),
      description: decode
          .messageTo<google_protobuf_wrappers.HederaStringValue?>(
            3,
            (b) => google_protobuf_wrappers.HederaStringValue.deserialize(b),
          ),
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
      DefaultHederaProtoTypeUrl
          .comHederaHapiNodeAddressbookRegisteredNodeUpdateTransactionBody;
}
