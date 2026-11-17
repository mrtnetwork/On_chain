import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

/// *
///  * # Tss Vote Transaction
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.services.auxiliary.tss"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A transaction body to vote on the validity of Threshold Signature Scheme
///  * (TSS) Messages for a candidate roster.
///  *
///  * - A `TssVoteTransactionBody` MUST identify the hash of the roster containing
///  *   the node generating this TssVote
///  * - A `TssVoteTransactionBody` MUST identify the hash of the roster that the
///  *   TSS messages is for
///  *  - If the candidate roster has received enough yes votes, the candidate
///  *    roster SHALL be adopted.
///  *  - Switching to the candidate roster MUST not happen until enough nodes have
///  *    voted that they have verified a threshold number of TSS messages from the
///  *    active roster.
///  *  - A vote consists of a bit vector of message statuses where each bit
///  *    corresponds to the order of TssMessages as they have come through
///  *    consensus.
///  *  - The threshold for votes to adopt a candidate roster SHALL be at least 1/3
///  *    of the consensus weight of the active roster to ensure that at least 1
///  *    honest node has validated the TSS key material.
class HederaTssVoteTransactionBody extends HederaProtoMessage with Equality {
    /// *
  ///    * A hash of the roster containing the node generating this TssVote.
  final List<int>? sourceRosterHash;

    /// *
  ///    * A hash of the roster that this TssVote is for.
  final List<int>? targetRosterHash;

    /// *
  ///    * An identifier (and public key) computed from the TssMessages for the target
  ///    * roster.
  final List<int>? ledgerId;

    /// *
  ///    * A signature produced by the node.
  ///    * &lt;p&gt;
  ///    * This signature SHALL be produced using the node RSA signing key to sign
  ///    * the ledger_id.&lt;br/&gt;
  ///    * This signature SHALL be used to establish a chain of trust in the ledger id.
  final List<int>? nodeSignature;

    /// *
  ///    * A bit vector of message statuses.
  ///    * &lt;p&gt;
  ///    * #### Example
  ///    * &lt;ul&gt;&lt;li&gt;The least significant bit of byte[0] SHALL be the 0th item in the sequence.&lt;/li&gt;
  ///    *     &lt;li&gt;The most significant bit of byte[0] SHALL be the 7th item in the sequence.&lt;/li&gt;
  ///    *     &lt;li&gt;The least significant bit of byte[1] SHALL be the 8th item in the sequence.&lt;/li&gt;
  ///    *     &lt;li&gt;The most significant bit of byte[1] SHALL be the 15th item in the sequence.&lt;/li&gt;
  ///    * &lt;/ul&gt;
  ///    * A bit SHALL be set if the `TssMessage` for the `TssMessageTransaction`
  ///    * with a sequence number matching that bit index has been
  ///    * received, and is valid.&lt;br/&gt;
  ///    * A bit SHALL NOT be set if the `TssMessage` has not been received or was
  ///    * received but not valid.
  final List<int>? tssVote;

  const HederaTssVoteTransactionBody({
    this.sourceRosterHash,
    this.targetRosterHash,
    this.ledgerId,
    this.nodeSignature,
    this.tssVote,
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
        ProtoFieldConfig.bytes(3),
        ProtoFieldConfig.bytes(4),
        ProtoFieldConfig.bytes(5),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        sourceRosterHash,
        targetRosterHash,
        ledgerId,
        nodeSignature,
        tssVote,
      ];


HederaTssVoteTransactionBody copyWith(
{List<int>? sourceRosterHash,

List<int>? targetRosterHash,

List<int>? ledgerId,

List<int>? nodeSignature,

List<int>? tssVote,

}) {
    return HederaTssVoteTransactionBody(
sourceRosterHash: sourceRosterHash ?? this.sourceRosterHash,
targetRosterHash: targetRosterHash ?? this.targetRosterHash,
ledgerId: ledgerId ?? this.ledgerId,
nodeSignature: nodeSignature ?? this.nodeSignature,
tssVote: tssVote ?? this.tssVote,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'source_roster_hash': config.encodeBinary(sourceRosterHash),
      'target_roster_hash': config.encodeBinary(targetRosterHash),
      'ledger_id': config.encodeBinary(ledgerId),
      'node_signature': config.encodeBinary(nodeSignature),
      'tss_vote': config.encodeBinary(tssVote),
    };
  }


  factory HederaTssVoteTransactionBody.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaTssVoteTransactionBody(
      sourceRosterHash: config.decodeBinary<List<int>?>(json.valueAs('source_roster_hash', normalizeKeyLookup: config.normalizeKeys)),
      targetRosterHash: config.decodeBinary<List<int>?>(json.valueAs('target_roster_hash', normalizeKeyLookup: config.normalizeKeys)),
      ledgerId: config.decodeBinary<List<int>?>(json.valueAs('ledger_id', normalizeKeyLookup: config.normalizeKeys)),
      nodeSignature: config.decodeBinary<List<int>?>(json.valueAs('node_signature', normalizeKeyLookup: config.normalizeKeys)),
      tssVote: config.decodeBinary<List<int>?>(json.valueAs('tss_vote', normalizeKeyLookup: config.normalizeKeys)),
    );
  }

  factory HederaTssVoteTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaTssVoteTransactionBody(
      sourceRosterHash: decode.getBytes<List<int>?>(1),
      targetRosterHash: decode.getBytes<List<int>?>(2),
      ledgerId: decode.getBytes<List<int>?>(3),
      nodeSignature: decode.getBytes<List<int>?>(4),
      tssVote: decode.getBytes<List<int>?>(5),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiServicesAuxiliaryTssTssVoteTransactionBody;

}


