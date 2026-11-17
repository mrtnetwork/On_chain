import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

/// *
///      * An enumeration of well-known block node endpoint APIs, and a
///      * catch-all option for otherwise unknown endpoint APIs.
enum HederaRegisteredServiceEndpointBlockNodeEndpointBlockNodeApi implements ProtoEnumVariant {
    /// *
  ///        * Any other API type associated with a block node.&lt;br/&gt;
  ///        * The caller must consult local documentation to determine the
  ///        * correct call semantics.&lt;br/&gt;
  ///        * It is RECOMMENDED to call the detail status endpoint for further
  ///        * information before using this endpoint.
  other(0, 'OTHER'),
    /// *
  ///        * The Block Node Status API.
  status(1, 'STATUS'),
    /// *
  ///        * The Block Node Publish API.
  publish(2, 'PUBLISH'),
    /// *
  ///        * The Block Node Subscribe Stream API.
  subscribeStream(3, 'SUBSCRIBE_STREAM'),
    /// *
  ///        * The Block Node State Proof API.
  stateProof(4, 'STATE_PROOF');

  const HederaRegisteredServiceEndpointBlockNodeEndpointBlockNodeApi(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static HederaRegisteredServiceEndpointBlockNodeEndpointBlockNodeApi fromValue(int? value) {
    value ??=0;
    return HederaRegisteredServiceEndpointBlockNodeEndpointBlockNodeApi.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaRegisteredServiceEndpointBlockNodeEndpointBlockNodeApi found for the given value. $value", details: {"name": "HederaRegisteredServiceEndpointBlockNodeEndpointBlockNodeApi", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static HederaRegisteredServiceEndpointBlockNodeEndpointBlockNodeApi from(Object? value) {
    value ??=0;
    return HederaRegisteredServiceEndpointBlockNodeEndpointBlockNodeApi.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching HederaRegisteredServiceEndpointBlockNodeEndpointBlockNodeApi found for the given value. $value", details: {"name": "HederaRegisteredServiceEndpointBlockNodeEndpointBlockNodeApi", "value": value?.toString()})
    );
  }

}


/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.addressbook"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A registered network node endpoint.&lt;br/&gt;
///  * Each registered network node in the global address book publishes one or
///  * more endpoints which enable the nodes to communicate both with other
///  * nodes and with clients to receive requests.
///  *
///  * This message supports a TCP/UDP port and IP address (V4 or V6),
///  * or MAY include a FQDN _instead of_ an IP address.&lt;br/&gt;
class HederaRegisteredServiceEndpoint extends HederaProtoMessage with Equality {
    /// *
  ///    * An IP address or fully qualified domain name.
  ///    * &lt;p&gt;
  ///    * This oneof is REQUIRED.
  /// *
  ///      * A 32-bit IPv4 address or 128-bit IPv6 address.&lt;br/&gt;
  ///      * This is the address of the endpoint, encoded in pure "big-endian"
  ///      * (i.e. left to right) order (e.g. IPv4 address `127.0.0.1` has
  ///      * hex bytes in the order `7F`, `00`, `00`, `01`.&lt;br/&gt;
  ///      * IPv6 address `::1` has hex bytes `00`, `00`, `00`, `00`, `00`, `00`,
  ///      * `00`, `00`, `00`, `00`, `00`, `00`, `00`, `00`, `00`, `01`).
  final List<int>? ipAddress;

    /// *
  ///      * A node domain name.
  ///      * &lt;p&gt;
  ///      * This MUST be the fully qualified domain name of the node.&lt;br/&gt;
  ///      * This value MUST NOT exceed 250 ASCII characters.&lt;br/&gt;
  ///      * This value MUST meet all other DNS name requirements.
  final String? domainName;

    /// *
  ///    * A network port to use.
  ///    * &lt;p&gt;
  ///    * This value MUST be between 0 and 65535, inclusive.&lt;br/&gt;
  ///    * This value is REQUIRED.
  final int? port;

    /// *
  ///    * A flag indicating if this endpoint requires TLS.
  ///    * &lt;p&gt;
  ///    * If this value is set true, then connections to this endpoint MUST
  ///    * enable TLS.
  ///    * &lt;p&gt;
  ///    * TLS endpoints MAY use self-signed certificates for this purpose,
  ///    * but use of self-signed certificates SHOULD be limited to testing and
  ///    * development environments to ensure production environments meet all
  ///    * expected characteristics for transport layer security.
  final bool? requiresTls;

    /// *
  ///    * An endpoint type.&lt;br/&gt;
  ///    * This declares the type of registered node endpoint and includes any
  ///    * type-specific fields.
  ///    * &lt;p&gt;
  ///    * This oneof is REQUIRED.
  /// *
  ///      * A Block Node.&lt;br/&gt;
  ///      * A Block Node stores the block chain, provides content proof services,
  ///      * and delivers the block stream to other clients.
  final HederaRegisteredServiceEndpointBlockNodeEndpoint? blockNode;

    /// *
  ///      * A Mirror Node.&lt;br/&gt;
  ///      * A Mirror Node is an advanced indexing and query service that provides
  ///      * fast and flexible access to query the block chain and transaction
  ///      * history. A Mirror Node typically stores all recent blockchain data,
  ///      * and some store the entire history of the network.
  final HederaRegisteredServiceEndpointMirrorNodeEndpoint? mirrorNode;

    /// *
  ///      * A RPC Relay.&lt;br/&gt;
  ///      * A RPC Relay is a proxy and translator between EVM tooling and a
  ///      * Hiero consensus network.
  final HederaRegisteredServiceEndpointRpcRelayEndpoint? rpcRelay;

    /// *
  ///      * A general service.&lt;br/&gt;
  ///      * A general service endpoint represents any network accessible service
  ///      * that is provided by a registered node but that is not a service
  ///      * currently defined as part of the Hiero Ledger system.
  final HederaRegisteredServiceEndpointGeneralServiceEndpoint? generalService;

  const HederaRegisteredServiceEndpoint({
    this.ipAddress,
    this.domainName,
    this.port,
    this.requiresTls,
    this.blockNode,
    this.mirrorNode,
    this.rpcRelay,
    this.generalService,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.string(2),
        ProtoFieldConfig.uint32(3),
        ProtoFieldConfig.bool(4),
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.message(6),
        ProtoFieldConfig.message(7),
        ProtoFieldConfig.message(8),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        ipAddress,
        domainName,
        port,
        requiresTls,
        blockNode,
        mirrorNode,
        rpcRelay,
        generalService,
      ];


HederaRegisteredServiceEndpoint copyWith(
{List<int>? ipAddress,

String? domainName,

int? port,

bool? requiresTls,

HederaRegisteredServiceEndpointBlockNodeEndpoint? blockNode,

HederaRegisteredServiceEndpointMirrorNodeEndpoint? mirrorNode,

HederaRegisteredServiceEndpointRpcRelayEndpoint? rpcRelay,

HederaRegisteredServiceEndpointGeneralServiceEndpoint? generalService,

}) {
    return HederaRegisteredServiceEndpoint(
ipAddress: ipAddress ?? this.ipAddress,
domainName: domainName ?? this.domainName,
port: port ?? this.port,
requiresTls: requiresTls ?? this.requiresTls,
blockNode: blockNode ?? this.blockNode,
mirrorNode: mirrorNode ?? this.mirrorNode,
rpcRelay: rpcRelay ?? this.rpcRelay,
generalService: generalService ?? this.generalService,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'ip_address': config.encodeBinary(ipAddress),
      'domain_name': domainName,
      'port': port,
      'requires_tls': requiresTls,
      'block_node': config.encodeMessage(blockNode),
      'mirror_node': config.encodeMessage(mirrorNode),
      'rpc_relay': config.encodeMessage(rpcRelay),
      'general_service': config.encodeMessage(generalService),
    };
  }


  factory HederaRegisteredServiceEndpoint.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaRegisteredServiceEndpoint(
      ipAddress: config.decodeBinary<List<int>?>(json.valueAs('ip_address', normalizeKeyLookup: config.normalizeKeys)),
      domainName: json.valueAsString<String?>('domain_name', normalizeKeyLookup: config.normalizeKeys),
      port: json.valueAsInt<int?>('port', normalizeKeyLookup: config.normalizeKeys),
      requiresTls: json.valueAsBool<bool?>('requires_tls', normalizeKeyLookup: config.normalizeKeys),
      blockNode: json.valueTo<HederaRegisteredServiceEndpointBlockNodeEndpoint?, Object>(
        key: 'block_node',
        parse: (v) => HederaRegisteredServiceEndpointBlockNodeEndpoint.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      mirrorNode: json.valueTo<HederaRegisteredServiceEndpointMirrorNodeEndpoint?, Object>(
        key: 'mirror_node',
        parse: (v) => HederaRegisteredServiceEndpointMirrorNodeEndpoint.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      rpcRelay: json.valueTo<HederaRegisteredServiceEndpointRpcRelayEndpoint?, Object>(
        key: 'rpc_relay',
        parse: (v) => HederaRegisteredServiceEndpointRpcRelayEndpoint.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      generalService: json.valueTo<HederaRegisteredServiceEndpointGeneralServiceEndpoint?, Object>(
        key: 'general_service',
        parse: (v) => HederaRegisteredServiceEndpointGeneralServiceEndpoint.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaRegisteredServiceEndpoint.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaRegisteredServiceEndpoint(
      ipAddress: decode.getBytes<List<int>?>(1),
      domainName: decode.getString<String?>(2),
      port: decode.getInt<int?>(3),
      requiresTls: decode.getBool<bool?>(4),
      blockNode: decode.messageTo<HederaRegisteredServiceEndpointBlockNodeEndpoint?>(5, (b) => HederaRegisteredServiceEndpointBlockNodeEndpoint.deserialize(b)),
      mirrorNode: decode.messageTo<HederaRegisteredServiceEndpointMirrorNodeEndpoint?>(6, (b) => HederaRegisteredServiceEndpointMirrorNodeEndpoint.deserialize(b)),
      rpcRelay: decode.messageTo<HederaRegisteredServiceEndpointRpcRelayEndpoint?>(7, (b) => HederaRegisteredServiceEndpointRpcRelayEndpoint.deserialize(b)),
      generalService: decode.messageTo<HederaRegisteredServiceEndpointGeneralServiceEndpoint?>(8, (b) => HederaRegisteredServiceEndpointGeneralServiceEndpoint.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiNodeAddressbookRegisteredServiceEndpoint;

}


/// *
///    * A message indicating this endpoint is a Block Node endpoint.&lt;br/&gt;
///    * Block Node endpoints offer one of several block node APIs, so this
///    * endpoint entry also declares which well-known Block Node API is
///    * supported by this endpoint, or "OTHER" for less common APIs.
class HederaRegisteredServiceEndpointBlockNodeEndpoint extends HederaProtoMessage with Equality {
    /// *
  ///      * An indicator of what API this endpoint supports.
  ///      * &lt;p&gt;
  ///      * This field is REQUIRED.
  final List<HederaRegisteredServiceEndpointBlockNodeEndpointBlockNodeApi> endpointApi;

  const HederaRegisteredServiceEndpointBlockNodeEndpoint({
    this.endpointApi = const [],
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
          elementType: ProtoFieldType.enumType,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        endpointApi,
      ];


HederaRegisteredServiceEndpointBlockNodeEndpoint copyWith(
{List<HederaRegisteredServiceEndpointBlockNodeEndpointBlockNodeApi>? endpointApi,

}) {
    return HederaRegisteredServiceEndpointBlockNodeEndpoint(
endpointApi: endpointApi ?? this.endpointApi,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'endpoint_api': endpointApi.map((e) => config.encodeEnum(e)).toList(),
    };
  }


  factory HederaRegisteredServiceEndpointBlockNodeEndpoint.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaRegisteredServiceEndpointBlockNodeEndpoint(
      endpointApi: (json.valueEnsureAsList<dynamic>('endpoint_api', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaRegisteredServiceEndpointBlockNodeEndpointBlockNodeApi, Object>(
          value: e,
          parse: (v) => HederaRegisteredServiceEndpointBlockNodeEndpointBlockNodeApi.from(v),
        )).toList(),
    );
  }

  factory HederaRegisteredServiceEndpointBlockNodeEndpoint.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaRegisteredServiceEndpointBlockNodeEndpoint(
      endpointApi: decode.getReapeatedEnum<HederaRegisteredServiceEndpointBlockNodeEndpointBlockNodeApi>(1, HederaRegisteredServiceEndpointBlockNodeEndpointBlockNodeApi.values),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiNodeAddressbookRegisteredServiceEndpointBlockNodeEndpoint;

}


/// *
///    * A message indicating this endpoint is a Mirror Node endpoint.
class HederaRegisteredServiceEndpointMirrorNodeEndpoint extends HederaProtoMessage with Equality {
  const HederaRegisteredServiceEndpointMirrorNodeEndpoint();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
      ];


HederaRegisteredServiceEndpointMirrorNodeEndpoint copyWith(
) {
    return HederaRegisteredServiceEndpointMirrorNodeEndpoint(
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
    };
  }


  factory HederaRegisteredServiceEndpointMirrorNodeEndpoint.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaRegisteredServiceEndpointMirrorNodeEndpoint(
    );
  }

  factory HederaRegisteredServiceEndpointMirrorNodeEndpoint.deserialize(List<int> bytes) {
    return HederaRegisteredServiceEndpointMirrorNodeEndpoint(
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiNodeAddressbookRegisteredServiceEndpointMirrorNodeEndpoint;

}


/// *
///    * A message indicating this endpoint is a RPC Relay endpoint.
class HederaRegisteredServiceEndpointRpcRelayEndpoint extends HederaProtoMessage with Equality {
  const HederaRegisteredServiceEndpointRpcRelayEndpoint();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
      ];


HederaRegisteredServiceEndpointRpcRelayEndpoint copyWith(
) {
    return HederaRegisteredServiceEndpointRpcRelayEndpoint(
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
    };
  }


  factory HederaRegisteredServiceEndpointRpcRelayEndpoint.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaRegisteredServiceEndpointRpcRelayEndpoint(
    );
  }

  factory HederaRegisteredServiceEndpointRpcRelayEndpoint.deserialize(List<int> bytes) {
    return HederaRegisteredServiceEndpointRpcRelayEndpoint(
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiNodeAddressbookRegisteredServiceEndpointRpcRelayEndpoint;

}


/// *
///    * A message indicating this endpoint is a General Service endpoint.
class HederaRegisteredServiceEndpointGeneralServiceEndpoint extends HederaProtoMessage with Equality {
    /// *
  ///      * A short description of the service provided.
  ///      * &lt;p&gt;
  ///      * This value, if set, MUST NOT exceed 100 bytes when encoded as UTF-8.&lt;br/&gt;
  ///      * This field is OPTIONAL.
  final String? description;

  const HederaRegisteredServiceEndpointGeneralServiceEndpoint({
    this.description,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        description,
      ];


HederaRegisteredServiceEndpointGeneralServiceEndpoint copyWith(
{String? description,

}) {
    return HederaRegisteredServiceEndpointGeneralServiceEndpoint(
description: description ?? this.description,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'description': description,
    };
  }


  factory HederaRegisteredServiceEndpointGeneralServiceEndpoint.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaRegisteredServiceEndpointGeneralServiceEndpoint(
      description: json.valueAsString<String?>('description', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaRegisteredServiceEndpointGeneralServiceEndpoint.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaRegisteredServiceEndpointGeneralServiceEndpoint(
      description: decode.getString<String?>(1),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiNodeAddressbookRegisteredServiceEndpointGeneralServiceEndpoint;

}


