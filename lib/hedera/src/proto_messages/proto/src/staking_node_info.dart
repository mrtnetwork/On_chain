import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

/// *
///  * # Staking Node Information
///  * This is an entry describing the staking characteristics of a single active
///  * node.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in [RFC2119](https://www.ietf.org/rfc/rfc2119)
///  * and clarified in [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.state.token"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * An Hedera Token Service staking info entity.
///  *
///  * Staking info is per node. Shard and Realm are implied based on the network
///  * address book entry for this node.
class HederaStakingNodeInfo extends HederaProtoMessage with Equality {
  /// *
  ///      * The entity number of this node.&lt;br/&gt;
  ///      * The shard and realm numbers are implied, based on the network address
  ///      * book entry for this node.
  ///      * &lt;p&gt;
  ///      * This value SHALL be unique within a given shard and realm.&lt;br/&gt;
  ///      * This value MAY be repeated across shards and/or realms.
  final BigInt? nodeNumber;

  /// *
  ///      * The minimum stake, in tinybar, that is required for this node to have a
  ///      * non-zero weight in the network consensus.
  ///      * &lt;p&gt;
  ///      * If the current value of `stake` is below this value, this node SHALL have
  ///      * a zero weight in network consensus.
  final BigInt? minStake;

  /// *
  ///      * The maximum stake to this node that is considered to calculate its weight
  ///      * in the network consensus.
  ///      * &lt;p&gt;
  ///      * If the current `stake` value is above this limit, the excess staked HBAR
  ///      * SHALL NOT be considered when determining consensus weight.
  final BigInt? maxStake;

  /// *
  ///      * The sum of balances of all accounts staked to this node, considering only
  ///      * accounts that choose to receive rewards.
  final BigInt? stakeToReward;

  /// *
  ///      * The sum of balances of all accounts staked to this node, considering only
  ///      * accounts that decline to receive rewards.
  final BigInt? stakeToNotReward;

  /// *
  ///      * The snapshot of stake_to_reward value at the beginning of the current
  ///      * staking period.
  ///      * &lt;p&gt;
  ///      * This is necessary when calculating rewards for the current staking period
  ///      * without considering changes to `stake_to_reward` _within_ the current
  ///      * staking period.&lt;br/&gt;
  ///      * This value SHALL be reset at the beginning of every staking period.
  final BigInt? stakeRewardStart;

  /// *
  ///      * The amount of staked HBAR from `stake_reward_start` that will have
  ///      * unclaimed rewards due to accounts changing their staking metadata in a
  ///      * way that disqualifies them for the current staking period.
  ///      * &lt;p&gt;
  ///      * This value SHALL be reset at the beginning of every staking period.
  final BigInt? unclaimedStakeRewardStart;

  /// *
  ///      * The total amount of HBAR staked to this node.
  ///      * &lt;p&gt;
  ///      * This is sum of stake_to_reward and stake_to_not_reward.&lt;br/&gt;
  ///      * If the sum is greater than `max_stake`, then the _effective_ stake
  ///      * SHALL be `max_stake`.&lt;br/&gt;
  ///      * If the sum is less than `min_stake`, then the _effective_ stake
  ///      * SHALL be `0`.
  final BigInt? stake;

  /// *
  ///      * A running list of reward amounts for the last 365+1 staking periods
  ///      * (typically a year and a day).
  ///      * &lt;p&gt;
  ///      * The first element SHALL be the reward up to and including the last full
  ///      * period prior to the present reward period.&lt;br/&gt;
  ///      * The second element SHALL be the reward up to and including the period
  ///      * before the last full period prior to the present period.&lt;br/&gt;
  ///      * The list SHALL continue in reverse chronological order until the reward
  ///      * history limit is reached.
  final List<BigInt> rewardSumHistory;

  /// *
  ///      * The consensus weight of this node in the network.
  ///      * &lt;p&gt;
  ///      * This is recomputed based on the `stake` of this node at midnight UTC of
  ///      * each day. If the `stake` of this node at that time is less than
  ///      * `min_stake`, then the weight SHALL be 0.&lt;br/&gt;
  ///      * &lt;p&gt;
  ///      * Given the following:
  ///      * &lt;ul&gt;
  ///      *   &lt;li&gt;The `effective stake` of a single node SHALL be `0` if the node
  ///      *       `stake` is less than `min_stake`.&lt;/li&gt;
  ///      *   &lt;li&gt;The `effective stake` SHALL be `max_stake` if the node `stake` is
  ///      *       greater than `max_stake`.&lt;/li&gt;
  ///      *   &lt;li&gt;The `effective stake` SHALL be the actual value of `stake` if
  ///      *       `min_stake` &lt; `stake` &lt; `max_stake`.&lt;/li&gt;
  ///      *   &lt;li&gt;The `effective network stake` SHALL be calculated as ∑(`effective
  ///      *       stake` of each node) for all nodes in the network address book.&lt;/li&gt;
  ///      * &lt;/ul&gt;
  ///      * &lt;p&gt;
  ///      * This field is deprecated and SHALL NOT be used when RosterLifecycle
  ///      * is enabled. The weight SHALL be same as the `effective_stake` described above.
  final int? weight;

  /// *
  ///      * The total staking rewards in tinybars that MAY be collected by all
  ///      * accounts staking to the current node after the end of this staking
  ///      * period.
  ///      * &lt;p&gt;
  ///      * This SHALL be calculated assuming that no account "renounces" its
  ///      * rewards by setting `decline_reward` to true, or is ineligible for
  ///      * some other reason.&lt;br/&gt;
  ///      * When the current node is deleted, this amount SHALL be subtracted from
  ///      * the total pending rewards of all accounts staking to all nodes in the
  ///      * network in NetworkStakingRewards.
  final BigInt? pendingRewards;

  /// *
  ///      * A flag indicating that this node has been removed from this network.
  final bool? deleted;

  const HederaStakingNodeInfo({
    this.nodeNumber,
    this.minStake,
    this.maxStake,
    this.stakeToReward,
    this.stakeToNotReward,
    this.stakeRewardStart,
    this.unclaimedStakeRewardStart,
    this.stake,
    this.rewardSumHistory = const [],
    this.weight,
    this.pendingRewards,
    this.deleted,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.int64(4),
        ProtoFieldConfig.int64(5),
        ProtoFieldConfig.int64(6),
        ProtoFieldConfig.int64(7),
        ProtoFieldConfig.int64(8),
        ProtoFieldConfig.repeated(
          fieldNumber: 9,
          elementType: ProtoFieldType.int64,
        ),
        ProtoFieldConfig.int32(
          10,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.int64(11),
        ProtoFieldConfig.bool(12),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    nodeNumber,
    minStake,
    maxStake,
    stakeToReward,
    stakeToNotReward,
    stakeRewardStart,
    unclaimedStakeRewardStart,
    stake,
    rewardSumHistory,
    weight,
    pendingRewards,
    deleted,
  ];

  HederaStakingNodeInfo copyWith({
    BigInt? nodeNumber,

    BigInt? minStake,

    BigInt? maxStake,

    BigInt? stakeToReward,

    BigInt? stakeToNotReward,

    BigInt? stakeRewardStart,

    BigInt? unclaimedStakeRewardStart,

    BigInt? stake,

    List<BigInt>? rewardSumHistory,

    int? weight,

    BigInt? pendingRewards,

    bool? deleted,
  }) {
    return HederaStakingNodeInfo(
      nodeNumber: nodeNumber ?? this.nodeNumber,
      minStake: minStake ?? this.minStake,
      maxStake: maxStake ?? this.maxStake,
      stakeToReward: stakeToReward ?? this.stakeToReward,
      stakeToNotReward: stakeToNotReward ?? this.stakeToNotReward,
      stakeRewardStart: stakeRewardStart ?? this.stakeRewardStart,
      unclaimedStakeRewardStart:
          unclaimedStakeRewardStart ?? this.unclaimedStakeRewardStart,
      stake: stake ?? this.stake,
      rewardSumHistory: rewardSumHistory ?? this.rewardSumHistory,
      weight: weight ?? this.weight,
      pendingRewards: pendingRewards ?? this.pendingRewards,
      deleted: deleted ?? this.deleted,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'node_number': config.encodeBigint(nodeNumber),
      'min_stake': config.encodeBigint(minStake),
      'max_stake': config.encodeBigint(maxStake),
      'stake_to_reward': config.encodeBigint(stakeToReward),
      'stake_to_not_reward': config.encodeBigint(stakeToNotReward),
      'stake_reward_start': config.encodeBigint(stakeRewardStart),
      'unclaimed_stake_reward_start': config.encodeBigint(
        unclaimedStakeRewardStart,
      ),
      'stake': config.encodeBigint(stake),
      'reward_sum_history':
          rewardSumHistory.map((e) => config.encodeBigint(e)).toList(),
      'weight': weight,
      'pending_rewards': config.encodeBigint(pendingRewards),
      'deleted': deleted,
    };
  }

  factory HederaStakingNodeInfo.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaStakingNodeInfo(
      nodeNumber: json.valueAsBigInt<BigInt?>(
        'node_number',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      minStake: json.valueAsBigInt<BigInt?>(
        'min_stake',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      maxStake: json.valueAsBigInt<BigInt?>(
        'max_stake',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      stakeToReward: json.valueAsBigInt<BigInt?>(
        'stake_to_reward',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      stakeToNotReward: json.valueAsBigInt<BigInt?>(
        'stake_to_not_reward',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      stakeRewardStart: json.valueAsBigInt<BigInt?>(
        'stake_reward_start',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      unclaimedStakeRewardStart: json.valueAsBigInt<BigInt?>(
        'unclaimed_stake_reward_start',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      stake: json.valueAsBigInt<BigInt?>(
        'stake',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      rewardSumHistory:
          (json.valueEnsureAsList<dynamic>(
            'reward_sum_history',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => JsonParser.valueAsBigInt<BigInt>(e)).toList(),
      weight: json.valueAsInt<int?>(
        'weight',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      pendingRewards: json.valueAsBigInt<BigInt?>(
        'pending_rewards',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      deleted: json.valueAsBool<bool?>(
        'deleted',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaStakingNodeInfo.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaStakingNodeInfo(
      nodeNumber: decode.getBigInt<BigInt?>(1),
      minStake: decode.getBigInt<BigInt?>(2),
      maxStake: decode.getBigInt<BigInt?>(3),
      stakeToReward: decode.getBigInt<BigInt?>(4),
      stakeToNotReward: decode.getBigInt<BigInt?>(5),
      stakeRewardStart: decode.getBigInt<BigInt?>(6),
      unclaimedStakeRewardStart: decode.getBigInt<BigInt?>(7),
      stake: decode.getBigInt<BigInt?>(8),
      rewardSumHistory: decode.getListOrEmpty<BigInt>(9),
      weight: decode.getInt<int?>(10),
      pendingRewards: decode.getBigInt<BigInt?>(11),
      deleted: decode.getBool<bool?>(12),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoStakingNodeInfo;
}
