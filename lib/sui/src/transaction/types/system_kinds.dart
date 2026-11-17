import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/serialization/bcs/serialization.dart';
import 'package:on_chain/sui/src/address/address/address.dart';

import 'package:on_chain/sui/src/transaction/types/types.dart';

/// Mirrors `crates/sui-types/src/transaction.rs` (`TransactionKind`,
/// `ChangeEpoch`, `ConsensusCommitPrologue[V1..V4]`, `AuthenticatorStateUpdate`,
/// `RandomnessStateUpdate`, `EndOfEpochTransactionKind`) and
/// `crates/sui-types/src/messages_consensus.rs`
/// (`ConsensusDeterminedVersionAssignments`) plus
/// `crates/sui-types/src/execution.rs` (`ExecutionTimeObservationKey`).
///
/// Wallets never build system transactions, but full-fidelity models are
/// required to decode checkpoints / executed system transactions (e.g. epoch
/// changes, consensus prologues) from BCS.
///
/// NOTE: `Genesis` objects (`GenesisObject::RawObject{data, owner}`) are
/// intentionally not modeled — `Data`/`Owner` Move-object layouts are deep and
/// genesis occurs once in chain history. Decoding a genesis transaction kind
/// throws [UnimplementedError].

/// NOTE: Sui digest newtypes (`TransactionDigest`, `ConsensusCommitDigest`,
/// `AdditionalConsensusStateDigest`) BCS-encode as length-prefixed byte
/// vectors, NOT fixed 32-byte arrays (verified against mainnet
/// `ConsensusCommitPrologueV4` wire bytes). [SuiObjectDigest] already models
/// exactly that and is reused here.

/// One `(SequenceNumber, modules, dependencies)` entry of
/// `ChangeEpoch.system_packages`.
class SuiSystemPackageUpgrade extends BcsSerialization {
  final BigInt sequenceNumber;
  final List<BuBytes> modules;
  final List<SuiAddress> dependencies;
  SuiSystemPackageUpgrade({
    required BigInt sequenceNumber,
    required List<List<int>> modules,
    required List<SuiAddress> dependencies,
  }) : sequenceNumber = sequenceNumber.asU64,
       modules = modules.map((e) => e.asImmutableBytes).toImutableList,
       dependencies = dependencies.immutable;
  factory SuiSystemPackageUpgrade.fromStruct(Map<String, dynamic> json) {
    return SuiSystemPackageUpgrade(
      sequenceNumber: json.valueAs("sequenceNumber"),
      modules: json.valueEnsureAsList<List<int>>("modules"),
      dependencies:
          json
              .valueEnsureAsList<Map<String, dynamic>>("dependencies")
              .map((e) => SuiAddress.fromStruct(e))
              .toList(),
    );
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.u64(property: "sequenceNumber"),
      LayoutConst.bcsVector(LayoutConst.bcsBytes(), property: "modules"),
      LayoutConst.bcsVector(SuiAddress.layout(), property: "dependencies"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "sequenceNumber": sequenceNumber,
      "modules": modules,
      "dependencies": dependencies.map((e) => e.toLayoutStruct()).toList(),
    };
  }
}

class SuiTransactionKindChangeEpoch extends SuiTransactionKind {
  final BigInt epoch;
  final BigInt protocolVersion;
  final BigInt storageCharge;
  final BigInt computationCharge;
  final BigInt storageRebate;
  final BigInt nonRefundableStorageFee;
  final BigInt epochStartTimestampMs;
  final List<SuiSystemPackageUpgrade> systemPackages;
  SuiTransactionKindChangeEpoch({
    required BigInt epoch,
    required BigInt protocolVersion,
    required BigInt storageCharge,
    required BigInt computationCharge,
    required BigInt storageRebate,
    required BigInt nonRefundableStorageFee,
    required BigInt epochStartTimestampMs,
    required List<SuiSystemPackageUpgrade> systemPackages,
  }) : epoch = epoch.asU64,
       protocolVersion = protocolVersion.asU64,
       storageCharge = storageCharge.asU64,
       computationCharge = computationCharge.asU64,
       storageRebate = storageRebate.asU64,
       nonRefundableStorageFee = nonRefundableStorageFee.asU64,
       epochStartTimestampMs = epochStartTimestampMs.asU64,
       systemPackages = systemPackages.immutable,
       super(type: SuiTransactionKinds.changeEpoch);
  factory SuiTransactionKindChangeEpoch.fromStruct(Map<String, dynamic> json) {
    return SuiTransactionKindChangeEpoch(
      epoch: json.valueAs("epoch"),
      protocolVersion: json.valueAs("protocolVersion"),
      storageCharge: json.valueAs("storageCharge"),
      computationCharge: json.valueAs("computationCharge"),
      storageRebate: json.valueAs("storageRebate"),
      nonRefundableStorageFee: json.valueAs("nonRefundableStorageFee"),
      epochStartTimestampMs: json.valueAs("epochStartTimestampMs"),
      systemPackages:
          json
              .valueEnsureAsList<Map<String, dynamic>>("systemPackages")
              .map((e) => SuiSystemPackageUpgrade.fromStruct(e))
              .toList(),
    );
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.u64(property: "epoch"),
      LayoutConst.u64(property: "protocolVersion"),
      LayoutConst.u64(property: "storageCharge"),
      LayoutConst.u64(property: "computationCharge"),
      LayoutConst.u64(property: "storageRebate"),
      LayoutConst.u64(property: "nonRefundableStorageFee"),
      LayoutConst.u64(property: "epochStartTimestampMs"),
      LayoutConst.bcsVector(
        SuiSystemPackageUpgrade.layout(),
        property: "systemPackages",
      ),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "epoch": epoch,
      "protocolVersion": protocolVersion,
      "storageCharge": storageCharge,
      "computationCharge": computationCharge,
      "storageRebate": storageRebate,
      "nonRefundableStorageFee": nonRefundableStorageFee,
      "epochStartTimestampMs": epochStartTimestampMs,
      "systemPackages": systemPackages.map((e) => e.toLayoutStruct()).toList(),
    };
  }
}

/// One cancelled transaction entry: `(TransactionDigest, Vec<(ObjectID, SequenceNumber)>)`.
class SuiCancelledTransactionEntry extends BcsSerialization {
  final SuiObjectDigest digest;
  final List<SuiObjectVersionAssignment> assignments;
  SuiCancelledTransactionEntry({
    required this.digest,
    required List<SuiObjectVersionAssignment> assignments,
  }) : assignments = assignments.immutable;
  factory SuiCancelledTransactionEntry.fromStruct(Map<String, dynamic> json) {
    return SuiCancelledTransactionEntry(
      digest: SuiObjectDigest.fromStruct(
        json.valueEnsureAsMap<String, dynamic>("digest"),
      ),
      assignments:
          json
              .valueEnsureAsList<Map<String, dynamic>>("assignments")
              .map((e) => SuiObjectVersionAssignment.fromStruct(e))
              .toList(),
    );
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      SuiObjectDigest.layout(property: "digest"),
      LayoutConst.bcsVector(
        SuiObjectVersionAssignment.layout(),
        property: "assignments",
      ),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "digest": digest.toLayoutStruct(),
      "assignments": assignments.map((e) => e.toLayoutStruct()).toList(),
    };
  }
}

/// `(ObjectID, SequenceNumber)` version assignment (BCS tuple, flattened).
class SuiObjectVersionAssignment extends BcsSerialization {
  final SuiAddress objectId;
  final BigInt version;
  SuiObjectVersionAssignment({required this.objectId, required BigInt version})
    : version = version.asU64;
  factory SuiObjectVersionAssignment.fromStruct(Map<String, dynamic> json) {
    return SuiObjectVersionAssignment(
      objectId: SuiAddress.fromStruct(
        json.valueEnsureAsMap<String, dynamic>("objectId"),
      ),
      version: json.valueAs("version"),
    );
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      SuiAddress.layout(property: "objectId"),
      LayoutConst.u64(property: "version"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"objectId": objectId.toLayoutStruct(), "version": version};
  }
}

/// V2 entry: `(TransactionDigest, Vec<(ConsensusObjectSequenceKey, SequenceNumber)>)`
/// where `ConsensusObjectSequenceKey = (ObjectID, SequenceNumber)`.
/// Both nested tuples are flattened (wire-identical: BCS tuples concatenate).
class SuiCancelledTransactionEntryV2 extends BcsSerialization {
  final SuiObjectDigest digest;
  final List<SuiConsensusObjectAssignment> assignments;
  SuiCancelledTransactionEntryV2({
    required this.digest,
    required List<SuiConsensusObjectAssignment> assignments,
  }) : assignments = assignments.immutable;
  factory SuiCancelledTransactionEntryV2.fromStruct(Map<String, dynamic> json) {
    return SuiCancelledTransactionEntryV2(
      digest: SuiObjectDigest.fromStruct(
        json.valueEnsureAsMap<String, dynamic>("digest"),
      ),
      assignments:
          json
              .valueEnsureAsList<Map<String, dynamic>>("assignments")
              .map((e) => SuiConsensusObjectAssignment.fromStruct(e))
              .toList(),
    );
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      SuiObjectDigest.layout(property: "digest"),
      LayoutConst.bcsVector(
        SuiConsensusObjectAssignment.layout(),
        property: "assignments",
      ),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "digest": digest.toLayoutStruct(),
      "assignments": assignments.map((e) => e.toLayoutStruct()).toList(),
    };
  }
}

class SuiConsensusObjectAssignment extends BcsSerialization {
  final SuiAddress objectId;
  final BigInt startVersion;
  final BigInt version;
  SuiConsensusObjectAssignment({
    required this.objectId,
    required BigInt startVersion,
    required BigInt version,
  }) : startVersion = startVersion.asU64,
       version = version.asU64;
  factory SuiConsensusObjectAssignment.fromStruct(Map<String, dynamic> json) {
    return SuiConsensusObjectAssignment(
      objectId: SuiAddress.fromStruct(
        json.valueEnsureAsMap<String, dynamic>("objectId"),
      ),
      startVersion: json.valueAs("startVersion"),
      version: json.valueAs("version"),
    );
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      SuiAddress.layout(property: "objectId"),
      LayoutConst.u64(property: "startVersion"),
      LayoutConst.u64(property: "version"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "objectId": objectId.toLayoutStruct(),
      "startVersion": startVersion,
      "version": version,
    };
  }
}

enum SuiConsensusDeterminedVersionAssignmentKinds {
  cancelledTransactions(value: 0),
  cancelledTransactionsV2(value: 1);

  const SuiConsensusDeterminedVersionAssignmentKinds({required this.value});
  final int value;
  static SuiConsensusDeterminedVersionAssignmentKinds fromName(String? name) {
    return values.firstWhere(
      (e) => e.name == name,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "Cannot find correct ConsensusDeterminedVersionAssignments from the given name.",
                details: {"name": name},
              ),
    );
  }
}

abstract class SuiTxConsensusVersionAssignments
    extends BcsVariantSerialization {
  final SuiConsensusDeterminedVersionAssignmentKinds type;
  const SuiTxConsensusVersionAssignments({required this.type});
  factory SuiTxConsensusVersionAssignments.fromStruct(
    Map<String, dynamic> json,
  ) {
    final decode = BcsVariantSerialization.toVariantDecodeResult(json);
    final type = SuiConsensusDeterminedVersionAssignmentKinds.fromName(
      decode.variantName,
    );
    return switch (type) {
      SuiConsensusDeterminedVersionAssignmentKinds.cancelledTransactions =>
        SuiCancelledTransactions.fromStruct(decode.value),
      SuiConsensusDeterminedVersionAssignmentKinds.cancelledTransactionsV2 =>
        SuiCancelledTransactionsV2.fromStruct(decode.value),
    };
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.bcsLazyEnum([
      LazyVariantModel(
        layout: SuiCancelledTransactions.layout,
        property:
            SuiConsensusDeterminedVersionAssignmentKinds
                .cancelledTransactions
                .name,
        index:
            SuiConsensusDeterminedVersionAssignmentKinds
                .cancelledTransactions
                .value,
      ),
      LazyVariantModel(
        layout: SuiCancelledTransactionsV2.layout,
        property:
            SuiConsensusDeterminedVersionAssignmentKinds
                .cancelledTransactionsV2
                .name,
        index:
            SuiConsensusDeterminedVersionAssignmentKinds
                .cancelledTransactionsV2
                .value,
      ),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createVariantLayout({String? property}) {
    return layout(property: property);
  }

  @override
  String get variantName => type.name;
}

class SuiCancelledTransactions extends SuiTxConsensusVersionAssignments {
  final List<SuiCancelledTransactionEntry> transactions;
  SuiCancelledTransactions({
    required List<SuiCancelledTransactionEntry> transactions,
  }) : transactions = transactions.immutable,
       super(
         type:
             SuiConsensusDeterminedVersionAssignmentKinds.cancelledTransactions,
       );
  factory SuiCancelledTransactions.fromStruct(Map<String, dynamic> json) {
    return SuiCancelledTransactions(
      transactions:
          json
              .valueEnsureAsList<Map<String, dynamic>>("transactions")
              .map((e) => SuiCancelledTransactionEntry.fromStruct(e))
              .toList(),
    );
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.bcsVector(
        SuiCancelledTransactionEntry.layout(),
        property: "transactions",
      ),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "transactions": transactions.map((e) => e.toLayoutStruct()).toList(),
    };
  }
}

class SuiCancelledTransactionsV2 extends SuiTxConsensusVersionAssignments {
  final List<SuiCancelledTransactionEntryV2> transactions;
  SuiCancelledTransactionsV2({
    required List<SuiCancelledTransactionEntryV2> transactions,
  }) : transactions = transactions.immutable,
       super(
         type:
             SuiConsensusDeterminedVersionAssignmentKinds
                 .cancelledTransactionsV2,
       );
  factory SuiCancelledTransactionsV2.fromStruct(Map<String, dynamic> json) {
    return SuiCancelledTransactionsV2(
      transactions:
          json
              .valueEnsureAsList<Map<String, dynamic>>("transactions")
              .map((e) => SuiCancelledTransactionEntryV2.fromStruct(e))
              .toList(),
    );
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.bcsVector(
        SuiCancelledTransactionEntryV2.layout(),
        property: "transactions",
      ),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "transactions": transactions.map((e) => e.toLayoutStruct()).toList(),
    };
  }
}

class SuiTransactionKindConsensusCommitPrologue extends SuiTransactionKind {
  final BigInt epoch;
  final BigInt round;
  final BigInt commitTimestampMs;
  SuiTransactionKindConsensusCommitPrologue({
    required BigInt epoch,
    required BigInt round,
    required BigInt commitTimestampMs,
  }) : epoch = epoch.asU64,
       round = round.asU64,
       commitTimestampMs = commitTimestampMs.asU64,
       super(type: SuiTransactionKinds.consensusCommitPrologue);
  factory SuiTransactionKindConsensusCommitPrologue.fromStruct(
    Map<String, dynamic> json,
  ) {
    return SuiTransactionKindConsensusCommitPrologue(
      epoch: json.valueAs("epoch"),
      round: json.valueAs("round"),
      commitTimestampMs: json.valueAs("commitTimestampMs"),
    );
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.u64(property: "epoch"),
      LayoutConst.u64(property: "round"),
      LayoutConst.u64(property: "commitTimestampMs"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "epoch": epoch,
      "round": round,
      "commitTimestampMs": commitTimestampMs,
    };
  }
}

class SuiTransactionKindConsensusCommitPrologueV2 extends SuiTransactionKind {
  final BigInt epoch;
  final BigInt round;
  final BigInt commitTimestampMs;
  final SuiObjectDigest consensusCommitDigest;
  SuiTransactionKindConsensusCommitPrologueV2({
    required BigInt epoch,
    required BigInt round,
    required BigInt commitTimestampMs,
    required this.consensusCommitDigest,
  }) : epoch = epoch.asU64,
       round = round.asU64,
       commitTimestampMs = commitTimestampMs.asU64,
       super(type: SuiTransactionKinds.consensusCommitPrologueV2);
  factory SuiTransactionKindConsensusCommitPrologueV2.fromStruct(
    Map<String, dynamic> json,
  ) {
    return SuiTransactionKindConsensusCommitPrologueV2(
      epoch: json.valueAs("epoch"),
      round: json.valueAs("round"),
      commitTimestampMs: json.valueAs("commitTimestampMs"),
      consensusCommitDigest: SuiObjectDigest.fromStruct(
        json.valueEnsureAsMap<String, dynamic>("consensusCommitDigest"),
      ),
    );
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.u64(property: "epoch"),
      LayoutConst.u64(property: "round"),
      LayoutConst.u64(property: "commitTimestampMs"),
      SuiObjectDigest.layout(property: "consensusCommitDigest"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "epoch": epoch,
      "round": round,
      "commitTimestampMs": commitTimestampMs,
      "consensusCommitDigest": consensusCommitDigest.toLayoutStruct(),
    };
  }
}

class SuiTransactionKindConsensusCommitPrologueV3 extends SuiTransactionKind {
  final BigInt epoch;
  final BigInt round;
  final BigInt? subDagIndex;
  final BigInt commitTimestampMs;
  final SuiObjectDigest consensusCommitDigest;
  final SuiTxConsensusVersionAssignments consensusDeterminedVersionAssignments;
  SuiTransactionKindConsensusCommitPrologueV3({
    required BigInt epoch,
    required BigInt round,
    BigInt? subDagIndex,
    required BigInt commitTimestampMs,
    required this.consensusCommitDigest,
    required this.consensusDeterminedVersionAssignments,
  }) : epoch = epoch.asU64,
       round = round.asU64,
       subDagIndex = subDagIndex?.asU64,
       commitTimestampMs = commitTimestampMs.asU64,
       super(type: SuiTransactionKinds.consensusCommitPrologueV3);
  factory SuiTransactionKindConsensusCommitPrologueV3.fromStruct(
    Map<String, dynamic> json,
  ) {
    return SuiTransactionKindConsensusCommitPrologueV3(
      epoch: json.valueAs("epoch"),
      round: json.valueAs("round"),
      subDagIndex: json.valueAs<BigInt?>("subDagIndex"),
      commitTimestampMs: json.valueAs("commitTimestampMs"),
      consensusCommitDigest: SuiObjectDigest.fromStruct(
        json.valueEnsureAsMap<String, dynamic>("consensusCommitDigest"),
      ),
      consensusDeterminedVersionAssignments:
          SuiTxConsensusVersionAssignments.fromStruct(
            json.valueEnsureAsMap<String, dynamic>(
              "consensusDeterminedVersionAssignments",
            ),
          ),
    );
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.u64(property: "epoch"),
      LayoutConst.u64(property: "round"),
      LayoutConst.optional(LayoutConst.u64(), property: "subDagIndex"),
      LayoutConst.u64(property: "commitTimestampMs"),
      SuiObjectDigest.layout(property: "consensusCommitDigest"),
      SuiTxConsensusVersionAssignments.layout(
        property: "consensusDeterminedVersionAssignments",
      ),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "epoch": epoch,
      "round": round,
      "subDagIndex": subDagIndex,
      "commitTimestampMs": commitTimestampMs,
      "consensusCommitDigest": consensusCommitDigest.toLayoutStruct(),
      "consensusDeterminedVersionAssignments":
          consensusDeterminedVersionAssignments.toVariantLayoutStruct(),
    };
  }
}

class SuiTransactionKindConsensusCommitPrologueV4 extends SuiTransactionKind {
  final BigInt epoch;
  final BigInt round;
  final BigInt? subDagIndex;
  final BigInt commitTimestampMs;
  final SuiObjectDigest consensusCommitDigest;
  final SuiTxConsensusVersionAssignments consensusDeterminedVersionAssignments;
  final SuiObjectDigest additionalStateDigest;
  SuiTransactionKindConsensusCommitPrologueV4({
    required BigInt epoch,
    required BigInt round,
    BigInt? subDagIndex,
    required BigInt commitTimestampMs,
    required this.consensusCommitDigest,
    required this.consensusDeterminedVersionAssignments,
    required this.additionalStateDigest,
  }) : epoch = epoch.asU64,
       round = round.asU64,
       subDagIndex = subDagIndex?.asU64,
       commitTimestampMs = commitTimestampMs.asU64,
       super(type: SuiTransactionKinds.consensusCommitPrologueV4);
  factory SuiTransactionKindConsensusCommitPrologueV4.fromStruct(
    Map<String, dynamic> json,
  ) {
    return SuiTransactionKindConsensusCommitPrologueV4(
      epoch: json.valueAs("epoch"),
      round: json.valueAs("round"),
      subDagIndex: json.valueAs<BigInt?>("subDagIndex"),
      commitTimestampMs: json.valueAs("commitTimestampMs"),
      consensusCommitDigest: SuiObjectDigest.fromStruct(
        json.valueEnsureAsMap<String, dynamic>("consensusCommitDigest"),
      ),
      consensusDeterminedVersionAssignments:
          SuiTxConsensusVersionAssignments.fromStruct(
            json.valueEnsureAsMap<String, dynamic>(
              "consensusDeterminedVersionAssignments",
            ),
          ),
      additionalStateDigest: SuiObjectDigest.fromStruct(
        json.valueEnsureAsMap<String, dynamic>("additionalStateDigest"),
      ),
    );
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.u64(property: "epoch"),
      LayoutConst.u64(property: "round"),
      LayoutConst.optional(LayoutConst.u64(), property: "subDagIndex"),
      LayoutConst.u64(property: "commitTimestampMs"),
      SuiObjectDigest.layout(property: "consensusCommitDigest"),
      SuiTxConsensusVersionAssignments.layout(
        property: "consensusDeterminedVersionAssignments",
      ),
      SuiObjectDigest.layout(property: "additionalStateDigest"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "epoch": epoch,
      "round": round,
      "subDagIndex": subDagIndex,
      "commitTimestampMs": commitTimestampMs,
      "consensusCommitDigest": consensusCommitDigest.toLayoutStruct(),
      "consensusDeterminedVersionAssignments":
          consensusDeterminedVersionAssignments.toVariantLayoutStruct(),
      "additionalStateDigest": additionalStateDigest.toLayoutStruct(),
    };
  }
}

/// `JwkId { iss, kid }` — key identifying a JWK (see `authenticator_state.rs`).
class SuiTxJwkId extends BcsSerialization {
  final String iss;
  final String kid;
  const SuiTxJwkId({required this.iss, required this.kid});
  factory SuiTxJwkId.fromStruct(Map<String, dynamic> json) {
    return SuiTxJwkId(iss: json.valueAs("iss"), kid: json.valueAs("kid"));
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.bcsString(property: "iss"),
      LayoutConst.bcsString(property: "kid"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"iss": iss, "kid": kid};
  }
}

/// `JWK { kty, e, n, alg }` RSA public key (field order is wire-significant).
class SuiTxJwk extends BcsSerialization {
  final String kty;
  final String e;
  final String n;
  final String alg;
  const SuiTxJwk({
    required this.kty,
    required this.e,
    required this.n,
    required this.alg,
  });
  factory SuiTxJwk.fromStruct(Map<String, dynamic> json) {
    return SuiTxJwk(
      kty: json.valueAs("kty"),
      e: json.valueAs("e"),
      n: json.valueAs("n"),
      alg: json.valueAs("alg"),
    );
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.bcsString(property: "kty"),
      LayoutConst.bcsString(property: "e"),
      LayoutConst.bcsString(property: "n"),
      LayoutConst.bcsString(property: "alg"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"kty": kty, "e": e, "n": n, "alg": alg};
  }
}

/// One RSA JWK of `AuthenticatorStateUpdate.new_active_jwks`:
/// `ActiveJwk { jwk_id, jwk, epoch }`.
class SuiTxActiveJwk extends BcsSerialization {
  final SuiTxJwkId jwkId;
  final SuiTxJwk jwk;
  final BigInt epoch;
  SuiTxActiveJwk({
    required this.jwkId,
    required this.jwk,
    required BigInt epoch,
  }) : epoch = epoch.asU64;
  factory SuiTxActiveJwk.fromStruct(Map<String, dynamic> json) {
    return SuiTxActiveJwk(
      jwkId: SuiTxJwkId.fromStruct(
        json.valueEnsureAsMap<String, dynamic>("jwkId"),
      ),
      jwk: SuiTxJwk.fromStruct(json.valueEnsureAsMap<String, dynamic>("jwk")),
      epoch: json.valueAs("epoch"),
    );
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      SuiTxJwkId.layout(property: "jwkId"),
      SuiTxJwk.layout(property: "jwk"),
      LayoutConst.u64(property: "epoch"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "jwkId": jwkId.toLayoutStruct(),
      "jwk": jwk.toLayoutStruct(),
      "epoch": epoch,
    };
  }
}

class SuiTransactionKindAuthenticatorStateUpdate extends SuiTransactionKind {
  final BigInt epoch;
  final BigInt round;
  final List<SuiTxActiveJwk> newActiveJwks;
  final BigInt authenticatorObjInitialSharedVersion;
  SuiTransactionKindAuthenticatorStateUpdate({
    required BigInt epoch,
    required BigInt round,
    required List<SuiTxActiveJwk> newActiveJwks,
    required BigInt authenticatorObjInitialSharedVersion,
  }) : epoch = epoch.asU64,
       round = round.asU64,
       newActiveJwks = newActiveJwks.immutable,
       authenticatorObjInitialSharedVersion =
           authenticatorObjInitialSharedVersion.asU64,
       super(type: SuiTransactionKinds.authenticatorStateUpdate);
  factory SuiTransactionKindAuthenticatorStateUpdate.fromStruct(
    Map<String, dynamic> json,
  ) {
    return SuiTransactionKindAuthenticatorStateUpdate(
      epoch: json.valueAs("epoch"),
      round: json.valueAs("round"),
      newActiveJwks:
          json
              .valueEnsureAsList<Map<String, dynamic>>("newActiveJwks")
              .map((e) => SuiTxActiveJwk.fromStruct(e))
              .toList(),
      authenticatorObjInitialSharedVersion: json.valueAs(
        "authenticatorObjInitialSharedVersion",
      ),
    );
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.u64(property: "epoch"),
      LayoutConst.u64(property: "round"),
      LayoutConst.bcsVector(SuiTxActiveJwk.layout(), property: "newActiveJwks"),
      LayoutConst.u64(property: "authenticatorObjInitialSharedVersion"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "epoch": epoch,
      "round": round,
      "newActiveJwks": newActiveJwks.map((e) => e.toLayoutStruct()).toList(),
      "authenticatorObjInitialSharedVersion":
          authenticatorObjInitialSharedVersion,
    };
  }
}

class SuiTransactionKindRandomnessStateUpdate extends SuiTransactionKind {
  final BigInt epoch;
  final BigInt randomnessRound;
  final BuBytes randomBytes;
  final BigInt randomnessObjInitialSharedVersion;
  SuiTransactionKindRandomnessStateUpdate({
    required BigInt epoch,
    required BigInt randomnessRound,
    required List<int> randomBytes,
    required BigInt randomnessObjInitialSharedVersion,
  }) : epoch = epoch.asU64,
       randomnessRound = randomnessRound.asU64,
       randomBytes = randomBytes.asImmutableBytes,
       randomnessObjInitialSharedVersion =
           randomnessObjInitialSharedVersion.asU64,
       super(type: SuiTransactionKinds.randomnessStateUpdate);
  factory SuiTransactionKindRandomnessStateUpdate.fromStruct(
    Map<String, dynamic> json,
  ) {
    return SuiTransactionKindRandomnessStateUpdate(
      epoch: json.valueAs("epoch"),
      randomnessRound: json.valueAs("randomnessRound"),
      randomBytes: json.valueAsBytes("randomBytes"),
      randomnessObjInitialSharedVersion: json.valueAs(
        "randomnessObjInitialSharedVersion",
      ),
    );
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.u64(property: "epoch"),
      LayoutConst.u64(property: "randomnessRound"),
      LayoutConst.bcsBytes(property: "randomBytes"),
      LayoutConst.u64(property: "randomnessObjInitialSharedVersion"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "epoch": epoch,
      "randomnessRound": randomnessRound,
      "randomBytes": randomBytes,
      "randomnessObjInitialSharedVersion": randomnessObjInitialSharedVersion,
    };
  }
}

enum SuiExecutionTimeObservationKeyKinds {
  moveEntryPoint(value: 0),
  transferObjects(value: 1),
  splitCoins(value: 2),
  mergeCoins(value: 3),
  publish(value: 4),
  makeMoveVec(value: 5),
  upgrade(value: 6);

  const SuiExecutionTimeObservationKeyKinds({required this.value});
  final int value;
  static SuiExecutionTimeObservationKeyKinds fromName(String? name) {
    return values.firstWhere(
      (e) => e.name == name,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "Cannot find correct ExecutionTimeObservationKey from the given name.",
                details: {"name": name},
              ),
    );
  }
}

abstract class SuiExecutionTimeObservationKey extends BcsVariantSerialization {
  final SuiExecutionTimeObservationKeyKinds type;
  const SuiExecutionTimeObservationKey({required this.type});
  factory SuiExecutionTimeObservationKey.fromStruct(Map<String, dynamic> json) {
    final decode = BcsVariantSerialization.toVariantDecodeResult(json);
    final type = SuiExecutionTimeObservationKeyKinds.fromName(
      decode.variantName,
    );
    return switch (type) {
      SuiExecutionTimeObservationKeyKinds.moveEntryPoint =>
        SuiObservationMoveEntryPoint.fromStruct(decode.value),
      SuiExecutionTimeObservationKeyKinds.transferObjects =>
        const SuiObservationTransferObjects(),
      SuiExecutionTimeObservationKeyKinds.splitCoins =>
        const SuiObservationSplitCoins(),
      SuiExecutionTimeObservationKeyKinds.mergeCoins =>
        const SuiObservationMergeCoins(),
      SuiExecutionTimeObservationKeyKinds.publish =>
        const SuiObservationPublish(),
      SuiExecutionTimeObservationKeyKinds.makeMoveVec =>
        const SuiObservationMakeMoveVec(),
      SuiExecutionTimeObservationKeyKinds.upgrade =>
        const SuiObservationUpgrade(),
    };
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.bcsLazyEnum([
      LazyVariantModel(
        layout: SuiObservationMoveEntryPoint.layout,
        property: SuiExecutionTimeObservationKeyKinds.moveEntryPoint.name,
        index: SuiExecutionTimeObservationKeyKinds.moveEntryPoint.value,
      ),
      LazyVariantModel(
        layout: SuiObservationTransferObjects.layout,
        property: SuiExecutionTimeObservationKeyKinds.transferObjects.name,
        index: SuiExecutionTimeObservationKeyKinds.transferObjects.value,
      ),
      LazyVariantModel(
        layout: SuiObservationSplitCoins.layout,
        property: SuiExecutionTimeObservationKeyKinds.splitCoins.name,
        index: SuiExecutionTimeObservationKeyKinds.splitCoins.value,
      ),
      LazyVariantModel(
        layout: SuiObservationMergeCoins.layout,
        property: SuiExecutionTimeObservationKeyKinds.mergeCoins.name,
        index: SuiExecutionTimeObservationKeyKinds.mergeCoins.value,
      ),
      LazyVariantModel(
        layout: SuiObservationPublish.layout,
        property: SuiExecutionTimeObservationKeyKinds.publish.name,
        index: SuiExecutionTimeObservationKeyKinds.publish.value,
      ),
      LazyVariantModel(
        layout: SuiObservationMakeMoveVec.layout,
        property: SuiExecutionTimeObservationKeyKinds.makeMoveVec.name,
        index: SuiExecutionTimeObservationKeyKinds.makeMoveVec.value,
      ),
      LazyVariantModel(
        layout: SuiObservationUpgrade.layout,
        property: SuiExecutionTimeObservationKeyKinds.upgrade.name,
        index: SuiExecutionTimeObservationKeyKinds.upgrade.value,
      ),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createVariantLayout({String? property}) {
    return layout(property: property);
  }

  @override
  String get variantName => type.name;
}

class SuiObservationMoveEntryPoint extends SuiExecutionTimeObservationKey {
  final SuiAddress package;
  final String module;
  final String function;
  final List<SuiTypeInput> typeArguments;
  SuiObservationMoveEntryPoint({
    required this.package,
    required this.module,
    required this.function,
    required List<SuiTypeInput> typeArguments,
  }) : typeArguments = typeArguments.immutable,
       super(type: SuiExecutionTimeObservationKeyKinds.moveEntryPoint);
  factory SuiObservationMoveEntryPoint.fromStruct(Map<String, dynamic> json) {
    return SuiObservationMoveEntryPoint(
      package: SuiAddress.fromStruct(
        json.valueEnsureAsMap<String, dynamic>("package"),
      ),
      module: json.valueAs("module"),
      function: json.valueAs("function"),
      typeArguments:
          json
              .valueEnsureAsList<Map<String, dynamic>>("typeArguments")
              .map((e) => SuiTypeInput.fromStruct(e))
              .toList(),
    );
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      SuiAddress.layout(property: "package"),
      LayoutConst.bcsString(property: "module"),
      LayoutConst.bcsString(property: "function"),
      LayoutConst.bcsVector(SuiTypeInput.layout(), property: "typeArguments"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "package": package.toLayoutStruct(),
      "module": module,
      "function": function,
      "typeArguments":
          typeArguments.map((e) => e.toVariantLayoutStruct()).toList(),
    };
  }
}

class SuiObservationTransferObjects extends SuiExecutionTimeObservationKey {
  const SuiObservationTransferObjects()
    : super(type: SuiExecutionTimeObservationKeyKinds.transferObjects);
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.noArgs(property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout();
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {};
  }
}

class SuiObservationSplitCoins extends SuiExecutionTimeObservationKey {
  const SuiObservationSplitCoins()
    : super(type: SuiExecutionTimeObservationKeyKinds.splitCoins);
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.noArgs(property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout();
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {};
  }
}

class SuiObservationMergeCoins extends SuiExecutionTimeObservationKey {
  const SuiObservationMergeCoins()
    : super(type: SuiExecutionTimeObservationKeyKinds.mergeCoins);
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.noArgs(property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout();
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {};
  }
}

class SuiObservationPublish extends SuiExecutionTimeObservationKey {
  const SuiObservationPublish()
    : super(type: SuiExecutionTimeObservationKeyKinds.publish);
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.noArgs(property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout();
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {};
  }
}

class SuiObservationMakeMoveVec extends SuiExecutionTimeObservationKey {
  const SuiObservationMakeMoveVec()
    : super(type: SuiExecutionTimeObservationKeyKinds.makeMoveVec);
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.noArgs(property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout();
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {};
  }
}

class SuiObservationUpgrade extends SuiExecutionTimeObservationKey {
  const SuiObservationUpgrade()
    : super(type: SuiExecutionTimeObservationKeyKinds.upgrade);
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.noArgs(property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout();
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {};
  }
}

/// One `(AuthorityName, Duration)` estimate. `Duration` is `std::time`
/// (`secs: u64`, `nanos: u32`); `AuthorityName` is `[u8; 32]`.
class SuiAuthorityTimeEstimate extends BcsSerialization {
  final SuiAddress authority;
  final BigInt secs;
  final int nanos;
  SuiAuthorityTimeEstimate({
    required this.authority,
    required BigInt secs,
    required this.nanos,
  }) : secs = secs.asU64;
  factory SuiAuthorityTimeEstimate.fromStruct(Map<String, dynamic> json) {
    return SuiAuthorityTimeEstimate(
      authority: SuiAddress.fromStruct(
        json.valueEnsureAsMap<String, dynamic>("authority"),
      ),
      secs: json.valueAs("secs"),
      nanos: json.valueAs("nanos"),
    );
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      SuiAddress.layout(property: "authority"),
      LayoutConst.u64(property: "secs"),
      LayoutConst.u32(property: "nanos"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "authority": authority.toLayoutStruct(),
      "secs": secs,
      "nanos": nanos,
    };
  }
}

class SuiTxExecutionTimeObservation extends BcsSerialization {
  final SuiExecutionTimeObservationKey key;
  final List<SuiAuthorityTimeEstimate> estimates;
  SuiTxExecutionTimeObservation({
    required this.key,
    required List<SuiAuthorityTimeEstimate> estimates,
  }) : estimates = estimates.immutable;
  factory SuiTxExecutionTimeObservation.fromStruct(Map<String, dynamic> json) {
    return SuiTxExecutionTimeObservation(
      key: SuiExecutionTimeObservationKey.fromStruct(
        json.valueEnsureAsMap<String, dynamic>("key"),
      ),
      estimates:
          json
              .valueEnsureAsList<Map<String, dynamic>>("estimates")
              .map((e) => SuiAuthorityTimeEstimate.fromStruct(e))
              .toList(),
    );
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      SuiExecutionTimeObservationKey.layout(property: "key"),
      LayoutConst.bcsVector(
        SuiAuthorityTimeEstimate.layout(),
        property: "estimates",
      ),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "key": key.toVariantLayoutStruct(),
      "estimates": estimates.map((e) => e.toLayoutStruct()).toList(),
    };
  }
}

class SuiStoredExecutionTimeObservations extends BcsSerialization {
  final List<SuiTxExecutionTimeObservation> observations;
  SuiStoredExecutionTimeObservations({
    required List<SuiTxExecutionTimeObservation> observations,
  }) : observations = observations.immutable;
  factory SuiStoredExecutionTimeObservations.fromStruct(
    Map<String, dynamic> json,
  ) {
    return SuiStoredExecutionTimeObservations(
      observations:
          json
              .valueEnsureAsList<Map<String, dynamic>>("observations")
              .map((e) => SuiTxExecutionTimeObservation.fromStruct(e))
              .toList(),
    );
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.bcsVector(
        SuiTxExecutionTimeObservation.layout(),
        property: "observations",
      ),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "observations": observations.map((e) => e.toLayoutStruct()).toList(),
    };
  }
}

enum SuiEndOfEpochTransactionKinds {
  changeEpoch(value: 0),
  authenticatorStateCreate(value: 1),
  authenticatorStateExpire(value: 2),
  randomnessStateCreate(value: 3),
  denyListStateCreate(value: 4),
  bridgeStateCreate(value: 5),
  bridgeCommitteeInit(value: 6),
  storeExecutionTimeObservations(value: 7),
  accumulatorRootCreate(value: 8),
  coinRegistryCreate(value: 9),
  displayRegistryCreate(value: 10),
  addressAliasStateCreate(value: 11),
  writeAccumulatorStorageCost(value: 12),
  forwardingAddressRegistryCreate(value: 13);

  const SuiEndOfEpochTransactionKinds({required this.value});
  final int value;
  static SuiEndOfEpochTransactionKinds fromName(String? name) {
    return values.firstWhere(
      (e) => e.name == name,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "Cannot find correct EndOfEpochTransactionKind from the given name.",
                details: {"name": name},
              ),
    );
  }
}

abstract class SuiTxEndOfEpochKind extends BcsVariantSerialization {
  final SuiEndOfEpochTransactionKinds type;
  const SuiTxEndOfEpochKind({required this.type});
  factory SuiTxEndOfEpochKind.fromStruct(Map<String, dynamic> json) {
    final decode = BcsVariantSerialization.toVariantDecodeResult(json);
    final type = SuiEndOfEpochTransactionKinds.fromName(decode.variantName);
    return switch (type) {
      SuiEndOfEpochTransactionKinds.changeEpoch =>
        SuiEndOfEpochChangeEpoch.fromStruct(decode.value),
      SuiEndOfEpochTransactionKinds.authenticatorStateCreate =>
        const SuiEndOfEpochAuthenticatorStateCreate(),
      SuiEndOfEpochTransactionKinds.authenticatorStateExpire =>
        SuiEndOfEpochAuthenticatorStateExpire.fromStruct(decode.value),
      SuiEndOfEpochTransactionKinds.randomnessStateCreate =>
        const SuiEndOfEpochRandomnessStateCreate(),
      SuiEndOfEpochTransactionKinds.denyListStateCreate =>
        const SuiEndOfEpochDenyListStateCreate(),
      SuiEndOfEpochTransactionKinds.bridgeStateCreate =>
        SuiEndOfEpochBridgeStateCreate.fromStruct(decode.value),
      SuiEndOfEpochTransactionKinds.bridgeCommitteeInit =>
        SuiEndOfEpochBridgeCommitteeInit.fromStruct(decode.value),
      SuiEndOfEpochTransactionKinds.storeExecutionTimeObservations =>
        SuiEndOfEpochStoreExecutionTimeObservations.fromStruct(decode.value),
      SuiEndOfEpochTransactionKinds.accumulatorRootCreate =>
        const SuiEndOfEpochAccumulatorRootCreate(),
      SuiEndOfEpochTransactionKinds.coinRegistryCreate =>
        const SuiEndOfEpochCoinRegistryCreate(),
      SuiEndOfEpochTransactionKinds.displayRegistryCreate =>
        const SuiEndOfEpochDisplayRegistryCreate(),
      SuiEndOfEpochTransactionKinds.addressAliasStateCreate =>
        const SuiEndOfEpochAddressAliasStateCreate(),
      SuiEndOfEpochTransactionKinds.writeAccumulatorStorageCost =>
        SuiEndOfEpochWriteAccumulatorStorageCost.fromStruct(decode.value),
      SuiEndOfEpochTransactionKinds.forwardingAddressRegistryCreate =>
        const SuiEndOfEpochForwardingAddressRegistryCreate(),
    };
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.bcsLazyEnum([
      LazyVariantModel(
        layout: SuiEndOfEpochChangeEpoch.layout,
        property: SuiEndOfEpochTransactionKinds.changeEpoch.name,
        index: SuiEndOfEpochTransactionKinds.changeEpoch.value,
      ),
      LazyVariantModel(
        layout: SuiEndOfEpochAuthenticatorStateCreate.layout,
        property: SuiEndOfEpochTransactionKinds.authenticatorStateCreate.name,
        index: SuiEndOfEpochTransactionKinds.authenticatorStateCreate.value,
      ),
      LazyVariantModel(
        layout: SuiEndOfEpochAuthenticatorStateExpire.layout,
        property: SuiEndOfEpochTransactionKinds.authenticatorStateExpire.name,
        index: SuiEndOfEpochTransactionKinds.authenticatorStateExpire.value,
      ),
      LazyVariantModel(
        layout: SuiEndOfEpochRandomnessStateCreate.layout,
        property: SuiEndOfEpochTransactionKinds.randomnessStateCreate.name,
        index: SuiEndOfEpochTransactionKinds.randomnessStateCreate.value,
      ),
      LazyVariantModel(
        layout: SuiEndOfEpochDenyListStateCreate.layout,
        property: SuiEndOfEpochTransactionKinds.denyListStateCreate.name,
        index: SuiEndOfEpochTransactionKinds.denyListStateCreate.value,
      ),
      LazyVariantModel(
        layout: SuiEndOfEpochBridgeStateCreate.layout,
        property: SuiEndOfEpochTransactionKinds.bridgeStateCreate.name,
        index: SuiEndOfEpochTransactionKinds.bridgeStateCreate.value,
      ),
      LazyVariantModel(
        layout: SuiEndOfEpochBridgeCommitteeInit.layout,
        property: SuiEndOfEpochTransactionKinds.bridgeCommitteeInit.name,
        index: SuiEndOfEpochTransactionKinds.bridgeCommitteeInit.value,
      ),
      LazyVariantModel(
        layout: SuiEndOfEpochStoreExecutionTimeObservations.layout,
        property:
            SuiEndOfEpochTransactionKinds.storeExecutionTimeObservations.name,
        index:
            SuiEndOfEpochTransactionKinds.storeExecutionTimeObservations.value,
      ),
      LazyVariantModel(
        layout: SuiEndOfEpochAccumulatorRootCreate.layout,
        property: SuiEndOfEpochTransactionKinds.accumulatorRootCreate.name,
        index: SuiEndOfEpochTransactionKinds.accumulatorRootCreate.value,
      ),
      LazyVariantModel(
        layout: SuiEndOfEpochCoinRegistryCreate.layout,
        property: SuiEndOfEpochTransactionKinds.coinRegistryCreate.name,
        index: SuiEndOfEpochTransactionKinds.coinRegistryCreate.value,
      ),
      LazyVariantModel(
        layout: SuiEndOfEpochDisplayRegistryCreate.layout,
        property: SuiEndOfEpochTransactionKinds.displayRegistryCreate.name,
        index: SuiEndOfEpochTransactionKinds.displayRegistryCreate.value,
      ),
      LazyVariantModel(
        layout: SuiEndOfEpochAddressAliasStateCreate.layout,
        property: SuiEndOfEpochTransactionKinds.addressAliasStateCreate.name,
        index: SuiEndOfEpochTransactionKinds.addressAliasStateCreate.value,
      ),
      LazyVariantModel(
        layout: SuiEndOfEpochWriteAccumulatorStorageCost.layout,
        property:
            SuiEndOfEpochTransactionKinds.writeAccumulatorStorageCost.name,
        index: SuiEndOfEpochTransactionKinds.writeAccumulatorStorageCost.value,
      ),
      LazyVariantModel(
        layout: SuiEndOfEpochForwardingAddressRegistryCreate.layout,
        property:
            SuiEndOfEpochTransactionKinds.forwardingAddressRegistryCreate.name,
        index:
            SuiEndOfEpochTransactionKinds.forwardingAddressRegistryCreate.value,
      ),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createVariantLayout({String? property}) {
    return layout(property: property);
  }

  @override
  String get variantName => type.name;
}

class SuiEndOfEpochChangeEpoch extends SuiTxEndOfEpochKind {
  final SuiTransactionKindChangeEpoch changeEpoch;
  SuiEndOfEpochChangeEpoch(this.changeEpoch)
    : super(type: SuiEndOfEpochTransactionKinds.changeEpoch);
  factory SuiEndOfEpochChangeEpoch.fromStruct(Map<String, dynamic> json) {
    return SuiEndOfEpochChangeEpoch(
      SuiTransactionKindChangeEpoch.fromStruct(
        json.valueEnsureAsMap<String, dynamic>("changeEpoch"),
      ),
    );
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      SuiTransactionKindChangeEpoch.layout(property: "changeEpoch"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"changeEpoch": changeEpoch.toLayoutStruct()};
  }
}

class SuiEndOfEpochAuthenticatorStateCreate extends SuiTxEndOfEpochKind {
  const SuiEndOfEpochAuthenticatorStateCreate()
    : super(type: SuiEndOfEpochTransactionKinds.authenticatorStateCreate);
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.noArgs(property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout();
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {};
  }
}

class SuiEndOfEpochAuthenticatorStateExpire extends SuiTxEndOfEpochKind {
  final BigInt minEpoch;
  final BigInt authenticatorObjInitialSharedVersion;
  SuiEndOfEpochAuthenticatorStateExpire({
    required BigInt minEpoch,
    required BigInt authenticatorObjInitialSharedVersion,
  }) : minEpoch = minEpoch.asU64,
       authenticatorObjInitialSharedVersion =
           authenticatorObjInitialSharedVersion.asU64,
       super(type: SuiEndOfEpochTransactionKinds.authenticatorStateExpire);
  factory SuiEndOfEpochAuthenticatorStateExpire.fromStruct(
    Map<String, dynamic> json,
  ) {
    return SuiEndOfEpochAuthenticatorStateExpire(
      minEpoch: json.valueAs("minEpoch"),
      authenticatorObjInitialSharedVersion: json.valueAs(
        "authenticatorObjInitialSharedVersion",
      ),
    );
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.u64(property: "minEpoch"),
      LayoutConst.u64(property: "authenticatorObjInitialSharedVersion"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "minEpoch": minEpoch,
      "authenticatorObjInitialSharedVersion":
          authenticatorObjInitialSharedVersion,
    };
  }
}

class SuiEndOfEpochRandomnessStateCreate extends SuiTxEndOfEpochKind {
  const SuiEndOfEpochRandomnessStateCreate()
    : super(type: SuiEndOfEpochTransactionKinds.randomnessStateCreate);
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.noArgs(property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout();
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {};
  }
}

class SuiEndOfEpochDenyListStateCreate extends SuiTxEndOfEpochKind {
  const SuiEndOfEpochDenyListStateCreate()
    : super(type: SuiEndOfEpochTransactionKinds.denyListStateCreate);
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.noArgs(property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout();
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {};
  }
}

class SuiEndOfEpochBridgeStateCreate extends SuiTxEndOfEpochKind {
  final String chainIdentifier;
  const SuiEndOfEpochBridgeStateCreate(this.chainIdentifier)
    : super(type: SuiEndOfEpochTransactionKinds.bridgeStateCreate);
  factory SuiEndOfEpochBridgeStateCreate.fromStruct(Map<String, dynamic> json) {
    return SuiEndOfEpochBridgeStateCreate(json.valueAs("chainIdentifier"));
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.bcsString(property: "chainIdentifier"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"chainIdentifier": chainIdentifier};
  }
}

class SuiEndOfEpochBridgeCommitteeInit extends SuiTxEndOfEpochKind {
  final BigInt bridgeSharedVersion;
  SuiEndOfEpochBridgeCommitteeInit({required BigInt bridgeSharedVersion})
    : bridgeSharedVersion = bridgeSharedVersion.asU64,
      super(type: SuiEndOfEpochTransactionKinds.bridgeCommitteeInit);
  factory SuiEndOfEpochBridgeCommitteeInit.fromStruct(
    Map<String, dynamic> json,
  ) {
    return SuiEndOfEpochBridgeCommitteeInit(
      bridgeSharedVersion: json.valueAs("bridgeSharedVersion"),
    );
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.u64(property: "bridgeSharedVersion"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"bridgeSharedVersion": bridgeSharedVersion};
  }
}

class SuiEndOfEpochStoreExecutionTimeObservations extends SuiTxEndOfEpochKind {
  final SuiStoredExecutionTimeObservations observations;
  SuiEndOfEpochStoreExecutionTimeObservations(this.observations)
    : super(type: SuiEndOfEpochTransactionKinds.storeExecutionTimeObservations);
  factory SuiEndOfEpochStoreExecutionTimeObservations.fromStruct(
    Map<String, dynamic> json,
  ) {
    return SuiEndOfEpochStoreExecutionTimeObservations(
      SuiStoredExecutionTimeObservations.fromStruct(
        json.valueEnsureAsMap<String, dynamic>("observations"),
      ),
    );
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      SuiStoredExecutionTimeObservations.layout(property: "observations"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"observations": observations.toLayoutStruct()};
  }
}

class SuiEndOfEpochAccumulatorRootCreate extends SuiTxEndOfEpochKind {
  const SuiEndOfEpochAccumulatorRootCreate()
    : super(type: SuiEndOfEpochTransactionKinds.accumulatorRootCreate);
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.noArgs(property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout();
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {};
  }
}

class SuiEndOfEpochCoinRegistryCreate extends SuiTxEndOfEpochKind {
  const SuiEndOfEpochCoinRegistryCreate()
    : super(type: SuiEndOfEpochTransactionKinds.coinRegistryCreate);
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.noArgs(property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout();
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {};
  }
}

class SuiEndOfEpochDisplayRegistryCreate extends SuiTxEndOfEpochKind {
  const SuiEndOfEpochDisplayRegistryCreate()
    : super(type: SuiEndOfEpochTransactionKinds.displayRegistryCreate);
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.noArgs(property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout();
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {};
  }
}

class SuiEndOfEpochAddressAliasStateCreate extends SuiTxEndOfEpochKind {
  const SuiEndOfEpochAddressAliasStateCreate()
    : super(type: SuiEndOfEpochTransactionKinds.addressAliasStateCreate);
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.noArgs(property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout();
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {};
  }
}

class SuiEndOfEpochWriteAccumulatorStorageCost extends SuiTxEndOfEpochKind {
  final BigInt storageCost;
  SuiEndOfEpochWriteAccumulatorStorageCost({required BigInt storageCost})
    : storageCost = storageCost.asU64,
      super(type: SuiEndOfEpochTransactionKinds.writeAccumulatorStorageCost);
  factory SuiEndOfEpochWriteAccumulatorStorageCost.fromStruct(
    Map<String, dynamic> json,
  ) {
    return SuiEndOfEpochWriteAccumulatorStorageCost(
      storageCost: json.valueAs("storageCost"),
    );
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.u64(property: "storageCost"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"storageCost": storageCost};
  }
}

class SuiEndOfEpochForwardingAddressRegistryCreate extends SuiTxEndOfEpochKind {
  const SuiEndOfEpochForwardingAddressRegistryCreate()
    : super(
        type: SuiEndOfEpochTransactionKinds.forwardingAddressRegistryCreate,
      );
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.noArgs(property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout();
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {};
  }
}

class SuiTransactionKindEndOfEpochTransaction extends SuiTransactionKind {
  final List<SuiTxEndOfEpochKind> transactions;
  SuiTransactionKindEndOfEpochTransaction({
    required List<SuiTxEndOfEpochKind> transactions,
  }) : transactions = transactions.immutable,
       super(type: SuiTransactionKinds.endOfEpochTransaction);
  factory SuiTransactionKindEndOfEpochTransaction.fromStruct(
    Map<String, dynamic> json,
  ) {
    return SuiTransactionKindEndOfEpochTransaction(
      transactions:
          json
              .valueEnsureAsList<Map<String, dynamic>>("transactions")
              .map((e) => SuiTxEndOfEpochKind.fromStruct(e))
              .toList(),
    );
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.bcsVector(
        SuiTxEndOfEpochKind.layout(),
        property: "transactions",
      ),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "transactions":
          transactions.map((e) => e.toVariantLayoutStruct()).toList(),
    };
  }
}

class SuiTransactionKindProgrammableSystemTransaction
    extends SuiTransactionKind {
  final SuiProgrammableTransaction transaction;

  SuiTransactionKindProgrammableSystemTransaction(this.transaction)
    : super(type: SuiTransactionKinds.programmableSystemTransaction);
  factory SuiTransactionKindProgrammableSystemTransaction.fromStruct(
    Map<String, dynamic> json,
  ) {
    return SuiTransactionKindProgrammableSystemTransaction(
      SuiProgrammableTransaction.fromStruct(
        json.valueEnsureAsMap<String, dynamic>("transaction"),
      ),
    );
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      SuiProgrammableTransaction.layout(property: "transaction"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"transaction": transaction.toLayoutStruct()};
  }
}
