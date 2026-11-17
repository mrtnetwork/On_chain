import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/proto_messages/types.dart';
import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';
import 'package:on_chain/sui/src/serialization/protobuf/wkt.dart';

import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/bcs.dart" as sui_rpc_v2_bcs;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/gas_cost_summary.dart" as sui_rpc_v2_gas_cost_summary;
import "package:on_chain/sui/src/proto_messages/google/protobuf/src/timestamp.dart" as google_protobuf_timestamp;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/signature.dart" as sui_rpc_v2_signature;

enum SuiCheckpointCommitmentCheckpointCommitmentKind implements ProtoEnumVariant {
  checkpointCommitmentKindUnknown(0, 'CHECKPOINT_COMMITMENT_KIND_UNKNOWN'),
    /// An elliptic curve multiset hash attesting to the set of objects that
  /// comprise the live state of the Sui blockchain.
  ecmhLiveObjectSet(1, 'ECMH_LIVE_OBJECT_SET'),
    /// Digest of the checkpoint artifacts.
  checkpointArtifacts(2, 'CHECKPOINT_ARTIFACTS');

  const SuiCheckpointCommitmentCheckpointCommitmentKind(this.value, this.protoName);
  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static SuiCheckpointCommitmentCheckpointCommitmentKind fromValue(int? value) {
    value ??=0;
    return SuiCheckpointCommitmentCheckpointCommitmentKind.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching SuiCheckpointCommitmentCheckpointCommitmentKind found for the given value. $value", details: {"name": "SuiCheckpointCommitmentCheckpointCommitmentKind", "value": value?.toString()})
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static SuiCheckpointCommitmentCheckpointCommitmentKind from(Object? value) {
    value ??=0;
    return SuiCheckpointCommitmentCheckpointCommitmentKind.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching SuiCheckpointCommitmentCheckpointCommitmentKind found for the given value. $value", details: {"name": "SuiCheckpointCommitmentCheckpointCommitmentKind", "value": value?.toString()})
    );
  }

}


/// Copyright (c) Mysten Labs, Inc.
/// SPDX-License-Identifier: Apache-2.0
/// A header for a checkpoint on the Sui blockchain.
///
/// On the Sui network, checkpoints define the history of the blockchain. They are quite similar to
/// the concept of blocks used by other blockchains like Bitcoin or Ethereum. The Sui blockchain,
/// however, forms checkpoints after transaction execution has already happened to provide a
/// certified history of the chain, instead of being formed before execution.
///
/// Checkpoints commit to a variety of state, including but not limited to:
/// - The hash of the previous checkpoint.
/// - The set of transaction digests, their corresponding effects digests, as well as the set of
/// user signatures that authorized its execution.
/// - The objects produced by a transaction.
/// - The set of live objects that make up the current state of the chain.
/// - On epoch transitions, the next validator committee.
///
/// `CheckpointSummary`s themselves don't directly include all of the previous information but they
/// are the top-level type by which all the information is committed to transitively via cryptographic
/// hashes included in the summary. `CheckpointSummary`s are signed and certified by a quorum of
/// the validator committee in a given epoch to allow verification of the chain's state.
class SuiCheckpointSummary extends SuiProtoMessage {
    /// This CheckpointSummary serialized as BCS.
  final sui_rpc_v2_bcs.SuiBcs? bcs;

    /// The digest of this CheckpointSummary.
  final String? digest;

    /// Epoch that this checkpoint belongs to.
  final BigInt? epoch;

    /// The height of this checkpoint.
  final BigInt? sequenceNumber;

    /// Total number of transactions committed since genesis, including those in this
  /// checkpoint.
  final BigInt? totalNetworkTransactions;

    /// The hash of the `CheckpointContents` for this checkpoint.
  final String? contentDigest;

    /// The hash of the previous `CheckpointSummary`.
  ///
  /// This will be `None` only for the first, or genesis, checkpoint.
  final String? previousDigest;

    /// The running total gas costs of all transactions included in the current epoch so far
  /// until this checkpoint.
  final sui_rpc_v2_gas_cost_summary.SuiGasCostSummary? epochRollingGasCostSummary;

    /// Timestamp of the checkpoint - number of milliseconds from the Unix epoch
  /// Checkpoint timestamps are monotonic, but not strongly monotonic - subsequent
  /// checkpoints can have the same timestamp if they originate from the same underlining consensus commit.
  final google_protobuf_timestamp.SuiTimestamp? timestamp;

    /// Commitments to checkpoint-specific state.
  final List<SuiCheckpointCommitment> commitments;

    /// Extra data only present in the final checkpoint of an epoch.
  final SuiEndOfEpochData? endOfEpochData;

    /// `CheckpointSummary` is not an evolvable structure - it must be readable by any version of
  /// the code. Therefore, to allow extensions to be added to `CheckpointSummary`,
  /// opaque data can be added to checkpoints, which can be deserialized based on the current
  /// protocol version.
  final BuBytes? versionSpecificData;

  SuiCheckpointSummary({
    this.bcs,
    this.digest,
    this.epoch,
    this.sequenceNumber,
    this.totalNetworkTransactions,
    this.contentDigest,
    this.previousDigest,
    this.epochRollingGasCostSummary,
    this.timestamp,
    this.commitments = const [],
    this.endOfEpochData,
    List<int>? versionSpecificData,
  }) : 
    versionSpecificData = versionSpecificData?.asImmutableBytes;

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
        ProtoFieldConfig.string(2, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(3, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(4, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(5, hasOptionalFlags: true),
        ProtoFieldConfig.string(6, hasOptionalFlags: true),
        ProtoFieldConfig.string(7, hasOptionalFlags: true),
        ProtoFieldConfig.message(8, hasOptionalFlags: true),
        ProtoFieldConfig.message(9, hasOptionalFlags: true),
        ProtoFieldConfig.repeated(
          fieldNumber: 10,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.message(11, hasOptionalFlags: true),
        ProtoFieldConfig.bytes(12, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        bcs,
        digest,
        epoch,
        sequenceNumber,
        totalNetworkTransactions,
        contentDigest,
        previousDigest,
        epochRollingGasCostSummary,
        timestamp,
        commitments,
        endOfEpochData,
        versionSpecificData,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'bcs': config.encodeMessage(bcs),
      'digest': digest,
      'epoch': config.encodeBigint(epoch),
      'sequence_number': config.encodeBigint(sequenceNumber),
      'total_network_transactions': config.encodeBigint(totalNetworkTransactions),
      'content_digest': contentDigest,
      'previous_digest': previousDigest,
      'epoch_rolling_gas_cost_summary': config.encodeMessage(epochRollingGasCostSummary),
      'timestamp': timestamp?.toRfc3339(),
      'commitments': commitments.map((e) => config.encodeMessage(e)).toList(),
      'end_of_epoch_data': config.encodeMessage(endOfEpochData),
      'version_specific_data': config.encodeBinary(versionSpecificData),
    };
  }


  factory SuiCheckpointSummary.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiCheckpointSummary(
      bcs: json.valueTo<sui_rpc_v2_bcs.SuiBcs?, Object>(
        key: 'bcs',
        parse: (v) => sui_rpc_v2_bcs.SuiBcs.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      digest: json.valueAsString<String?>('digest', normalizeKeyLookup: config.normalizeKeys),
      epoch: json.valueAsBigInt<BigInt?>('epoch', normalizeKeyLookup: config.normalizeKeys),
      sequenceNumber: json.valueAsBigInt<BigInt?>('sequence_number', normalizeKeyLookup: config.normalizeKeys),
      totalNetworkTransactions: json.valueAsBigInt<BigInt?>('total_network_transactions', normalizeKeyLookup: config.normalizeKeys),
      contentDigest: json.valueAsString<String?>('content_digest', normalizeKeyLookup: config.normalizeKeys),
      previousDigest: json.valueAsString<String?>('previous_digest', normalizeKeyLookup: config.normalizeKeys),
      epochRollingGasCostSummary: json.valueTo<sui_rpc_v2_gas_cost_summary.SuiGasCostSummary?, Object>(
        key: 'epoch_rolling_gas_cost_summary',
        parse: (v) => sui_rpc_v2_gas_cost_summary.SuiGasCostSummary.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      timestamp: json.valueTo<google_protobuf_timestamp.SuiTimestamp?, Object>(
        key: 'timestamp',
        parse: (v) => google_protobuf_timestamp.SuiTimestamp.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      commitments: (json.valueEnsureAsList<dynamic>('commitments', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<SuiCheckpointCommitment, Object>(
          value: e,
          parse: (v) => SuiCheckpointCommitment.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
      endOfEpochData: json.valueTo<SuiEndOfEpochData?, Object>(
        key: 'end_of_epoch_data',
        parse: (v) => SuiEndOfEpochData.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      versionSpecificData: config.decodeBinary<List<int>?>(json.valueAs('version_specific_data', normalizeKeyLookup: config.normalizeKeys)),
    );
  }

  factory SuiCheckpointSummary.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiCheckpointSummary(
      bcs: decode.messageTo<sui_rpc_v2_bcs.SuiBcs?>(1, (b) => sui_rpc_v2_bcs.SuiBcs.deserialize(b)),
      digest: decode.getString<String?>(2),
      epoch: decode.getBigInt<BigInt?>(3),
      sequenceNumber: decode.getBigInt<BigInt?>(4),
      totalNetworkTransactions: decode.getBigInt<BigInt?>(5),
      contentDigest: decode.getString<String?>(6),
      previousDigest: decode.getString<String?>(7),
      epochRollingGasCostSummary: decode.messageTo<sui_rpc_v2_gas_cost_summary.SuiGasCostSummary?>(8, (b) => sui_rpc_v2_gas_cost_summary.SuiGasCostSummary.deserialize(b)),
      timestamp: decode.messageTo<google_protobuf_timestamp.SuiTimestamp?>(9, (b) => google_protobuf_timestamp.SuiTimestamp.deserialize(b)),
      commitments: decode.getListOfBytes(10).map((b) => SuiCheckpointCommitment.deserialize(b)).toList(),
      endOfEpochData: decode.messageTo<SuiEndOfEpochData?>(11, (b) => SuiEndOfEpochData.deserialize(b)),
      versionSpecificData: decode.getBytes<List<int>?>(12),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2CheckpointSummary;

}


/// Data, which when included in a `CheckpointSummary`, signals the end of an `Epoch`.
class SuiEndOfEpochData extends SuiProtoMessage {
    /// The set of validators that will be in the `ValidatorCommittee` for the next epoch.
  final List<sui_rpc_v2_signature.SuiValidatorCommitteeMember> nextEpochCommittee;

    /// The protocol version that is in effect during the next epoch.
  final BigInt? nextEpochProtocolVersion;

    /// Commitments to epoch specific state (live object set)
  final List<SuiCheckpointCommitment> epochCommitments;

  const SuiEndOfEpochData({
    this.nextEpochCommittee = const [],
    this.nextEpochProtocolVersion,
    this.epochCommitments = const [],
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
        ProtoFieldConfig.uint64(2, hasOptionalFlags: true),
        ProtoFieldConfig.repeated(
          fieldNumber: 3,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        nextEpochCommittee,
        nextEpochProtocolVersion,
        epochCommitments,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'next_epoch_committee': nextEpochCommittee.map((e) => config.encodeMessage(e)).toList(),
      'next_epoch_protocol_version': config.encodeBigint(nextEpochProtocolVersion),
      'epoch_commitments': epochCommitments.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory SuiEndOfEpochData.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiEndOfEpochData(
      nextEpochCommittee: (json.valueEnsureAsList<dynamic>('next_epoch_committee', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<sui_rpc_v2_signature.SuiValidatorCommitteeMember, Object>(
          value: e,
          parse: (v) => sui_rpc_v2_signature.SuiValidatorCommitteeMember.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
      nextEpochProtocolVersion: json.valueAsBigInt<BigInt?>('next_epoch_protocol_version', normalizeKeyLookup: config.normalizeKeys),
      epochCommitments: (json.valueEnsureAsList<dynamic>('epoch_commitments', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<SuiCheckpointCommitment, Object>(
          value: e,
          parse: (v) => SuiCheckpointCommitment.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory SuiEndOfEpochData.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiEndOfEpochData(
      nextEpochCommittee: decode.getListOfBytes(1).map((b) => sui_rpc_v2_signature.SuiValidatorCommitteeMember.deserialize(b)).toList(),
      nextEpochProtocolVersion: decode.getBigInt<BigInt?>(2),
      epochCommitments: decode.getListOfBytes(3).map((b) => SuiCheckpointCommitment.deserialize(b)).toList(),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2EndOfEpochData;

}


/// A commitment made by a checkpoint.
class SuiCheckpointCommitment extends SuiProtoMessage {
  final SuiCheckpointCommitmentCheckpointCommitmentKind? kind;

  final String? digest;

  const SuiCheckpointCommitment({
    this.kind,
    this.digest,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.enumType(1, hasOptionalFlags: true),
        ProtoFieldConfig.string(2, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        kind,
        digest,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'kind': config.encodeEnum(kind),
      'digest': digest,
    };
  }


  factory SuiCheckpointCommitment.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiCheckpointCommitment(
      kind: json.valueTo<SuiCheckpointCommitmentCheckpointCommitmentKind?, Object?>(
        key: 'kind',
        parse: (v) => SuiCheckpointCommitmentCheckpointCommitmentKind.from(v),
      ),
      digest: json.valueAsString<String?>('digest', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory SuiCheckpointCommitment.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiCheckpointCommitment(
      kind: decode.getEnum<SuiCheckpointCommitmentCheckpointCommitmentKind?>(1, SuiCheckpointCommitmentCheckpointCommitmentKind.values),
      digest: decode.getString<String?>(2),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2CheckpointCommitment;

}


