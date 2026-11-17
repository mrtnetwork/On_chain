import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

/// *
///  * # Ledger Id Publication
///  * A system-initiated (i.e. internal) transaction to externalize a new
///  * ledger id and the verification key to use in verifying recursive
///  * chain-of-trust proofs from the new ledger id.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.tss"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A system initiated transaction to externalize the ledger id and verification
///  * key for recursive chain-of-trust proofs extending from the new ledger id.
///  *
///  * This transaction SHALL be issued whenever the ledger id changes.&lt;br/&gt;
///  * This transaction MUST NOT be sent by a client and SHALL be rejected if
///  * received by any node.&lt;br/&gt;
///  * This transaction SHALL be present in the record stream or block stream.
///  *
///  * ### Block Stream Effects
///  * None
class HederaLedgerIdPublicationTransactionBody extends HederaProtoMessage
    with Equality {
  /// *
  ///    * The new ledger id.
  final List<int>? ledgerId;

  /// *
  ///    * The key to use when verifying recursive chain-of-trust proofs that extend
  ///    * from this ledger id.
  final List<int>? historyProofVerificationKey;

  /// *
  ///    * The node-specific contributions made to the new ledger id.
  final List<HederaLedgerIdNodeContribution> nodeContributions;

  const HederaLedgerIdPublicationTransactionBody({
    this.ledgerId,
    this.historyProofVerificationKey,
    this.nodeContributions = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.repeated(
          fieldNumber: 3,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    ledgerId,
    historyProofVerificationKey,
    nodeContributions,
  ];

  HederaLedgerIdPublicationTransactionBody copyWith({
    List<int>? ledgerId,

    List<int>? historyProofVerificationKey,

    List<HederaLedgerIdNodeContribution>? nodeContributions,
  }) {
    return HederaLedgerIdPublicationTransactionBody(
      ledgerId: ledgerId ?? this.ledgerId,
      historyProofVerificationKey:
          historyProofVerificationKey ?? this.historyProofVerificationKey,
      nodeContributions: nodeContributions ?? this.nodeContributions,
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
      'history_proof_verification_key': config.encodeBinary(
        historyProofVerificationKey,
      ),
      'node_contributions':
          nodeContributions.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory HederaLedgerIdPublicationTransactionBody.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaLedgerIdPublicationTransactionBody(
      ledgerId: config.decodeBinary<List<int>?>(
        json.valueAs('ledger_id', normalizeKeyLookup: config.normalizeKeys),
      ),
      historyProofVerificationKey: config.decodeBinary<List<int>?>(
        json.valueAs(
          'history_proof_verification_key',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      nodeContributions:
          (json.valueEnsureAsList<dynamic>(
                'node_contributions',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) =>
                    JsonParser.valueTo<HederaLedgerIdNodeContribution, Object>(
                      value: e,
                      parse:
                          (v) => HederaLedgerIdNodeContribution.fromJson(
                            JsonParser.valueAs(v),
                            config: config,
                          ),
                    ),
              )
              .toList(),
    );
  }

  factory HederaLedgerIdPublicationTransactionBody.deserialize(
    List<int> bytes,
  ) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaLedgerIdPublicationTransactionBody(
      ledgerId: decode.getBytes<List<int>?>(1),
      historyProofVerificationKey: decode.getBytes<List<int>?>(2),
      nodeContributions:
          decode
              .getListOfBytes(3)
              .map((b) => HederaLedgerIdNodeContribution.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl
          .comHederaHapiNodeTssLedgerIdPublicationTransactionBody;
}

/// *
///  * A record of the proof key a node had in a particular address
///  * book. Necessary to keep at each point history so that nodes
///  * can verify the correct key was used to sign in transitions
///  * starting from the current address book; no matter how keys
///  * have been rotated from the time the address book was created.
class HederaLedgerIdNodeContribution extends HederaProtoMessage with Equality {
  /// *
  ///    * The node id.
  final BigInt? nodeId;

  /// *
  ///    * The node's consensus weight when the ledger id was published.
  final BigInt? weight;

  /// *
  ///    * The public key the node used to contribute to history proofs when the
  ///    * ledger id was published.
  final List<int>? historyProofKey;

  const HederaLedgerIdNodeContribution({
    this.nodeId,
    this.weight,
    this.historyProofKey,
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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [nodeId, weight, historyProofKey];

  HederaLedgerIdNodeContribution copyWith({
    BigInt? nodeId,

    BigInt? weight,

    List<int>? historyProofKey,
  }) {
    return HederaLedgerIdNodeContribution(
      nodeId: nodeId ?? this.nodeId,
      weight: weight ?? this.weight,
      historyProofKey: historyProofKey ?? this.historyProofKey,
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
      'weight': config.encodeBigint(weight),
      'history_proof_key': config.encodeBinary(historyProofKey),
    };
  }

  factory HederaLedgerIdNodeContribution.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaLedgerIdNodeContribution(
      nodeId: json.valueAsBigInt<BigInt?>(
        'node_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      weight: json.valueAsBigInt<BigInt?>(
        'weight',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      historyProofKey: config.decodeBinary<List<int>?>(
        json.valueAs(
          'history_proof_key',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
    );
  }

  factory HederaLedgerIdNodeContribution.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaLedgerIdNodeContribution(
      nodeId: decode.getBigInt<BigInt?>(1),
      weight: decode.getBigInt<BigInt?>(2),
      historyProofKey: decode.getBytes<List<int>?>(3),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.comHederaHapiNodeTssLedgerIdNodeContribution;
}
