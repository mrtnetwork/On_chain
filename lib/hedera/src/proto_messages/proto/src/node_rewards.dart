import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

/// -
///  * ‌
///  * Hedera Token Services Protobuf
///  * ​
///  * Copyright (C) 2018 - 2023 Hedera Hashgraph, LLC
///  * ​
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
///  * ‍
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.state.token"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A record of node rewards status.&lt;br/&gt;
///  * This is used to record the number of "active" nodes in a staking
///  * period based on number of judges each node created in that period.
///  * It also records the number of rounds so far in the staking period.
///  *
///  * A Node SHALL be considered "active" if it produced "judges" according
///  * to the consensus algorithm in a percentage of rounds, during the
///  * staking period, greater than the network configuration value for
///  * `nodes.activeRoundsPercent`.
class HederaNodeRewards extends HederaProtoMessage with Equality {
    /// *
  ///    * A number of rounds so far, in this staking period.
  final BigInt? numRoundsInStakingPeriod;

    /// *
  ///    * The fees collected by node accounts in this period.
  final BigInt? nodeFeesCollected;

    /// *
  ///    * A list of node activities.&lt;br/&gt;
  ///    * This records the number of rounds when each node created
  ///    * judges for the consensus algorithm.
  ///    * &lt;p&gt;
  ///    * This list SHALL contain one entry for each node participating
  ///    * in consensus during this staking period.
  final List<HederaNodeActivity> nodeActivities;

  const HederaNodeRewards({
    this.numRoundsInStakingPeriod,
    this.nodeFeesCollected,
    this.nodeActivities = const [],
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
        ProtoFieldConfig.repeated(
          fieldNumber: 3,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        numRoundsInStakingPeriod,
        nodeFeesCollected,
        nodeActivities,
      ];


HederaNodeRewards copyWith(
{BigInt? numRoundsInStakingPeriod,

BigInt? nodeFeesCollected,

List<HederaNodeActivity>? nodeActivities,

}) {
    return HederaNodeRewards(
numRoundsInStakingPeriod: numRoundsInStakingPeriod ?? this.numRoundsInStakingPeriod,
nodeFeesCollected: nodeFeesCollected ?? this.nodeFeesCollected,
nodeActivities: nodeActivities ?? this.nodeActivities,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'num_rounds_in_staking_period': config.encodeBigint(numRoundsInStakingPeriod),
      'node_fees_collected': config.encodeBigint(nodeFeesCollected),
      'node_activities': nodeActivities.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaNodeRewards.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaNodeRewards(
      numRoundsInStakingPeriod: json.valueAsBigInt<BigInt?>('num_rounds_in_staking_period', normalizeKeyLookup: config.normalizeKeys),
      nodeFeesCollected: json.valueAsBigInt<BigInt?>('node_fees_collected', normalizeKeyLookup: config.normalizeKeys),
      nodeActivities: (json.valueEnsureAsList<dynamic>('node_activities', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaNodeActivity, Object>(
          value: e,
          parse: (v) => HederaNodeActivity.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaNodeRewards.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaNodeRewards(
      numRoundsInStakingPeriod: decode.getBigInt<BigInt?>(1),
      nodeFeesCollected: decode.getBigInt<BigInt?>(2),
      nodeActivities: decode.getListOfBytes(3).map((b) => HederaNodeActivity.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoNodeRewards;

}


/// *
///  * A record of judge rounds missed by a single node.&lt;br/&gt;
///  * This records, for a single node, the number of rounds so far, during this staking
///  * period that missed creating judges. This is used to determine if the node is
///  * "active" or not.
///  *
///  * This message SHALL NOT record the total number of rounds in a staking
///  * period.&lt;br/&gt;
///  * This message SHALL record a count of rounds for a single node that missed creating judges.
class HederaNodeActivity extends HederaProtoMessage with Equality {
    /// *
  ///    * A node identifier.
  final BigInt? nodeId;

    /// *
  ///    * A count of rounds.&lt;br/&gt;
  ///    * This is the count of rounds so far, in this staking period in which the node identified
  ///    * by `node_id` did not create judges.
  final BigInt? numMissedJudgeRounds;

  const HederaNodeActivity({
    this.nodeId,
    this.numMissedJudgeRounds,
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
        nodeId,
        numMissedJudgeRounds,
      ];


HederaNodeActivity copyWith(
{BigInt? nodeId,

BigInt? numMissedJudgeRounds,

}) {
    return HederaNodeActivity(
nodeId: nodeId ?? this.nodeId,
numMissedJudgeRounds: numMissedJudgeRounds ?? this.numMissedJudgeRounds,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'node_id': config.encodeBigint(nodeId),
      'num_missed_judge_rounds': config.encodeBigint(numMissedJudgeRounds),
    };
  }


  factory HederaNodeActivity.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaNodeActivity(
      nodeId: json.valueAsBigInt<BigInt?>('node_id', normalizeKeyLookup: config.normalizeKeys),
      numMissedJudgeRounds: json.valueAsBigInt<BigInt?>('num_missed_judge_rounds', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory HederaNodeActivity.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaNodeActivity(
      nodeId: decode.getBigInt<BigInt?>(1),
      numMissedJudgeRounds: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoNodeActivity;

}


