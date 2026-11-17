import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/com/hedera/hapi/node/addressbook/src/registered_service_endpoint.dart" as com_hedera_hapi_node_addressbook_registered_service_endpoint;

/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.addressbook"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A transaction body to create a new registered node in the network
///  * address book.
///  *
///  * This transaction, once complete, SHALL add a new registered node to the
///  * network state.
///  * The new registered node SHALL be visible and discoverable upon
///  * completion of this transaction.
///  *
///  * ### Block Stream Effects
///  * None.
class HederaRegisteredNodeCreateTransactionBody extends HederaProtoMessage with Equality {
    /// *
  ///      * An administrative key controlled by the node operator.
  ///      * &lt;p&gt;
  ///      * This key MUST sign this transaction.&lt;br/&gt;
  ///      * This key MUST sign each transaction to update this node.&lt;br/&gt;
  ///      * This field MUST contain a valid `Key` value.&lt;br/&gt;
  ///      * This field is REQUIRED and MUST NOT be set to an empty `KeyList`.&lt;br/&gt;
  ///      * It is RECOMMENDED that this key be composed of one or more unique public
  ///      * keys that are not associated with any network account.&lt;br/&gt;
  ///      * This key MAY be a complex key containing `KeyList` or `ThresholdKey`
  ///      * elements, but SHOULD NOT be a contract ID key.
  final proto_basic_types.HederaKey? adminKey;

    /// *
  ///      * A short description of the node.
  ///      * &lt;p&gt;
  ///      * This value, if set, MUST NOT exceed 100 bytes when encoded as UTF-8.&lt;br/&gt;
  ///      * This field is OPTIONAL.
  final String? description;

    /// *
  ///      * A list of service endpoints for client calls.
  ///      * &lt;p&gt;
  ///      * These endpoints SHALL represent the published endpoints to which
  ///      * clients may submit requests.&lt;br/&gt;
  ///      * Endpoints in this list MAY supply either IP address or FQDN, but MUST
  ///      * NOT supply both values for the same endpoint.&lt;br/&gt;
  ///      * Multiple endpoints in this list MAY resolve to the same interface.&lt;br/&gt;
  ///      * One Registered Node MAY expose endpoints for multiple service types.&lt;br/&gt;
  ///      * This list MUST NOT be empty.&lt;br/&gt;
  ///      * This list MUST NOT contain more than `50` entries.
  final List<com_hedera_hapi_node_addressbook_registered_service_endpoint.HederaRegisteredServiceEndpoint> serviceEndpoint;

  const HederaRegisteredNodeCreateTransactionBody({
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
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.string(2),
        ProtoFieldConfig.repeated(
          fieldNumber: 3,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        adminKey,
        description,
        serviceEndpoint,
      ];


HederaRegisteredNodeCreateTransactionBody copyWith(
{proto_basic_types.HederaKey? adminKey,

String? description,

List<com_hedera_hapi_node_addressbook_registered_service_endpoint.HederaRegisteredServiceEndpoint>? serviceEndpoint,

}) {
    return HederaRegisteredNodeCreateTransactionBody(
adminKey: adminKey ?? this.adminKey,
description: description ?? this.description,
serviceEndpoint: serviceEndpoint ?? this.serviceEndpoint,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'admin_key': config.encodeMessage(adminKey),
      'description': description,
      'service_endpoint': serviceEndpoint.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaRegisteredNodeCreateTransactionBody.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaRegisteredNodeCreateTransactionBody(
      adminKey: json.valueTo<proto_basic_types.HederaKey?, Object>(
        key: 'admin_key',
        parse: (v) => proto_basic_types.HederaKey.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      description: json.valueAsString<String?>('description', normalizeKeyLookup: config.normalizeKeys),
      serviceEndpoint: (json.valueEnsureAsList<dynamic>('service_endpoint', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<com_hedera_hapi_node_addressbook_registered_service_endpoint.HederaRegisteredServiceEndpoint, Object>(
          value: e,
          parse: (v) => com_hedera_hapi_node_addressbook_registered_service_endpoint.HederaRegisteredServiceEndpoint.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaRegisteredNodeCreateTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaRegisteredNodeCreateTransactionBody(
      adminKey: decode.messageTo<proto_basic_types.HederaKey?>(1, (b) => proto_basic_types.HederaKey.deserialize(b)),
      description: decode.getString<String?>(2),
      serviceEndpoint: decode.getListOfBytes(3).map((b) => com_hedera_hapi_node_addressbook_registered_service_endpoint.HederaRegisteredServiceEndpoint.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiNodeAddressbookRegisteredNodeCreateTransactionBody;

}


