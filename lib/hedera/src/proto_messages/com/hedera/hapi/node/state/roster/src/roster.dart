import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;

/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.state.roster"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A single roster in the network state.
///  * &lt;p&gt;
///  * The roster SHALL be a list of `RosterEntry` objects.
class HederaRoster extends HederaProtoMessage with Equality {
    /// *
  ///      * List of roster entries, one per consensus node.
  ///      * &lt;p&gt;
  ///      * This list SHALL contain roster entries in natural order of ascending node ids.
  ///      * This list SHALL NOT be empty.&lt;br/&gt;
  final List<HederaRosterEntry> rosterEntries;

  const HederaRoster({
    this.rosterEntries = const [],
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
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        rosterEntries,
      ];


HederaRoster copyWith(
{List<HederaRosterEntry>? rosterEntries,

}) {
    return HederaRoster(
rosterEntries: rosterEntries ?? this.rosterEntries,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'roster_entries': rosterEntries.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaRoster.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaRoster(
      rosterEntries: (json.valueEnsureAsList<dynamic>('roster_entries', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaRosterEntry, Object>(
          value: e,
          parse: (v) => HederaRosterEntry.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaRoster.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaRoster(
      rosterEntries: decode.getListOfBytes(1).map((b) => HederaRosterEntry.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiNodeStateRosterRoster;

}


/// *
///  * A single roster entry in the network state.
///  *
///  * Each roster entry SHALL encapsulate the elements required
///  * to manage node participation in the Threshold Signature Scheme (TSS).&lt;br/&gt;
///  * All fields are REQUIRED.
class HederaRosterEntry extends HederaProtoMessage with Equality {
    /// The tssEncryptionKey field has been reserved because it is no longer
  /// required to be stored in the Roster. The public portion of this key will
  /// continue to be stored in TssBaseService, but will, however, just be
  /// stored as raw bytes.
  /// *
  ///      * A consensus node identifier.
  ///      * &lt;p&gt;
  ///      * Node identifiers SHALL be unique _within_ a ledger,
  ///      * and MUST NOT be repeated _between_ shards and realms.
  final BigInt? nodeId;

    /// *
  ///      * A consensus weight.
  ///      * &lt;p&gt;
  ///      * Each node SHALL have a weight of zero or more in consensus calculations.&lt;br/&gt;
  ///      * The sum of the weights of all nodes in the roster SHALL form the total weight of the system,
  ///      * and each node's individual weight SHALL be proportional to that sum.&lt;br/&gt;
  final BigInt? weight;

    /// *
  ///      * An RSA public certificate used for signing gossip events.
  ///      * &lt;p&gt;
  ///      * This value SHALL be a certificate of a type permitted for gossip
  ///      * signatures.&lt;br/&gt;
  ///      * This value SHALL be the DER encoding of the certificate presented.&lt;br/&gt;
  ///      * This field is REQUIRED and MUST NOT be empty.
  final List<int>? gossipCaCertificate;

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
  final List<proto_basic_types.HederaServiceEndpoint> gossipEndpoint;

  const HederaRosterEntry({
    this.nodeId,
    this.weight,
    this.gossipCaCertificate,
    this.gossipEndpoint = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1),
        ProtoFieldConfig.uint64(2),
        ProtoFieldConfig.bytes(3),
        ProtoFieldConfig.repeated(
          fieldNumber: 5,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        nodeId,
        weight,
        gossipCaCertificate,
        gossipEndpoint,
      ];


HederaRosterEntry copyWith(
{BigInt? nodeId,

BigInt? weight,

List<int>? gossipCaCertificate,

List<proto_basic_types.HederaServiceEndpoint>? gossipEndpoint,

}) {
    return HederaRosterEntry(
nodeId: nodeId ?? this.nodeId,
weight: weight ?? this.weight,
gossipCaCertificate: gossipCaCertificate ?? this.gossipCaCertificate,
gossipEndpoint: gossipEndpoint ?? this.gossipEndpoint,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'node_id': config.encodeBigint(nodeId),
      'weight': config.encodeBigint(weight),
      'gossip_ca_certificate': config.encodeBinary(gossipCaCertificate),
      'gossip_endpoint': gossipEndpoint.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaRosterEntry.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaRosterEntry(
      nodeId: json.valueAsBigInt<BigInt?>('node_id', normalizeKeyLookup: config.normalizeKeys),
      weight: json.valueAsBigInt<BigInt?>('weight', normalizeKeyLookup: config.normalizeKeys),
      gossipCaCertificate: config.decodeBinary<List<int>?>(json.valueAs('gossip_ca_certificate', normalizeKeyLookup: config.normalizeKeys)),
      gossipEndpoint: (json.valueEnsureAsList<dynamic>('gossip_endpoint', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<proto_basic_types.HederaServiceEndpoint, Object>(
          value: e,
          parse: (v) => proto_basic_types.HederaServiceEndpoint.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaRosterEntry.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaRosterEntry(
      nodeId: decode.getBigInt<BigInt?>(1),
      weight: decode.getBigInt<BigInt?>(2),
      gossipCaCertificate: decode.getBytes<List<int>?>(3),
      gossipEndpoint: decode.getListOfBytes(5).map((b) => proto_basic_types.HederaServiceEndpoint.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiNodeStateRosterRosterEntry;

}


