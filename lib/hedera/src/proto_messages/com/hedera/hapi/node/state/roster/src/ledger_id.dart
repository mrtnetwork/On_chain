import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

/// *
///  * # Ledger ID
///  * A Ledger ID is a Threshold Signature Scheme (TSS) public key that
///  * identifies the ledger.  A Ledger ID is intended to be long-lived, but
///  * may change under rare circumstances.  The Ledger ID for a particular
///  * distributed ledger can be used to validate the signature of that ledger
///  * in, for example, a block stream "block proof".
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.state.roster"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A ledger identifier.&lt;br/&gt;
///  * This message identifies a ledger and is used to verify ledger
///  * signatures in a Threshold Signature Scheme (TSS).
///  *
///  * A ledger identifier SHALL be a public key defined according to the TSS
///  * process.&lt;br/&gt;
///  * A ledger identifier SHOULD NOT change, but MAY do so in rare
///  * circumstances.&lt;br/&gt;
///  * Clients SHOULD always check for the correct ledger identifier, according to
///  * the network roster, before attempting to verify any state proof or other
///  * ledger signature.
///  *
///  * ### Block Stream Effects
///  * Every block in the Block Stream `BlockProof` SHALL be signed via TSS and
///  * MUST be verified with the ledger identifier current at the _start_ of that
///  * block.
///  * If the ledger identifier changes, the new value MUST be used to validate
///  * Block Proof items after the change.
///  * A change to the ledger identifier SHALL be reported in a State Change for
///  * the block containing that change, which SHALL be verified with the _prior_
///  * ledger identifier.
class HederaLedgerId extends HederaProtoMessage with Equality {
  /// *
  ///    * A public key.&lt;br/&gt;
  ///    * This key both identifies the ledger and can be used to verify ledger
  ///    * signatures.
  ///    * &lt;p&gt;
  ///    * This value MUST be set.&lt;br/&gt;
  ///    * This value MUST NOT be empty.&lt;br/&gt;
  ///    * This value MUST contain a valid public key.
  final List<int>? ledgerId;

  /// *
  ///    * A round number.&lt;br/&gt;
  ///    * This identifies when this ledger id becomes active.&lt;br/&gt;
  ///    * This value is REQUIRED.
  final BigInt? round;

  /// *
  ///    * A signature from the prior ledger key.&lt;br/&gt;
  ///    * This signature is the _previous_ ledger ID signing _this_ ledger ID.&lt;br/&gt;
  ///    * This value MAY be unset, if there is no prior ledger ID.&lt;br/&gt;
  ///    * This value SHOULD be set if a prior ledger ID exists
  ///    * to generate the signature.
  final List<int>? ledgerSignature;

  /// *
  ///    * The signatures from nodes in the active roster signing the new
  ///    * ledger id.&lt;br/&gt;
  ///    * These signatures establish a chain of trust from the network to the new
  ///    * ledger id.
  ///    * &lt;p&gt;
  ///    * This value MUST be present when the ledger signature of a previous ledger
  ///    * id is absent.
  final HederaRosterSignatures? rosterSignatures;

  const HederaLedgerId({
    this.ledgerId,
    this.round,
    this.ledgerSignature,
    this.rosterSignatures,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.uint64(2),
        ProtoFieldConfig.bytes(3),
        ProtoFieldConfig.message(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    ledgerId,
    round,
    ledgerSignature,
    rosterSignatures,
  ];

  HederaLedgerId copyWith({
    List<int>? ledgerId,

    BigInt? round,

    List<int>? ledgerSignature,

    HederaRosterSignatures? rosterSignatures,
  }) {
    return HederaLedgerId(
      ledgerId: ledgerId ?? this.ledgerId,
      round: round ?? this.round,
      ledgerSignature: ledgerSignature ?? this.ledgerSignature,
      rosterSignatures: rosterSignatures ?? this.rosterSignatures,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'ledger_id': config.encodeBinary(ledgerId),
      'round': config.encodeBigint(round),
      'ledger_signature': config.encodeBinary(ledgerSignature),
      'roster_signatures': config.encodeMessage(rosterSignatures),
    };
  }

  factory HederaLedgerId.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaLedgerId(
      ledgerId: config.decodeBinary<List<int>?>(
        json.valueAs('ledger_id', normalizeKeyLookup: config.normalizeKeys),
      ),
      round: json.valueAsBigInt<BigInt?>(
        'round',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      ledgerSignature: config.decodeBinary<List<int>?>(
        json.valueAs(
          'ledger_signature',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      rosterSignatures: json.valueTo<HederaRosterSignatures?, Object>(
        key: 'roster_signatures',
        parse:
            (v) => HederaRosterSignatures.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaLedgerId.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaLedgerId(
      ledgerId: decode.getBytes<List<int>?>(1),
      round: decode.getBigInt<BigInt?>(2),
      ledgerSignature: decode.getBytes<List<int>?>(3),
      rosterSignatures: decode.messageTo<HederaRosterSignatures?>(
        4,
        (b) => HederaRosterSignatures.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeStateRosterLedgerId;
}

/// *
///  * A collection of signatures from nodes in a roster.
class HederaRosterSignatures extends HederaProtoMessage with Equality {
  /// *
  ///    * A roster hash for the roster that the node signatures are from.
  final List<int>? rosterHash;

  /// *
  ///    * A list of node signatures on the same message where all node ids in the
  ///    * NodeSignature objects are from the roster that the roster_hash represents.
  final List<HederaNodeSignature> nodeSignatures;

  const HederaRosterSignatures({
    this.rosterHash,
    this.nodeSignatures = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [rosterHash, nodeSignatures];

  HederaRosterSignatures copyWith({
    List<int>? rosterHash,

    List<HederaNodeSignature>? nodeSignatures,
  }) {
    return HederaRosterSignatures(
      rosterHash: rosterHash ?? this.rosterHash,
      nodeSignatures: nodeSignatures ?? this.nodeSignatures,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'roster_hash': config.encodeBinary(rosterHash),
      'node_signatures':
          nodeSignatures.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory HederaRosterSignatures.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaRosterSignatures(
      rosterHash: config.decodeBinary<List<int>?>(
        json.valueAs('roster_hash', normalizeKeyLookup: config.normalizeKeys),
      ),
      nodeSignatures:
          (json.valueEnsureAsList<dynamic>(
                'node_signatures',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<HederaNodeSignature, Object>(
                  value: e,
                  parse:
                      (v) => HederaNodeSignature.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory HederaRosterSignatures.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaRosterSignatures(
      rosterHash: decode.getBytes<List<int>?>(1),
      nodeSignatures:
          decode
              .getListOfBytes(2)
              .map((b) => HederaNodeSignature.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeStateRosterRosterSignatures;
}

/// *
///  * A pair of a _RSA_ signature and the node id of the node that created the
///  * signature.
class HederaNodeSignature extends HederaProtoMessage with Equality {
  /// *
  ///    * The node id of the node that created the _RSA_ signature.
  ///    * This value MUST be set.&lt;br/&gt;
  ///    * This value MUST NOT be empty.&lt;br/&gt;
  ///    * This value is REQUIRED.
  final BigInt? nodeId;

  /// *
  ///    * The bytes of an _RSA_ signature.
  ///    * This value MUST be set.&lt;br/&gt;
  ///    * This value MUST NOT be empty.&lt;br/&gt;
  ///    * This value MUST contain a valid signature.
  final List<int>? nodeSignature;

  const HederaNodeSignature({this.nodeId, this.nodeSignature});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.uint64(1), ProtoFieldConfig.bytes(2)],
    );
  }

  @override
  List<Object?> get protoValues => [nodeId, nodeSignature];

  HederaNodeSignature copyWith({BigInt? nodeId, List<int>? nodeSignature}) {
    return HederaNodeSignature(
      nodeId: nodeId ?? this.nodeId,
      nodeSignature: nodeSignature ?? this.nodeSignature,
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
      'node_signature': config.encodeBinary(nodeSignature),
    };
  }

  factory HederaNodeSignature.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaNodeSignature(
      nodeId: json.valueAsBigInt<BigInt?>(
        'node_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      nodeSignature: config.decodeBinary<List<int>?>(
        json.valueAs(
          'node_signature',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
    );
  }

  factory HederaNodeSignature.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaNodeSignature(
      nodeId: decode.getBigInt<BigInt?>(1),
      nodeSignature: decode.getBytes<List<int>?>(2),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeStateRosterNodeSignature;
}
