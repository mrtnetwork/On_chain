import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart" as proto_timestamp;

/// *
///  * # PlatformState
///  * Messages that hold platform state in the network state.
///  *
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in [RFC2119](https://www.ietf.org/rfc/rfc2119)
///  * and clarified in [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// * Copyright (C) 2024 Hedera Hashgraph, LLC
///  *
///  * Licensed under the Apache License, Version 2.0 (the "License");
///  * you may not use this file except in compliance with the License.
///  * You may obtain a copy of the License at
///  *
///  *      http://www.apache.org/licenses/LICENSE-2.0
///  *
///  * Unless required by applicable law or agreed to in writing, software
///  * distributed under the License is distributed on an "AS IS" BASIS,
///  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
///  * See the License for the specific language governing permissions and
///  * limitations under the License.
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.platform.state"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * The current state of platform consensus.&lt;br/&gt;
///  * This message stores the current consensus data for the platform
///  * in network state.
///  *
///  * The platform state SHALL represent the latest round's consensus.&lt;br/&gt;
///  * This data SHALL be used to ensure consistency and provide critical data for
///  * restart and reconnect.
class HederaPlatformState extends HederaProtoMessage with Equality {
    /// *
  ///      * A version describing the current version of application software.
  ///      * &lt;p&gt;
  ///      * This SHALL be the software version that created this state.
  final proto_basic_types.HederaSemanticVersion? creationSoftwareVersion;

    /// *
  ///      * A number of non-ancient rounds.
  ///      * &lt;p&gt;
  ///      * This SHALL be the count of rounds considered non-ancient.
  final int? roundsNonAncient;

    /// *
  ///      * A snapshot of the consensus state at the end of the round.
  ///      * &lt;p&gt;
  ///      * This SHALL be used for restart/reconnect.
  final HederaConsensusSnapshot? consensusSnapshot;

    /// *
  ///      * A timestamp for the next scheduled time when a freeze will start.
  ///      * &lt;p&gt;
  ///      * If a freeze is not scheduled, this SHALL NOT be set.&lt;br/&gt;
  ///      * If a freeze is currently scheduled, this MUST be set, and MUST
  ///      * match the timestamp requested for that freeze.
  final proto_timestamp.HederaTimestamp? freezeTime;

    /// *
  ///      * A timestamp for the last time a freeze was performed.&lt;br/&gt;
  ///      * If not set, there has never been a freeze.
  final proto_timestamp.HederaTimestamp? lastFrozenTime;

    /// Fields below are to be deprecated in the foreseeable future.
  /// *
  ///      * A running event hash.&lt;br/&gt;
  ///      * This is computed by the consensus event stream.
  ///      * &lt;p&gt;
  ///      * This will be _removed_ and the field number reserved once the consensus
  ///      * event stream is retired.
  final List<int>? legacyRunningEventHash;

    /// *
  ///      * A consensus generation.&lt;br/&gt;
  ///      * The lowest judge generation before birth round mode was enabled.
  ///      * &lt;p&gt;
  ///      * This SHALL be `MAX_UNSIGNED` if birth round mode has not yet been enabled.
  final BigInt? lowestJudgeGenerationBeforeBirthRoundMode;

    /// *
  ///      * A consensus round.&lt;br/&gt;
  ///      * The last round before the birth round mode was enabled.
  ///      * Will be removed after the birth round migration.
  ///      * &lt;p&gt;
  ///      * This SHALL be `MAX_UNSIGNED` if birth round mode has not yet been enabled.
  final BigInt? lastRoundBeforeBirthRoundMode;

    /// *
  ///      * A consensus node semantic version.&lt;br/&gt;
  ///      * The software version that enabled birth round mode.
  ///      * &lt;p&gt;
  ///      * This SHALL be unset if birth round migration has not yet happened.&lt;br/&gt;
  ///      * If birth round migration is complete, this SHALL be the _first_ software
  ///      * version that enabled birth round mode.
  final proto_basic_types.HederaSemanticVersion? firstVersionInBirthRoundMode;

  const HederaPlatformState({
    this.creationSoftwareVersion,
    this.roundsNonAncient,
    this.consensusSnapshot,
    this.freezeTime,
    this.lastFrozenTime,
    this.legacyRunningEventHash,
    this.lowestJudgeGenerationBeforeBirthRoundMode,
    this.lastRoundBeforeBirthRoundMode,
    this.firstVersionInBirthRoundMode,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.uint32(2),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.message(4),
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.bytes(10000, options: [ProtoOptionBool(name: "deprecated", value: true)]),
        ProtoFieldConfig.uint64(10001, options: [ProtoOptionBool(name: "deprecated", value: true)]),
        ProtoFieldConfig.uint64(10002, options: [ProtoOptionBool(name: "deprecated", value: true)]),
        ProtoFieldConfig.message(10003, options: [ProtoOptionBool(name: "deprecated", value: true)]),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        creationSoftwareVersion,
        roundsNonAncient,
        consensusSnapshot,
        freezeTime,
        lastFrozenTime,
        legacyRunningEventHash,
        lowestJudgeGenerationBeforeBirthRoundMode,
        lastRoundBeforeBirthRoundMode,
        firstVersionInBirthRoundMode,
      ];


HederaPlatformState copyWith(
{proto_basic_types.HederaSemanticVersion? creationSoftwareVersion,

int? roundsNonAncient,

HederaConsensusSnapshot? consensusSnapshot,

proto_timestamp.HederaTimestamp? freezeTime,

proto_timestamp.HederaTimestamp? lastFrozenTime,

List<int>? legacyRunningEventHash,

BigInt? lowestJudgeGenerationBeforeBirthRoundMode,

BigInt? lastRoundBeforeBirthRoundMode,

proto_basic_types.HederaSemanticVersion? firstVersionInBirthRoundMode,

}) {
    return HederaPlatformState(
creationSoftwareVersion: creationSoftwareVersion ?? this.creationSoftwareVersion,
roundsNonAncient: roundsNonAncient ?? this.roundsNonAncient,
consensusSnapshot: consensusSnapshot ?? this.consensusSnapshot,
freezeTime: freezeTime ?? this.freezeTime,
lastFrozenTime: lastFrozenTime ?? this.lastFrozenTime,
legacyRunningEventHash: legacyRunningEventHash ?? this.legacyRunningEventHash,
lowestJudgeGenerationBeforeBirthRoundMode: lowestJudgeGenerationBeforeBirthRoundMode ?? this.lowestJudgeGenerationBeforeBirthRoundMode,
lastRoundBeforeBirthRoundMode: lastRoundBeforeBirthRoundMode ?? this.lastRoundBeforeBirthRoundMode,
firstVersionInBirthRoundMode: firstVersionInBirthRoundMode ?? this.firstVersionInBirthRoundMode,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'creation_software_version': config.encodeMessage(creationSoftwareVersion),
      'rounds_non_ancient': roundsNonAncient,
      'consensus_snapshot': config.encodeMessage(consensusSnapshot),
      'freeze_time': config.encodeMessage(freezeTime),
      'last_frozen_time': config.encodeMessage(lastFrozenTime),
      'legacy_running_event_hash': config.encodeBinary(legacyRunningEventHash),
      'lowest_judge_generation_before_birth_round_mode': config.encodeBigint(lowestJudgeGenerationBeforeBirthRoundMode),
      'last_round_before_birth_round_mode': config.encodeBigint(lastRoundBeforeBirthRoundMode),
      'first_version_in_birth_round_mode': config.encodeMessage(firstVersionInBirthRoundMode),
    };
  }


  factory HederaPlatformState.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaPlatformState(
      creationSoftwareVersion: json.valueTo<proto_basic_types.HederaSemanticVersion?, Object>(
        key: 'creation_software_version',
        parse: (v) => proto_basic_types.HederaSemanticVersion.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      roundsNonAncient: json.valueAsInt<int?>('rounds_non_ancient', normalizeKeyLookup: config.normalizeKeys),
      consensusSnapshot: json.valueTo<HederaConsensusSnapshot?, Object>(
        key: 'consensus_snapshot',
        parse: (v) => HederaConsensusSnapshot.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      freezeTime: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'freeze_time',
        parse: (v) => proto_timestamp.HederaTimestamp.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      lastFrozenTime: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'last_frozen_time',
        parse: (v) => proto_timestamp.HederaTimestamp.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      legacyRunningEventHash: config.decodeBinary<List<int>?>(json.valueAs('legacy_running_event_hash', normalizeKeyLookup: config.normalizeKeys)),
      lowestJudgeGenerationBeforeBirthRoundMode: json.valueAsBigInt<BigInt?>('lowest_judge_generation_before_birth_round_mode', normalizeKeyLookup: config.normalizeKeys),
      lastRoundBeforeBirthRoundMode: json.valueAsBigInt<BigInt?>('last_round_before_birth_round_mode', normalizeKeyLookup: config.normalizeKeys),
      firstVersionInBirthRoundMode: json.valueTo<proto_basic_types.HederaSemanticVersion?, Object>(
        key: 'first_version_in_birth_round_mode',
        parse: (v) => proto_basic_types.HederaSemanticVersion.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaPlatformState.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaPlatformState(
      creationSoftwareVersion: decode.messageTo<proto_basic_types.HederaSemanticVersion?>(1, (b) => proto_basic_types.HederaSemanticVersion.deserialize(b)),
      roundsNonAncient: decode.getInt<int?>(2),
      consensusSnapshot: decode.messageTo<HederaConsensusSnapshot?>(3, (b) => HederaConsensusSnapshot.deserialize(b)),
      freezeTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(4, (b) => proto_timestamp.HederaTimestamp.deserialize(b)),
      lastFrozenTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(5, (b) => proto_timestamp.HederaTimestamp.deserialize(b)),
      legacyRunningEventHash: decode.getBytes<List<int>?>(10000),
      lowestJudgeGenerationBeforeBirthRoundMode: decode.getBigInt<BigInt?>(10001),
      lastRoundBeforeBirthRoundMode: decode.getBigInt<BigInt?>(10002),
      firstVersionInBirthRoundMode: decode.messageTo<proto_basic_types.HederaSemanticVersion?>(10003, (b) => proto_basic_types.HederaSemanticVersion.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiPlatformStatePlatformState;

}


/// *
///  * A consensus snapshot.&lt;br/&gt;
///  * This is a snapshot of the consensus state for a particular round.
///  *
///  * This message SHALL record consensus data necessary for restart
///  * and reconnect.
class HederaConsensusSnapshot extends HederaProtoMessage with Equality {
    /// *
  ///      * A consensus round.&lt;br/&gt;
  ///      * The round number of this snapshot.
  final BigInt? round;

    /// *
  ///      * A list of SHA-384 hash values.&lt;br/&gt;
  ///      * The hashes of all judges for this round.
  ///      * &lt;p&gt;
  ///      * This list SHALL be ordered by creator ID.&lt;br/&gt;
  ///      * This list MUST be deterministically ordered.
  final List<List<int>> judgeHashes;

    /// *
  ///      * A list of minimum judge information entries.&lt;br/&gt;
  ///      * These are "minimum ancient" entries for non-ancient rounds.
  final List<HederaMinimumJudgeInfo> minimumJudgeInfoList;

    /// *
  ///      * A single consensus number.&lt;br/&gt;
  ///      * The consensus order of the next event to reach consensus.
  final BigInt? nextConsensusNumber;

    /// *
  ///      * A "consensus" timestamp.&lt;br/&gt;
  ///      * The consensus timestamp of this snapshot.
  ///      * &lt;p&gt;
  ///      * Depending on the context this timestamp may have different meanings:
  ///      * &lt;ul&gt;
  ///      * &lt;li&gt;if there are transactions, the timestamp is equal to the timestamp of the last transaction&lt;/li&gt;
  ///      * &lt;li&gt;if there are no transactions, the timestamp is equal to the timestamp of the last event&lt;/li&gt;
  ///      * &lt;li&gt;if there are no events, the timestamp is equal to the timestamp of the previous round plus a small constant&lt;/li&gt;
  ///      * &lt;/ul&gt;
  ///      * &lt;p&gt;
  ///      * This SHALL be a consensus value and MAY NOT correspond to an actual
  ///      * "wall clock" timestamp.&lt;br/&gt;
  ///      * Consensus Timestamps SHALL always increase.
  final proto_timestamp.HederaTimestamp? consensusTimestamp;

    /// * A list of judge creator ids and its hashes in a round.&lt;br/&gt;
  final List<HederaJudgeId> judgeIds;

  const HederaConsensusSnapshot({
    this.round,
    this.judgeHashes = const [],
    this.minimumJudgeInfoList = const [],
    this.nextConsensusNumber,
    this.consensusTimestamp,
    this.judgeIds = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.bytes,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 3,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.uint64(4),
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.repeated(
          fieldNumber: 6,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        round,
        judgeHashes,
        minimumJudgeInfoList,
        nextConsensusNumber,
        consensusTimestamp,
        judgeIds,
      ];


HederaConsensusSnapshot copyWith(
{BigInt? round,

List<List<int>>? judgeHashes,

List<HederaMinimumJudgeInfo>? minimumJudgeInfoList,

BigInt? nextConsensusNumber,

proto_timestamp.HederaTimestamp? consensusTimestamp,

List<HederaJudgeId>? judgeIds,

}) {
    return HederaConsensusSnapshot(
round: round ?? this.round,
judgeHashes: judgeHashes ?? this.judgeHashes,
minimumJudgeInfoList: minimumJudgeInfoList ?? this.minimumJudgeInfoList,
nextConsensusNumber: nextConsensusNumber ?? this.nextConsensusNumber,
consensusTimestamp: consensusTimestamp ?? this.consensusTimestamp,
judgeIds: judgeIds ?? this.judgeIds,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'round': config.encodeBigint(round),
      'judge_hashes': judgeHashes.map((e) => config.encodeBinary(e)).toList(),
      'minimum_judge_info_list': minimumJudgeInfoList.map((e) => config.encodeMessage(e)).toList(),
      'next_consensus_number': config.encodeBigint(nextConsensusNumber),
      'consensus_timestamp': config.encodeMessage(consensusTimestamp),
      'judge_ids': judgeIds.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaConsensusSnapshot.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaConsensusSnapshot(
      round: json.valueAsBigInt<BigInt?>('round', normalizeKeyLookup: config.normalizeKeys),
      judgeHashes: (json.valueEnsureAsList<dynamic>('judge_hashes', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => config.decodeBinary<List<int>>(e)).toList(),
      minimumJudgeInfoList: (json.valueEnsureAsList<dynamic>('minimum_judge_info_list', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaMinimumJudgeInfo, Object>(
          value: e,
          parse: (v) => HederaMinimumJudgeInfo.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
      nextConsensusNumber: json.valueAsBigInt<BigInt?>('next_consensus_number', normalizeKeyLookup: config.normalizeKeys),
      consensusTimestamp: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'consensus_timestamp',
        parse: (v) => proto_timestamp.HederaTimestamp.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      judgeIds: (json.valueEnsureAsList<dynamic>('judge_ids', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaJudgeId, Object>(
          value: e,
          parse: (v) => HederaJudgeId.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaConsensusSnapshot.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaConsensusSnapshot(
      round: decode.getBigInt<BigInt?>(1),
      judgeHashes: decode.getListOfBytes(2),
      minimumJudgeInfoList: decode.getListOfBytes(3).map((b) => HederaMinimumJudgeInfo.deserialize(b)).toList(),
      nextConsensusNumber: decode.getBigInt<BigInt?>(4),
      consensusTimestamp: decode.messageTo<proto_timestamp.HederaTimestamp?>(5, (b) => proto_timestamp.HederaTimestamp.deserialize(b)),
      judgeIds: decode.getListOfBytes(6).map((b) => HederaJudgeId.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiPlatformStateConsensusSnapshot;

}


/// *
///  * A judge information that includes the creator node ID and the
///  * SHA-384 hash value of the judge.
class HederaJudgeId extends HederaProtoMessage with Equality {
    /// *
  ///      * The creator node ID who created this judge.
  final BigInt? creatorId;

    /// *
  ///      * SHA-384 hash value of this judge
  final List<int>? judgeHash;

  const HederaJudgeId({
    this.creatorId,
    this.judgeHash,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1),
        ProtoFieldConfig.bytes(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        creatorId,
        judgeHash,
      ];


HederaJudgeId copyWith(
{BigInt? creatorId,

List<int>? judgeHash,

}) {
    return HederaJudgeId(
creatorId: creatorId ?? this.creatorId,
judgeHash: judgeHash ?? this.judgeHash,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'creator_id': config.encodeBigint(creatorId),
      'judge_hash': config.encodeBinary(judgeHash),
    };
  }


  factory HederaJudgeId.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaJudgeId(
      creatorId: json.valueAsBigInt<BigInt?>('creator_id', normalizeKeyLookup: config.normalizeKeys),
      judgeHash: config.decodeBinary<List<int>?>(json.valueAs('judge_hash', normalizeKeyLookup: config.normalizeKeys)),
    );
  }

  factory HederaJudgeId.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaJudgeId(
      creatorId: decode.getBigInt<BigInt?>(1),
      judgeHash: decode.getBytes<List<int>?>(2),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiPlatformStateJudgeId;

}


/// *
///  * Records the minimum ancient indicator for all judges in a particular round.
class HederaMinimumJudgeInfo extends HederaProtoMessage with Equality {
    /// *
  ///      * A consensus round.&lt;br/&gt;
  ///      * The round this judge information applies to.
  final BigInt? round;

    /// *
  ///      * This is a minimum ancient threshold for all judges for a given round.
  ///      * The value should be interpreted as a generation if the birth
  ///      * round migration is not yet completed, and a birth round thereafter.
  ///      * &lt;p&gt;
  ///      * This SHALL reflect the relevant minimum threshold, whether
  ///      * generation-based or birth-round-based.
  final BigInt? minimumJudgeAncientThreshold;

  const HederaMinimumJudgeInfo({
    this.round,
    this.minimumJudgeAncientThreshold,
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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        round,
        minimumJudgeAncientThreshold,
      ];


HederaMinimumJudgeInfo copyWith(
{BigInt? round,

BigInt? minimumJudgeAncientThreshold,

}) {
    return HederaMinimumJudgeInfo(
round: round ?? this.round,
minimumJudgeAncientThreshold: minimumJudgeAncientThreshold ?? this.minimumJudgeAncientThreshold,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'round': config.encodeBigint(round),
      'minimum_judge_ancient_threshold': config.encodeBigint(minimumJudgeAncientThreshold),
    };
  }


  factory HederaMinimumJudgeInfo.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaMinimumJudgeInfo(
      round: json.valueAsBigInt<BigInt?>('round', normalizeKeyLookup: config.normalizeKeys),
      minimumJudgeAncientThreshold: json.valueAsBigInt<BigInt?>('minimum_judge_ancient_threshold', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaMinimumJudgeInfo.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaMinimumJudgeInfo(
      round: decode.getBigInt<BigInt?>(1),
      minimumJudgeAncientThreshold: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiPlatformStateMinimumJudgeInfo;

}


/// *
///  * A consensus node identifier.&lt;br/&gt;
///  * This value uniquely identifies a single consensus node within the network.
class HederaNodeId extends HederaProtoMessage with Equality {
    /// *
  ///    * A numeric identifier.
  final BigInt? id;

  const HederaNodeId({
    this.id,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        id,
      ];


HederaNodeId copyWith(
{BigInt? id,

}) {
    return HederaNodeId(
id: id ?? this.id,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'id': config.encodeBigint(id),
    };
  }


  factory HederaNodeId.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaNodeId(
      id: json.valueAsBigInt<BigInt?>('id', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaNodeId.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaNodeId(
      id: decode.getBigInt<BigInt?>(1),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiPlatformStateNodeId;

}


