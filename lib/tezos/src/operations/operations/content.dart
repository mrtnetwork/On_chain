import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/tezos/src/address/address.dart';
import 'package:on_chain/tezos/src/serialization/serialization.dart';
import 'package:on_chain/tezos/src/utils/utils.dart';
import 'package:on_chain/tezos/src/crypto/crypto.dart';
import 'package:on_chain/tezos/src/micheline/src/michline.dart';
import 'package:on_chain/tezos/src/operations/entry_point/entry_point.dart';
import 'package:on_chain/tezos/src/operations/layouts/utils.dart';
import 'package:on_chain/tezos/src/operations/utils/utils.dart';

enum TezosOperationKind {
  activeAccount("activate_account", 4),
  attestation("attestation", 21),
  attestationsAggregate("attestations_aggregate", 31),
  ballot("ballot", 6),
  delegation("delegation", 110),
  drainDelegate("drain_delegate", 9),
  setDepositsLimit("set_deposits_limit", 112),
  increasePaidStorage("increase_paid_storage", 113),
  registerGlobalConstant("register_global_constant", 111),
  transaction("transaction", 108),
  reveal("reveal", 107),
  updateConsensusKey("update_consensus_key", 114),
  updateCompanionKey("update_companion_key", 115),
  preattestation("preattestation", 20),
  preattestationsAggregate("preattestations_aggregate", 30),
  proposals("proposals", 5),
  seedNonceRevelation("seed_nonce_revelation", 1),
  failingNoop("failing_noop", 17),
  origination("origination", 109),
  transferTicket("transfer_ticket", 158),
  smartRollupAddMessages("smart_rollup_add_messages", 201),
  smartRollupCement("smart_rollup_cement", 202),
  smartRollupExecuteOutboxMessage("smart_rollup_execute_outbox_message", 206),
  smartRollupRecoverBond("smart_rollup_recover_bond", 207),
  smartRollupOriginate("smart_rollup_originate", 200),
  smartRollupPublish("smart_rollup_publish", 203),
  smartRollupTimeout("smart_rollup_timeout", 205),
  smartRollupRefute("smart_rollup_refute", 204),
  attestationWithDal("attestation_with_dal", 23),
  zkRollupOperation("zk_rollup_origination", 250),
  zkRollupPublish("zk_rollup_publish", 251),
  zkRollupUpdate("zk_rollup_update", 252),
  vdfRevelation("vdf_revelation", 8),
  doubleConsensusOperationEvidence("double_consensus_operation_evidence", 2),
  doubleBakingEvidence("double_baking_evidence", 3),
  dalEntrapmentEvidence("dal_entrapment_evidence", 24),
  dalPublishCommitment("dal_publish_commitment", 230);

  const TezosOperationKind(this.operationName, this.tag);

  final String operationName;
  final int tag;

  static TezosOperationKind fromOperation(String? value) {
    return values.firstWhere(
      (e) => e.operationName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid Tezos operation kind.",
              ),
    );
  }
}

sealed class TezosOperationContent
    extends
        OctezVariatnSerializable<TezosOperationContent, TezosOperationContent>
    with Equality {
  final TezosOperationKind type;
  const TezosOperationContent(this.type);
  factory TezosOperationContent.deserialize(List<int> bytes) {
    return layout().deserialize(bytes).value;
  }

  factory TezosOperationContent.fromJson(Map<String, dynamic> json) {
    final type = TezosOperationKind.fromOperation(json.valueAsString("kind"));
    final decode = switch (type) {
      TezosOperationKind.activeAccount =>
        TezosActivateAccountOperation.deserializeJson(json),
      TezosOperationKind.attestation =>
        TezosAttestationOperation.deserializeJson(json),
      TezosOperationKind.attestationsAggregate =>
        TezosAttestationOperationsAggregateOperation.deserializeJson(json),
      TezosOperationKind.ballot => TezosBallotOperation.deserializeJson(json),
      TezosOperationKind.delegation => TezosDelegationOperation.deserializeJson(
        json,
      ),
      TezosOperationKind.drainDelegate =>
        TezosDrainDelegateOperation.deserializeJson(json),
      TezosOperationKind.setDepositsLimit =>
        TezosSetDepositsLimitOperation.deserializeJson(json),
      TezosOperationKind.increasePaidStorage =>
        TezosIncreasePaidStorageOperation.deserializeJson(json),
      TezosOperationKind.registerGlobalConstant =>
        TezosRegisterGlobalConstantOperation.deserializeJson(json),
      TezosOperationKind.transaction =>
        TezosTransactionOperation.deserializeJson(json),
      TezosOperationKind.reveal => TezosRevealOperation.deserializeJson(json),
      TezosOperationKind.updateConsensusKey =>
        TezosUpdateConsensusKeyOperation.deserializeJson(json),
      TezosOperationKind.updateCompanionKey =>
        TezosUpdateCompanionKeyOperation.deserializeJson(json),
      TezosOperationKind.preattestation =>
        TezosPreattestationOperation.deserializeJson(json),
      TezosOperationKind.preattestationsAggregate =>
        TezosPreattestationOperationsAggregateOperation.deserializeJson(json),
      TezosOperationKind.proposals => TezosProposalsOperation.deserializeJson(
        json,
      ),
      TezosOperationKind.seedNonceRevelation =>
        TezosSeedNonceRevelationOperation.deserializeJson(json),
      TezosOperationKind.failingNoop =>
        TezosFailingNoopOperation.deserializeJson(json),
      TezosOperationKind.origination =>
        TezosOriginationOperation.deserializeJson(json),
      TezosOperationKind.transferTicket =>
        TezosTransferTicketOperation.deserializeJson(json),
      TezosOperationKind.smartRollupAddMessages =>
        TezosSmartRollupAddMessagesOperation.deserializeJson(json),
      TezosOperationKind.smartRollupCement =>
        TezosSmartRollupCementOperation.deserializeJson(json),
      TezosOperationKind.smartRollupExecuteOutboxMessage =>
        TezosSmartRollupExecuteOutboxMessageOperation.deserializeJson(json),
      TezosOperationKind.smartRollupRecoverBond =>
        TezosSmartRollupRecoverBondOperation.deserializeJson(json),
      TezosOperationKind.smartRollupOriginate =>
        TezosSmartRollupOriginateOperation.deserializeJson(json),
      TezosOperationKind.smartRollupPublish =>
        TezosSmartRollupPublishOperation.deserializeJson(json),
      TezosOperationKind.smartRollupTimeout =>
        TezosSmartRollupTimeoutOperation.deserializeJson(json),
      TezosOperationKind.smartRollupRefute =>
        TezosSmartRollupRefuteOperation.deserializeJson(json),
      TezosOperationKind.attestationWithDal =>
        TezosAttestationOperationWithDalOperation.deserializeJson(json),
      TezosOperationKind.zkRollupOperation =>
        TezosZkRollupOriginationOperation.deserializeJson(json),
      TezosOperationKind.zkRollupPublish =>
        TezosZkRollupPublishOperation.deserializeJson(json),
      TezosOperationKind.zkRollupUpdate =>
        TezosZkRollupUpdateOperation.deserializeJson(json),
      TezosOperationKind.vdfRevelation =>
        TezosVdfRevelationOperation.deserializeJson(json),
      TezosOperationKind.doubleConsensusOperationEvidence =>
        TezosDoubleConsensusOperation.deserializeJson(json),
      TezosOperationKind.doubleBakingEvidence =>
        TezosDoubleBakingOperation.deserializeJson(json),
      TezosOperationKind.dalEntrapmentEvidence =>
        TezosDalEntrapmentOperation.deserializeJson(json),
      TezosOperationKind.dalPublishCommitment =>
        TezosDalPublishCommitmentOperation.deserializeJson(json),
    };
    return decode;
  }
  static TaggedUnionLayout<TezosOperationContent> layout() =>
      TaggedUnionLayout<TezosOperationContent>(
        tagLayout: TezosLayoutUtils.tzUint8,
        tagFor: (op) => op.type.tag,
        cases: [
          // 1
          UnionCase<TezosOperationContent>(
            TezosOperationKind.seedNonceRevelation.tag,
            TezosSeedNonceRevelationOperation.layout(),
          ),
          // 4
          UnionCase<TezosOperationContent>(
            TezosOperationKind.activeAccount.tag,
            TezosActivateAccountOperation.layout(),
          ),
          // 5
          UnionCase<TezosOperationContent>(
            TezosOperationKind.proposals.tag,
            TezosProposalsOperation.layout(),
          ),
          // 6
          UnionCase<TezosOperationContent>(
            TezosOperationKind.ballot.tag,
            TezosBallotOperation.layout(),
          ),
          // 9
          UnionCase<TezosOperationContent>(
            TezosOperationKind.drainDelegate.tag,
            TezosDrainDelegateOperation.layout(),
          ),
          // 17
          UnionCase<TezosOperationContent>(
            TezosOperationKind.failingNoop.tag,
            TezosFailingNoopOperation.layout(),
          ),
          // 20
          UnionCase<TezosOperationContent>(
            TezosOperationKind.preattestation.tag,
            TezosPreattestationOperation.layout(),
          ),
          // 21
          UnionCase<TezosOperationContent>(
            TezosOperationKind.attestation.tag,
            TezosAttestationOperation.layout(),
          ),
          // 23
          UnionCase<TezosOperationContent>(
            TezosOperationKind.attestationWithDal.tag,
            TezosAttestationOperationWithDalOperation.layout(),
          ),
          // 30
          UnionCase<TezosOperationContent>(
            TezosOperationKind.preattestationsAggregate.tag,
            TezosPreattestationOperationsAggregateOperation.layout(),
          ),
          // 31
          UnionCase<TezosOperationContent>(
            TezosOperationKind.attestationsAggregate.tag,
            TezosAttestationOperationsAggregateOperation.layout(),
          ),
          // 107
          UnionCase<TezosOperationContent>(
            TezosOperationKind.reveal.tag,
            TezosRevealOperation.layout(),
          ),
          // 108
          UnionCase<TezosOperationContent>(
            TezosOperationKind.transaction.tag,
            TezosTransactionOperation.layout(),
          ),
          // 109
          UnionCase<TezosOperationContent>(
            TezosOperationKind.origination.tag,
            TezosOriginationOperation.layout(),
          ),
          // 110
          UnionCase<TezosOperationContent>(
            TezosOperationKind.delegation.tag,
            TezosDelegationOperation.layout(),
          ),
          // 111
          UnionCase<TezosOperationContent>(
            TezosOperationKind.registerGlobalConstant.tag,
            TezosRegisterGlobalConstantOperation.layout(),
          ),
          // 112
          UnionCase<TezosOperationContent>(
            TezosOperationKind.setDepositsLimit.tag,
            TezosSetDepositsLimitOperation.layout(),
          ),
          // 113
          UnionCase<TezosOperationContent>(
            TezosOperationKind.increasePaidStorage.tag,
            TezosIncreasePaidStorageOperation.layout(),
          ),
          // 114
          UnionCase<TezosOperationContent>(
            TezosOperationKind.updateConsensusKey.tag,
            TezosUpdateConsensusKeyOperation.layout(),
          ),
          // 115
          UnionCase<TezosOperationContent>(
            TezosOperationKind.updateCompanionKey.tag,
            TezosUpdateCompanionKeyOperation.layout(),
          ),
          // 158
          UnionCase<TezosOperationContent>(
            TezosOperationKind.transferTicket.tag,
            TezosTransferTicketOperation.layout(),
          ),
          // 200
          UnionCase<TezosOperationContent>(
            TezosOperationKind.smartRollupOriginate.tag,
            TezosSmartRollupOriginateOperation.layout(),
          ),
          // 201
          UnionCase<TezosOperationContent>(
            TezosOperationKind.smartRollupAddMessages.tag,
            TezosSmartRollupAddMessagesOperation.layout(),
          ),
          // 202
          UnionCase<TezosOperationContent>(
            TezosOperationKind.smartRollupCement.tag,
            TezosSmartRollupCementOperation.layout(),
          ),
          // 203
          UnionCase<TezosOperationContent>(
            TezosOperationKind.smartRollupPublish.tag,
            TezosSmartRollupPublishOperation.layout(),
          ),
          // 204
          UnionCase<TezosOperationContent>(
            TezosOperationKind.smartRollupRefute.tag,
            TezosSmartRollupRefuteOperation.layout(),
          ),
          // 205
          UnionCase<TezosOperationContent>(
            TezosOperationKind.smartRollupTimeout.tag,
            TezosSmartRollupTimeoutOperation.layout(),
          ),
          // 206
          UnionCase<TezosOperationContent>(
            TezosOperationKind.smartRollupExecuteOutboxMessage.tag,
            TezosSmartRollupExecuteOutboxMessageOperation.layout(),
          ),
          // 207
          UnionCase<TezosOperationContent>(
            TezosOperationKind.smartRollupRecoverBond.tag,
            TezosSmartRollupRecoverBondOperation.layout(),
          ),
          // 250
          UnionCase<TezosOperationContent>(
            TezosOperationKind.zkRollupOperation.tag,
            TezosZkRollupOriginationOperation.layout(),
          ),
          // 251
          UnionCase<TezosOperationContent>(
            TezosOperationKind.zkRollupPublish.tag,
            TezosZkRollupPublishOperation.layout(),
          ),
          // 252
          UnionCase<TezosOperationContent>(
            TezosOperationKind.zkRollupUpdate.tag,
            TezosZkRollupUpdateOperation.layout(),
          ),
          // 2
          UnionCase<TezosOperationContent>(
            TezosOperationKind.doubleConsensusOperationEvidence.tag,
            TezosDoubleConsensusOperation.layout(),
          ),
          // 3
          UnionCase<TezosOperationContent>(
            TezosOperationKind.doubleBakingEvidence.tag,
            TezosDoubleBakingOperation.layout(),
          ),
          // 8
          UnionCase<TezosOperationContent>(
            TezosOperationKind.vdfRevelation.tag,
            TezosVdfRevelationOperation.layout(),
          ),
          // 24
          UnionCase<TezosOperationContent>(
            TezosOperationKind.dalEntrapmentEvidence.tag,
            TezosDalEntrapmentOperation.layout(),
          ),
          // 230
          UnionCase<TezosOperationContent>(
            TezosOperationKind.dalPublishCommitment.tag,
            TezosDalPublishCommitmentOperation.layout(),
          ),
        ],
      );

  @override
  Map<String, dynamic> toJson();

  @override
  List<int> serializeBytes() => toLayot().serialize(this);

  @override
  TaggedUnionLayout<TezosOperationContent> toVariantLayot() {
    return layout();
  }

  @override
  List<int> serializeVariantBytes() {
    return toVariantLayot().serialize(this);
  }

  @override
  String get varintName => type.operationName;

  @override
  Map<String, dynamic> toVariantJson() {
    return {"kind": varintName, ...toJson()};
  }
}

/// Manager ops: source, fee, counter, gas_limit, storage_limit.
sealed class TezosManagerOperationContent extends TezosOperationContent {
  TezosManagerOperationContent({
    required TezosOperationKind type,
    required TezosAddress source,
    required this.fee,
    required this.counter,
    required this.gasLimit,
    required this.storageLimit,
  }) : source = source.ensureIsPubAddress(),
       super(type);

  final TezosAddress source;
  final BigInt fee;
  final BigInt counter;
  final BigInt gasLimit;
  final BigInt storageLimit;

  /// Common manager JSON fields (source / fee / counters).
  @override
  Map<String, dynamic> toJson() => {
    'source': source.address,
    'fee': fee.toString(),
    'counter': counter.toString(),
    'gas_limit': gasLimit.toString(),
    'storage_limit': storageLimit.toString(),
  };

  TezosManagerOperationContent copyWith({
    TezosAddress? source,
    BigInt? fee,
    BigInt? counter,
    BigInt? gasLimit,
    BigInt? storageLimit,
  });
}

// APPROX: `id` is specifically Ed25519.Public_key_hash.encoding (raw 20-byte hash, NOT the 4-curve  TezosLayoutUtils.publicKeyHashLayout() union -- activate_account is Ed25519-only pre-genesis-migration accounts). activation_code width (20 bytes) assumed.
class TezosActivateAccountOperation extends TezosOperationContent {
  final TezosAddress pkh;
  final List<int> secret;
  TezosActivateAccountOperation({
    required TezosAddress pkh,
    required this.secret,
  }) : pkh = pkh.ensureIsAddress(XtzAddrPrefixes.tz1),
       super(TezosOperationKind.activeAccount);
  factory TezosActivateAccountOperation.deserialize(List<int> bytes) {
    final layout = TezosActivateAccountOperation.layout();
    return layout.deserialize(bytes).value;
  }
  factory TezosActivateAccountOperation.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return TezosActivateAccountOperation(
      pkh: TezosAddress(json.valueAsString("pkh")),
      secret: json.valueAsBytes("secret"),
    );
  }
  static Layout<TezosActivateAccountOperation> layout() =>
      ObjSeqLayout<TezosActivateAccountOperation>(
        [
          LayoutConst.fixedBlobN(20), // pkh,
          LayoutConst.fixedBlobN(20), // secret
        ],
        build:
            (v) => TezosActivateAccountOperation(
              pkh: TezosAddress.fromBytes(
                JsonParser.valueAsBytes(v[0]),
                type: XtzAddrPrefixes.tz1,
              ),
              secret: JsonParser.valueAsBytes(v[1]),
            ),
        unbuild: (v) => [v.pkh.hashBytes, v.secret],
      );

  @override
  Map<String, dynamic> toJson() {
    return {"pkh": pkh.address, "secret": BytesUtils.toHexString(secret)};
  }

  @override
  Layout<TezosActivateAccountOperation> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [type, pkh, secret];
}

class TezosConsensusContent extends OctezSerializable with Equality {
  final int slot; // Slot_repr.t -- assumed uint16
  final int level; // Raw_level_repr.t -- int32
  final int round; // Round_repr.t -- assumed int32
  final List<int> blockPayloadHash;

  TezosConsensusContent({
    required this.slot,
    required this.level,
    required this.round,
    required List<int> blockPayloadHash,
  }) : blockPayloadHash =
           blockPayloadHash
               .exc(
                 length: 32,
                 operation: "TezosConsensusContent",
                 reason: "Invalid public hash bytes length.",
               )
               .asImmutableBytes;
  factory TezosConsensusContent.fromJson(Map<String, dynamic> json) {
    return TezosConsensusContent(
      slot: json.valueAsInt("slot"),
      level: json.valueAsInt("level"),
      round: json.valueAsInt("round"),
      blockPayloadHash: TezosUtils.decodeValueHash(
        json.valueAsString("block_payload_hash"),
      ),
    );
  }
  factory TezosConsensusContent.deserialize(List<int> bytes) {
    return layout().deserialize(bytes).value;
  }

  static Layout<TezosConsensusContent> layout() =>
      ObjSeqLayout<TezosConsensusContent>(
        [
          TezosLayoutUtils.tzUint16, // slot -- APPROX width
          TezosLayoutUtils.tzInt32, // level
          TezosLayoutUtils.tzInt32, // round -- APPROX width
          LayoutConst.fixedBlobN(32), // block_payload_hash -- APPROX width
        ],
        build:
            (v) => TezosConsensusContent(
              slot: JsonParser.valueAsInt(v[0]),
              level: JsonParser.valueAsInt(v[1]),
              round: JsonParser.valueAsInt(v[2]),
              blockPayloadHash: JsonParser.valueAsBytes(v[3]),
            ),
        unbuild: (c) => [c.slot, c.level, c.round, c.blockPayloadHash],
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      "slot": slot,
      "level": level,
      "round": round,
      "block_payload_hash": TezosUtils.encodeValueHash(blockPayloadHash),
    };
  }

  @override
  Layout<dynamic> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [slot, level, round, blockPayloadHash];
}

class TezosAttestationOperation extends TezosOperationContent {
  final TezosConsensusContent consensusContent;

  TezosAttestationOperation({required this.consensusContent})
    : super(TezosOperationKind.attestation);
  factory TezosAttestationOperation.deserializeJson(Map<String, dynamic> json) {
    return TezosAttestationOperation(
      consensusContent: TezosConsensusContent.fromJson(json),
    );
  }
  factory TezosAttestationOperation.deserialize(List<int> bytes) {
    return TezosAttestationOperation(
      consensusContent: TezosConsensusContent.deserialize(bytes),
    );
  }
  static Layout<TezosAttestationOperation> layout() =>
      ObjSeqLayout<TezosAttestationOperation>(
        [TezosConsensusContent.layout()],
        build:
            (v) => TezosAttestationOperation(
              consensusContent: v[0] as TezosConsensusContent,
            ),
        unbuild: (v) => [v.consensusContent],
      );

  @override
  Layout<TezosAttestationOperation> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [consensusContent];

  @override
  Map<String, dynamic> toJson() {
    return consensusContent.toJson();
  }
}

class TezosConsensusAggregateContent extends OctezSerializable with Equality {
  final int level;
  final int round;
  final List<int> blockPayloadHash;

  TezosConsensusAggregateContent({
    required this.level,
    required this.round,
    required this.blockPayloadHash,
  });
  factory TezosConsensusAggregateContent.fromJson(Map<String, dynamic> json) =>
      TezosConsensusAggregateContent(
        level: json.valueAs("level"),
        round: json.valueAs("round"),
        blockPayloadHash: TezosUtils.decodeValueHash(
          json.valueAs("block_payload_hash"),
        ),
      );
  static Layout<TezosConsensusAggregateContent> layout() =>
      ObjSeqLayout<TezosConsensusAggregateContent>(
        [
          TezosLayoutUtils.tzInt32, // level
          TezosLayoutUtils.tzInt32, // round -- APPROX width
          LayoutConst.fixedBlobN(32), // block_payload_hash -- APPROX width
        ],
        build:
            (v) => TezosConsensusAggregateContent(
              level: v[0] as int,
              round: v[1] as int,
              blockPayloadHash: v[2] as List<int>,
            ),
        unbuild: (c) => [c.level, c.round, c.blockPayloadHash],
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      "level": level,
      "round": round,
      "block_payload_hash": TezosUtils.encodeValueHash(blockPayloadHash),
    };
  }

  @override
  Layout<dynamic> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [level, round, blockPayloadHash];
}

class TezosAggregateCommitteeMember extends OctezSerializable with Equality {
  final int slot;
  final BigInt? dalTezosAttestationOperation;
  TezosAggregateCommitteeMember({
    required this.slot,
    required this.dalTezosAttestationOperation,
  });
  factory TezosAggregateCommitteeMember.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return TezosAggregateCommitteeMember(
      slot: json.valueAsInt("slot"),
      dalTezosAttestationOperation: json.valueAsBigInt("dal_attestation"),
    );
  }

  static Layout<TezosAggregateCommitteeMember> layout() =>
      ObjSeqLayout<TezosAggregateCommitteeMember>(
        [
          TezosLayoutUtils.tzUint16,
          TezosLayoutUtils.optionLayout(TezosLayoutUtils.tzZ),
        ],
        build:
            (v) => TezosAggregateCommitteeMember(
              slot: v[0] as int,
              dalTezosAttestationOperation: v[1] as BigInt?,
            ),
        unbuild: (m) => [m.slot, m.dalTezosAttestationOperation],
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      "slot": slot,
      "dal_attestation": dalTezosAttestationOperation?.toString(),
    }.notNullValue;
  }

  @override
  Layout<dynamic> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [slot, dalTezosAttestationOperation];
}

// // APPROX: Same remainder-list caveat as preattestations_aggregate, plus TezosAggregateCommitteeMember's dal_attestation field shape is a guess.
class TezosAttestationOperationsAggregateOperation
    extends TezosOperationContent {
  final TezosConsensusAggregateContent consensusContent;
  final List<TezosAggregateCommitteeMember> committee;

  TezosAttestationOperationsAggregateOperation({
    required this.consensusContent,
    required this.committee,
  }) : super(TezosOperationKind.attestationsAggregate);

  factory TezosAttestationOperationsAggregateOperation.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return TezosAttestationOperationsAggregateOperation(
      consensusContent: TezosConsensusAggregateContent.fromJson(
        json.valueEnsureAsMap("consensus_content"),
      ),
      committee:
          json
              .valueEnsureAsList<Map<String, dynamic>>("committee")
              .map(TezosAggregateCommitteeMember.deserializeJson)
              .toList(),
    );
  }

  static Layout<TezosAttestationOperationsAggregateOperation> layout() =>
      ObjSeqLayout<TezosAttestationOperationsAggregateOperation>(
        [
          TezosConsensusAggregateContent.layout(), // consensus_content,
          DynamicSizeLayout(
            RemainderListLayout(TezosAggregateCommitteeMember.layout()),
          ), // committee
        ],
        build:
            (v) => TezosAttestationOperationsAggregateOperation(
              consensusContent: v[0] as TezosConsensusAggregateContent,
              committee: v[1] as List<TezosAggregateCommitteeMember>,
            ),
        unbuild: (v) => [v.consensusContent, v.committee],
      );

  @override
  Layout<TezosAttestationOperationsAggregateOperation> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [consensusContent, committee];

  @override
  Map<String, dynamic> toJson() {
    return {
      "consensus_content": consensusContent.toJson(),
      "committee": committee.map((e) => e.toJson()).toList(),
    };
  }
}

enum TezosBallotVote {
  yay("yay"),
  nay("nay"),
  pass("pass");

  final String value;
  const TezosBallotVote(this.value);
  static Layout<TezosBallotVote> layout() => ConvLayout<TezosBallotVote, int>(
    TezosLayoutUtils.tzUint8,
    toWire: (b) => b.index,
    fromWire: (i) => TezosBallotVote.values[i],
  );
  static TezosBallotVote fromValue(String? value) {
    return TezosBallotVote.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw OnChainErrors.tezosPlugin(
                "TezosBallotVote.lookup",
                reason: "Invalid TezosBallotVote.",
                details: {"value": "$value"},
              ),
    );
  }
}

// APPROX: TezosBallotOperation enum tag order (Yay=0/Nay=1/Pass=2) assumed; verify against Vote_repr.ballot_encoding.
class TezosBallotOperation extends TezosOperationContent {
  final TezosAddress source;
  final int period;
  final List<int> proposal;
  final TezosBallotVote ballot;

  TezosBallotOperation({
    required TezosAddress source,
    required this.period,
    required List<int> proposal,
    required this.ballot,
  }) : proposal =
           proposal
               .exc(
                 length: QuickCrypto.blake2b256DigestSize,
                 operation: "TezosBallotOperation",
                 name: "Invalid proposal hash length.",
               )
               .asImmutableBytes,
       source = source.ensureIsPubAddress(),
       super(TezosOperationKind.ballot);

  factory TezosBallotOperation.deserializeJson(Map<String, dynamic> json) {
    return TezosBallotOperation(
      source: TezosAddress(json.valueAsString("source")),
      period: json.valueAsInt("period"),
      proposal: TezosUtils.decodeProtocol(json.valueAsString("proposal")),
      ballot: TezosBallotVote.fromValue(json.valueAsString("ballot")),
    );
  }

  static Layout<TezosBallotOperation> layout() =>
      ObjSeqLayout<TezosBallotOperation>(
        [
          TezosLayoutUtils.publicKeyHashLayout(), // source,
          TezosLayoutUtils.tzInt32, // period,
          LayoutConst.fixedBlobN(32), // proposal,
          TezosBallotVote.layout(), // ballot
        ],
        build:
            (v) => TezosBallotOperation(
              source: v[0] as TezosAddress,
              period: v[1] as int,
              proposal: v[2] as List<int>,
              ballot: v[3] as TezosBallotVote,
            ),
        unbuild: (v) => [v.source, v.period, v.proposal, v.ballot],
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      "source": source.address,
      "period": period,
      "proposal": TezosUtils.encodeProtocol(proposal),
      "ballot": ballot.name,
    };
  }

  @override
  Layout<TezosBallotOperation> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [source, period, proposal, ballot];
}

// APPROX: gas_limit/storage_limit are wrapped in `check_size 10` in the .ml (a decode-time bound, not a shape change) -- not enforced here.
class TezosDelegationOperation extends TezosManagerOperationContent {
  final TezosAddress? delegate;

  TezosDelegationOperation({
    required super.source,
    required super.fee,
    required super.counter,
    required super.gasLimit,
    required super.storageLimit,
    required TezosAddress? delegate,
  }) : delegate = delegate?.ensureIsPubAddress(),
       super(type: TezosOperationKind.delegation);
  factory TezosDelegationOperation.deserialize(List<int> bytes) {
    return layout().deserialize(bytes).value;
  }
  factory TezosDelegationOperation.deserializeJson(Map<String, dynamic> json) {
    return TezosDelegationOperation(
      source: TezosAddress(json.valueAsString("source")),
      fee: json.valueAsBigInt("fee"),
      counter: json.valueAsBigInt("counter"),
      gasLimit: json.valueAsBigInt("gas_limit"),
      storageLimit: json.valueAsBigInt("storage_limit"),
      delegate: json.valueTo<TezosAddress?, String>(
        key: "delegate",
        parse: TezosAddress.new,
      ),
    );
  }

  static Layout<TezosDelegationOperation> layout() =>
      ObjSeqLayout<TezosDelegationOperation>(
        [
          TezosLayoutUtils.publicKeyHashLayout(), // source,
          TezosLayoutUtils.tzNat, // fee,
          TezosLayoutUtils.tzNat, // counter,
          TezosLayoutUtils.tzNat, // gas_limit,
          TezosLayoutUtils.tzNat, // storage_limit,
          TezosLayoutUtils.optionLayout(
            TezosLayoutUtils.publicKeyHashLayout(),
          ), // delegate
        ],
        build:
            (v) => TezosDelegationOperation(
              source: v[0] as TezosAddress,
              fee: v[1] as BigInt,
              counter: v[2] as BigInt,
              gasLimit: v[3] as BigInt,
              storageLimit: v[4] as BigInt,
              delegate: v[5] as TezosAddress?,
            ),
        unbuild:
            (v) => [
              v.source,
              v.fee,
              v.counter,
              v.gasLimit,
              v.storageLimit,
              v.delegate,
            ],
      );

  @override
  Layout<TezosDelegationOperation> toLayot() {
    return layout();
  }

  @override
  Map<String, dynamic> toJson() {
    return {...super.toJson(), "delegate": delegate?.address}.notNullValue;
  }

  @override
  List<dynamic> get variables => [
    source,
    fee,
    counter,
    gasLimit,
    storageLimit,
    delegate,
  ];

  @override
  TezosDelegationOperation copyWith({
    TezosAddress? source,
    BigInt? fee,
    BigInt? counter,
    BigInt? gasLimit,
    BigInt? storageLimit,
    TezosAddress? delegate,
  }) {
    return TezosDelegationOperation(
      source: source ?? this.source,
      fee: fee ?? this.fee,
      counter: counter ?? this.counter,
      gasLimit: gasLimit ?? this.gasLimit,
      storageLimit: storageLimit ?? this.storageLimit,
      delegate: delegate ?? this.delegate,
    );
  }
}

class TezosDrainDelegateOperation extends TezosOperationContent {
  final TezosAddress consensusKey;
  final TezosAddress delegate;
  final TezosAddress destination;
  factory TezosDrainDelegateOperation.deserialize(List<int> bytes) {
    return layout().deserialize(bytes).value;
  }
  factory TezosDrainDelegateOperation.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return TezosDrainDelegateOperation(
      consensusKey: TezosAddress(json.valueAsString("consensus_key")),
      delegate: TezosAddress(json.valueAsString("delegate")),
      destination: TezosAddress(json.valueAsString("destination")),
    );
  }
  TezosDrainDelegateOperation({
    required TezosAddress consensusKey,
    required TezosAddress delegate,
    required TezosAddress destination,
  }) : consensusKey = consensusKey.ensureIsPubAddress(),
       delegate = delegate.ensureIsPubAddress(),
       destination = destination.ensureIsPubAddress(),
       super(TezosOperationKind.drainDelegate);

  static Layout<TezosDrainDelegateOperation> layout() =>
      ObjSeqLayout<TezosDrainDelegateOperation>(
        [
          TezosLayoutUtils.publicKeyHashLayout(), // consensus_key,
          TezosLayoutUtils.publicKeyHashLayout(), // delegate,
          TezosLayoutUtils.publicKeyHashLayout(), // destination
        ],
        build:
            (v) => TezosDrainDelegateOperation(
              consensusKey: v[0] as TezosAddress,
              delegate: v[1] as TezosAddress,
              destination: v[2] as TezosAddress,
            ),
        unbuild: (v) => [v.consensusKey, v.delegate, v.destination],
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      "consensus_key": consensusKey.address,
      "delegate": delegate.address,
      "destination": destination.address,
    };
  }

  @override
  Layout<TezosDrainDelegateOperation> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [consensusKey, delegate, destination];
}

// APPROX: gas_limit/storage_limit are wrapped in `check_size 10` in the .ml (a decode-time bound, not a shape change) -- not enforced here. Also: Tez_repr encodes as N (nat); confirm mutez vs tez scaling.
class TezosSetDepositsLimitOperation extends TezosManagerOperationContent {
  final BigInt? limit;

  TezosSetDepositsLimitOperation({
    required super.source,
    required super.fee,
    required super.counter,
    required super.gasLimit,
    required super.storageLimit,
    required this.limit,
  }) : super(type: TezosOperationKind.setDepositsLimit);
  factory TezosSetDepositsLimitOperation.deserialize(List<int> bytes) {
    return layout().deserialize(bytes).value;
  }
  factory TezosSetDepositsLimitOperation.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return TezosSetDepositsLimitOperation(
      source: TezosAddress(json.valueAsString("source")),
      fee: json.valueAsBigInt("fee"),
      counter: json.valueAsBigInt("counter"),
      gasLimit: json.valueAsBigInt("gas_limit"),
      storageLimit: json.valueAsBigInt("storage_limit"),
      limit: json.valueAsBigInt("limit"),
    );
  }
  static Layout<TezosSetDepositsLimitOperation> layout() =>
      ObjSeqLayout<TezosSetDepositsLimitOperation>(
        [
          TezosLayoutUtils.publicKeyHashLayout(),
          TezosLayoutUtils.tzNat,
          TezosLayoutUtils.tzNat,
          TezosLayoutUtils.tzNat,
          TezosLayoutUtils.tzNat,
          TezosLayoutUtils.optionLayout(TezosLayoutUtils.tzNat),
        ],
        build:
            (v) => TezosSetDepositsLimitOperation(
              source: v[0] as TezosAddress,
              fee: v[1] as BigInt,
              counter: v[2] as BigInt,
              gasLimit: v[3] as BigInt,
              storageLimit: v[4] as BigInt,
              limit: v[5] as BigInt?,
            ),
        unbuild:
            (v) => [
              v.source,
              v.fee,
              v.counter,
              v.gasLimit,
              v.storageLimit,
              v.limit,
            ],
      );

  @override
  Layout<TezosSetDepositsLimitOperation> toLayot() {
    return layout();
  }

  @override
  Map<String, dynamic> toJson() {
    return {...super.toJson(), "limit": limit?.toString()}.notNullValue;
  }

  @override
  List<dynamic> get variables => [
    source,
    fee,
    counter,
    gasLimit,
    storageLimit,
    limit,
  ]; // "set_deposits_limit" in operation_repr.ml

  @override
  TezosSetDepositsLimitOperation copyWith({
    TezosAddress? source,
    BigInt? fee,
    BigInt? counter,
    BigInt? gasLimit,
    BigInt? storageLimit,
    BigInt? limit,
  }) {
    return TezosSetDepositsLimitOperation(
      source: source ?? this.source,
      fee: fee ?? this.fee,
      counter: counter ?? this.counter,
      gasLimit: gasLimit ?? this.gasLimit,
      storageLimit: storageLimit ?? this.storageLimit,
      limit: limit ?? this.limit,
    );
  }
}

// APPROX: gas_limit/storage_limit are wrapped in `check_size 10` in the .ml (a decode-time bound, not a shape change) -- not enforced here. Also: destination width (Contract_hash, no tag byte assumed) not independently confirmed.
class TezosIncreasePaidStorageOperation extends TezosManagerOperationContent {
  final BigInt amount;
  final TezosAddress destination;

  TezosIncreasePaidStorageOperation({
    required super.source,
    required super.fee,
    required super.counter,
    required super.gasLimit,
    required super.storageLimit,
    required this.amount,
    required TezosAddress destination,
  }) : destination = destination.ensureIsContractAddress(),
       super(type: TezosOperationKind.increasePaidStorage);
  factory TezosIncreasePaidStorageOperation.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return TezosIncreasePaidStorageOperation(
      source: TezosAddress(json.valueAsString("source")),
      fee: json.valueAsBigInt("fee"),
      counter: json.valueAsBigInt("counter"),
      gasLimit: json.valueAsBigInt("gas_limit"),
      storageLimit: json.valueAsBigInt("storage_limit"),
      amount: json.valueAsBigInt("amount"),
      destination: TezosAddress(json.valueAsString("destination")),
    );
  }
  static Layout<TezosIncreasePaidStorageOperation> layout() =>
      ObjSeqLayout<TezosIncreasePaidStorageOperation>(
        [
          TezosLayoutUtils.publicKeyHashLayout(), // source,
          TezosLayoutUtils.tzNat, // fee,
          TezosLayoutUtils.tzNat, // counter,
          TezosLayoutUtils.tzNat, // gas_limit,
          TezosLayoutUtils.tzNat, // storage_limit,
          TezosLayoutUtils.tzZ, // amount_in_bytes,
          LayoutConst.fixedBlobN(22), // destination
        ],
        build:
            (v) => TezosIncreasePaidStorageOperation(
              source: v[0] as TezosAddress,
              fee: v[1] as BigInt,
              counter: v[2] as BigInt,
              gasLimit: v[3] as BigInt,
              storageLimit: v[4] as BigInt,
              amount: v[5] as BigInt,
              destination: TezosUtils.decodeDestinationAddr(v[6] as List<int>),
            ),
        unbuild:
            (v) => [
              v.source,
              v.fee,
              v.counter,
              v.gasLimit,
              v.storageLimit,
              v.amount,
              TezosUtils.encodeDestinationAddr(v.destination),
            ],
      );

  @override
  Layout<TezosIncreasePaidStorageOperation> toLayot() {
    return layout();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),

      "amount": amount.toString(),
      "destination": destination.address,
    }.notNullValue;
  }

  @override
  List<dynamic> get variables => [
    source,
    fee,
    counter,
    gasLimit,
    storageLimit,
    amount,
    destination,
  ];

  @override
  TezosIncreasePaidStorageOperation copyWith({
    TezosAddress? source,
    BigInt? fee,
    BigInt? counter,
    BigInt? gasLimit,
    BigInt? storageLimit,
    BigInt? amount,
    TezosAddress? destination,
  }) {
    return TezosIncreasePaidStorageOperation(
      source: source ?? this.source,
      fee: fee ?? this.fee,
      counter: counter ?? this.counter,
      gasLimit: gasLimit ?? this.gasLimit,
      storageLimit: storageLimit ?? this.storageLimit,
      amount: amount ?? this.amount,
      destination: destination ?? this.destination,
    );
  }
}

// APPROX: gas_limit/storage_limit are wrapped in `check_size 10` in the .ml (a decode-time bound, not a shape change) -- not enforced here. Also: lazy_expr ~= length-prefixed raw MichelineExpr bytes, not independently verified.
class TezosRegisterGlobalConstantOperation
    extends TezosManagerOperationContent {
  final MichelineExpr value;

  TezosRegisterGlobalConstantOperation({
    required super.source,
    required super.fee,
    required super.counter,
    required super.gasLimit,
    required super.storageLimit,
    required this.value,
  }) : super(type: TezosOperationKind.registerGlobalConstant);

  factory TezosRegisterGlobalConstantOperation.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return TezosRegisterGlobalConstantOperation(
      source: TezosAddress(json.valueAsString("source")),
      fee: json.valueAsBigInt("fee"),
      counter: json.valueAsBigInt("counter"),
      gasLimit: json.valueAsBigInt("gas_limit"),
      storageLimit: json.valueAsBigInt("storage_limit"),
      value: MichelineExpr.deserializeJson(json.valueAs("value")),
    );
  }

  static Layout<TezosRegisterGlobalConstantOperation> layout() =>
      ObjSeqLayout<TezosRegisterGlobalConstantOperation>(
        [
          TezosLayoutUtils.publicKeyHashLayout(), // source,
          TezosLayoutUtils.tzNat, // fee,
          TezosLayoutUtils.tzNat, // counter,
          TezosLayoutUtils.tzNat, // gas_limit,
          TezosLayoutUtils.tzNat, // storage_limit,
          const DynamicBytesLayout(),
        ],
        build:
            (v) => TezosRegisterGlobalConstantOperation(
              source: v[0] as TezosAddress,
              fee: v[1] as BigInt,
              counter: v[2] as BigInt,
              gasLimit: v[3] as BigInt,
              storageLimit: v[4] as BigInt,
              value: MichelineExpr.deserialize(v[5]),
            ),
        unbuild:
            (v) => [
              v.source,
              v.fee,
              v.counter,
              v.gasLimit,
              v.storageLimit,
              v.value.serializeBytes(),
            ],
      );

  @override
  List<dynamic> get variables => [
    source,
    fee,
    counter,
    gasLimit,
    storageLimit,
    value,
  ];

  @override
  Layout<TezosRegisterGlobalConstantOperation> toLayot() {
    return layout();
  }

  @override
  Map<String, dynamic> toJson() {
    return {...super.toJson(), "value": value.toJson()}.notNullValue;
  }

  @override
  TezosRegisterGlobalConstantOperation copyWith({
    TezosAddress? source,
    BigInt? fee,
    BigInt? counter,
    BigInt? gasLimit,
    BigInt? storageLimit,
    MichelineExpr? value,
  }) {
    return TezosRegisterGlobalConstantOperation(
      source: source ?? this.source,
      fee: fee ?? this.fee,
      counter: counter ?? this.counter,
      gasLimit: gasLimit ?? this.gasLimit,
      storageLimit: storageLimit ?? this.storageLimit,
      value: value ?? this.value,
    );
  }
}

// APPROX: gas_limit/storage_limit are wrapped in `check_size 10` in the .ml
// (a decode-time bound, not a shape change) -- not enforced here.
// Also: parameters collapses (entrypoint, value) into one opaque blob --
// Entrypoint_repr.smart_encoding not modeled.
class TezosTransactionOperation extends TezosManagerOperationContent {
  final BigInt amount;
  final TezosAddress destination;
  final TezosContractParameters? parameters;

  TezosTransactionOperation({
    required super.source,
    required super.fee,
    required super.counter,
    required super.gasLimit,
    required super.storageLimit,
    required this.amount,
    required this.destination,
    required this.parameters,
  }) : super(type: TezosOperationKind.transaction);

  factory TezosTransactionOperation.deserializeJson(Map<String, dynamic> json) {
    return TezosTransactionOperation(
      source: TezosAddress(json.valueAsString("source")),
      fee: json.valueAsBigInt("fee"),
      counter: json.valueAsBigInt("counter"),
      gasLimit: json.valueAsBigInt("gas_limit"),
      storageLimit: json.valueAsBigInt("storage_limit"),
      amount: json.valueAsBigInt("amount"),
      destination: TezosAddress(json.valueAsString("destination")),
      parameters: json.valueTo<TezosContractParameters?, Map<String, dynamic>>(
        key: "parameters",
        parse: TezosContractParameters.deserializeJson,
      ),
    );
  }

  static Layout<TezosTransactionOperation> layout() =>
      ObjSeqLayout<TezosTransactionOperation>(
        [
          TezosLayoutUtils.publicKeyHashLayout(), // source,
          TezosLayoutUtils.tzNat, // fee,
          TezosLayoutUtils.tzNat, // counter,
          TezosLayoutUtils.tzNat, // gas_limit,
          TezosLayoutUtils.tzNat, // storage_limit,
          TezosLayoutUtils.tzNat, // amount,
          LayoutConst.fixedBlobN(22), // destination,
          TezosLayoutUtils.optionLayout(
            TezosContractParameters.layout(),
          ), // parameters
        ],
        build:
            (v) => TezosTransactionOperation(
              source: v[0] as TezosAddress,
              fee: v[1] as BigInt,
              counter: v[2] as BigInt,
              gasLimit: v[3] as BigInt,
              storageLimit: v[4] as BigInt,
              amount: v[5] as BigInt,
              destination: TezosUtils.decodeDestinationAddr(v[6] as List<int>),
              parameters: v[7] as TezosContractParameters?,
            ),
        unbuild: (v) {
          final isDefaultParams = v.parameters?.isDefault() ?? true;
          return [
            v.source,
            v.fee,
            v.counter,
            v.gasLimit,
            v.storageLimit,
            v.amount,
            TezosUtils.encodeDestinationAddr(v.destination),
            isDefaultParams ? null : v.parameters,
          ];
        },
      );

  @override
  List<dynamic> get variables => [
    source,
    fee,
    counter,
    gasLimit,
    storageLimit,
    amount,
    destination,
    parameters,
  ];

  @override
  Layout<TezosTransactionOperation> toLayot() {
    return layout();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),

      "amount": amount.toString(),
      "destination": destination.address,
      "parameters": parameters?.toJson(),
    }.notNullValue;
  }

  @override
  TezosTransactionOperation copyWith({
    TezosAddress? source,
    BigInt? fee,
    BigInt? counter,
    BigInt? gasLimit,
    BigInt? storageLimit,
    BigInt? amount,
    TezosAddress? destination,
    TezosContractParameters? parameters,
  }) {
    return TezosTransactionOperation(
      source: source ?? this.source,
      fee: fee ?? this.fee,
      counter: counter ?? this.counter,
      gasLimit: gasLimit ?? this.gasLimit,
      storageLimit: storageLimit ?? this.storageLimit,
      amount: amount ?? this.amount,
      destination: destination ?? this.destination,
      parameters: parameters ?? this.parameters,
    );
  }
}

// APPROX: gas_limit/storage_limit are wrapped in `check_size 10` in the .ml (a decode-time bound, not a shape change) -- not enforced here.
class TezosRevealOperation extends TezosManagerOperationContent {
  final TezosPublicKey publicKey;
  final TezosBlsSignature? proof;

  TezosRevealOperation({
    required super.source,
    required super.fee,
    required super.counter,
    required super.gasLimit,
    required super.storageLimit,
    required this.publicKey,
    required this.proof,
  }) : super(type: TezosOperationKind.reveal);

  factory TezosRevealOperation.deserializeJson(Map<String, dynamic> json) {
    return TezosRevealOperation(
      source: TezosAddress(json.valueAsString("source")),
      fee: json.valueAsBigInt("fee"),
      counter: json.valueAsBigInt("counter"),
      gasLimit: json.valueAsBigInt("gas_limit"),
      storageLimit: json.valueAsBigInt("storage_limit"),

      proof: json.valueTo<TezosBlsSignature?, String>(
        key: "proof",
        parse: TezosBlsSignature.decode,
      ),
      publicKey: TezosPublicKey.decode(json.valueAsString("public_key")),
    );
  }

  static Layout<TezosRevealOperation> layout() =>
      ObjSeqLayout<TezosRevealOperation>(
        [
          TezosLayoutUtils.publicKeyHashLayout(), // source,
          TezosLayoutUtils.tzNat, // fee,
          TezosLayoutUtils.tzNat, // counter,
          TezosLayoutUtils.tzNat, // gas_limit,
          TezosLayoutUtils.tzNat, // storage_limit,
          TezosLayoutUtils.publicKeyLayout(), // public_key,
          TezosLayoutUtils.optionLayout(
            DynamicSizeLayout(
              LayoutConst.fixedBlobN(TezosKeyType.bls.signatureLength),
            ),
          ), // proof
        ],
        build: (v) {
          final proof = v[6] as List<int>?;
          return TezosRevealOperation(
            source: v[0] as TezosAddress,
            fee: v[1] as BigInt,
            counter: v[2] as BigInt,
            gasLimit: v[3] as BigInt,
            storageLimit: v[4] as BigInt,
            publicKey: v[5] as TezosPublicKey,
            proof: proof == null ? null : TezosBlsSignature(proof),
          );
        },
        unbuild:
            (v) => [
              v.source,
              v.fee,
              v.counter,
              v.gasLimit,
              v.storageLimit,
              v.publicKey,
              v.proof?.bytes,
            ],
      );

  @override
  Layout<TezosRevealOperation> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [
    source,
    fee,
    counter,
    gasLimit,
    storageLimit,
    publicKey,
    proof,
  ];

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),

      "public_key": publicKey.encode(),
      "proof": proof?.encode(),
    }.notNullValue;
  }

  @override
  TezosRevealOperation copyWith({
    TezosAddress? source,
    BigInt? fee,
    BigInt? counter,
    BigInt? gasLimit,
    BigInt? storageLimit,
    TezosPublicKey? publicKey,
    TezosBlsSignature? proof,
  }) {
    return TezosRevealOperation(
      source: source ?? this.source,
      fee: fee ?? this.fee,
      counter: counter ?? this.counter,
      gasLimit: gasLimit ?? this.gasLimit,
      storageLimit: storageLimit ?? this.storageLimit,
      publicKey: publicKey ?? this.publicKey,
      proof: proof ?? this.proof,
    );
  }
}

// APPROX: gas_limit/storage_limit are wrapped in `check_size 10` in the .ml (a decode-time bound, not a shape change) -- not enforced here. Also: `kind = Consensus` is fixed by tag 114 vs 115, not a field.
class TezosUpdateConsensusKeyOperation extends TezosManagerOperationContent {
  final TezosPublicKey publicKey;
  final TezosBlsSignature? proof;

  TezosUpdateConsensusKeyOperation({
    required super.source,
    required super.fee,
    required super.counter,
    required super.gasLimit,
    required super.storageLimit,
    required this.publicKey,
    required this.proof,
  }) : super(type: TezosOperationKind.updateConsensusKey);
  factory TezosUpdateConsensusKeyOperation.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return TezosUpdateConsensusKeyOperation(
      source: TezosAddress(json.valueAsString("source")),
      fee: json.valueAsBigInt("fee"),
      counter: json.valueAsBigInt("counter"),
      gasLimit: json.valueAsBigInt("gas_limit"),
      storageLimit: json.valueAsBigInt("storage_limit"),

      proof: json.valueTo<TezosBlsSignature?, String>(
        key: "proof",
        parse: TezosBlsSignature.decode,
      ),
      publicKey: TezosPublicKey.decode(json.valueAsString("pk")),
    );
  }
  static Layout<TezosUpdateConsensusKeyOperation> layout() =>
      ObjSeqLayout<TezosUpdateConsensusKeyOperation>(
        [
          TezosLayoutUtils.publicKeyHashLayout(), // source,
          TezosLayoutUtils.tzNat, // fee,
          TezosLayoutUtils.tzNat, // counter,
          TezosLayoutUtils.tzNat, // gas_limit,
          TezosLayoutUtils.tzNat, // storage_limit,
          TezosLayoutUtils.publicKeyLayout(), // pk,
          TezosLayoutUtils.optionLayout(
            DynamicSizeLayout(
              LayoutConst.fixedBlobN(TezosKeyType.bls.signatureLength),
            ),
          ), // proof
        ],
        build: (v) {
          final proof = v[6] as List<int>?;
          return TezosUpdateConsensusKeyOperation(
            source: v[0] as TezosAddress,
            fee: v[1] as BigInt,
            counter: v[2] as BigInt,
            gasLimit: v[3] as BigInt,
            storageLimit: v[4] as BigInt,
            publicKey: v[5] as TezosPublicKey,
            proof: proof == null ? null : TezosBlsSignature(proof),
          );
        },
        unbuild:
            (v) => [
              v.source,
              v.fee,
              v.counter,
              v.gasLimit,
              v.storageLimit,
              v.publicKey,
              v.proof?.bytes,
            ],
      );

  @override
  Layout<TezosUpdateConsensusKeyOperation> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [
    source,
    fee,
    counter,
    gasLimit,
    storageLimit,
    publicKey,
    proof,
  ];

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),

      "pk": publicKey.encode(),
      "proof": proof?.encode(),
    }.notNullValue;
  }

  @override
  TezosUpdateConsensusKeyOperation copyWith({
    TezosAddress? source,
    BigInt? fee,
    BigInt? counter,
    BigInt? gasLimit,
    BigInt? storageLimit,
    TezosPublicKey? publicKey,
    TezosBlsSignature? proof,
  }) {
    return TezosUpdateConsensusKeyOperation(
      source: source ?? this.source,
      fee: fee ?? this.fee,
      counter: counter ?? this.counter,
      gasLimit: gasLimit ?? this.gasLimit,
      storageLimit: storageLimit ?? this.storageLimit,
      publicKey: publicKey ?? this.publicKey,
      proof: proof ?? this.proof,
    );
  }
}

// // APPROX: gas_limit/storage_limit are wrapped in `check_size 10` in the .ml (a decode-time bound, not a shape change) -- not enforced here. Also: `kind = Companion` is fixed by tag 115, not a field.
class TezosUpdateCompanionKeyOperation extends TezosManagerOperationContent {
  final TezosPublicKey publicKey;
  final TezosBlsSignature? proof;

  TezosUpdateCompanionKeyOperation({
    required super.source,
    required super.fee,
    required super.counter,
    required super.gasLimit,
    required super.storageLimit,
    required this.publicKey,
    required this.proof,
  }) : super(type: TezosOperationKind.updateCompanionKey);
  factory TezosUpdateCompanionKeyOperation.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return TezosUpdateCompanionKeyOperation(
      source: TezosAddress(json.valueAsString("source")),
      fee: json.valueAsBigInt("fee"),
      counter: json.valueAsBigInt("counter"),
      gasLimit: json.valueAsBigInt("gas_limit"),
      storageLimit: json.valueAsBigInt("storage_limit"),

      proof: json.valueTo<TezosBlsSignature?, String>(
        key: "proof",
        parse: TezosBlsSignature.decode,
      ),
      publicKey: TezosPublicKey.decode(json.valueAsString("pk")),
    );
  }
  static Layout<TezosUpdateCompanionKeyOperation> layout() =>
      ObjSeqLayout<TezosUpdateCompanionKeyOperation>(
        [
          TezosLayoutUtils.publicKeyHashLayout(), // source,
          TezosLayoutUtils.tzNat, // fee,
          TezosLayoutUtils.tzNat, // counter,
          TezosLayoutUtils.tzNat, // gas_limit,
          TezosLayoutUtils.tzNat, // storage_limit,
          TezosLayoutUtils.publicKeyLayout(), // pk,
          TezosLayoutUtils.optionLayout(
            DynamicSizeLayout(
              LayoutConst.fixedBlobN(TezosKeyType.bls.signatureLength),
            ),
          ), // proof
        ],
        build: (v) {
          final proof = v[6] as List<int>?;
          return TezosUpdateCompanionKeyOperation(
            source: v[0] as TezosAddress,
            fee: v[1] as BigInt,
            counter: v[2] as BigInt,
            gasLimit: v[3] as BigInt,
            storageLimit: v[4] as BigInt,
            publicKey: v[5] as TezosPublicKey,
            proof: proof == null ? null : TezosBlsSignature(proof),
          );
        },
        unbuild:
            (v) => [
              v.source,
              v.fee,
              v.counter,
              v.gasLimit,
              v.storageLimit,
              v.publicKey,
              v.proof?.bytes,
            ],
      );

  @override
  Layout<TezosUpdateCompanionKeyOperation> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [
    source,
    fee,
    counter,
    gasLimit,
    storageLimit,
    publicKey,
    proof,
  ];

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),

      "pk": publicKey.encode(),
      "proof": proof?.encode(),
    }.notNullValue;
  }

  @override
  TezosUpdateCompanionKeyOperation copyWith({
    TezosAddress? source,
    BigInt? fee,
    BigInt? counter,
    BigInt? gasLimit,
    BigInt? storageLimit,
    TezosPublicKey? publicKey,
    TezosBlsSignature? proof,
  }) {
    return TezosUpdateCompanionKeyOperation(
      source: source ?? this.source,
      fee: fee ?? this.fee,
      counter: counter ?? this.counter,
      gasLimit: gasLimit ?? this.gasLimit,
      storageLimit: storageLimit ?? this.storageLimit,
      publicKey: publicKey ?? this.publicKey,
      proof: proof ?? this.proof,
    );
  }
}
// // ---------------------------------------------------------------------------
// // Vote_repr.ballot = Yay | Nay | Pass
// //
// // Tag order/values (0/1/2) assumed from declaration order via
// // Data_encoding.string_enum's usual binary numbering -- verify against
// // Vote_repr.ballot_encoding directly; string_enum's binary tag size also
// // depends on the number of cases and isn't necessarily a single byte for
// // every string_enum in general, though for a 3-case enum it will be.
// // ---------------------------------------------------------------------------

// APPROX: consensus_content field widths (slot/round/hash) are best-guess; see tezos_consensus_content.dart.
class TezosPreattestationOperation extends TezosOperationContent {
  final TezosConsensusContent consensusContent;

  TezosPreattestationOperation({required this.consensusContent})
    : super(TezosOperationKind.preattestation);
  factory TezosPreattestationOperation.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return TezosPreattestationOperation(
      consensusContent: TezosConsensusContent.fromJson(json),
    );
  }

  static Layout<TezosPreattestationOperation> layout() =>
      ObjSeqLayout<TezosPreattestationOperation>(
        [
          TezosConsensusContent.layout(), // -
        ],
        build:
            (v) => TezosPreattestationOperation(
              consensusContent: v[0] as TezosConsensusContent,
            ),
        unbuild: (v) => [v.consensusContent],
      );

  @override
  Layout<TezosPreattestationOperation> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [consensusContent];
  @override
  Map<String, dynamic> toJson() {
    return consensusContent.toJson();
  }
}

// APPROX: committee is an unprefixed `list` (Variable.list) -- only safe as a remainder-to-end field because this case can only ever be the single content of an operation (consensus ops don't batch); relies on TezosSignedContentsLayout's bounded sub-reader fix.
class TezosPreattestationOperationsAggregateOperation
    extends TezosOperationContent {
  final TezosConsensusAggregateContent consensusContent;
  final List<int> committee;

  factory TezosPreattestationOperationsAggregateOperation.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return TezosPreattestationOperationsAggregateOperation(
      consensusContent: TezosConsensusAggregateContent.fromJson(
        json.valueEnsureAsMap<String, dynamic>("consensus_content"),
      ),
      committee: json.valueEnsureAsList<int>("committee"),
    );
  }

  TezosPreattestationOperationsAggregateOperation({
    required this.consensusContent,
    required List<int> committee,
  }) : committee = committee.immutable,
       super(TezosOperationKind.preattestationsAggregate);

  static Layout<TezosPreattestationOperationsAggregateOperation> layout() =>
      ObjSeqLayout<TezosPreattestationOperationsAggregateOperation>(
        [
          TezosConsensusAggregateContent.layout(), // consensus_content,
          DynamicSizeLayout(
            RemainderListLayout(TezosLayoutUtils.tzUint16),
          ), // committee
        ],
        build:
            (v) => TezosPreattestationOperationsAggregateOperation(
              consensusContent: v[0] as TezosConsensusAggregateContent,
              committee: v[1] as List<int>,
            ),
        unbuild: (v) => [v.consensusContent, v.committee],
      );

  @override
  Layout<TezosPreattestationOperationsAggregateOperation> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [consensusContent, committee];

  @override
  Map<String, dynamic> toJson() {
    return {
      "consensus_content": consensusContent.toJson(),
      "committee": committee,
    };
  }
}

// // APPROX: proposals is `list(Protocol_hash.encoding)` with a `max_length` bound (validation-only, not shape) -- unprefixed, relies on the bounded-sub-reader fix like the aggregate committees above.
class TezosProposalsOperation extends TezosOperationContent {
  final TezosAddress source;
  final int period;
  final List<List<int>> proposals;

  TezosProposalsOperation({
    required TezosAddress source,
    required this.period,
    required List<List<int>> proposals,
  }) : proposals =
           proposals
               .map(
                 (e) =>
                     e
                         .exc(
                           length: QuickCrypto.blake2b256DigestSize,
                           operation: "TezosProposalsOperation",
                           reason: "Invalid proposal bytes length.",
                         )
                         .asImmutableBytes,
               )
               .toImutableList,
       source = source.ensureIsPubAddress(),
       super(TezosOperationKind.proposals);

  factory TezosProposalsOperation.deserializeJson(Map<String, dynamic> json) {
    return TezosProposalsOperation(
      source: TezosAddress(json.valueAsString("source")),
      period: json.valueAsInt("period"),
      proposals:
          json
              .valueEnsureAsList<String>("proposals")
              .map(TezosUtils.decodeProtocol)
              .toList(),
    );
  }

  static Layout<TezosProposalsOperation> layout() =>
      ObjSeqLayout<TezosProposalsOperation>(
        [
          TezosLayoutUtils.publicKeyHashLayout(), // source,
          TezosLayoutUtils.tzInt32, // period,
          DynamicSizeLayout(
            RemainderListLayout(LayoutConst.fixedBlobN(32)),
          ), // proposals
        ],
        build:
            (v) => TezosProposalsOperation(
              source: v[0] as TezosAddress,
              period: v[1] as int,
              proposals: v[2] as List<List<int>>,
            ),
        unbuild: (v) => [v.source, v.period, v.proposals],
      );

  @override
  Layout<TezosProposalsOperation> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [source, period, proposals];

  @override
  Map<String, dynamic> toJson() {
    return {
      "source": source.address,
      "period": period,
      "proposals": proposals.map(TezosUtils.encodeProtocol).toList(),
    };
  }
}

// // APPROX: nonce width (32 bytes) assumed -- Seed_repr.nonce_encoding not shown.
class TezosSeedNonceRevelationOperation extends TezosOperationContent {
  final int level;
  final List<int> nonce;
  factory TezosSeedNonceRevelationOperation.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return TezosSeedNonceRevelationOperation(
      level: json.valueAsInt("level"),
      nonce: json.valueAsBytes("nonce", allowHex: true),
    );
  }
  TezosSeedNonceRevelationOperation({
    required this.level,
    required List<int> nonce,
  }) : nonce =
           nonce
               .exc(
                 length: QuickCrypto.blake2b256DigestSize,
                 operation: "TezosSeedNonceRevelationOperation",
                 reason: "Invalid nonce bytes length.",
               )
               .asImmutableBytes,
       super(TezosOperationKind.seedNonceRevelation);

  factory TezosSeedNonceRevelationOperation.fromJson(
    Map<String, dynamic> json,
  ) {
    return TezosSeedNonceRevelationOperation(
      level: json.valueAsInt("level"),
      nonce: json.valueAsBytes("nonce", allowHex: true),
    );
  }

  static Layout<TezosSeedNonceRevelationOperation> layout() =>
      ObjSeqLayout<TezosSeedNonceRevelationOperation>(
        [
          TezosLayoutUtils.tzInt32, // level,
          LayoutConst.fixedBlobN(32), // nonce
        ],
        build:
            (v) => TezosSeedNonceRevelationOperation(
              level: v[0] as int,
              nonce: v[1] as List<int>,
            ),
        unbuild: (v) => [v.level, v.nonce],
      );

  @override
  Layout<TezosSeedNonceRevelationOperation> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [level, nonce];

  @override
  Map<String, dynamic> toJson() {
    return {"level": level, "nonce": BytesUtils.toHexString(nonce)};
  }
}

// APPROX: `string Hex` only affects JSON rendering; binary shape should match DynamicBytesLayout, not independently verified.
class TezosFailingNoopOperation extends TezosOperationContent {
  final List<int> arbitrary;

  TezosFailingNoopOperation({required List<int> arbitrary})
    : arbitrary = arbitrary.asImmutableBytes,
      super(TezosOperationKind.failingNoop);

  factory TezosFailingNoopOperation.deserializeJson(Map<String, dynamic> json) {
    return TezosFailingNoopOperation(
      arbitrary: json.valueAsBytes("arbitrary", allowHex: true),
    );
  }

  static Layout<TezosFailingNoopOperation> layout() =>
      ObjSeqLayout<TezosFailingNoopOperation>(
        [
          DynamicBytesLayout(), // arbitrary
        ],
        build: (v) => TezosFailingNoopOperation(arbitrary: v[0] as List<int>),
        unbuild: (v) => [v.arbitrary],
      );
  @override
  Layout<TezosFailingNoopOperation> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [arbitrary];

  @override
  Map<String, dynamic> toJson() {
    return {"arbitrary": BytesUtils.toHexString(arbitrary)};
  }
}

// // ---------------------------------------------------------------------------
// // Added this pass, cross-checked against the obj*/req/opt lines in
// // operation_repr.ml (not re-run through generate_tezos_layouts.py).
// // ---------------------------------------------------------------------------

/// TezosScript_repr.t: {code; storage}, both lazy_expr (= length-prefixed
/// MichelineExpr bytes, same shape as TezosRegisterGlobalConstantOperation.value).
class TezosScript extends OctezSerializable<TezosScript> with Equality {
  final MichelineExpr code;
  final MichelineExpr storage;
  TezosScript({required this.code, required this.storage});
  factory TezosScript.fromJson(Map<String, dynamic> json) {
    return TezosScript(
      code: MichelineExpr.deserializeJson(json.valueAs("code")),
      storage: MichelineExpr.deserializeJson(json.valueAs("storage")),
    );
  }

  static Layout<TezosScript> layout() => ObjSeqLayout<TezosScript>(
    [
      DynamicBytesLayout(), // code
      DynamicBytesLayout(), // storage
    ],
    build:
        (v) => TezosScript(
          code: MichelineExpr.deserialize(v[0]),
          storage: MichelineExpr.deserialize(v[1]),
        ),
    unbuild: (v) => [v.code.serializeBytes(), v.storage.serializeBytes()],
  );

  @override
  Map<String, dynamic> toJson() {
    return {"code": code.toJson(), "storage": storage.toJson()};
  }

  @override
  Layout<TezosScript> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [code, storage];
}

// APPROX: gas_limit/storage_limit check_size(10) bound not enforced (same as
// every other manager op here). Field order confirmed from origination_case's
// `obj3 (req "balance") (opt "delegate") (req "script")`.
class TezosOriginationOperation extends TezosManagerOperationContent {
  final BigInt balance;
  final TezosAddress? delegate;
  final TezosScript script;

  TezosOriginationOperation({
    required super.source,
    required super.fee,
    required super.counter,
    required super.gasLimit,
    required super.storageLimit,
    required this.balance,
    required TezosAddress? delegate,
    required this.script,
  }) : delegate = delegate?.ensureIsPubAddress(),
       super(type: TezosOperationKind.origination);
  factory TezosOriginationOperation.deserializeJson(Map<String, dynamic> json) {
    return TezosOriginationOperation(
      source: TezosAddress(json.valueAsString("source")),
      fee: json.valueAsBigInt("fee"),
      counter: json.valueAsBigInt("counter"),
      gasLimit: json.valueAsBigInt("gas_limit"),
      storageLimit: json.valueAsBigInt("storage_limit"),
      balance: json.valueAsBigInt("balance"),
      delegate: json.valueTo<TezosAddress?, String>(
        key: "delegate",
        parse: TezosAddress.new,
      ),
      script: TezosScript.fromJson(json.valueEnsureAsMap("script")),
    );
  }
  static Layout<TezosOriginationOperation> layout() =>
      ObjSeqLayout<TezosOriginationOperation>(
        [
          TezosLayoutUtils.publicKeyHashLayout(), // source
          TezosLayoutUtils.tzNat, // fee
          TezosLayoutUtils.tzNat, // counter
          TezosLayoutUtils.tzNat, // gas_limit
          TezosLayoutUtils.tzNat, // storage_limit
          TezosLayoutUtils.tzNat, // balance (credit)
          TezosLayoutUtils.optionLayout(
            TezosLayoutUtils.publicKeyHashLayout(),
          ), // delegate
          TezosScript.layout(), // script
        ],
        build:
            (v) => TezosOriginationOperation(
              source: v[0] as TezosAddress,
              fee: v[1] as BigInt,
              counter: v[2] as BigInt,
              gasLimit: v[3] as BigInt,
              storageLimit: v[4] as BigInt,
              balance: v[5] as BigInt,
              delegate: v[6] as TezosAddress?,
              script: v[7] as TezosScript,
            ),
        unbuild:
            (v) => [
              v.source,
              v.fee,
              v.counter,
              v.gasLimit,
              v.storageLimit,
              v.balance,
              v.delegate,
              v.script,
            ],
      );

  @override
  Layout<TezosOriginationOperation> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [
    source,
    fee,
    counter,
    gasLimit,
    storageLimit,
    balance,
    delegate,
    script,
  ];
  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),

      "balance": balance.toString(),
      "delegate": delegate?.address,
      "script": script.toJson(),
    }.notNullValue;
  }

  @override
  TezosOriginationOperation copyWith({
    TezosAddress? source,
    BigInt? fee,
    BigInt? counter,
    BigInt? gasLimit,
    BigInt? storageLimit,
    BigInt? balance,
    TezosAddress? delegate,
    TezosScript? script,
  }) {
    return TezosOriginationOperation(
      source: source ?? this.source,
      fee: fee ?? this.fee,
      counter: counter ?? this.counter,
      gasLimit: gasLimit ?? this.gasLimit,
      storageLimit: storageLimit ?? this.storageLimit,
      balance: balance ?? this.balance,
      delegate: delegate ?? this.delegate,
      script: script ?? this.script,
    );
  }
}

// APPROX: gas_limit/storage_limit check_size(10) bound not enforced.
// `entrypoint` here is Entrypoint_repr.simple_encoding (a plain string) --
// distinct from TezosTransactionOperation's smart_encoding, which this file leaves opaque.
// `amount` (Ticket_amount.encoding) modeled as TezosLayoutUtils.tzNat: documented as a
// positive integer, exact wire form not independently confirmed.
class TezosTransferTicketOperation extends TezosManagerOperationContent {
  final MichelineExpr contents; // lazy_expr
  final MichelineExpr ty; // lazy_expr
  final TezosAddress ticketer; // Contract_repr
  final BigInt amount;
  final TezosAddress destination; // Contract_repr
  final String entrypoint;

  TezosTransferTicketOperation({
    required super.source,
    required super.fee,
    required super.counter,
    required super.gasLimit,
    required super.storageLimit,
    required this.contents,
    required this.ty,
    required TezosAddress ticketer,
    required this.amount,
    required TezosAddress destination,
    required this.entrypoint,
  }) : ticketer = ticketer.ensureIsContractAddress(),
       destination = destination.ensureIsContractAddress(),
       super(type: TezosOperationKind.transferTicket);

  factory TezosTransferTicketOperation.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return TezosTransferTicketOperation(
      source: TezosAddress(json.valueAsString("source")),
      fee: json.valueAsBigInt("fee"),
      counter: json.valueAsBigInt("counter"),
      gasLimit: json.valueAsBigInt("gas_limit"),
      storageLimit: json.valueAsBigInt("storage_limit"),
      amount: json.valueAsBigInt("ticket_amount"),
      destination: TezosAddress(json.valueAsString("destination")),
      contents: MichelineExpr.deserializeJson(json.valueAs("ticket_contents")),
      ty: MichelineExpr.deserializeJson(json.valueAs("ticket_ty")),
      entrypoint: json.valueAsString("entrypoint"),
      ticketer: TezosAddress(json.valueAsString("ticket_ticketer")),
    );
  }
  static Layout<TezosTransferTicketOperation> layout() =>
      ObjSeqLayout<TezosTransferTicketOperation>(
        [
          TezosLayoutUtils.publicKeyHashLayout(), // source
          TezosLayoutUtils.tzNat, // fee
          TezosLayoutUtils.tzNat, // counter
          TezosLayoutUtils.tzNat, // gas_limit
          TezosLayoutUtils.tzNat, // storage_limit
          DynamicBytesLayout(), // ticket_contents
          DynamicBytesLayout(), // ticket_ty
          LayoutConst.fixedBlobN(22), // ticket_ticketer
          TezosLayoutUtils.tzNat, // ticket_amount
          LayoutConst.fixedBlobN(22), // destination
          TezosLayoutUtils.tzString, // entrypoint
        ],
        build:
            (v) => TezosTransferTicketOperation(
              source: v[0] as TezosAddress,
              fee: v[1] as BigInt,
              counter: v[2] as BigInt,
              gasLimit: v[3] as BigInt,
              storageLimit: v[4] as BigInt,
              contents: MichelineExpr.deserialize(v[5]),
              ty: MichelineExpr.deserialize(v[6]),
              ticketer: TezosUtils.decodeDestinationAddr(v[7] as List<int>),
              amount: v[8] as BigInt,
              destination: TezosUtils.decodeDestinationAddr(v[9] as List<int>),
              entrypoint: v[10] as String,
            ),
        unbuild:
            (v) => [
              v.source,
              v.fee,
              v.counter,
              v.gasLimit,
              v.storageLimit,
              v.contents.serializeBytes(),
              v.ty.serializeBytes(),
              TezosUtils.encodeDestinationAddr(v.ticketer),
              v.amount,
              TezosUtils.encodeDestinationAddr(v.destination),
              v.entrypoint,
            ],
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),

      "ticket_contents": contents.toJson(),
      "ticket_ty": ty.toJson(),
      "ticket_ticketer": ticketer.address,
      "ticket_amount": amount.toString(),
      "destination": destination.address,
      "entrypoint": entrypoint,
    }.notNullValue;
  }

  @override
  Layout<TezosTransferTicketOperation> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [
    source,
    fee,
    counter,
    gasLimit,
    storageLimit,
    contents,
    ty,
    ticketer,
    amount,
    destination,
    entrypoint,
  ];

  @override
  TezosTransferTicketOperation copyWith({
    TezosAddress? source,
    BigInt? fee,
    BigInt? counter,
    BigInt? gasLimit,
    BigInt? storageLimit,
    MichelineExpr? contents,
    MichelineExpr? ty,
    TezosAddress? ticketer,
    BigInt? amount,
    TezosAddress? destination,
    String? entrypoint,
  }) {
    return TezosTransferTicketOperation(
      source: source ?? this.source,
      fee: fee ?? this.fee,
      counter: counter ?? this.counter,
      gasLimit: gasLimit ?? this.gasLimit,
      storageLimit: storageLimit ?? this.storageLimit,
      contents: contents ?? this.contents,
      ty: ty ?? this.ty,
      ticketer: ticketer ?? this.ticketer,
      amount: amount ?? this.amount,
      destination: destination ?? this.destination,
      entrypoint: entrypoint ?? this.entrypoint,
    );
  }
}

// APPROX: rollup address width (20 bytes, Contract_hash's family) not
// independently confirmed against Sc_rollup_repr.encoding.
// `messages` is `list (string Hex)` -- each element self-delimited by
// list's handling of variable-size elements, so no extra wrapper needed
// beyond being the last (only) field of this obj1.
class TezosSmartRollupAddMessagesOperation
    extends TezosManagerOperationContent {
  final List<List<int>> messages;

  TezosSmartRollupAddMessagesOperation({
    required super.source,
    required super.fee,
    required super.counter,
    required super.gasLimit,
    required super.storageLimit,
    required this.messages,
  }) : super(type: TezosOperationKind.smartRollupAddMessages);

  factory TezosSmartRollupAddMessagesOperation.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return TezosSmartRollupAddMessagesOperation(
      source: TezosAddress(json.valueAsString("source")),
      fee: json.valueAsBigInt("fee"),
      counter: json.valueAsBigInt("counter"),
      gasLimit: json.valueAsBigInt("gas_limit"),
      storageLimit: json.valueAsBigInt("storage_limit"),
      messages:
          json
              .valueEnsureAsList<String>("message")
              .map(BytesUtils.fromHexString)
              .toList(),
    );
  }

  static Layout<TezosSmartRollupAddMessagesOperation> layout() =>
      ObjSeqLayout<TezosSmartRollupAddMessagesOperation>(
        [
          TezosLayoutUtils.publicKeyHashLayout(), // source
          TezosLayoutUtils.tzNat, // fee
          TezosLayoutUtils.tzNat, // counter
          TezosLayoutUtils.tzNat, // gas_limit
          TezosLayoutUtils.tzNat, // storage_limit
          DynamicSizeLayout(
            RemainderListLayout(DynamicBytesLayout()),
          ), // messages
        ],
        build:
            (v) => TezosSmartRollupAddMessagesOperation(
              source: v[0] as TezosAddress,
              fee: v[1] as BigInt,
              counter: v[2] as BigInt,
              gasLimit: v[3] as BigInt,
              storageLimit: v[4] as BigInt,
              messages: v[5] as List<List<int>>,
            ),
        unbuild:
            (v) => [
              v.source,
              v.fee,
              v.counter,
              v.gasLimit,
              v.storageLimit,
              v.messages,
            ],
      );

  @override
  List<dynamic> get variables => [
    source,
    fee,
    counter,
    gasLimit,
    storageLimit,
    messages,
  ];

  @override
  Layout<TezosSmartRollupAddMessagesOperation> toLayot() {
    return layout();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),

      "message": messages.map(BytesUtils.toHexString).toList(),
    }.notNullValue;
  }

  @override
  TezosSmartRollupAddMessagesOperation copyWith({
    TezosAddress? source,
    BigInt? fee,
    BigInt? counter,
    BigInt? gasLimit,
    BigInt? storageLimit,
    List<List<int>>? messages,
  }) {
    return TezosSmartRollupAddMessagesOperation(
      source: source ?? this.source,
      fee: fee ?? this.fee,
      counter: counter ?? this.counter,
      gasLimit: gasLimit ?? this.gasLimit,
      storageLimit: storageLimit ?? this.storageLimit,
      messages: messages ?? this.messages,
    );
  }
}

// APPROX: rollup address modeled as 20-byte hash (Sc_rollup_repr.encoding),
// same family/width as Contract_hash -- not independently confirmed.
class TezosSmartRollupCementOperation extends TezosManagerOperationContent {
  final TezosAddress rollup;

  TezosSmartRollupCementOperation({
    required super.source,
    required super.fee,
    required super.counter,
    required super.gasLimit,
    required super.storageLimit,
    required TezosAddress rollup,
  }) : rollup = rollup.ensureIsRollUp(),
       super(type: TezosOperationKind.smartRollupCement);

  factory TezosSmartRollupCementOperation.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return TezosSmartRollupCementOperation(
      source: TezosAddress(json.valueAsString("source")),
      fee: json.valueAsBigInt("fee"),
      counter: json.valueAsBigInt("counter"),
      gasLimit: json.valueAsBigInt("gas_limit"),
      storageLimit: json.valueAsBigInt("storage_limit"),
      rollup: TezosAddress(json.valueAsString("rollup")),
    );
  }

  static final Layout<TezosSmartRollupCementOperation> _layout =
      ObjSeqLayout<TezosSmartRollupCementOperation>(
        [
          TezosLayoutUtils.publicKeyHashLayout(), // source
          TezosLayoutUtils.tzNat, // fee
          TezosLayoutUtils.tzNat, // counter
          TezosLayoutUtils.tzNat, // gas_limit
          TezosLayoutUtils.tzNat, // storage_limit
          LayoutConst.fixedBlobN(20), // rollup
        ],
        build:
            (v) => TezosSmartRollupCementOperation(
              source: v[0] as TezosAddress,
              fee: v[1] as BigInt,
              counter: v[2] as BigInt,
              gasLimit: v[3] as BigInt,
              storageLimit: v[4] as BigInt,
              rollup: TezosAddress.smartRollupBytes(v[5] as List<int>),
            ),
        unbuild:
            (v) => [
              v.source,
              v.fee,
              v.counter,
              v.gasLimit,
              v.storageLimit,
              v.rollup.hashBytes,
            ],
      );

  static Layout<TezosSmartRollupCementOperation> layout() => _layout;

  @override
  List<dynamic> get variables => [
    source,
    fee,
    counter,
    gasLimit,
    storageLimit,
    rollup,
  ];

  @override
  Layout<TezosSmartRollupCementOperation> toLayot() {
    return layout();
  }

  @override
  Map<String, dynamic> toJson() {
    return {...super.toJson(), "rollup": rollup.address}.notNullValue;
  }

  @override
  TezosSmartRollupCementOperation copyWith({
    TezosAddress? source,
    BigInt? fee,
    BigInt? counter,
    BigInt? gasLimit,
    BigInt? storageLimit,
    TezosAddress? rollup,
  }) {
    return TezosSmartRollupCementOperation(
      source: source ?? this.source,
      fee: fee ?? this.fee,
      counter: counter ?? this.counter,
      gasLimit: gasLimit ?? this.gasLimit,
      storageLimit: storageLimit ?? this.storageLimit,
      rollup: rollup ?? this.rollup,
    );
  }
}

// APPROX: rollup (20-byte) and cemented_commitment (32-byte hash) widths
// assumed by convention, not independently confirmed.
// `output_proof` is modeled as length-prefixed bytes for consistency with
// dynamic byte fields, but as the LAST field it may in fact be an unprefixed
// remainder in the real protocol. Flagged; settle with a real forged test
// vector before relying on this.
class TezosSmartRollupExecuteOutboxMessageOperation
    extends TezosManagerOperationContent {
  final TezosAddress rollup;
  final List<int> cementedCommitment;
  final List<int> outputProof;

  TezosSmartRollupExecuteOutboxMessageOperation({
    required super.source,
    required super.fee,
    required super.counter,
    required super.gasLimit,
    required super.storageLimit,
    required TezosAddress rollup,
    required this.cementedCommitment,
    required this.outputProof,
  }) : rollup = rollup.ensureIsRollUp(),
       super(type: TezosOperationKind.smartRollupExecuteOutboxMessage);

  factory TezosSmartRollupExecuteOutboxMessageOperation.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return TezosSmartRollupExecuteOutboxMessageOperation(
      source: TezosAddress(json.valueAsString("source")),
      fee: json.valueAsBigInt("fee"),
      counter: json.valueAsBigInt("counter"),
      gasLimit: json.valueAsBigInt("gas_limit"),
      storageLimit: json.valueAsBigInt("storage_limit"),
      rollup: TezosAddress(json.valueAsString("rollup")),
      cementedCommitment: TezosUtils.decodeSmartRollupCommitment(
        json.valueAsString("cemented_commitment"),
      ),
      outputProof: json.valueAsBytes("output_proof"),
    );
  }

  static Layout<TezosSmartRollupExecuteOutboxMessageOperation> layout() =>
      ObjSeqLayout<TezosSmartRollupExecuteOutboxMessageOperation>(
        [
          TezosLayoutUtils.publicKeyHashLayout(), // source
          TezosLayoutUtils.tzNat, // fee
          TezosLayoutUtils.tzNat, // counter
          TezosLayoutUtils.tzNat, // gas_limit
          TezosLayoutUtils.tzNat, // storage_limit
          LayoutConst.fixedBlobN(20), // rollup
          LayoutConst.fixedBlobN(32), // cemented_commitment
          DynamicBytesLayout(), // output_proof
        ],
        build:
            (v) => TezosSmartRollupExecuteOutboxMessageOperation(
              source: v[0] as TezosAddress,
              fee: v[1] as BigInt,
              counter: v[2] as BigInt,
              gasLimit: v[3] as BigInt,
              storageLimit: v[4] as BigInt,
              rollup: TezosAddress.smartRollupBytes(v[5] as List<int>),
              cementedCommitment: v[6] as List<int>,
              outputProof: v[7] as List<int>,
            ),
        unbuild:
            (v) => [
              v.source,
              v.fee,
              v.counter,
              v.gasLimit,
              v.storageLimit,
              v.rollup.hashBytes,
              v.cementedCommitment,
              v.outputProof,
            ],
      );

  @override
  List<dynamic> get variables => [
    source,
    fee,
    counter,
    gasLimit,
    storageLimit,
    rollup,
    cementedCommitment,
    outputProof,
  ];

  @override
  Layout<TezosSmartRollupExecuteOutboxMessageOperation> toLayot() {
    return layout();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),

      "rollup": rollup.address,
      "cemented_commitment": TezosUtils.encodeSmartRollupCommitment(
        cementedCommitment,
      ),
      "output_proof": BytesUtils.toHexString(outputProof),
    }.notNullValue;
  }

  @override
  TezosSmartRollupExecuteOutboxMessageOperation copyWith({
    TezosAddress? source,
    BigInt? fee,
    BigInt? counter,
    BigInt? gasLimit,
    BigInt? storageLimit,
    TezosAddress? rollup,
    List<int>? cementedCommitment,
    List<int>? outputProof,
  }) {
    return TezosSmartRollupExecuteOutboxMessageOperation(
      source: source ?? this.source,
      fee: fee ?? this.fee,
      counter: counter ?? this.counter,
      gasLimit: gasLimit ?? this.gasLimit,
      storageLimit: storageLimit ?? this.storageLimit,
      rollup: rollup ?? this.rollup,
      cementedCommitment: cementedCommitment ?? this.cementedCommitment,
      outputProof: outputProof ?? this.outputProof,
    );
  }
}

// APPROX: rollup address (Sc_rollup_repr.Address.encoding) modeled as
// 20-byte hash by convention, not independently confirmed.
class TezosSmartRollupRecoverBondOperation
    extends TezosManagerOperationContent {
  final TezosAddress rollup;
  final TezosAddress staker;

  TezosSmartRollupRecoverBondOperation({
    required super.source,
    required super.fee,
    required super.counter,
    required super.gasLimit,
    required super.storageLimit,
    required TezosAddress rollup,
    required TezosAddress staker,
  }) : staker = staker.ensureIsPubAddress(),
       rollup = rollup.ensureIsRollUp(),
       super(type: TezosOperationKind.smartRollupRecoverBond);

  factory TezosSmartRollupRecoverBondOperation.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return TezosSmartRollupRecoverBondOperation(
      source: TezosAddress(json.valueAsString("source")),
      fee: json.valueAsBigInt("fee"),
      counter: json.valueAsBigInt("counter"),
      gasLimit: json.valueAsBigInt("gas_limit"),
      storageLimit: json.valueAsBigInt("storage_limit"),
      rollup: TezosAddress(json.valueAsString("rollup")),
      staker: TezosAddress(json.valueAsString("staker")),
    );
  }

  static final Layout<TezosSmartRollupRecoverBondOperation> _layout =
      ObjSeqLayout<TezosSmartRollupRecoverBondOperation>(
        [
          TezosLayoutUtils.publicKeyHashLayout(), // source
          TezosLayoutUtils.tzNat, // fee
          TezosLayoutUtils.tzNat, // counter
          TezosLayoutUtils.tzNat, // gas_limit
          TezosLayoutUtils.tzNat, // storage_limit
          LayoutConst.fixedBlobN(20), // rollup
          TezosLayoutUtils.publicKeyHashLayout(), // staker
        ],
        build:
            (v) => TezosSmartRollupRecoverBondOperation(
              source: v[0] as TezosAddress,
              fee: v[1] as BigInt,
              counter: v[2] as BigInt,
              gasLimit: v[3] as BigInt,
              storageLimit: v[4] as BigInt,
              rollup: TezosAddress.smartRollupBytes(v[5] as List<int>),
              staker: v[6] as TezosAddress,
            ),
        unbuild:
            (v) => [
              v.source,
              v.fee,
              v.counter,
              v.gasLimit,
              v.storageLimit,
              v.rollup.hashBytes,
              v.staker,
            ],
      );

  static Layout<TezosSmartRollupRecoverBondOperation> layout() => _layout;

  @override
  List<dynamic> get variables => [
    source,
    fee,
    counter,
    gasLimit,
    storageLimit,
    rollup,
    staker,
  ];

  @override
  Layout<TezosSmartRollupRecoverBondOperation> toLayot() {
    return layout();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),

      "rollup": rollup.address,
      "staker": staker.address,
    }.notNullValue;
  }

  @override
  TezosSmartRollupRecoverBondOperation copyWith({
    TezosAddress? source,
    BigInt? fee,
    BigInt? counter,
    BigInt? gasLimit,
    BigInt? storageLimit,
    TezosAddress? rollup,
    TezosAddress? staker,
  }) {
    return TezosSmartRollupRecoverBondOperation(
      source: source ?? this.source,
      fee: fee ?? this.fee,
      counter: counter ?? this.counter,
      gasLimit: gasLimit ?? this.gasLimit,
      storageLimit: storageLimit ?? this.storageLimit,
      rollup: rollup ?? this.rollup,
      staker: staker ?? this.staker,
    );
  }
}

// // ---------------------------------------------------------------------------
// // Added from the Sc_rollups.Kind / Sc_rollup_repr / Sc_rollup_commitment_repr
// // / Sc_rollup_game_repr / Sc_rollup_whitelist_repr / TezosScript_repr sources you
// // sent. Still approximated where those files don't pin the exact width
// // (hashes, the `constant` no-op assumption) -- flagged per class below.
// // ---------------------------------------------------------------------------

/// Sc_rollups.Kind.t: Data_encoding.string_enum over
/// [Example_arith; Wasm_2_0_0; Riscv]. string_enum is specifically designed
/// to encode as a compact integer tag in binary (vs. the string in JSON),
/// tag width uint8 for this few cases -- fairly confident, but the exact
/// data-encoding version's tag-width rule isn't reproduced here from source.
enum TezosSmartRollupKind {
  arith("arith"),
  wasm20("wasm_2_0_0"),
  riscv("riscv");

  final String value;
  const TezosSmartRollupKind(this.value);
  static Layout<TezosSmartRollupKind> layout() =>
      ConvLayout<TezosSmartRollupKind, int>(
        TezosLayoutUtils.tzUint8,
        toWire: (k) => k.index,
        fromWire: (i) => TezosSmartRollupKind.values[i],
      );
  static TezosSmartRollupKind fromValue(String? value) {
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw OnChainErrors.tezosPlugin(
                "TezosSmartRollupKind.lookup",
                reason: "Invalid TezosSmartRollupKind.",
                details: {"value": "$value"},
              ),
    );
  }
}

// APPROX: gas_limit/storage_limit check_size(10) bound not enforced.
// `boot_sector` (plain `string`, not last field of the obj4) is modeled as
// length-prefixed bytes for consistency with other non-terminal variable
// fields.
// `whitelist` = `option (list Implicit_account_repr.encoding)`: the list
// is the last field once unwrapped from `opt`, so no extra size wrapper
// needed.
class TezosSmartRollupOriginateOperation extends TezosManagerOperationContent {
  final TezosSmartRollupKind kind;
  final List<int> bootSector;
  final MichelineExpr parametersTy;
  final List<TezosAddress>? whitelist;

  TezosSmartRollupOriginateOperation({
    required super.source,
    required super.fee,
    required super.counter,
    required super.gasLimit,
    required super.storageLimit,
    required this.kind,
    required List<int> bootSector,
    required this.parametersTy,
    required List<TezosAddress>? whitelist,
  }) : whitelist = whitelist?.map((e) => e.ensureIsPubAddress()).toImutableList,
       bootSector = bootSector.asImmutableBytes,
       super(type: TezosOperationKind.smartRollupOriginate);

  factory TezosSmartRollupOriginateOperation.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return TezosSmartRollupOriginateOperation(
      source: TezosAddress(json.valueAsString("source")),
      fee: json.valueAsBigInt("fee"),
      counter: json.valueAsBigInt("counter"),
      gasLimit: json.valueAsBigInt("gas_limit"),
      storageLimit: json.valueAsBigInt("storage_limit"),
      kind: TezosSmartRollupKind.fromValue(json.valueAsString("pvm_kind")),
      bootSector: json.valueAsBytes("kernel", allowHex: true),
      parametersTy: MichelineExpr.deserializeJson(
        json.valueAs("parameters_ty"),
      ),
      whitelist:
          json
              .valueAsList<List<String>?>("whitelist")
              ?.map((e) => TezosAddress(e))
              .toList(),
    );
  }

  static Layout<TezosSmartRollupOriginateOperation> layout() =>
      ObjSeqLayout<TezosSmartRollupOriginateOperation>(
        [
          TezosLayoutUtils.publicKeyHashLayout(), // source
          TezosLayoutUtils.tzNat, // fee
          TezosLayoutUtils.tzNat, // counter
          TezosLayoutUtils.tzNat, // gas_limit
          TezosLayoutUtils.tzNat, // storage_limit
          TezosSmartRollupKind.layout(), // pvm_kind
          DynamicBytesLayout(), // boot_sector
          const DynamicBytesLayout(), // parameters_ty
          TezosLayoutUtils.optionLayout(
            DynamicSizeLayout(
              RemainderListLayout(TezosLayoutUtils.publicKeyHashLayout()),
            ),
          ),
        ],
        build:
            (v) => TezosSmartRollupOriginateOperation(
              source: v[0] as TezosAddress,
              fee: v[1] as BigInt,
              counter: v[2] as BigInt,
              gasLimit: v[3] as BigInt,
              storageLimit: v[4] as BigInt,
              kind: v[5] as TezosSmartRollupKind,
              bootSector: v[6] as List<int>,
              parametersTy: MichelineExpr.deserialize(v[7]),
              whitelist: v[8] as List<TezosAddress>?,
            ),
        unbuild:
            (v) => [
              v.source,
              v.fee,
              v.counter,
              v.gasLimit,
              v.storageLimit,
              v.kind,
              v.bootSector,
              v.parametersTy.serializeBytes(),
              v.whitelist,
            ],
      );

  @override
  List<dynamic> get variables => [
    source,
    fee,
    counter,
    gasLimit,
    storageLimit,
    kind,
    bootSector,
    parametersTy,
    whitelist,
  ];

  @override
  Layout<TezosSmartRollupOriginateOperation> toLayot() {
    return layout();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),

      "pvm_kind": kind.value,
      "kernel": BytesUtils.toHexString(bootSector),
      "parameters_ty": parametersTy.toJson(),
      "whitelist": whitelist?.map((e) => e.address).toList(),
    }.notNullValue;
  }

  @override
  TezosSmartRollupOriginateOperation copyWith({
    TezosAddress? source,
    BigInt? fee,
    BigInt? counter,
    BigInt? gasLimit,
    BigInt? storageLimit,
    TezosSmartRollupKind? kind,
    List<int>? bootSector,
    MichelineExpr? parametersTy,
    List<TezosAddress>? whitelist,
  }) {
    return TezosSmartRollupOriginateOperation(
      source: source ?? this.source,
      fee: fee ?? this.fee,
      counter: counter ?? this.counter,
      gasLimit: gasLimit ?? this.gasLimit,
      storageLimit: storageLimit ?? this.storageLimit,
      kind: kind ?? this.kind,
      bootSector: bootSector ?? this.bootSector,
      parametersTy: parametersTy ?? this.parametersTy,
      whitelist: whitelist ?? this.whitelist,
    );
  }
}

/// Sc_rollup_commitment_repr.V1.t. Field order confirmed from its own
/// `obj4`. Hash widths (State_hash / Commitment_hash) APPROX'd at 32 bytes
/// by convention with other blake2b hashes in this codebase (Protocol_hash,
/// block/branch hashes) -- not independently confirmed against
/// Smart_rollup.State_hash/Commitment_hash directly. number_of_ticks
/// (Bounded.Int64) modeled as a plain big-endian u64, not N/Z.
class TezosSmartRollupCommitment
    extends OctezSerializable<TezosSmartRollupCommitment>
    with Equality {
  final List<int> compressedState;
  final int inboxLevel;
  final List<int> predecessor;
  final BigInt numberOfTicks;

  TezosSmartRollupCommitment({
    required List<int> compressedState,
    required this.inboxLevel,
    required List<int> predecessor,
    required this.numberOfTicks,
  }) : compressedState = compressedState.asImmutableBytes,
       predecessor = predecessor.asImmutableBytes;
  factory TezosSmartRollupCommitment.fromJson(Map<String, dynamic> json) {
    return TezosSmartRollupCommitment(
      compressedState: TezosUtils.decodeSmartRollupState(
        json.valueAsString("compressed_state"),
      ),
      inboxLevel: json.valueAsInt("inbox_level"),
      predecessor: TezosUtils.decodeSmartRollupCommitment(
        json.valueAsString("predecessor"),
      ),
      numberOfTicks: json.valueAsBigInt("number_of_ticks"),
    );
  }

  static Layout<TezosSmartRollupCommitment> layout() =>
      ObjSeqLayout<TezosSmartRollupCommitment>(
        [
          LayoutConst.fixedBlobN(32), // compressed_state
          TezosLayoutUtils.tzInt32, // inbox_level
          LayoutConst.fixedBlobN(32), // predecessor
          LayoutConst.u64be(),
        ],
        build:
            (v) => TezosSmartRollupCommitment(
              compressedState: v[0] as List<int>,
              inboxLevel: v[1] as int,
              predecessor: v[2] as List<int>,
              numberOfTicks: v[3] as BigInt,
            ),
        unbuild:
            (v) => [
              v.compressedState,
              v.inboxLevel,
              v.predecessor,
              v.numberOfTicks,
            ],
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      "compressed_state": TezosUtils.encodeSmartRollupState(compressedState),
      "inbox_level": inboxLevel,
      "predecessor": TezosUtils.encodeSmartRollupCommitment(predecessor),
      "number_of_ticks": numberOfTicks.toString(),
    };
  }

  @override
  Layout<TezosSmartRollupCommitment> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [
    compressedState,
    inboxLevel,
    predecessor,
    numberOfTicks,
  ];
}

// APPROX: rollup address (20 bytes) and commitment hash widths (32 bytes,
// inherited from scRollupCommitmentLayout) by convention, not independently
// confirmed.
class TezosSmartRollupPublishOperation extends TezosManagerOperationContent {
  final TezosAddress rollup;
  final TezosSmartRollupCommitment commitment;

  TezosSmartRollupPublishOperation({
    required super.source,
    required super.fee,
    required super.counter,
    required super.gasLimit,
    required super.storageLimit,
    required TezosAddress rollup,
    required this.commitment,
  }) : rollup = rollup.ensureIsRollUp(),
       super(type: TezosOperationKind.smartRollupPublish);

  factory TezosSmartRollupPublishOperation.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return TezosSmartRollupPublishOperation(
      source: TezosAddress(json.valueAsString("source")),
      fee: json.valueAsBigInt("fee"),
      counter: json.valueAsBigInt("counter"),
      gasLimit: json.valueAsBigInt("gas_limit"),
      storageLimit: json.valueAsBigInt("storage_limit"),
      rollup: TezosAddress(json.valueAsString("rollup")),
      commitment: TezosSmartRollupCommitment.fromJson(
        json.valueEnsureAsMap("commitment"),
      ),
    );
  }

  static Layout<TezosSmartRollupPublishOperation> layout() =>
      ObjSeqLayout<TezosSmartRollupPublishOperation>(
        [
          TezosLayoutUtils.publicKeyHashLayout(), // source
          TezosLayoutUtils.tzNat, // fee
          TezosLayoutUtils.tzNat, // counter
          TezosLayoutUtils.tzNat, // gas_limit
          TezosLayoutUtils.tzNat, // storage_limit
          LayoutConst.fixedBlobN(20), // rollup
          TezosSmartRollupCommitment.layout(), // commitment
        ],
        build:
            (v) => TezosSmartRollupPublishOperation(
              source: v[0] as TezosAddress,
              fee: v[1] as BigInt,
              counter: v[2] as BigInt,
              gasLimit: v[3] as BigInt,
              storageLimit: v[4] as BigInt,
              rollup: TezosAddress.smartRollupBytes(v[5] as List<int>),
              commitment: v[6] as TezosSmartRollupCommitment,
            ),
        unbuild:
            (v) => [
              v.source,
              v.fee,
              v.counter,
              v.gasLimit,
              v.storageLimit,
              v.rollup.hashBytes,
              v.commitment,
            ],
      );

  @override
  List<dynamic> get variables => [
    source,
    fee,
    counter,
    gasLimit,
    storageLimit,
    rollup,
    commitment,
  ];

  @override
  Layout<TezosSmartRollupPublishOperation> toLayot() {
    return layout();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),

      "rollup": rollup.address,
      "commitment": commitment.toJson(),
    }.notNullValue;
  }

  @override
  TezosSmartRollupPublishOperation copyWith({
    TezosAddress? source,
    BigInt? fee,
    BigInt? counter,
    BigInt? gasLimit,
    BigInt? storageLimit,
    TezosAddress? rollup,
    TezosSmartRollupCommitment? commitment,
  }) {
    return TezosSmartRollupPublishOperation(
      source: source ?? this.source,
      fee: fee ?? this.fee,
      counter: counter ?? this.counter,
      gasLimit: gasLimit ?? this.gasLimit,
      storageLimit: storageLimit ?? this.storageLimit,
      rollup: rollup ?? this.rollup,
      commitment: commitment ?? this.commitment,
    );
  }
}

/// Sc_rollup_game_repr.Index.t: {alice; bob}, both Staker.t
/// (= Implicit_account_repr.t, i.e. a plain public key hash).
class TezosSmartRollupGameIndex
    extends OctezSerializable<TezosSmartRollupGameIndex>
    with Equality {
  final TezosAddress alice;
  final TezosAddress bob;
  TezosSmartRollupGameIndex({
    required TezosAddress alice,
    required TezosAddress bob,
  }) : alice = alice.ensureIsPubAddress(),
       bob = bob.ensureIsPubAddress();
  factory TezosSmartRollupGameIndex.fromJson(Map<String, dynamic> json) {
    return TezosSmartRollupGameIndex(
      alice: TezosAddress(json.valueAsString("alice")),
      bob: TezosAddress(json.valueAsString("bob")),
    );
  }

  static Layout<TezosSmartRollupGameIndex> layout() =>
      ObjSeqLayout<TezosSmartRollupGameIndex>(
        [
          TezosLayoutUtils.publicKeyHashLayout(),
          TezosLayoutUtils.publicKeyHashLayout(),
        ],
        build:
            (v) => TezosSmartRollupGameIndex(
              alice: v[0] as TezosAddress,
              bob: v[1] as TezosAddress,
            ),
        unbuild: (v) => [v.alice, v.bob],
      );
  @override
  Map<String, dynamic> toJson() {
    return {"alice": alice.address, "bob": bob.address};
  }

  @override
  Layout<TezosSmartRollupGameIndex> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [alice, bob];
}

// APPROX: rollup address (20 bytes) by convention.
class TezosSmartRollupTimeoutOperation extends TezosManagerOperationContent {
  final TezosAddress rollup;
  final TezosSmartRollupGameIndex stakers;

  TezosSmartRollupTimeoutOperation({
    required super.source,
    required super.fee,
    required super.counter,
    required super.gasLimit,
    required super.storageLimit,
    required TezosAddress rollup,
    required this.stakers,
  }) : rollup = rollup.ensureIsRollUp(),
       super(type: TezosOperationKind.smartRollupTimeout);

  factory TezosSmartRollupTimeoutOperation.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return TezosSmartRollupTimeoutOperation(
      source: TezosAddress(json.valueAsString("source")),
      fee: json.valueAsBigInt("fee"),
      counter: json.valueAsBigInt("counter"),
      gasLimit: json.valueAsBigInt("gas_limit"),
      storageLimit: json.valueAsBigInt("storage_limit"),
      rollup: TezosAddress(json.valueAsString("rollup")),
      stakers: TezosSmartRollupGameIndex.fromJson(
        json.valueEnsureAsMap("stakers"),
      ),
    );
  }

  static Layout<TezosSmartRollupTimeoutOperation> layout() =>
      ObjSeqLayout<TezosSmartRollupTimeoutOperation>(
        [
          TezosLayoutUtils.publicKeyHashLayout(), // source
          TezosLayoutUtils.tzNat, // fee
          TezosLayoutUtils.tzNat, // counter
          TezosLayoutUtils.tzNat, // gas_limit
          TezosLayoutUtils.tzNat, // storage_limit
          LayoutConst.fixedBlobN(20), // rollup
          TezosSmartRollupGameIndex.layout(), // stakers
        ],
        build:
            (v) => TezosSmartRollupTimeoutOperation(
              source: v[0] as TezosAddress,
              fee: v[1] as BigInt,
              counter: v[2] as BigInt,
              gasLimit: v[3] as BigInt,
              storageLimit: v[4] as BigInt,
              rollup: TezosAddress.smartRollupBytes(v[5] as List<int>),
              stakers: v[6] as TezosSmartRollupGameIndex,
            ),
        unbuild:
            (v) => [
              v.source,
              v.fee,
              v.counter,
              v.gasLimit,
              v.storageLimit,
              v.rollup.hashBytes,
              v.stakers,
            ],
      );

  @override
  List<dynamic> get variables => [
    source,
    fee,
    counter,
    gasLimit,
    storageLimit,
    rollup,
    stakers,
  ];

  @override
  Layout<TezosSmartRollupTimeoutOperation> toLayot() {
    return layout();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),

      "rollup": rollup.address,
      "stakers": stakers.toJson(),
    }.notNullValue;
  }

  @override
  TezosSmartRollupTimeoutOperation copyWith({
    TezosAddress? source,
    BigInt? fee,
    BigInt? counter,
    BigInt? gasLimit,
    BigInt? storageLimit,
    TezosAddress? rollup,
    TezosSmartRollupGameIndex? stakers,
  }) {
    return TezosSmartRollupTimeoutOperation(
      source: source ?? this.source,
      fee: fee ?? this.fee,
      counter: counter ?? this.counter,
      gasLimit: gasLimit ?? this.gasLimit,
      storageLimit: storageLimit ?? this.storageLimit,
      rollup: rollup ?? this.rollup,
      stakers: stakers ?? this.stakers,
    );
  }
}

// /// Sc_rollup_game_repr.refutation -- both "Start" and "Move" cases, now
// /// that Sc_rollup_dissection_chunk_repr.ml and Sc_rollup_proof_repr.ml (and
// /// Sc_rollup_inbox_repr.ml for Dal_slot_repr.Page bits) are in hand.
// ///
// /// Confirmed by this pass, not guessed:
// ///  - Sc_rollup_tick_repr.encoding = Data_encoding.n (tick IS tzNat -- the
// ///    earlier guess was right).
// ///  - dissection_chunk = obj2 (opt "state" State_hash.encoding) (req "tick" ...).
// ///  - raw_data_proof's payload is explicitly `Bounded.string
// ///    ~length_kind:`Uint16 ...` -- a confirmed 2-byte length prefix
// ///    (TezosDynamicBytesLayout16), distinct from the 4-byte convention used
// ///    for every other variable field in this file.
// ///  - Page.Index.encoding = Data_encoding.int16 (page_index is a plain
// ///    signed int16).
// ///
// /// Still APPROX / uncertain:
// ///  - `(constant "...")` kind-label fields throughout this stack: assumed
// ///    zero binary width, same caveat as TezosSmartRollupRefutationStart below --
// ///    not re-derived from source, verify against a real forged operation.
// ///  - State_hash width (32 bytes), same convention as elsewhere in this file.
// ///  - Dal_slot_index_repr.encoding width: not shown in what you sent (only
// ///    its *use* inside Page.encoding is visible); guessed as uint8 given
// ///    typical slot counts (currently well under 256) -- flagged, this one
// ///    is a genuine guess rather than a convention-based approximation.
enum TezosSmartRollupRefutationKind {
  start("start"),
  move("move");

  const TezosSmartRollupRefutationKind(this.value);
  final String value;
  static TezosSmartRollupRefutationKind fromValue(String? value) {
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw OnChainErrors.tezosPlugin(
                "TezosSmartRollupRefutationKind.lookup",
                reason: "Invalid TezosSmartRollupRefutationKind.",
                details: {"value": "$value"},
              ),
    );
  }
}

sealed class TezosSmartRollupRefutation
    extends
        OctezVariatnSerializable<
          TezosSmartRollupRefutation,
          TezosSmartRollupRefutation
        >
    with Equality {
  final TezosSmartRollupRefutationKind type;
  const TezosSmartRollupRefutation(this.type);

  static TaggedUnionLayout<TezosSmartRollupRefutation> layout() =>
      TaggedUnionLayout<TezosSmartRollupRefutation>(
        tagLayout: TezosLayoutUtils.tzUint8,
        tagFor:
            (r) => switch (r) {
              TezosSmartRollupRefutationStart _ => 0,
              TezosSmartRollupRefutationMove _ => 1,
            },
        cases: [
          UnionCase<TezosSmartRollupRefutation>(
            0,
            TezosSmartRollupRefutationStart.layout(),
          ),
          UnionCase<TezosSmartRollupRefutation>(
            1,
            TezosSmartRollupRefutationMove.layout(),
          ),
        ],
      );

  factory TezosSmartRollupRefutation.fromJson(Map<String, dynamic> json) {
    final type = TezosSmartRollupRefutationKind.fromValue(
      json.valueAsString('refutation_kind'),
    );
    return switch (type) {
      TezosSmartRollupRefutationKind.start =>
        TezosSmartRollupRefutationStart.fromJson(json),
      TezosSmartRollupRefutationKind.move =>
        TezosSmartRollupRefutationMove.fromJson(json),
    };
  }

  @override
  Map<String, dynamic> toVariantJson() {
    return {"refutation_kind": varintName, ...toJson()};
  }

  @override
  TaggedUnionLayout<TezosSmartRollupRefutation> toVariantLayot() {
    return layout();
  }

  @override
  String get varintName => type.value;
}

class TezosSmartRollupRefutationStart extends TezosSmartRollupRefutation {
  final List<int> playerCommitmentHash;
  final List<int> opponentCommitmentHash;

  TezosSmartRollupRefutationStart({
    required List<int> playerCommitmentHash,
    required List<int> opponentCommitmentHash,
  }) : playerCommitmentHash = playerCommitmentHash.asImmutableBytes,
       opponentCommitmentHash = opponentCommitmentHash.asImmutableBytes,
       super(TezosSmartRollupRefutationKind.start);
  factory TezosSmartRollupRefutationStart.fromJson(Map<String, dynamic> json) {
    return TezosSmartRollupRefutationStart(
      playerCommitmentHash: TezosUtils.decodeSmartRollupCommitment(
        json.valueAsString("player_commitment_hash"),
      ),
      opponentCommitmentHash: TezosUtils.decodeSmartRollupCommitment(
        json.valueAsString("opponent_commitment_hash"),
      ),
    );
  }
  static Layout<TezosSmartRollupRefutationStart> layout() =>
      ObjSeqLayout<TezosSmartRollupRefutationStart>(
        [
          LayoutConst.fixedBlobN(32), // player_commitment_hash
          LayoutConst.fixedBlobN(32), // opponent_commitment_hash
        ],
        build:
            (v) => TezosSmartRollupRefutationStart(
              playerCommitmentHash: v[0] as List<int>,
              opponentCommitmentHash: v[1] as List<int>,
            ),
        unbuild: (v) => [v.playerCommitmentHash, v.opponentCommitmentHash],
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      "player_commitment_hash": TezosUtils.encodeSmartRollupCommitment(
        playerCommitmentHash,
      ),
      "opponent_commitment_hash": TezosUtils.encodeSmartRollupCommitment(
        opponentCommitmentHash,
      ),
    };
  }

  @override
  Layout<TezosSmartRollupRefutationStart> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [playerCommitmentHash, opponentCommitmentHash];
}

class TezosSmartRollupRefutationMove extends TezosSmartRollupRefutation {
  final BigInt choice; // Sc_rollup_tick_repr.encoding = n
  final TezosSmartRollupStep step;
  TezosSmartRollupRefutationMove({required this.choice, required this.step})
    : super(TezosSmartRollupRefutationKind.move);
  factory TezosSmartRollupRefutationMove.fromJson(Map<String, dynamic> json) {
    return TezosSmartRollupRefutationMove(
      choice: json.valueAsBigInt("choice"),
      step: TezosSmartRollupStep.fromJson(json.valueAs("step")),
    );
  }

  static Layout<TezosSmartRollupRefutationMove> layout() =>
      ObjSeqLayout<TezosSmartRollupRefutationMove>(
        [TezosLayoutUtils.tzNat, TezosSmartRollupStep.layout()],
        build:
            (v) => TezosSmartRollupRefutationMove(
              choice: v[0] as BigInt,
              step: v[1] as TezosSmartRollupStep,
            ),
        unbuild: (v) => [v.choice, v.step],
      );

  @override
  Map<String, dynamic> toJson() {
    return {"choice": choice.toString(), "step": step.toJson()};
  }

  @override
  Layout<TezosSmartRollupRefutationMove> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [choice, step];
}

/// Sc_rollup_dissection_chunk_repr.t: {state_hash: State_hash.t option; tick}.
class TezosSmartRollupDissectionChunk
    extends OctezSerializable<TezosSmartRollupDissectionChunk>
    with Equality {
  final List<int>? stateHash;
  final BigInt tick;

  TezosSmartRollupDissectionChunk({
    required this.stateHash,
    required this.tick,
  });

  factory TezosSmartRollupDissectionChunk.fromJson(Map<String, dynamic> json) {
    return TezosSmartRollupDissectionChunk(
      stateHash: json.valueTo<List<int>?, String>(
        key: "state",
        parse: TezosUtils.decodeSmartRollupState,
      ),
      tick: json.valueAsBigInt("tick"),
    );
  }
  static Layout<TezosSmartRollupDissectionChunk> layout() =>
      ObjSeqLayout<TezosSmartRollupDissectionChunk>(
        [
          TezosLayoutUtils.optionLayout(LayoutConst.fixedBlobN(32)), // state
          TezosLayoutUtils.tzNat, // tick
        ],
        build:
            (v) => TezosSmartRollupDissectionChunk(
              stateHash: v[0] as List<int>?,
              tick: v[1] as BigInt,
            ),
        unbuild: (v) => [v.stateHash, v.tick],
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      "tick": tick.toString(),
      "state": switch (stateHash) {
        List<int> hash => TezosUtils.encodeSmartRollupState(hash),
        _ => null,
      },
    }.notNullValue;
  }

  @override
  Layout<TezosSmartRollupDissectionChunk> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [stateHash, tick];
}

/// Dal_slot_repr.Page.t: {slot_id: {published_level; index}; page_index}.
/// APPROX: Dal_slot_index_repr width guessed as uint8 (not shown in source
/// you sent). page_index (int16) is confirmed.
class TezosSmartRollupDalPageId
    extends OctezSerializable<TezosSmartRollupDalPageId>
    with Equality {
  final int publishedLevel;
  final int slotIndex;
  final int pageIndex;

  TezosSmartRollupDalPageId({
    required this.publishedLevel,
    required this.slotIndex,
    required this.pageIndex,
  });
  factory TezosSmartRollupDalPageId.fromJson(Map<String, dynamic> json) {
    return TezosSmartRollupDalPageId(
      publishedLevel: json.valueAsInt("published_level"),
      slotIndex: json.valueAsInt("slot_index"),
      pageIndex: json.valueAsInt('page_index'),
    );
  }
  static Layout<TezosSmartRollupDalPageId> layout() =>
      ObjSeqLayout<TezosSmartRollupDalPageId>(
        [
          TezosLayoutUtils.tzInt32, // published_level
          TezosLayoutUtils.tzUint8, // slot_index (APPROX width)
          LayoutConst.i16Be(),
        ],
        build:
            (v) => TezosSmartRollupDalPageId(
              publishedLevel: v[0] as int,
              slotIndex: v[1] as int,
              pageIndex: v[2] as int,
            ),
        unbuild: (v) => [v.publishedLevel, v.slotIndex, v.pageIndex],
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      "published_level": publishedLevel,
      "slot_index": slotIndex,
      "page_index": pageIndex,
    };
  }

  @override
  Layout<TezosSmartRollupDalPageId> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [publishedLevel, slotIndex, pageIndex];
}

enum ScRollupTezosRevealOperationProofKind {
  rawDataProof("raw_data_proof"),
  metadataProof("metadata_proof"),
  dalPageProof("dal_page_proof"),
  dalParametersProof("dal_parameters_proof");

  final String value;
  const ScRollupTezosRevealOperationProofKind(this.value);
  static ScRollupTezosRevealOperationProofKind fromValue(String? value) {
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw OnChainErrors.tezosPlugin(
                "ScRollupTezosRevealOperationProofKind.lookup",
                reason: "Invalid ScRollupTezosRevealOperationProofKind.",
                details: {"value": "$value"},
              ),
    );
  }
}

/// Sc_rollup_proof_repr.reveal_proof, all 4 cases confirmed from source.
sealed class ScRollupTezosRevealOperationProof
    extends
        OctezVariatnSerializable<
          ScRollupTezosRevealOperationProof,
          ScRollupTezosRevealOperationProof
        >
    with Equality {
  final ScRollupTezosRevealOperationProofKind type;
  const ScRollupTezosRevealOperationProof(this.type);
  factory ScRollupTezosRevealOperationProof.fromJson(
    Map<String, dynamic> json,
  ) {
    final type = ScRollupTezosRevealOperationProofKind.fromValue(
      json.valueAsString("reveal_proof_kind"),
    );
    final ScRollupTezosRevealOperationProof decode = switch (type) {
      ScRollupTezosRevealOperationProofKind.rawDataProof =>
        ScRollupRawDataProof.fromJson(json),
      ScRollupTezosRevealOperationProofKind.metadataProof =>
        ScRollupMetadataProof(),
      ScRollupTezosRevealOperationProofKind.dalPageProof =>
        ScRollupDalPageProof.fromJson(json),
      ScRollupTezosRevealOperationProofKind.dalParametersProof =>
        ScRollupDalParametersProof(),
    };
    return decode;
  }

  static TaggedUnionLayout<ScRollupTezosRevealOperationProof> layout() =>
      TaggedUnionLayout<ScRollupTezosRevealOperationProof>(
        tagLayout: TezosLayoutUtils.tzUint8,
        tagFor:
            (r) => switch (r) {
              ScRollupRawDataProof _ => 0,
              ScRollupMetadataProof _ => 1,
              ScRollupDalPageProof _ => 2,
              ScRollupDalParametersProof _ => 3,
            },
        cases: [
          UnionCase<ScRollupTezosRevealOperationProof>(
            0,
            ScRollupRawDataProof.layout(),
          ),
          UnionCase<ScRollupTezosRevealOperationProof>(
            1,
            ScRollupMetadataProof.layout(),
          ),
          UnionCase<ScRollupTezosRevealOperationProof>(
            2,
            ScRollupDalPageProof.layout(),
          ),
          UnionCase<ScRollupTezosRevealOperationProof>(
            3,
            ScRollupDalParametersProof.layout(),
          ),
        ],
      );
  @override
  Map<String, dynamic> toVariantJson() {
    return {"reveal_proof_kind": varintName, ...toJson()};
  }

  @override
  TaggedUnionLayout<ScRollupTezosRevealOperationProof> toVariantLayot() {
    return layout();
  }

  @override
  String get varintName => type.value;
}

class ScRollupRawDataProof extends ScRollupTezosRevealOperationProof {
  final List<int> data; // Uint16-length-prefixed (confirmed)
  ScRollupRawDataProof({required List<int> data})
    : data = data.asImmutableBytes,
      super(ScRollupTezosRevealOperationProofKind.rawDataProof);
  factory ScRollupRawDataProof.fromJson(Map<String, dynamic> json) {
    return ScRollupRawDataProof(
      data: json.valueAsBytes("raw_data", allowHex: true),
    );
  }

  static Layout<ScRollupRawDataProof> layout() =>
      ObjSeqLayout<ScRollupRawDataProof>(
        [DynamicBytesLayout(discriminator: LayoutConst.u16be())],
        build: (v) => ScRollupRawDataProof(data: v[0] as List<int>),
        unbuild: (v) => [v.data],
      );
  @override
  Map<String, dynamic> toJson() {
    return {"raw_data": BytesUtils.toHexString(data)};
  }

  @override
  Layout<ScRollupRawDataProof> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [data];
}

class ScRollupDalPageProof extends ScRollupTezosRevealOperationProof {
  final TezosSmartRollupDalPageId pageId;
  final List<int> proof; // Dal_slot_repr.History.proof = bytes Hex
  ScRollupDalPageProof({required this.pageId, required List<int> proof})
    : proof = proof.asImmutableBytes,
      super(ScRollupTezosRevealOperationProofKind.dalPageProof);
  factory ScRollupDalPageProof.fromJson(Map<String, dynamic> json) {
    return ScRollupDalPageProof(
      pageId: TezosSmartRollupDalPageId.fromJson(
        json.valueEnsureAsMap("dal_page_id"),
      ),
      proof: json.valueAsBytes("dal_proof", allowHex: true),
    );
  }

  static Layout<ScRollupDalPageProof> layout() =>
      ObjSeqLayout<ScRollupDalPageProof>(
        [TezosSmartRollupDalPageId.layout(), DynamicBytesLayout()],
        build:
            (v) => ScRollupDalPageProof(
              pageId: v[0] as TezosSmartRollupDalPageId,
              proof: v[1] as List<int>,
            ),
        unbuild: (v) => [v.pageId, v.proof],
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      "dal_page_id": pageId.toJson(),
      "dal_proof": BytesUtils.toHexString(proof),
    };
  }

  @override
  Layout<ScRollupDalPageProof> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [pageId, proof];
}

class ScRollupDalParametersProof extends ScRollupTezosRevealOperationProof {
  const ScRollupDalParametersProof()
    : super(ScRollupTezosRevealOperationProofKind.dalParametersProof);
  @override
  Map<String, dynamic> toJson() {
    return {};
  }

  static EmptyLayout<ScRollupDalParametersProof> layout() =>
      EmptyLayout(ScRollupDalParametersProof());

  @override
  Layout<ScRollupDalParametersProof> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [];
}

class ScRollupMetadataProof extends ScRollupTezosRevealOperationProof {
  const ScRollupMetadataProof()
    : super(ScRollupTezosRevealOperationProofKind.metadataProof);
  @override
  Map<String, dynamic> toJson() {
    return {};
  }

  static EmptyLayout<ScRollupMetadataProof> layout() =>
      EmptyLayout(ScRollupMetadataProof());

  @override
  Layout<ScRollupMetadataProof> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [];
}

enum TezosSmartRollupInputProofKind {
  revealProof("reveal_proof"),
  inboxProof("inbox_proof"),
  firstInput("first_input");

  final String value;
  const TezosSmartRollupInputProofKind(this.value);
  static TezosSmartRollupInputProofKind fromValue(String? value) {
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw OnChainErrors.tezosPlugin(
                "TezosSmartRollupInputProofKind.lookup",
                reason: "Invalid TezosSmartRollupInputProofKind.",
                details: {"value": "$value"},
              ),
    );
  }
}

// /// Sc_rollup_proof_repr.input_proof, all 3 cases confirmed from source.
sealed class TezosSmartRollupInputProof
    extends
        OctezVariatnSerializable<
          TezosSmartRollupInputProof,
          TezosSmartRollupInputProof
        >
    with Equality {
  final TezosSmartRollupInputProofKind type;
  const TezosSmartRollupInputProof(this.type);
  factory TezosSmartRollupInputProof.fromJson(Map<String, dynamic> json) {
    final type = TezosSmartRollupInputProofKind.fromValue(
      json.valueAsString("input_proof_kind"),
    );
    return switch (type) {
      TezosSmartRollupInputProofKind.revealProof =>
        ScRollupTezosRevealOperationInputProof.fromJson(json),
      TezosSmartRollupInputProofKind.inboxProof =>
        TezosSmartRollupInboxProof.fromJson(json),
      TezosSmartRollupInputProofKind.firstInput =>
        TezosSmartRollupFirstInboxMessage(),
    };
  }
  static TaggedUnionLayout<TezosSmartRollupInputProof> layout() =>
      TaggedUnionLayout<TezosSmartRollupInputProof>(
        tagLayout: TezosLayoutUtils.tzUint8,
        tagFor:
            (r) => switch (r) {
              TezosSmartRollupInboxProof _ => 0,
              ScRollupTezosRevealOperationInputProof _ => 1,
              TezosSmartRollupFirstInboxMessage _ => 2,
            },
        cases: [
          UnionCase<TezosSmartRollupInputProof>(
            0,
            TezosSmartRollupInboxProof.layout(),
          ),
          UnionCase<TezosSmartRollupInputProof>(
            1,
            ScRollupTezosRevealOperationInputProof.layout(),
          ),
          UnionCase<TezosSmartRollupInputProof>(
            2,
            TezosSmartRollupFirstInboxMessage.layout(),
          ),
        ],
      );
  @override
  TaggedUnionLayout<TezosSmartRollupInputProof> toVariantLayot() {
    return layout();
  }

  @override
  Map<String, dynamic> toVariantJson() {
    return {"input_proof_kind": varintName, ...toJson()};
  }

  @override
  String get varintName => type.value;
}

class TezosSmartRollupInboxProof extends TezosSmartRollupInputProof {
  final int level;
  final BigInt messageCounter; // Data_encoding.n
  final List<int>
  serializedProof; // Sc_rollup_inbox_repr.serialized_proof = string Hex
  TezosSmartRollupInboxProof({
    required this.level,
    required this.messageCounter,
    required this.serializedProof,
  }) : super(TezosSmartRollupInputProofKind.inboxProof);
  factory TezosSmartRollupInboxProof.fromJson(Map<String, dynamic> json) {
    return TezosSmartRollupInboxProof(
      level: json.valueAsInt("level"),
      messageCounter: json.valueAsBigInt("message_counter"),
      serializedProof: json.valueAsBytes("serialized_proof", allowHex: true),
    );
  }
  static Layout<TezosSmartRollupInboxProof> layout() =>
      ObjSeqLayout<TezosSmartRollupInboxProof>(
        [
          TezosLayoutUtils.tzInt32,
          TezosLayoutUtils.tzNat,
          const DynamicBytesLayout(),
        ],
        build:
            (v) => TezosSmartRollupInboxProof(
              level: v[0] as int,
              messageCounter: v[1] as BigInt,
              serializedProof: v[2] as List<int>,
            ),
        unbuild: (v) => [v.level, v.messageCounter, v.serializedProof],
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      "level": level,
      "message_counter": messageCounter.toString(),
      "serialized_proof": BytesUtils.toHexString(serializedProof),
    };
  }

  @override
  Layout<TezosSmartRollupInboxProof> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [level, messageCounter, serializedProof];
}

class ScRollupTezosRevealOperationInputProof
    extends TezosSmartRollupInputProof {
  final ScRollupTezosRevealOperationProof reveal;
  ScRollupTezosRevealOperationInputProof({required this.reveal})
    : super(TezosSmartRollupInputProofKind.revealProof);
  factory ScRollupTezosRevealOperationInputProof.fromJson(
    Map<String, dynamic> json,
  ) {
    return ScRollupTezosRevealOperationInputProof(
      reveal: ScRollupTezosRevealOperationProof.fromJson(
        json.valueEnsureAsMap("reveal_proof"),
      ),
    );
  }
  static Layout<ScRollupTezosRevealOperationInputProof> layout() =>
      ObjSeqLayout<ScRollupTezosRevealOperationInputProof>(
        [ScRollupTezosRevealOperationProof.layout()],
        build:
            (v) => ScRollupTezosRevealOperationInputProof(
              reveal: v[0] as ScRollupTezosRevealOperationProof,
            ),
        unbuild: (v) => [v.reveal],
      );
  @override
  Map<String, dynamic> toJson() {
    return {"reveal_proof": reveal.toVariantJson()};
  }

  @override
  Layout<ScRollupTezosRevealOperationInputProof> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [reveal];
}

class TezosSmartRollupFirstInboxMessage extends TezosSmartRollupInputProof {
  TezosSmartRollupFirstInboxMessage()
    : super(TezosSmartRollupInputProofKind.firstInput);

  static Layout<TezosSmartRollupFirstInboxMessage> layout() =>
      EmptyLayout<TezosSmartRollupFirstInboxMessage>(
        TezosSmartRollupFirstInboxMessage(),
      );

  @override
  Map<String, dynamic> toJson() {
    return {};
  }

  @override
  Layout<TezosSmartRollupFirstInboxMessage> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [];
}

/// Sc_rollup_proof_repr.t = {pvm_step: string Hex; input_proof: option}.
/// `pvm_step` is the PVM-kind-specific serialized proof blob -- opaque
/// bytes here by design (the real protocol treats it as opaque too, per
/// the module's own doc comment on why `proof` is `bytes` and not a
/// structured type). Not the last field of the obj2, so length-prefixed
/// per this file's usual convention.
class TezosSmartRollupProof extends OctezSerializable<TezosSmartRollupProof>
    with Equality {
  final List<int> pvmStep;
  final TezosSmartRollupInputProof? inputProof;
  TezosSmartRollupProof({required List<int> pvmStep, required this.inputProof})
    : pvmStep = pvmStep.asImmutableBytes;
  factory TezosSmartRollupProof.fromJson(Map<String, dynamic> json) {
    return TezosSmartRollupProof(
      pvmStep: json.valueAsBytes("pvm_step", allowHex: true),
      inputProof: json
          .valueTo<TezosSmartRollupInputProof?, Map<String, dynamic>>(
            key: "input_proof",
            parse: TezosSmartRollupInputProof.fromJson,
          ),
    );
  }
  static Layout<TezosSmartRollupProof> layout() =>
      ObjSeqLayout<TezosSmartRollupProof>(
        [
          const DynamicBytesLayout(),
          TezosLayoutUtils.optionLayout(TezosSmartRollupInputProof.layout()),
        ],
        build:
            (v) => TezosSmartRollupProof(
              pvmStep: v[0] as List<int>,
              inputProof: v[1] as TezosSmartRollupInputProof?,
            ),
        unbuild: (v) => [v.pvmStep, v.inputProof],
      );
  @override
  Map<String, dynamic> toJson() {
    return {
      "pvm_step": BytesUtils.toHexString(pvmStep),
      "input_proof": inputProof?.toVariantJson(),
    }.notNullValue;
  }

  @override
  Layout<TezosSmartRollupProof> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [pvmStep, inputProof];
}

// / Sc_rollup_game_repr.step: Dissection (list of chunks) | Proof.
sealed class TezosSmartRollupStep
    extends OctezSerializable<TezosSmartRollupStep>
    with Equality {
  const TezosSmartRollupStep();
  factory TezosSmartRollupStep.fromJson(dynamic json) {
    if (json is List) {
      return TezosSmartRollupStepDissection.fromJson(
        JsonParser.valueEnsureAsList<Map<String, dynamic>>(json),
      );
    }
    return TezosSmartRollupStepProof.fromJson(
      JsonParser.valueEnsureAsMap<String, dynamic>(json),
    );
  }

  static Layout<TezosSmartRollupStep> layout() =>
      TaggedUnionLayout<TezosSmartRollupStep>(
        tagLayout: TezosLayoutUtils.tzUint8,
        tagFor:
            (r) => switch (r) {
              TezosSmartRollupStepDissection _ => 0,
              TezosSmartRollupStepProof _ => 1,
            },
        cases: [
          UnionCase<TezosSmartRollupStep>(
            0,
            TezosSmartRollupStepDissection.layout(),
          ),
          UnionCase<TezosSmartRollupStep>(
            1,
            TezosSmartRollupStepProof.layout(),
          ),
        ],
      );
}

class TezosSmartRollupStepDissection extends TezosSmartRollupStep {
  final List<TezosSmartRollupDissectionChunk> chunks;
  TezosSmartRollupStepDissection({required this.chunks});
  factory TezosSmartRollupStepDissection.fromJson(
    List<Map<String, dynamic>> json,
  ) {
    return TezosSmartRollupStepDissection(
      chunks: json.map(TezosSmartRollupDissectionChunk.fromJson).toList(),
    );
  }

  static ObjSeqLayout<TezosSmartRollupStepDissection> layout() =>
      ObjSeqLayout<TezosSmartRollupStepDissection>(
        [
          DynamicSizeLayout(
            RemainderListLayout(TezosSmartRollupDissectionChunk.layout()),
          ),
        ],
        build:
            (values) => TezosSmartRollupStepDissection(
              chunks: values[0] as List<TezosSmartRollupDissectionChunk>,
            ),
        unbuild: (v) => [v.chunks],
      );

  @override
  List<Map<String, dynamic>> toJson() {
    return chunks.map((e) => e.toJson()).toList();
  }

  @override
  Layout<TezosSmartRollupStep> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [chunks];
}

class TezosSmartRollupStepProof extends TezosSmartRollupStep {
  final TezosSmartRollupProof proof;
  TezosSmartRollupStepProof({required this.proof});
  factory TezosSmartRollupStepProof.fromJson(Map<String, dynamic> json) {
    return TezosSmartRollupStepProof(
      proof: TezosSmartRollupProof.fromJson(json),
    );
  }
  static ObjSeqLayout<TezosSmartRollupStepProof> layout() =>
      ObjSeqLayout<TezosSmartRollupStepProof>(
        [TezosSmartRollupProof.layout()],
        build:
            (v) =>
                TezosSmartRollupStepProof(proof: v[0] as TezosSmartRollupProof),
        unbuild: (v) => [v.proof],
      );

  @override
  Map<String, dynamic> toJson() {
    return proof.toJson();
  }

  @override
  Layout<TezosSmartRollupStep> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [proof];
}

// APPROX: rollup address (20 bytes) by convention. `opponent` = Staker.t =
// a plain public key hash.
class TezosSmartRollupRefuteOperation extends TezosManagerOperationContent {
  final TezosAddress rollup;
  final TezosAddress opponent;
  final TezosSmartRollupRefutation refutation;

  TezosSmartRollupRefuteOperation({
    required super.source,
    required super.fee,
    required super.counter,
    required super.gasLimit,
    required super.storageLimit,
    required TezosAddress rollup,
    required TezosAddress opponent,
    required this.refutation,
  }) : rollup = rollup.ensureIsRollUp(),
       opponent = opponent.ensureIsPubAddress(),
       super(type: TezosOperationKind.smartRollupRefute);

  factory TezosSmartRollupRefuteOperation.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return TezosSmartRollupRefuteOperation(
      source: TezosAddress(json.valueAsString("source")),
      fee: json.valueAsBigInt("fee"),
      counter: json.valueAsBigInt("counter"),
      gasLimit: json.valueAsBigInt("gas_limit"),
      storageLimit: json.valueAsBigInt("storage_limit"),
      rollup: TezosAddress(json.valueAsString("rollup")),
      opponent: TezosAddress(json.valueAs("opponent")),
      refutation: TezosSmartRollupRefutation.fromJson(
        json.valueEnsureAsMap("refutation"),
      ),
    );
  }

  static Layout<TezosSmartRollupRefuteOperation> layout() =>
      ObjSeqLayout<TezosSmartRollupRefuteOperation>(
        [
          TezosLayoutUtils.publicKeyHashLayout(), // source
          TezosLayoutUtils.tzNat, // fee
          TezosLayoutUtils.tzNat, // counter
          TezosLayoutUtils.tzNat, // gas_limit
          TezosLayoutUtils.tzNat, // storage_limit
          LayoutConst.fixedBlobN(20), // rollup
          TezosLayoutUtils.publicKeyHashLayout(), // opponent
          TezosSmartRollupRefutation.layout(), // refutation
        ],
        build:
            (v) => TezosSmartRollupRefuteOperation(
              source: v[0] as TezosAddress,
              fee: v[1] as BigInt,
              counter: v[2] as BigInt,
              gasLimit: v[3] as BigInt,
              storageLimit: v[4] as BigInt,
              rollup: TezosAddress.smartRollupBytes(v[5] as List<int>),
              opponent: v[6] as TezosAddress,
              refutation: v[7] as TezosSmartRollupRefutation,
            ),
        unbuild:
            (v) => [
              v.source,
              v.fee,
              v.counter,
              v.gasLimit,
              v.storageLimit,
              v.rollup.hashBytes,
              v.opponent,
              v.refutation,
            ],
      );

  @override
  Layout<TezosSmartRollupRefuteOperation> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [
    source,
    fee,
    counter,
    gasLimit,
    storageLimit,
    rollup,
    opponent,
    refutation,
  ];

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),

      "rollup": rollup.address,
      "opponent": opponent.address,
      "refutation": refutation.toVariantJson(),
    }.notNullValue;
  }

  @override
  TezosSmartRollupRefuteOperation copyWith({
    TezosAddress? source,
    BigInt? fee,
    BigInt? counter,
    BigInt? gasLimit,
    BigInt? storageLimit,
    TezosAddress? rollup,
    TezosAddress? opponent,
    TezosSmartRollupRefutation? refutation,
  }) {
    return TezosSmartRollupRefuteOperation(
      source: source ?? this.source,
      fee: fee ?? this.fee,
      counter: counter ?? this.counter,
      gasLimit: gasLimit ?? this.gasLimit,
      storageLimit: storageLimit ?? this.storageLimit,
      rollup: rollup ?? this.rollup,
      opponent: opponent ?? this.opponent,
      refutation: refutation ?? this.refutation,
    );
  }
}

class TezosAttestationOperationWithDalOperation extends TezosOperationContent {
  final TezosConsensusContent consensusContent;
  final BigInt dalTezosAttestationOperation; // Z.t

  TezosAttestationOperationWithDalOperation({
    required this.consensusContent,
    required this.dalTezosAttestationOperation,
  }) : super(TezosOperationKind.attestationWithDal);

  factory TezosAttestationOperationWithDalOperation.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return TezosAttestationOperationWithDalOperation(
      consensusContent: TezosConsensusContent.fromJson(json),
      dalTezosAttestationOperation: json.valueAsBigInt("dal_attestation"),
    );
  }

  static Layout<TezosAttestationOperationWithDalOperation> layout() =>
      ObjSeqLayout<TezosAttestationOperationWithDalOperation>(
        [TezosConsensusContent.layout(), TezosLayoutUtils.tzZ],
        build:
            (v) => TezosAttestationOperationWithDalOperation(
              consensusContent: v[0] as TezosConsensusContent,
              dalTezosAttestationOperation: v[1] as BigInt,
            ),
        unbuild: (v) => [v.consensusContent, v.dalTezosAttestationOperation],
      );

  @override
  Layout<TezosAttestationOperationWithDalOperation> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [
    consensusContent,
    dalTezosAttestationOperation,
  ];

  @override
  Map<String, dynamic> toJson() {
    return {
      ...consensusContent.toJson(),
      "dal_attestation": dalTezosAttestationOperation.toString(),
    };
  }
}

enum TezosZkCircuitVisibility {
  public("public"),
  private("private"),
  fee("fee");

  final String value;
  const TezosZkCircuitVisibility(this.value);
  static Layout<TezosZkCircuitVisibility> layout() =>
      ConvLayout<TezosZkCircuitVisibility, int>(
        TezosLayoutUtils.tzUint8,
        toWire: (v) => v.index,
        fromWire: (i) => TezosZkCircuitVisibility.values[i],
      );
  static TezosZkCircuitVisibility deserializeJson(Map<String, dynamic> json) {
    final key = json.keys.firstOrNull;
    return values.firstWhere(
      (e) => e.value == key,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid Tezos ZK circuit visibility.",
              ),
    );
  }

  Map<String, dynamic> toJson() => {name: {}};
}

class TezosZkCircuitInfo extends OctezSerializable<TezosZkCircuitInfo>
    with Equality {
  final List<int> name; // length-prefixed bytes
  final TezosZkCircuitVisibility kind;
  TezosZkCircuitInfo({required this.name, required this.kind});
  factory TezosZkCircuitInfo.fromJson(List<dynamic> json) {
    json = json.exc(
      length: 2,
      operation: "TezosZkCircuitInfo",
      reason: "Invalid TezosZkCircuitInfo json data.",
    );
    return TezosZkCircuitInfo(
      name: TezosOctezCodecUtils.decodeString(json[0]),
      kind: TezosZkCircuitVisibility.deserializeJson(json[1]),
    );
  }

  static Layout<TezosZkCircuitInfo> layout() =>
      ObjSeqLayout<TezosZkCircuitInfo>(
        [const DynamicBytesLayout(), TezosZkCircuitVisibility.layout()],
        build:
            (v) => TezosZkCircuitInfo(
              name: v[0] as List<int>,
              kind: v[1] as TezosZkCircuitVisibility,
            ),
        unbuild: (v) => [v.name, v.kind],
      );

  @override
  List<dynamic> toJson() {
    return [TezosOctezCodecUtils.encodeString(name), kind.toJson()];
  }

  @override
  Layout<TezosZkCircuitInfo> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [name];
}

class TezosZkRollupPrice extends OctezSerializable<TezosZkRollupPrice>
    with Equality {
  final List<int> id; // 32 bytes
  final BigInt amount; // Z.t
  TezosZkRollupPrice({required this.id, required this.amount});
  factory TezosZkRollupPrice.fromJson(Map<String, dynamic> json) {
    return TezosZkRollupPrice(
      id: TezosUtils.decodeScriptExpr(json.valueAsString("id")),
      amount: json.valueAsBigInt("amount"),
    );
  }
  static Layout<TezosZkRollupPrice> layout() =>
      ObjSeqLayout<TezosZkRollupPrice>(
        [LayoutConst.fixedBlobN(32), TezosLayoutUtils.tzZ],
        build:
            (v) => TezosZkRollupPrice(
              id: v[0] as List<int>,
              amount: v[1] as BigInt,
            ),
        unbuild: (v) => [v.id, v.amount],
      );

  @override
  Map<String, dynamic> toJson() {
    return {"id": TezosUtils.encodeScriptExpr(id), "amount": amount.toString()};
  }

  @override
  Layout<TezosZkRollupPrice> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [id, amount];
}

class TezosZkRollupL2Operation
    extends OctezSerializable<TezosZkRollupL2Operation>
    with Equality {
  final int opCode; // int31 -- modeled as int32, values fit
  final TezosZkRollupPrice price;
  final TezosAddress l1Dst;
  final TezosAddress rollupId; // 20 bytes
  final List<List<int>> payload;
  TezosZkRollupL2Operation({
    required this.opCode,
    required this.price,
    required TezosAddress l1Dst,
    required TezosAddress rollupId,
    required this.payload,
  }) : l1Dst = l1Dst.ensureIsPubAddress(),
       rollupId = rollupId.ensureIsZkRollUp();
  factory TezosZkRollupL2Operation.deserializeJson(Map<String, dynamic> json) {
    return TezosZkRollupL2Operation(
      opCode: json.valueAsInt("op_code"),
      price: TezosZkRollupPrice.fromJson(json.valueEnsureAsMap("price")),
      l1Dst: TezosAddress(json.valueAsString("l1_dst")),
      rollupId: TezosAddress(json.valueAsString("rollup_id")),
      payload:
          json
              .valueEnsureAsList<String>("payload")
              .map(BytesUtils.fromHexString)
              .toList(),
    );
  }
  static Layout<TezosZkRollupL2Operation>
  layout() => ObjSeqLayout<TezosZkRollupL2Operation>(
    [
      TezosLayoutUtils.tzInt32, // op_code
      TezosZkRollupPrice.layout(), // price
      TezosLayoutUtils.publicKeyHashLayout(), // l1_dst
      LayoutConst.fixedBlobN(20), // rollup_id
      const DynamicBytesLayout(),
    ],
    build: (v) {
      final List<int> bytes = JsonParser.valueAsBytes(v[4]);
      final List<List<int>> payload;
      if (bytes.isEmpty) {
        payload = const [];
      } else if (bytes.length % 32 == 0) {
        payload = List.generate(
          bytes.length ~/ 32,
          (i) => bytes.sublist(i * 32, i * 32 + 32),
        );
      } else {
        // Protocol scalars are 32 bytes; reject or keep as single opaque chunk
        throw OnChainErrors.tezosPlugin(
          "TezosZkRollupL2Operation",
          reason:
              'TezosZkRollupL2Operation.payload length ${bytes.length} is not a multiple of 32',
        );
      }
      return TezosZkRollupL2Operation(
        opCode: v[0] as int,
        price: v[1] as TezosZkRollupPrice,
        l1Dst: v[2] as TezosAddress,
        rollupId: TezosAddress.zkRollupBytes(v[3] as List<int>),
        payload: payload,
      );
    },
    unbuild:
        (v) => [
          v.opCode,
          v.price,
          v.l1Dst,
          v.rollupId.hashBytes,
          v.payload.expand((e) => e).toList(),
        ],
  );

  @override
  Map<String, dynamic> toJson() {
    return {
      "op_code": opCode,
      "price": price.toJson(),
      "l1_dst": l1Dst.address,
      "rollup_id": rollupId.address,
      "payload": payload.map(BytesUtils.toHexString).toList(),
    };
  }

  @override
  Layout<TezosZkRollupL2Operation> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [
    opCode,
    price,
    l1Dst,
    rollupId.hashBytes,
    payload,
  ];
}

class TezosZkRollupTicket extends OctezSerializable<TezosZkRollupTicket>
    with Equality {
  final MichelineExpr contents;
  final MichelineExpr ty;
  final TezosAddress ticketer; // 22 bytes, alpha.contract_id
  TezosZkRollupTicket({
    required this.contents,
    required this.ty,
    required TezosAddress ticketer,
  }) : ticketer = ticketer.ensureIsContractAddress();
  factory TezosZkRollupTicket.fromJson(Map<String, dynamic> json) {
    return TezosZkRollupTicket(
      contents: MichelineExpr.deserializeJson(json.valueAs("contents")),
      ty: MichelineExpr.deserializeJson(json.valueAs("ty")),
      ticketer: TezosAddress(json.valueAsString("ticketer")),
    );
  }
  static Layout<TezosZkRollupTicket> layout() =>
      ObjSeqLayout<TezosZkRollupTicket>(
        [
          MichelineExpr.layout(),
          MichelineExpr.layout(),
          LayoutConst.fixedBlobN(22),
        ],
        build:
            (v) => TezosZkRollupTicket(
              contents: v[0] as MichelineExpr,
              ty: v[1] as MichelineExpr,
              ticketer: TezosUtils.decodeDestinationAddr(v[2]),
            ),
        unbuild:
            (v) => [
              v.contents,
              v.ty,
              TezosUtils.encodeDestinationAddr(v.ticketer),
            ],
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      "contents": contents.toJson(),
      "ty": ty.toJson(),
      "ticketer": ticketer.address,
    };
  }

  @override
  Layout<TezosZkRollupTicket> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [contents, ty, ticketer];
}

/// X_8: (Zk_rollup_operation_repr.t, Zk_rollup_ticket_repr.t option)
class TezosZkRollupPublishItem
    extends OctezSerializable<TezosZkRollupPublishItem>
    with Equality {
  final TezosZkRollupL2Operation op;
  final TezosZkRollupTicket? ticket;
  TezosZkRollupPublishItem({required this.op, required this.ticket});
  factory TezosZkRollupPublishItem.fromJson(List<dynamic> json) {
    json = json.min(
      length: 1,
      operation: "TezosZkRollupPublishItem",
      reason: "Invalid TezosZkRollupPublishItem json",
    );
    final ticket = json.elementAtOrNull(1);
    return TezosZkRollupPublishItem(
      op: TezosZkRollupL2Operation.deserializeJson(
        JsonParser.valueEnsureAsMap(json[0]),
      ),
      ticket:
          ticket == null
              ? null
              : TezosZkRollupTicket.fromJson(
                JsonParser.valueEnsureAsMap(ticket),
              ),
    );
  }
  static Layout<TezosZkRollupPublishItem> layout() =>
      ObjSeqLayout<TezosZkRollupPublishItem>(
        [
          TezosZkRollupL2Operation.layout(),
          TezosLayoutUtils.optionLayout(TezosZkRollupTicket.layout()),
        ],
        build:
            (v) => TezosZkRollupPublishItem(
              op: v[0] as TezosZkRollupL2Operation,
              ticket: v[1] as TezosZkRollupTicket?,
            ),
        unbuild: (v) => [v.op, v.ticket],
      );

  @override
  List<dynamic> toJson() {
    return [op.toJson(), ticket?.toJson()];
  }

  @override
  Layout<TezosZkRollupPublishItem> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [op, ticket];
}

// ---------------------------------------------------------------------------
// Update-only pieces (X_0/X_1/X_3/X_4/X_6/X_7)
// ---------------------------------------------------------------------------

class TezosZkPendingPi extends OctezSerializable<TezosZkPendingPi> {
  final List<List<int>> newState; // bytes list, length-prefixed outer
  final List<int> fee; // 32 bytes
  final bool exitValidity;
  TezosZkPendingPi({
    required this.newState,
    required this.fee,
    required this.exitValidity,
  });
  factory TezosZkPendingPi.deserializeJson(Map<String, dynamic> json) {
    return TezosZkPendingPi(
      newState:
          json
              .valueEnsureAsList<String>("new_state")
              .map(BytesUtils.fromHexString)
              .toList(),
      fee: json.valueAsBytes("fee", allowHex: true),
      exitValidity: json.valueAsBool("exit_validity"),
    );
  }
  static Layout<TezosZkPendingPi> layout() => ObjSeqLayout<TezosZkPendingPi>(
    [
      DynamicSizeLayout(
        RemainderListLayout(DynamicBytesLayout()),
      ), // new_state (see note above)
      LayoutConst.fixedBlobN(32), // fee
      TezosLayoutUtils.tzBool, // exit_validity
    ],
    build:
        (v) => TezosZkPendingPi(
          newState: v[0] as List<List<int>>,
          fee: v[1] as List<int>,
          exitValidity: v[2] as bool,
        ),
    unbuild: (v) => [v.newState, v.fee, v.exitValidity],
  );

  @override
  Map<String, dynamic> toJson() {
    return {
      "new_state": newState.map(BytesUtils.toHexString).toList(),
      "fee": BytesUtils.toHexString(fee),
      "exit_validity": exitValidity,
    };
  }

  @override
  Layout<TezosZkPendingPi> toLayot() {
    return layout();
  }
}

class TezosZkPendingEntry extends OctezSerializable<TezosZkPendingEntry> {
  final List<int> id; // plain length-prefixed bytes
  final TezosZkPendingPi pi;
  TezosZkPendingEntry({required this.id, required this.pi});
  factory TezosZkPendingEntry.deserializeJson(List<dynamic> json) {
    json = json.exc(
      length: 2,
      operation: "TezosZkPendingEntry",
      reason: "Invalid TezosZkPendingEntry json data.",
    );
    return TezosZkPendingEntry(
      id: TezosOctezCodecUtils.decodeString(json[0]),
      pi: TezosZkPendingPi.deserializeJson(
        JsonParser.valueEnsureAsMap(json[1]),
      ),
    );
  }
  static Layout<TezosZkPendingEntry> layout() =>
      ObjSeqLayout<TezosZkPendingEntry>(
        [const DynamicBytesLayout(), TezosZkPendingPi.layout()],
        build:
            (v) => TezosZkPendingEntry(
              id: v[0] as List<int>,
              pi: v[1] as TezosZkPendingPi,
            ),
        unbuild: (v) => [v.id, v.pi],
      );

  @override
  List<dynamic> toJson() {
    return [TezosOctezCodecUtils.encodeString(id), pi.toJson()];
  }

  @override
  Layout<TezosZkPendingEntry> toLayot() {
    return layout();
  }
}

class TezosZkPrivatePi extends OctezSerializable<TezosZkPrivatePi> {
  final List<List<int>> newState;
  final List<int> fee; // 32 bytes
  TezosZkPrivatePi({required this.newState, required this.fee});
  factory TezosZkPrivatePi.deserializeJson(Map<String, dynamic> json) {
    return TezosZkPrivatePi(
      newState:
          json
              .valueEnsureAsList<String>("new_state")
              .map(BytesUtils.fromHexString)
              .toList(),
      fee: json.valueAsBytes("fee", allowHex: true),
    );
  }
  static Layout<TezosZkPrivatePi> layout() => ObjSeqLayout<TezosZkPrivatePi>(
    [
      DynamicSizeLayout(RemainderListLayout(DynamicBytesLayout())), //
      LayoutConst.fixedBlobN(32),
    ],
    build:
        (v) => TezosZkPrivatePi(
          newState: v[0] as List<List<int>>,
          fee: v[1] as List<int>,
        ),
    unbuild: (v) => [v.newState, v.fee],
  );

  @override
  Map<String, dynamic> toJson() {
    return {
      "new_state": newState.map(BytesUtils.toHexString).toList(),
      "fee": BytesUtils.toHexString(fee),
    };
  }

  @override
  Layout<TezosZkPrivatePi> toLayot() {
    return layout();
  }
}

class TezosZkPrivateEntry extends OctezSerializable<TezosZkPrivateEntry> {
  final List<int> id;
  final TezosZkPrivatePi pi;
  TezosZkPrivateEntry({required this.id, required this.pi});
  factory TezosZkPrivateEntry.deserializeJson(List<dynamic> json) {
    json = json.exc(
      length: 2,
      operation: "TezosZkPrivateEntry",
      reason: "Invalid TezosZkPrivateEntry json data.",
    );
    return TezosZkPrivateEntry(
      id: TezosOctezCodecUtils.decodeString(json[0]),
      pi: TezosZkPrivatePi.deserializeJson(
        JsonParser.valueEnsureAsMap(json[1]),
      ),
    );
  }
  static Layout<TezosZkPrivateEntry> layout() =>
      ObjSeqLayout<TezosZkPrivateEntry>(
        [const DynamicBytesLayout(), TezosZkPrivatePi.layout()],
        build:
            (v) => TezosZkPrivateEntry(
              id: v[0] as List<int>,
              pi: v[1] as TezosZkPrivatePi,
            ),
        unbuild: (v) => [v.id, v.pi],
      );

  @override
  List<dynamic> toJson() {
    return [TezosOctezCodecUtils.encodeString(id), pi.toJson()];
  }

  @override
  Layout<TezosZkPrivateEntry> toLayot() {
    return layout();
  }
}

class TezosZkFeePi extends OctezSerializable<TezosZkFeePi> {
  final List<List<int>> newState;
  TezosZkFeePi({required this.newState});
  factory TezosZkFeePi.deserializeJson(Map<String, dynamic> json) {
    return TezosZkFeePi(
      newState:
          json
              .valueEnsureAsList<String>("new_state")
              .map(BytesUtils.fromHexString)
              .toList(),
    );
  }
  static Layout<TezosZkFeePi> layout() => ObjSeqLayout<TezosZkFeePi>(
    [
      DynamicSizeLayout(RemainderListLayout(DynamicBytesLayout())), //
    ],
    build: (v) => TezosZkFeePi(newState: v[0] as List<List<int>>),
    unbuild: (v) => [v.newState],
  );

  @override
  Map<String, dynamic> toJson() {
    return {"new_state": newState.map(BytesUtils.toHexString).toList()};
  }

  @override
  Layout<TezosZkFeePi> toLayot() {
    return layout();
  }
}

class TezosZkRollupUpdateBody
    extends OctezSerializable<TezosZkRollupUpdateBody> {
  final List<TezosZkPendingEntry> pendingPis;
  final List<TezosZkPrivateEntry> privatePis;
  final TezosZkFeePi feePi; // bytes list, length-prefixed outer
  final List<int> proof;
  TezosZkRollupUpdateBody({
    required this.pendingPis,
    required this.privatePis,
    required this.feePi,
    required this.proof,
  });
  factory TezosZkRollupUpdateBody.fromJson(Map<String, dynamic> json) {
    return TezosZkRollupUpdateBody(
      pendingPis:
          json
              .valueEnsureAsList<List>("pending_pis")
              .map<TezosZkPendingEntry>(TezosZkPendingEntry.deserializeJson)
              .toList(),
      privatePis:
          json
              .valueEnsureAsList<List>("private_pis")
              .map<TezosZkPrivateEntry>(TezosZkPrivateEntry.deserializeJson)
              .toList(),
      feePi: TezosZkFeePi.deserializeJson(json.valueAsMap("fee_pi")),
      proof: json.valueAsBytes("proof", allowHex: true),
    );
  }

  static Layout<TezosZkRollupUpdateBody> layout() =>
      ObjSeqLayout<TezosZkRollupUpdateBody>(
        [
          DynamicSizeLayout(
            RemainderListLayout(TezosZkPendingEntry.layout()),
          ), // pending_pis
          DynamicSizeLayout(
            RemainderListLayout(TezosZkPrivateEntry.layout()),
          ), // private_pis
          TezosZkFeePi.layout(), // fee_pi (see TezosZkPendingPi note)
          const DynamicBytesLayout(), // proof
        ],
        build:
            (v) => TezosZkRollupUpdateBody(
              pendingPis: v[0] as List<TezosZkPendingEntry>,
              privatePis: v[1] as List<TezosZkPrivateEntry>,
              feePi: v[2] as TezosZkFeePi,
              proof: v[3] as List<int>,
            ),
        unbuild: (v) => [v.pendingPis, v.privatePis, v.feePi, v.proof],
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      "pending_pis": pendingPis.map((e) => e.toJson()).toList(),
      "private_pis": privatePis.map((e) => e.toJson()).toList(),
      "fee_pi": feePi.toJson(),
      "proof": BytesUtils.toHexString(proof),
    };
  }

  @override
  Layout<TezosZkRollupUpdateBody> toLayot() {
    return layout();
  }
}

// ---------------------------------------------------------------------------
// The 3 operation content classes -- `extends TezosOperationContent` once pasted
// into the generated file (kept plain here since this file doesn't import
// that hierarchy). All 5 manager-common fields (source/fee/counter/
// gasLimit/storageLimit) prepend as usual.
// ---------------------------------------------------------------------------

class TezosZkRollupOriginationOperation extends TezosManagerOperationContent {
  final List<int> publicParameters; // opaque, length-prefixed (see file header)
  final List<TezosZkCircuitInfo> circuitsInfo;
  final List<List<int>> initState;
  final int nbOps; // int31

  TezosZkRollupOriginationOperation({
    required super.source,
    required super.fee,
    required super.counter,
    required super.gasLimit,
    required super.storageLimit,
    required this.publicParameters,
    required this.circuitsInfo,
    required this.initState,
    required this.nbOps,
  }) : super(type: TezosOperationKind.zkRollupOperation);

  factory TezosZkRollupOriginationOperation.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return TezosZkRollupOriginationOperation(
      source: TezosAddress(json.valueAsString("source")),
      fee: json.valueAsBigInt("fee"),
      counter: json.valueAsBigInt("counter"),
      gasLimit: json.valueAsBigInt("gas_limit"),
      storageLimit: json.valueAsBigInt("storage_limit"),
      publicParameters: json.valueAsBytes("public_parameters", allowHex: true),
      circuitsInfo:
          json
              .valueEnsureAsList<List>("circuits_info")
              .map(TezosZkCircuitInfo.fromJson)
              .toList(),
      initState:
          json
              .valueEnsureAsList<String>("init_state")
              .map(BytesUtils.fromHexString)
              .toList(),
      nbOps: json.valueAsInt("nb_ops"),
    );
  }

  static Layout<TezosZkRollupOriginationOperation> layout() =>
      ObjSeqLayout<TezosZkRollupOriginationOperation>(
        [
          TezosLayoutUtils.publicKeyHashLayout(),
          TezosLayoutUtils.tzNat,
          TezosLayoutUtils.tzNat,
          TezosLayoutUtils.tzNat,
          TezosLayoutUtils.tzNat,
          const DynamicBytesLayout(), // public_parameters
          DynamicSizeLayout(
            RemainderListLayout(TezosZkCircuitInfo.layout()),
          ), // circuits_info
          DynamicSizeLayout(
            RemainderListLayout(const DynamicBytesLayout()),
          ), // init_state
          TezosLayoutUtils.tzInt32, // nb_ops
        ],
        build:
            (v) => TezosZkRollupOriginationOperation(
              source: v[0] as TezosAddress,
              fee: v[1] as BigInt,
              counter: v[2] as BigInt,
              gasLimit: v[3] as BigInt,
              storageLimit: v[4] as BigInt,
              publicParameters: v[5] as List<int>,
              circuitsInfo: v[6] as List<TezosZkCircuitInfo>,
              initState: v[7] as List<List<int>>,
              nbOps: v[8] as int,
            ),
        unbuild:
            (v) => [
              v.source,
              v.fee,
              v.counter,
              v.gasLimit,
              v.storageLimit,
              v.publicParameters,
              v.circuitsInfo,
              v.initState,
              v.nbOps,
            ],
      );

  @override
  Layout<TezosZkRollupOriginationOperation> toLayot() {
    return layout();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),

      "public_parameters": BytesUtils.toHexString(publicParameters),
      "circuits_info": circuitsInfo.map((e) => e.toJson()).toList(),
      "init_state": initState.map(BytesUtils.toHexString).toList(),
      "nb_ops": nbOps,
    }.notNullValue;
  }

  @override
  List<dynamic> get variables => [
    source,
    fee,
    counter,
    gasLimit,
    storageLimit,
    publicParameters,
    circuitsInfo,
    initState,
    nbOps,
  ];

  @override
  TezosZkRollupOriginationOperation copyWith({
    TezosAddress? source,
    BigInt? fee,
    BigInt? counter,
    BigInt? gasLimit,
    BigInt? storageLimit,
    List<int>? publicParameters,
    List<TezosZkCircuitInfo>? circuitsInfo,
    List<List<int>>? initState,
    int? nbOps,
  }) {
    return TezosZkRollupOriginationOperation(
      source: source ?? this.source,
      fee: fee ?? this.fee,
      counter: counter ?? this.counter,
      gasLimit: gasLimit ?? this.gasLimit,
      storageLimit: storageLimit ?? this.storageLimit,
      publicParameters: publicParameters ?? this.publicParameters,
      circuitsInfo: circuitsInfo ?? this.circuitsInfo,
      initState: initState ?? this.initState,
      nbOps: nbOps ?? this.nbOps,
    );
  }
}

class TezosZkRollupPublishOperation extends TezosManagerOperationContent {
  final TezosAddress zkRollup; // 20 bytes
  final List<TezosZkRollupPublishItem> op;
  factory TezosZkRollupPublishOperation.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return TezosZkRollupPublishOperation(
      source: TezosAddress(json.valueAsString("source")),
      fee: json.valueAsBigInt("fee"),
      counter: json.valueAsBigInt("counter"),
      gasLimit: json.valueAsBigInt("gas_limit"),
      storageLimit: json.valueAsBigInt("storage_limit"),
      op:
          json
              .valueEnsureAsList<List>("op")
              .map(TezosZkRollupPublishItem.fromJson)
              .toList(),
      zkRollup: TezosAddress(json.valueAsString("zk_rollup")),
    );
  }

  TezosZkRollupPublishOperation({
    required super.source,
    required super.fee,
    required super.counter,
    required super.gasLimit,
    required super.storageLimit,
    required TezosAddress zkRollup,
    required this.op,
  }) : zkRollup = zkRollup.ensureIsZkRollUp(),
       super(type: TezosOperationKind.zkRollupPublish);

  static Layout<TezosZkRollupPublishOperation> layout() =>
      ObjSeqLayout<TezosZkRollupPublishOperation>(
        [
          TezosLayoutUtils.publicKeyHashLayout(),
          TezosLayoutUtils.tzNat,
          TezosLayoutUtils.tzNat,
          TezosLayoutUtils.tzNat,
          TezosLayoutUtils.tzNat,
          LayoutConst.fixedBlobN(20), // zk_rollup
          DynamicSizeLayout(
            RemainderListLayout(TezosZkRollupPublishItem.layout()),
          ), // op
        ],
        build:
            (v) => TezosZkRollupPublishOperation(
              source: v[0] as TezosAddress,
              fee: v[1] as BigInt,
              counter: v[2] as BigInt,
              gasLimit: v[3] as BigInt,
              storageLimit: v[4] as BigInt,
              zkRollup: TezosAddress.zkRollupBytes(v[5] as List<int>),
              op: v[6] as List<TezosZkRollupPublishItem>,
            ),
        unbuild:
            (v) => [
              v.source,
              v.fee,
              v.counter,
              v.gasLimit,
              v.storageLimit,
              v.zkRollup.hashBytes,
              v.op,
            ],
      );

  @override
  Layout<TezosZkRollupPublishOperation> toLayot() {
    return layout();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),

      "zk_rollup": zkRollup.address,
      "op": op.map((e) => e.toJson()).toList(),
    }.notNullValue;
  }

  @override
  List<dynamic> get variables => [
    source,
    fee,
    counter,
    gasLimit,
    storageLimit,
    zkRollup,
    op,
  ];

  @override
  TezosZkRollupPublishOperation copyWith({
    TezosAddress? source,
    BigInt? fee,
    BigInt? counter,
    BigInt? gasLimit,
    BigInt? storageLimit,
    TezosAddress? zkRollup,
    List<TezosZkRollupPublishItem>? op,
  }) {
    return TezosZkRollupPublishOperation(
      source: source ?? this.source,
      fee: fee ?? this.fee,
      counter: counter ?? this.counter,
      gasLimit: gasLimit ?? this.gasLimit,
      storageLimit: storageLimit ?? this.storageLimit,
      zkRollup: zkRollup ?? this.zkRollup,
      op: op ?? this.op,
    );
  }
}

class TezosZkRollupUpdateOperation extends TezosManagerOperationContent {
  final TezosAddress zkRollup; // 20 bytes
  final TezosZkRollupUpdateBody update;

  TezosZkRollupUpdateOperation({
    required super.source,
    required super.fee,
    required super.counter,
    required super.gasLimit,
    required super.storageLimit,
    required TezosAddress zkRollup,
    required this.update,
  }) : zkRollup = zkRollup.ensureIsZkRollUp(),
       super(type: TezosOperationKind.zkRollupUpdate);
  factory TezosZkRollupUpdateOperation.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return TezosZkRollupUpdateOperation(
      source: TezosAddress(json.valueAsString("source")),
      fee: json.valueAsBigInt("fee"),
      counter: json.valueAsBigInt("counter"),
      gasLimit: json.valueAsBigInt("gas_limit"),
      storageLimit: json.valueAsBigInt("storage_limit"),

      zkRollup: TezosAddress(json.valueAsString("zk_rollup")),
      update: TezosZkRollupUpdateBody.fromJson(json.valueEnsureAsMap("update")),
    );
  }
  static Layout<TezosZkRollupUpdateOperation> layout() =>
      ObjSeqLayout<TezosZkRollupUpdateOperation>(
        [
          TezosLayoutUtils.publicKeyHashLayout(),
          TezosLayoutUtils.tzNat,
          TezosLayoutUtils.tzNat,
          TezosLayoutUtils.tzNat,
          TezosLayoutUtils.tzNat,
          LayoutConst.fixedBlobN(20),
          TezosZkRollupUpdateBody.layout(),
        ],
        build:
            (v) => TezosZkRollupUpdateOperation(
              source: v[0] as TezosAddress,
              fee: v[1] as BigInt,
              counter: v[2] as BigInt,
              gasLimit: v[3] as BigInt,
              storageLimit: v[4] as BigInt,
              zkRollup: TezosAddress.zkRollupBytes(v[5] as List<int>),
              update: v[6] as TezosZkRollupUpdateBody,
            ),
        unbuild:
            (v) => [
              v.source,
              v.fee,
              v.counter,
              v.gasLimit,
              v.storageLimit,
              v.zkRollup.hashBytes,
              v.update,
            ],
      );
  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),

      "zk_rollup": zkRollup.address,
      "update": update.toJson(),
    }.notNullValue;
  }

  @override
  List<dynamic> get variables => [
    source,
    fee,
    counter,
    gasLimit,
    storageLimit,
    zkRollup,
    update,
  ];

  @override
  Layout<TezosZkRollupUpdateOperation> toLayot() {
    return layout();
  }

  @override
  TezosZkRollupUpdateOperation copyWith({
    TezosAddress? source,
    BigInt? fee,
    BigInt? counter,
    BigInt? gasLimit,
    BigInt? storageLimit,
    TezosAddress? zkRollup,
    TezosZkRollupUpdateBody? update,
  }) {
    return TezosZkRollupUpdateOperation(
      source: source ?? this.source,
      fee: fee ?? this.fee,
      counter: counter ?? this.counter,
      gasLimit: gasLimit ?? this.gasLimit,
      storageLimit: storageLimit ?? this.storageLimit,
      zkRollup: zkRollup ?? this.zkRollup,
      update: update ?? this.update,
    );
  }
}

class TezosVdfSolution extends OctezSerializable<TezosVdfSolution>
    with Equality {
  final List<int> result;
  final List<int> proof;
  TezosVdfSolution({required List<int> result, required List<int> proof})
    : result = result.asImmutableBytes.exc(
        length: 100,
        operation: "TezosVdfSolution",
        reason: "Invalid result bytes length.",
      ),
      proof = proof.asImmutableBytes.exc(
        length: 100,
        operation: "TezosVdfSolution",
        reason: "Invalid proof bytes length.",
      );
  factory TezosVdfSolution.fromJson(List<String> json) {
    json = json.exc(
      length: 2,
      operation: "TezosVdfSolution",
      reason: "Invalid TezosVdfSolution json data.",
    );
    return TezosVdfSolution(
      result: JsonParser.valueAsBytes(json[0], allowHex: true),
      proof: JsonParser.valueAsBytes(json[1], allowHex: true),
    );
  }
  static Layout<TezosVdfSolution> layout() => ObjSeqLayout<TezosVdfSolution>(
    [LayoutConst.fixedBlobN(100), LayoutConst.fixedBlobN(100)],
    build:
        (v) => TezosVdfSolution(
          result: v[0] as List<int>,
          proof: v[1] as List<int>,
        ),
    unbuild: (s) => [s.result, s.proof],
  );

  @override
  List<String> toJson() {
    return [BytesUtils.toHexString(result), BytesUtils.toHexString(proof)];
  }

  @override
  Layout<TezosVdfSolution> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [result, proof];
}

class TezosVdfRevelationOperation extends TezosOperationContent {
  final TezosVdfSolution solution;
  TezosVdfRevelationOperation({required this.solution})
    : super(TezosOperationKind.vdfRevelation);
  factory TezosVdfRevelationOperation.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return TezosVdfRevelationOperation(
      solution: TezosVdfSolution.fromJson(
        json.valueEnsureAsList<String>("solution"),
      ),
    );
  }
  static Layout<TezosVdfRevelationOperation> layout() =>
      ObjSeqLayout<TezosVdfRevelationOperation>(
        [TezosVdfSolution.layout()],
        build:
            (v) =>
                TezosVdfRevelationOperation(solution: v[0] as TezosVdfSolution),
        unbuild: (v) => [v.solution],
      );

  @override
  Map<String, dynamic> toJson() {
    return {"solution": solution.toJson()};
  }

  @override
  Layout<TezosOperationContent> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [solution];
}

class TezosBlockHeaderShell extends OctezSerializable<TezosBlockHeaderShell>
    with Equality {
  final int level;
  final int protoLevel;
  final List<int> predecessor; // 32
  final BigInt timestamp; // signed int64
  final int validationPasses;
  final List<int> operationsHash; // 32
  final List<List<int>> fitness;
  final List<int> context; // 32

  TezosBlockHeaderShell({
    required this.level,
    required this.protoLevel,
    required List<int> predecessor,
    required this.timestamp,
    required this.validationPasses,
    required List<int> operationsHash,
    required this.fitness,
    required List<int> context,
  }) : predecessor = predecessor.asImmutableBytes.exc(
         length: 32,
         operation: "TezosBlockHeaderShell",
         reason: "Invalid predecessor length.",
       ),
       operationsHash = operationsHash.asImmutableBytes.exc(
         length: 32,
         operation: "TezosBlockHeaderShell",
         reason: "Invalid operation hash bytes length.",
       ),
       context = context.asImmutableBytes.exc(
         length: 32,
         operation: "TezosBlockHeaderShell",
         reason: "Invalid context length.",
       );

  factory TezosBlockHeaderShell.fromJson(Map<String, dynamic> json) {
    return TezosBlockHeaderShell(
      level: json.valueAsInt("level"),
      protoLevel: json.valueAsInt("proto"),
      predecessor: TezosUtils.decodeBlockHash(
        json.valueAsString("predecessor"),
      ),
      timestamp: json.valueTo<BigInt, String>(
        key: "timestamp",
        parse: (e) {
          final toBig = BigintUtils.tryParse(e);
          if (toBig != null) return toBig;
          return TezosOctezCodecUtils.isoDateTimetoSecond(e);
        },
      ), // protocol may use ISO string
      validationPasses: json.valueAsInt("validation_pass"),
      operationsHash: TezosUtils.decodeLLo(
        json.valueAsString("operations_hash"),
      ),
      fitness:
          json
              .valueEnsureAsList<String>("fitness")
              .map(BytesUtils.fromHexString)
              .toList(),
      context: TezosUtils.decodeContext(json.valueAsString("context")),
    );
  }

  static Layout<TezosBlockHeaderShell> layout() =>
      ObjSeqLayout<TezosBlockHeaderShell>(
        [
          TezosLayoutUtils.tzInt32,
          TezosLayoutUtils.tzUint8,
          LayoutConst.fixedBlobN(32),
          LayoutConst.i64Be(),
          TezosLayoutUtils.tzUint8,
          LayoutConst.fixedBlobN(32),
          DynamicSizeLayout(RemainderListLayout(const DynamicBytesLayout())),
          LayoutConst.fixedBlobN(32),
        ],
        build:
            (v) => TezosBlockHeaderShell(
              level: v[0] as int,
              protoLevel: v[1] as int,
              predecessor: v[2] as List<int>,
              timestamp: v[3] as BigInt,
              validationPasses: v[4] as int,
              operationsHash: v[5] as List<int>,
              fitness: v[6] as List<List<int>>,
              context: v[7] as List<int>,
            ),
        unbuild:
            (v) => [
              v.level,
              v.protoLevel,
              v.predecessor,
              v.timestamp,
              v.validationPasses,
              v.operationsHash,
              v.fitness,
              v.context,
            ],
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      "level": level,
      "proto": protoLevel,
      "predecessor": TezosUtils.encodeBlockHash(predecessor),
      "timestamp": TezosOctezCodecUtils.encodeIsoSecondTimestamp(timestamp),
      "validation_pass": validationPasses,
      "operations_hash": TezosUtils.encodeLLo(operationsHash),
      "fitness": fitness.map(BytesUtils.toHexString).toList(),
      "context": TezosUtils.encodeContext(context),
    };
  }

  @override
  Layout<TezosBlockHeaderShell> toLayot() => layout();

  @override
  List<dynamic> get variables => [
    level,
    protoLevel,
    predecessor,
    timestamp,
    validationPasses,
    operationsHash,
    fitness,
    context,
  ];
}

enum TezosPerBlockVote {
  on("on"),
  off("off"),
  pass("pass");

  final String value;
  const TezosPerBlockVote(this.value);

  static Layout<TezosPerBlockVote> layout() =>
      ConvLayout<TezosPerBlockVote, int>(
        TezosLayoutUtils.tzUint8,
        toWire: (v) => v.index,
        fromWire: (i) => TezosPerBlockVote.values[i],
      );

  static TezosPerBlockVote fromValue(String? value) {
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw OnChainErrors.tezosPlugin(
                "TezosPerBlockVote.lookup",
                reason: "Invalid TezosPerBlockVote.",
                details: {"value": "$value"},
              ),
    );
  }
}

class TezosBlockHeaderContents
    extends OctezSerializable<TezosBlockHeaderContents>
    with Equality {
  final List<int> payloadHash; // 32
  final int payloadRound;
  final List<int> proofOfWorkNonce; // 8
  final List<int>? seedNonceHash; // 32 opt
  final TezosPerBlockVote liquidityBakingToggleVote;

  TezosBlockHeaderContents({
    required List<int> payloadHash,
    required this.payloadRound,
    required List<int> proofOfWorkNonce,
    required this.seedNonceHash,
    required this.liquidityBakingToggleVote,
  }) : payloadHash = payloadHash.asImmutableBytes.exc(
         length: 32,
         operation: "TezosBlockHeaderContents",
       ),
       proofOfWorkNonce = proofOfWorkNonce.asImmutableBytes.exc(
         length: 8,
         operation: "TezosBlockHeaderContents",
       );

  factory TezosBlockHeaderContents.fromJson(Map<String, dynamic> json) {
    return TezosBlockHeaderContents(
      payloadHash: TezosUtils.decodeValueHash(
        json.valueAsString("payload_hash"),
      ),
      payloadRound: json.valueAsInt("payload_round"),
      proofOfWorkNonce: json.valueAsBytes(
        "proof_of_work_nonce",
        allowHex: true,
      ),
      seedNonceHash: json.valueTo<List<int>?, String>(
        key: "seed_nonce_hash",
        parse: (s) => TezosUtils.decodeNonceHash(s),
      ),
      liquidityBakingToggleVote: TezosPerBlockVote.fromValue(
        json.valueAsString("liquidity_baking_toggle_vote"),
      ),
    );
  }

  static Layout<TezosBlockHeaderContents> layout() =>
      ObjSeqLayout<TezosBlockHeaderContents>(
        [
          LayoutConst.fixedBlobN(32),
          TezosLayoutUtils.tzInt32,
          LayoutConst.fixedBlobN(8),
          TezosLayoutUtils.optionLayout(LayoutConst.fixedBlobN(32)),
          TezosPerBlockVote.layout(),
        ],
        build:
            (v) => TezosBlockHeaderContents(
              payloadHash: v[0] as List<int>,
              payloadRound: v[1] as int,
              proofOfWorkNonce: v[2] as List<int>,
              seedNonceHash: v[3] as List<int>?,
              liquidityBakingToggleVote: v[4] as TezosPerBlockVote,
            ),
        unbuild:
            (v) => [
              v.payloadHash,
              v.payloadRound,
              v.proofOfWorkNonce,
              v.seedNonceHash,
              v.liquidityBakingToggleVote,
            ],
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      "payload_hash": TezosUtils.encodeValueHash(payloadHash),
      "payload_round": payloadRound,
      "proof_of_work_nonce": BytesUtils.toHexString(proofOfWorkNonce),
      "seed_nonce_hash":
          seedNonceHash == null
              ? null
              : TezosUtils.encodeNonceHash(seedNonceHash!),
      "liquidity_baking_toggle_vote": liquidityBakingToggleVote.value,
    }.notNullValue;
  }

  @override
  Layout<TezosBlockHeaderContents> toLayot() => layout();

  @override
  List<dynamic> get variables => [
    payloadHash,
    payloadRound,
    proofOfWorkNonce,
    seedNonceHash,
    liquidityBakingToggleVote,
  ];
}

class TezosBlockHeader extends OctezSerializable<TezosBlockHeader>
    with Equality {
  final TezosBlockHeaderShell shell;
  final TezosBlockHeaderContents contents;
  final TezosSignature signature; // raw tail (variable)

  TezosBlockHeader({
    required this.shell,
    required this.contents,
    required this.signature,
  });

  factory TezosBlockHeader.fromJson(Map<String, dynamic> json) {
    return TezosBlockHeader(
      shell: TezosBlockHeaderShell.fromJson(json),
      contents: TezosBlockHeaderContents.fromJson(json),
      signature: TezosSignature.decode(json.valueAsString("signature")),
    );
  }

  static Layout<TezosBlockHeader> layout() => ObjSeqLayout<TezosBlockHeader>(
    [
      TezosBlockHeaderShell.layout(),
      TezosBlockHeaderContents.layout(),
      const RawTailLayout(),
    ],
    build:
        (v) => TezosBlockHeader(
          shell: v[0] as TezosBlockHeaderShell,
          contents: v[1] as TezosBlockHeaderContents,
          signature: TezosSignature.fromBytes(v[2]),
        ),
    unbuild: (v) => [v.shell, v.contents, v.signature.bytes],
  );

  @override
  Map<String, dynamic> toJson() {
    return {
      ...shell.toJson(),
      ...contents.toJson(),
      "signature": signature.encode(),
    };
  }

  @override
  Layout<TezosBlockHeader> toLayot() => layout();

  @override
  List<dynamic> get variables => [shell, contents, signature];
}

class TezosDoubleBakingOperation extends TezosOperationContent {
  final TezosBlockHeader bh1;
  final TezosBlockHeader bh2;

  TezosDoubleBakingOperation({required this.bh1, required this.bh2})
    : super(TezosOperationKind.doubleBakingEvidence);

  factory TezosDoubleBakingOperation.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return TezosDoubleBakingOperation(
      bh1: TezosBlockHeader.fromJson(json.valueEnsureAsMap("bh1")),
      bh2: TezosBlockHeader.fromJson(json.valueEnsureAsMap("bh2")),
    );
  }

  static Layout<TezosDoubleBakingOperation> layout() =>
      ObjSeqLayout<TezosDoubleBakingOperation>(
        [
          DynamicSizeLayout(TezosBlockHeader.layout()),
          DynamicSizeLayout(TezosBlockHeader.layout()),
        ],
        build:
            (v) => TezosDoubleBakingOperation(
              bh1: v[0] as TezosBlockHeader,
              bh2: v[1] as TezosBlockHeader,
            ),
        unbuild: (v) => [v.bh1, v.bh2],
      );

  @override
  Map<String, dynamic> toJson() {
    return {"bh1": bh1.toJson(), "bh2": bh2.toJson()};
  }

  @override
  Layout<TezosDoubleBakingOperation> toLayot() => layout();

  @override
  List<dynamic> get variables => [bh1, bh2];
}

// /// Inlined consensus op used by double_consensus / dal_entrapment evidence.
class TezosInlinedConsensusOperation
    extends OctezSerializable<TezosInlinedConsensusOperation>
    with Equality {
  final List<int> branch; // 32
  final TezosOperationContent operations;
  final TezosSignature? signature; // raw tail; empty = none

  TezosInlinedConsensusOperation({
    required List<int> branch,
    required this.operations,
    required this.signature,
  }) : branch = branch.asImmutableBytes.exc(
         length: 32,
         operation: "TezosInlinedConsensusOperation",
       );

  factory TezosInlinedConsensusOperation.fromJson(Map<String, dynamic> json) {
    return TezosInlinedConsensusOperation(
      branch: TezosUtils.decodeBlockHash(json.valueAsString("branch")),
      operations: TezosOperationContent.fromJson(
        json.valueEnsureAsMap("operations"),
      ),
      signature: json.valueTo<TezosSignature?, String>(
        key: "signature",
        parse: TezosSignature.decode,
      ),
    );
  }

  static Layout<TezosInlinedConsensusOperation> layout() =>
      ObjSeqLayout<TezosInlinedConsensusOperation>(
        [
          LayoutConst.fixedBlobN(32),
          // only consensus kinds are valid; still use full content layout
          // so tag dispatch matches the wire.
          LazyLayout(() => TezosOperationContent.layout()),
          const RawTailLayout(),
        ],
        build:
            (v) => TezosInlinedConsensusOperation(
              branch: v[0] as List<int>,
              operations: v[1] as TezosOperationContent,
              signature:
                  (v[2] as List).isEmpty
                      ? null
                      : TezosSignature.fromBytes(v[2]),
            ),
        unbuild: (v) => [v.branch, v.operations, v.signature?.bytes ?? <int>[]],
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      "branch": TezosUtils.encodeBlockHash(branch),
      "operations": operations.toVariantJson(),
      "signature": signature?.encode(),
    }.notNullValue;
  }

  @override
  Layout<TezosInlinedConsensusOperation> toLayot() => layout();

  @override
  List<dynamic> get variables => [branch, operations, signature];
}

class TezosDalShard extends OctezSerializable<TezosDalShard> with Equality {
  final int index;
  final List<List<int>> path;

  TezosDalShard({required this.index, required this.path});

  factory TezosDalShard.fromJson(List<dynamic> json) {
    json = json.exc(
      length: 2,
      operation: "TezosDalShard",
      reason: "Invalid TezosDalShard json (expect [index, pages]).",
    );
    return TezosDalShard(
      index: JsonParser.valueAsInt(json[0]),
      path:
          JsonParser.valueEnsureAsList<String>(
            json[1],
          ).map(BytesUtils.fromHexString).toList(),
    );
  }

  static Layout<TezosDalShard> layout() => ObjSeqLayout<TezosDalShard>(
    [
      TezosLayoutUtils.tzInt32,
      DynamicSizeLayout(RemainderListLayout(const DynamicBytesLayout())),
    ],
    build:
        (v) => TezosDalShard(index: v[0] as int, path: v[1] as List<List<int>>),
    unbuild: (v) => [v.index, v.path],
  );

  @override
  List<dynamic> toJson() {
    return [index, path.map(BytesUtils.toHexString).toList()];
  }

  @override
  Layout<TezosDalShard> toLayot() => layout();

  @override
  List<dynamic> get variables => [index, path];
}

class TezosDalShardWithProof extends OctezSerializable<TezosDalShardWithProof>
    with Equality {
  final TezosDalShard shard;
  final List<int> proof; // 48-byte DAL commitment on the wire

  TezosDalShardWithProof({required this.shard, required List<int> proof})
    : proof = proof.asImmutableBytes.exc(
        length: 48,
        operation: "TezosDalShardWithProof",
        reason: "DAL commitment proof must be 48 bytes.",
      );

  factory TezosDalShardWithProof.fromJson(Map<String, dynamic> json) {
    return TezosDalShardWithProof(
      shard: TezosDalShard.fromJson(json.valueEnsureAsList("shard")),
      proof: TezosUtils.decodeDalCommitment(json.valueAsString("proof")),
    );
  }

  static Layout<TezosDalShardWithProof> layout() =>
      ObjSeqLayout<TezosDalShardWithProof>(
        [TezosDalShard.layout(), LayoutConst.fixedBlobN(48)],
        build:
            (v) => TezosDalShardWithProof(
              shard: v[0] as TezosDalShard,
              proof: v[1] as List<int>,
            ),
        unbuild: (v) => [v.shard, v.proof],
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      "shard": shard.toJson(),
      "proof": TezosUtils.encodeDalCommitment(proof),
    };
  }

  @override
  Layout<TezosDalShardWithProof> toLayot() => layout();

  @override
  List<dynamic> get variables => [shard, proof];
}

class TezosDalEntrapmentOperation extends TezosOperationContent {
  final TezosInlinedConsensusOperation attestation;
  final int consensusSlot;
  final int slotIndex;
  final int? lagIndex;
  final TezosDalShardWithProof shardWithProof;

  TezosDalEntrapmentOperation({
    required this.attestation,
    required this.consensusSlot,
    required this.slotIndex,
    required this.lagIndex,
    required this.shardWithProof,
  }) : super(TezosOperationKind.dalEntrapmentEvidence);

  factory TezosDalEntrapmentOperation.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return TezosDalEntrapmentOperation(
      attestation: TezosInlinedConsensusOperation.fromJson(
        json.valueEnsureAsMap("attestation"),
      ),
      consensusSlot: json.valueAsInt("consensus_slot"),
      slotIndex: json.valueAsInt("slot_index"),
      lagIndex: json.valueAsInt("lag_index"),
      shardWithProof: TezosDalShardWithProof.fromJson(
        json.valueEnsureAsMap("shard_with_proof"),
      ),
    );
  }

  static Layout<TezosDalEntrapmentOperation> layout() =>
      ObjSeqLayout<TezosDalEntrapmentOperation>(
        [
          DynamicSizeLayout(TezosInlinedConsensusOperation.layout()),
          TezosLayoutUtils.tzUint16,
          TezosLayoutUtils.tzUint8,
          TezosLayoutUtils.optionLayout(TezosLayoutUtils.tzUint8),
          TezosDalShardWithProof.layout(),
        ],
        build:
            (v) => TezosDalEntrapmentOperation(
              attestation: v[0] as TezosInlinedConsensusOperation,
              consensusSlot: v[1] as int,
              slotIndex: v[2] as int,
              lagIndex: v[3] as int?,
              shardWithProof: v[4] as TezosDalShardWithProof,
            ),
        unbuild:
            (v) => [
              v.attestation,
              v.consensusSlot,
              v.slotIndex,
              v.lagIndex,
              v.shardWithProof,
            ],
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      "attestation": attestation.toJson(),
      "consensus_slot": consensusSlot,
      "slot_index": slotIndex,
      "lag_index": lagIndex,
      "shard_with_proof": shardWithProof.toJson(),
    }.notNullValue;
  }

  @override
  Layout<TezosDalEntrapmentOperation> toLayot() => layout();

  @override
  List<dynamic> get variables => [
    attestation,
    consensusSlot,
    slotIndex,
    lagIndex,
    shardWithProof,
  ];
}

class TezosDalSlotHeader extends OctezSerializable<TezosDalSlotHeader>
    with Equality {
  final int slotIndex;
  final List<int> commitment; // 48
  final List<int> commitmentProof; // 96

  TezosDalSlotHeader({
    required this.slotIndex,
    required List<int> commitment,
    required List<int> commitmentProof,
  }) : commitment = commitment.asImmutableBytes.exc(
         length: 48,
         operation: "TezosDalPublishCommitmentOperation",
       ),
       commitmentProof = commitmentProof.asImmutableBytes.exc(
         length: 96,
         operation: "TezosDalPublishCommitmentOperation",
       );

  factory TezosDalSlotHeader.deserializeJson(Map<String, dynamic> json) {
    return TezosDalSlotHeader(
      slotIndex: json.valueAsInt("slot_index"),
      commitment: TezosUtils.decodeDalCommitment(
        json.valueAsString("commitment"),
      ),
      commitmentProof: json.valueAsBytes("commitment_proof", allowHex: true),
    );
  }

  static Layout<TezosDalSlotHeader> layout() =>
      ObjSeqLayout<TezosDalSlotHeader>(
        [
          TezosLayoutUtils.tzUint8,
          LayoutConst.fixedBlobN(48),
          LayoutConst.fixedBlobN(96),
        ],
        build:
            (v) => TezosDalSlotHeader(
              slotIndex: v[0] as int,
              commitment: v[1] as List<int>,
              commitmentProof: v[2] as List<int>,
            ),
        unbuild: (v) => [v.slotIndex, v.commitment, v.commitmentProof],
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      "slot_index": slotIndex,
      "commitment": TezosUtils.encodeDalCommitment(commitment),
      "commitment_proof": BytesUtils.toHexString(commitmentProof),
    };
  }

  @override
  Layout<TezosDalSlotHeader> toLayot() => layout();

  @override
  List<dynamic> get variables => [slotIndex, commitment, commitmentProof];
}

class TezosDalPublishCommitmentOperation extends TezosManagerOperationContent {
  final TezosDalSlotHeader slotHeader;

  TezosDalPublishCommitmentOperation({
    required super.source,
    required super.fee,
    required super.counter,
    required super.gasLimit,
    required super.storageLimit,
    required this.slotHeader,
  }) : super(type: TezosOperationKind.dalPublishCommitment);

  factory TezosDalPublishCommitmentOperation.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return TezosDalPublishCommitmentOperation(
      source: TezosAddress(json.valueAsString("source")),
      fee: json.valueAsBigInt("fee"),
      counter: json.valueAsBigInt("counter"),
      gasLimit: json.valueAsBigInt("gas_limit"),
      storageLimit: json.valueAsBigInt("storage_limit"),
      slotHeader: TezosDalSlotHeader.deserializeJson(
        json.valueEnsureAsMap("slot_header"),
      ),
    );
  }

  static Layout<TezosDalPublishCommitmentOperation> layout() =>
      ObjSeqLayout<TezosDalPublishCommitmentOperation>(
        [
          TezosLayoutUtils.publicKeyHashLayout(),
          TezosLayoutUtils.tzNat,
          TezosLayoutUtils.tzNat,
          TezosLayoutUtils.tzNat,
          TezosLayoutUtils.tzNat,
          TezosDalSlotHeader.layout(),
        ],
        build:
            (v) => TezosDalPublishCommitmentOperation(
              source: v[0] as TezosAddress,
              fee: v[1] as BigInt,
              counter: v[2] as BigInt,
              gasLimit: v[3] as BigInt,
              storageLimit: v[4] as BigInt,
              slotHeader: v[5] as TezosDalSlotHeader,
            ),
        unbuild:
            (v) => [
              v.source,
              v.fee,
              v.counter,
              v.gasLimit,
              v.storageLimit,
              v.slotHeader,
            ],
      );

  @override
  Map<String, dynamic> toJson() {
    return {...super.toJson(), "slot_header": slotHeader.toJson()}.notNullValue;
  }

  @override
  Layout<TezosDalPublishCommitmentOperation> toLayot() => layout();

  @override
  List<dynamic> get variables => [
    source,
    fee,
    counter,
    gasLimit,
    storageLimit,
    slotHeader,
  ];

  @override
  TezosDalPublishCommitmentOperation copyWith({
    TezosAddress? source,
    BigInt? fee,
    BigInt? counter,
    BigInt? gasLimit,
    BigInt? storageLimit,
    TezosDalSlotHeader? slotHeader,
  }) {
    return TezosDalPublishCommitmentOperation(
      source: source ?? this.source,
      fee: fee ?? this.fee,
      counter: counter ?? this.counter,
      gasLimit: gasLimit ?? this.gasLimit,
      storageLimit: storageLimit ?? this.storageLimit,
      slotHeader: slotHeader ?? this.slotHeader,
    );
  }
}

class TezosDoubleConsensusOperation extends TezosOperationContent {
  final int slot;
  final TezosInlinedConsensusOperation op1;
  final TezosInlinedConsensusOperation op2;

  TezosDoubleConsensusOperation({
    required this.slot,
    required this.op1,
    required this.op2,
  }) : super(TezosOperationKind.doubleConsensusOperationEvidence);

  factory TezosDoubleConsensusOperation.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return TezosDoubleConsensusOperation(
      slot: json.valueAsInt("slot"),
      op1: TezosInlinedConsensusOperation.fromJson(
        json.valueEnsureAsMap("op1"),
      ),
      op2: TezosInlinedConsensusOperation.fromJson(
        json.valueEnsureAsMap("op2"),
      ),
    );
  }

  static Layout<TezosDoubleConsensusOperation> layout() =>
      ObjSeqLayout<TezosDoubleConsensusOperation>(
        [
          TezosLayoutUtils.tzUint16,
          DynamicSizeLayout(TezosInlinedConsensusOperation.layout()),
          DynamicSizeLayout(TezosInlinedConsensusOperation.layout()),
        ],
        build:
            (v) => TezosDoubleConsensusOperation(
              slot: v[0] as int,
              op1: v[1] as TezosInlinedConsensusOperation,
              op2: v[2] as TezosInlinedConsensusOperation,
            ),
        unbuild: (v) => [v.slot, v.op1, v.op2],
      );

  @override
  Map<String, dynamic> toJson() {
    return {"slot": slot, "op1": op1.toJson(), "op2": op2.toJson()};
  }

  @override
  Layout<TezosDoubleConsensusOperation> toLayot() => layout();

  @override
  List<dynamic> get variables => [slot, op1, op2];
}

extension ExtTezosOperationContent on TezosOperationContent {
  TezosOperationContent fold({
    TezosOperationContent Function(TezosOperationContent content)? onContent,
    TezosManagerOperationContent Function(TezosManagerOperationContent content)?
    onManagerContent,
  }) {
    return switch (this) {
      TezosManagerOperationContent manager =>
        onManagerContent == null ? manager : onManagerContent(manager),
      TezosOperationContent() => onContent == null ? this : onContent(this),
    };
  }
}

// /// Inlined consensus op used by double_consensus / dal_entrapment evidence.
class TezosInlinedOperation
    extends OctezSerializable<TezosInlinedConsensusOperation>
    with Equality {
  final List<int> branch; // 32
  final TezosOperationContent operations;

  TezosInlinedOperation({required List<int> branch, required this.operations})
    : branch = branch.asImmutableBytes.exc(
        length: 32,
        operation: "TezosInlinedConsensusOperation",
      );

  factory TezosInlinedOperation.fromJson(Map<String, dynamic> json) {
    return TezosInlinedOperation(
      branch: TezosUtils.decodeBlockHash(json.valueAsString("branch")),
      operations: TezosOperationContent.fromJson(
        json.valueEnsureAsMap("operations"),
      ),
    );
  }

  static Layout<TezosInlinedConsensusOperation> layout() =>
      ObjSeqLayout<TezosInlinedConsensusOperation>(
        [
          LayoutConst.fixedBlobN(32),
          LazyLayout(() => TezosOperationContent.layout()),
        ],
        build:
            (v) => TezosInlinedConsensusOperation(
              branch: v[0] as List<int>,
              operations: v[1] as TezosOperationContent,
              signature:
                  (v[2] as List).isEmpty
                      ? null
                      : TezosSignature.fromBytes(v[2]),
            ),
        unbuild: (v) => [v.branch, v.operations, v.signature?.bytes ?? <int>[]],
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      "branch": TezosUtils.encodeBlockHash(branch),
      "operations": operations.toVariantJson(),
    }.notNullValue;
  }

  @override
  Layout<TezosInlinedConsensusOperation> toLayot() => layout();

  @override
  List<dynamic> get variables => [branch, operations];
}
