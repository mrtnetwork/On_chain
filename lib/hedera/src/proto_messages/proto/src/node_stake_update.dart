import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart"
    as proto_timestamp;
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;

/// *
///  * # Node Stake Updates
///  * A system-initiated (i.e. internal) transaction to update stake information
///  * for nodes at the end of a staking period.
///  *
///  * Note that staking rewards are not paid immediately. The rewards are
///  * calculated, and the amount to be paid is reserved in the reward account,
///  * at the end of each staking period. The actual recipient accounts are then
///  * paid rewards when that account participates in any transaction that
///  * changes staking information or the account balance. This reduces the
///  * resources for calculating the staking rewards, quite dramatically,
///  * and provides an incentive for account owners to engage with the network,
///  * in at least a minor fashion, occasionally (typically annually).&lt;br/&gt;
///  * The unexpected change in balances, however, can be surprising to the
///  * account holder.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.transaction"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A system initiated transaction to update staking information.
///  *
///  * This transaction SHALL be issued at the end of each staking period to update
///  * node stakes and reward limits.&lt;br/&gt;
///  * This transaction SHALL be a child of the first transaction to reach
///  * consensus following the end of the previous staking period.&lt;br/&gt;
///  * This transaction MUST NOT be sent by a client and SHALL be rejected if
///  * received by any node.&lt;br/&gt;
///  * This transaction SHALL be present in the record stream or block stream.
///  *
///  * ### Block Stream Effects
///  * None
class HederaNodeStakeUpdateTransactionBody extends HederaProtoMessage
    with Equality {
  /// *
  ///      * A timestamp indicating the end of the staking period.
  ///      * &lt;p&gt;
  ///      * This value SHALL be one nanosecond prior to midnight prior to the
  ///      * consensus time of the parent transaction.
  final proto_timestamp.HederaTimestamp? endOfStakingPeriod;

  /// *
  ///      * A list of `NodeStake` entries for each node at the beginning of the new
  ///      * staking period.
  ///      * &lt;p&gt;
  ///      * This list SHALL have one entry for each node participating in network
  ///      * consensus.
  final List<HederaNodeStake> nodeStake;

  /// *
  ///      * A maximum reward rate for this staking period.
  ///      * &lt;p&gt;
  ///      * This SHALL be a ratio of tinybar to HBAR.&lt;br/&gt;
  ///      * An account SHALL NOT receive a reward greater than the product of this
  ///      * ratio and the total number of HBAR staked by that account.
  final BigInt? maxStakingRewardRatePerHbar;

  /// *
  ///      * A fraction of network and service fees paid to
  ///      * the "node" reward account.&lt;br/&gt;
  ///      * The node staking rewards are paid from the designated reward account
  ///      * `0.0.801`, which receives a fraction of network and service fees for
  ///      * each transaction. This field is the value of that fraction for the
  ///      * last staking period.
  final proto_basic_types.HederaFraction? nodeRewardFeeFraction;

  /// *
  ///      * A limit to the number of staking periods held for inactive accounts.&lt;br/&gt;
  ///      * This is the maximum number of trailing staking periods for which an
  ///      * account can collect staking rewards.&lt;br/&gt;
  ///      * #### Example
  ///      * If this value is 365 with a calendar day period, then each account must
  ///      * collect rewards at least once per calendar year to receive the full
  ///      * amount of staking rewards earned.
  ///      * &lt;p&gt;
  ///      * Staking rewards SHALL be stored in network state for no more than
  ///      * `staking_periods_stored` staking periods.&lt;br/&gt;
  ///      * Each account MUST participate in at least one transaction that affects
  ///      * its balance, staking, or staking metadata within this time limit
  ///      * to receive all available staking rewards.
  final BigInt? stakingPeriodsStored;

  /// *
  ///      * A number of minutes representing a staking period.&lt;br/&gt;
  ///      * &lt;blockquote&gt;Note&lt;blockquote&gt;
  ///      * For the special case of `1440` minutes, periods are treated as
  ///      * calendar days aligned to midnight UTC, rather than repeating `1440`
  ///      * minute periods left-aligned at the epoch.&lt;/blockquote&gt;&lt;/blockquote&gt;
  final BigInt? stakingPeriod;

  /// *
  ///      * A fraction of network and service fees paid to
  ///      * the "general" reward account.&lt;br/&gt;
  ///      * The general staking rewards are paid from the designated reward account
  ///      * `0.0.800`, which receives a fraction of network and service fees for
  ///      * each transaction. This field is the value of that fraction for the
  ///      * last staking period.
  final proto_basic_types.HederaFraction? stakingRewardFeeFraction;

  /// *
  ///      * A minimum balance required to pay general staking rewards.
  ///      * &lt;p&gt;
  ///      * If the balance of the staking reward account `0.0.800` is below this
  ///      * threshold, staking rewards SHALL NOT be paid in full.
  final BigInt? stakingStartThreshold;

  /// *
  ///      * HIP-786 replaced this field with `max_total_reward`.&lt;br/&gt;
  ///      * This was a maximum total number of tinybars to be distributed as staking
  ///      * rewards in the staking period that just ended.
  final BigInt? stakingRewardRate;

  /// *
  ///      * An amount reserved in the staking reward account.&lt;br/&gt;
  ///      * This is an amount "reserved" in the balance of account `0.0.800` that
  ///      * is already owed for pending rewards that were previously earned but
  ///      * have not yet been collected.&lt;br/&gt;
  ///      * This value is further detailed in HIP-786.
  final BigInt? reservedStakingRewards;

  /// *
  ///      * An available, unreserved, amount in the staking reward account.&lt;br/&gt;
  ///      * This is the balance of the staking reward account `0.0.800` at the close
  ///      * of the staking period that just ended, after reduction for all "reserved"
  ///      * funds necessary to pay previously earned rewards.&lt;br/&gt;
  ///      * This value is further detailed in HIP-786.
  ///      * &lt;p&gt;
  ///      * This value SHALL be used to calculate the reward ratio according to
  ///      * the formula detailed in HIP-782.
  final BigInt? unreservedStakingRewardBalance;

  /// *
  ///      * A minimum balance required for maximum staking rewards.&lt;br/&gt;
  ///      * This value is further detailed in HIP-786.
  ///      * The formula to calculate staking rewards is detailed in HIP-782.
  ///      * &lt;p&gt;
  ///      * The value of `unreserved_staking_reward_balance` MUST match or exceed the
  ///      * value of this field to support the maximum staking reward ratio.&lt;br/&gt;
  final BigInt? rewardBalanceThreshold;

  /// *
  ///      * A maximum network-wide stake that can earn full rewards.&lt;br/&gt;
  ///      * If the network-wide stake, in tinybar, exceeds this value, then staking
  ///      * rewards must be reduced to maintain "smooth" reward adjustments as
  ///      * defined in HIP-782.&lt;br/&gt;
  ///      * This value is further detailed in HIP-786.
  ///      * &lt;p&gt;
  ///      * If the total network-wide stake exceeds this value, the effective
  ///      * staking reward ratio MUST be reduced to maintain solvency of the
  ///      * staking reward account.
  final BigInt? maxStakeRewarded;

  /// *
  ///      * A limit amount that could be paid as staking rewards.&lt;br/&gt;
  ///      * In the limit case, the network could pay at most this amount, in tinybar
  ///      * as staking rewards for the staking period that just ended, if all other
  ///      * conditions were met to perfection.&lt;br/&gt;
  ///      * &lt;p&gt;
  ///      * This value SHALL reflect the result of a maximum reward calculation that
  ///      * takes into account the balance thresholds and maximum stake thresholds
  ///      * as defined in HIP-782 and HIP-786.&lt;br/&gt;
  ///      * This value is a convenience. The actual defined calculation SHALL be
  ///      * authoritative in the unlikely event this value differs.
  final BigInt? maxTotalReward;

  const HederaNodeStakeUpdateTransactionBody({
    this.endOfStakingPeriod,
    this.nodeStake = const [],
    this.maxStakingRewardRatePerHbar,
    this.nodeRewardFeeFraction,
    this.stakingPeriodsStored,
    this.stakingPeriod,
    this.stakingRewardFeeFraction,
    this.stakingStartThreshold,
    this.stakingRewardRate,
    this.reservedStakingRewards,
    this.unreservedStakingRewardBalance,
    this.rewardBalanceThreshold,
    this.maxStakeRewarded,
    this.maxTotalReward,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.message(4),
        ProtoFieldConfig.int64(5),
        ProtoFieldConfig.int64(6),
        ProtoFieldConfig.message(7),
        ProtoFieldConfig.int64(8),
        ProtoFieldConfig.int64(
          9,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.int64(10),
        ProtoFieldConfig.int64(11),
        ProtoFieldConfig.int64(12),
        ProtoFieldConfig.int64(13),
        ProtoFieldConfig.int64(14),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    endOfStakingPeriod,
    nodeStake,
    maxStakingRewardRatePerHbar,
    nodeRewardFeeFraction,
    stakingPeriodsStored,
    stakingPeriod,
    stakingRewardFeeFraction,
    stakingStartThreshold,
    stakingRewardRate,
    reservedStakingRewards,
    unreservedStakingRewardBalance,
    rewardBalanceThreshold,
    maxStakeRewarded,
    maxTotalReward,
  ];

  HederaNodeStakeUpdateTransactionBody copyWith({
    proto_timestamp.HederaTimestamp? endOfStakingPeriod,

    List<HederaNodeStake>? nodeStake,

    BigInt? maxStakingRewardRatePerHbar,

    proto_basic_types.HederaFraction? nodeRewardFeeFraction,

    BigInt? stakingPeriodsStored,

    BigInt? stakingPeriod,

    proto_basic_types.HederaFraction? stakingRewardFeeFraction,

    BigInt? stakingStartThreshold,

    BigInt? stakingRewardRate,

    BigInt? reservedStakingRewards,

    BigInt? unreservedStakingRewardBalance,

    BigInt? rewardBalanceThreshold,

    BigInt? maxStakeRewarded,

    BigInt? maxTotalReward,
  }) {
    return HederaNodeStakeUpdateTransactionBody(
      endOfStakingPeriod: endOfStakingPeriod ?? this.endOfStakingPeriod,
      nodeStake: nodeStake ?? this.nodeStake,
      maxStakingRewardRatePerHbar:
          maxStakingRewardRatePerHbar ?? this.maxStakingRewardRatePerHbar,
      nodeRewardFeeFraction:
          nodeRewardFeeFraction ?? this.nodeRewardFeeFraction,
      stakingPeriodsStored: stakingPeriodsStored ?? this.stakingPeriodsStored,
      stakingPeriod: stakingPeriod ?? this.stakingPeriod,
      stakingRewardFeeFraction:
          stakingRewardFeeFraction ?? this.stakingRewardFeeFraction,
      stakingStartThreshold:
          stakingStartThreshold ?? this.stakingStartThreshold,
      stakingRewardRate: stakingRewardRate ?? this.stakingRewardRate,
      reservedStakingRewards:
          reservedStakingRewards ?? this.reservedStakingRewards,
      unreservedStakingRewardBalance:
          unreservedStakingRewardBalance ?? this.unreservedStakingRewardBalance,
      rewardBalanceThreshold:
          rewardBalanceThreshold ?? this.rewardBalanceThreshold,
      maxStakeRewarded: maxStakeRewarded ?? this.maxStakeRewarded,
      maxTotalReward: maxTotalReward ?? this.maxTotalReward,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'end_of_staking_period': config.encodeMessage(endOfStakingPeriod),
      'node_stake': nodeStake.map((e) => config.encodeMessage(e)).toList(),
      'max_staking_reward_rate_per_hbar': config.encodeBigint(
        maxStakingRewardRatePerHbar,
      ),
      'node_reward_fee_fraction': config.encodeMessage(nodeRewardFeeFraction),
      'staking_periods_stored': config.encodeBigint(stakingPeriodsStored),
      'staking_period': config.encodeBigint(stakingPeriod),
      'staking_reward_fee_fraction': config.encodeMessage(
        stakingRewardFeeFraction,
      ),
      'staking_start_threshold': config.encodeBigint(stakingStartThreshold),
      'staking_reward_rate': config.encodeBigint(stakingRewardRate),
      'reserved_staking_rewards': config.encodeBigint(reservedStakingRewards),
      'unreserved_staking_reward_balance': config.encodeBigint(
        unreservedStakingRewardBalance,
      ),
      'reward_balance_threshold': config.encodeBigint(rewardBalanceThreshold),
      'max_stake_rewarded': config.encodeBigint(maxStakeRewarded),
      'max_total_reward': config.encodeBigint(maxTotalReward),
    };
  }

  factory HederaNodeStakeUpdateTransactionBody.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaNodeStakeUpdateTransactionBody(
      endOfStakingPeriod: json
          .valueTo<proto_timestamp.HederaTimestamp?, Object>(
            key: 'end_of_staking_period',
            parse:
                (v) => proto_timestamp.HederaTimestamp.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      nodeStake:
          (json.valueEnsureAsList<dynamic>(
                'node_stake',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<HederaNodeStake, Object>(
                  value: e,
                  parse:
                      (v) => HederaNodeStake.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      maxStakingRewardRatePerHbar: json.valueAsBigInt<BigInt?>(
        'max_staking_reward_rate_per_hbar',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      nodeRewardFeeFraction: json
          .valueTo<proto_basic_types.HederaFraction?, Object>(
            key: 'node_reward_fee_fraction',
            parse:
                (v) => proto_basic_types.HederaFraction.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      stakingPeriodsStored: json.valueAsBigInt<BigInt?>(
        'staking_periods_stored',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      stakingPeriod: json.valueAsBigInt<BigInt?>(
        'staking_period',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      stakingRewardFeeFraction: json
          .valueTo<proto_basic_types.HederaFraction?, Object>(
            key: 'staking_reward_fee_fraction',
            parse:
                (v) => proto_basic_types.HederaFraction.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      stakingStartThreshold: json.valueAsBigInt<BigInt?>(
        'staking_start_threshold',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      stakingRewardRate: json.valueAsBigInt<BigInt?>(
        'staking_reward_rate',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      reservedStakingRewards: json.valueAsBigInt<BigInt?>(
        'reserved_staking_rewards',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      unreservedStakingRewardBalance: json.valueAsBigInt<BigInt?>(
        'unreserved_staking_reward_balance',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      rewardBalanceThreshold: json.valueAsBigInt<BigInt?>(
        'reward_balance_threshold',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      maxStakeRewarded: json.valueAsBigInt<BigInt?>(
        'max_stake_rewarded',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      maxTotalReward: json.valueAsBigInt<BigInt?>(
        'max_total_reward',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaNodeStakeUpdateTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaNodeStakeUpdateTransactionBody(
      endOfStakingPeriod: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        1,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
      nodeStake:
          decode
              .getListOfBytes(2)
              .map((b) => HederaNodeStake.deserialize(b))
              .toList(),
      maxStakingRewardRatePerHbar: decode.getBigInt<BigInt?>(3),
      nodeRewardFeeFraction: decode
          .messageTo<proto_basic_types.HederaFraction?>(
            4,
            (b) => proto_basic_types.HederaFraction.deserialize(b),
          ),
      stakingPeriodsStored: decode.getBigInt<BigInt?>(5),
      stakingPeriod: decode.getBigInt<BigInt?>(6),
      stakingRewardFeeFraction: decode
          .messageTo<proto_basic_types.HederaFraction?>(
            7,
            (b) => proto_basic_types.HederaFraction.deserialize(b),
          ),
      stakingStartThreshold: decode.getBigInt<BigInt?>(8),
      stakingRewardRate: decode.getBigInt<BigInt?>(9),
      reservedStakingRewards: decode.getBigInt<BigInt?>(10),
      unreservedStakingRewardBalance: decode.getBigInt<BigInt?>(11),
      rewardBalanceThreshold: decode.getBigInt<BigInt?>(12),
      maxStakeRewarded: decode.getBigInt<BigInt?>(13),
      maxTotalReward: decode.getBigInt<BigInt?>(14),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoNodeStakeUpdateTransactionBody;
}

/// *
///  * Staking information for one node at the end of a staking period.
///  *
///  * This SHALL be one entry in a list reported at the end of each
///  * full staking period.
class HederaNodeStake extends HederaProtoMessage with Equality {
  /// *
  ///      * A limit to the amount of stake considered for consensus weight.
  ///      * &lt;p&gt;
  ///      * The amount of stake (whether accepting rewards or not) assigned to a
  ///      * node that exceeds this limit SHALL NOT be considered for
  ///      * consensus weight calculation.&lt;br/&gt;
  ///      * If stake to _reward_ for a node exceeds this threshold, then all
  ///      * accounts staking to that node SHALL receive a lower reward rate in
  ///      * proportion to the excess stake.
  final BigInt? maxStake;

  /// *
  ///      * A minimum amount of HBAR staked to a node to receive rewards.
  ///      * &lt;p&gt;
  ///      * If the amount of stake (whether accepting rewards or not) assigned to
  ///      * a node at the start of a staking period is less than this threshold,
  ///      * then no rewards SHALL be paid to that node or to any accounts
  ///      * staking to that node.
  final BigInt? minStake;

  /// *
  ///      * A node identifier.&lt;br/&gt;
  ///      * This value uniquely identifies this node within the
  ///      * network address book.
  final BigInt? nodeId;

  /// *
  ///      * The rate of rewards, in tinybar per HBAR, for the staking reward
  ///      * period that just ended.
  final BigInt? rewardRate;

  /// *
  ///      * A consensus weight assigned to this node for the next staking period.
  final BigInt? stake;

  /// *
  ///      * The total amount staked to this node, while declining rewards.
  ///      * &lt;p&gt;
  ///      * This SHALL be the total staked amount, in tinybar, that is staked to
  ///      * this node with the value of the `decline_reward` set.&lt;br/&gt;
  ///      * This value MUST be calculated at the beginning of the staking period.
  final BigInt? stakeNotRewarded;

  /// *
  ///      * The total amount staked to this node, while accepting rewards.
  ///      * &lt;p&gt;
  ///      * This SHALL be the total staked amount, in tinybar, that is staked to
  ///      * this node with the value of the `decline_reward` not set.&lt;br/&gt;
  ///      * This value MUST be calculated at the beginning of the staking period.
  final BigInt? stakeRewarded;

  const HederaNodeStake({
    this.maxStake,
    this.minStake,
    this.nodeId,
    this.rewardRate,
    this.stake,
    this.stakeNotRewarded,
    this.stakeRewarded,
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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    maxStake,
    minStake,
    nodeId,
    rewardRate,
    stake,
    stakeNotRewarded,
    stakeRewarded,
  ];

  HederaNodeStake copyWith({
    BigInt? maxStake,

    BigInt? minStake,

    BigInt? nodeId,

    BigInt? rewardRate,

    BigInt? stake,

    BigInt? stakeNotRewarded,

    BigInt? stakeRewarded,
  }) {
    return HederaNodeStake(
      maxStake: maxStake ?? this.maxStake,
      minStake: minStake ?? this.minStake,
      nodeId: nodeId ?? this.nodeId,
      rewardRate: rewardRate ?? this.rewardRate,
      stake: stake ?? this.stake,
      stakeNotRewarded: stakeNotRewarded ?? this.stakeNotRewarded,
      stakeRewarded: stakeRewarded ?? this.stakeRewarded,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'max_stake': config.encodeBigint(maxStake),
      'min_stake': config.encodeBigint(minStake),
      'node_id': config.encodeBigint(nodeId),
      'reward_rate': config.encodeBigint(rewardRate),
      'stake': config.encodeBigint(stake),
      'stake_not_rewarded': config.encodeBigint(stakeNotRewarded),
      'stake_rewarded': config.encodeBigint(stakeRewarded),
    };
  }

  factory HederaNodeStake.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaNodeStake(
      maxStake: json.valueAsBigInt<BigInt?>(
        'max_stake',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      minStake: json.valueAsBigInt<BigInt?>(
        'min_stake',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      nodeId: json.valueAsBigInt<BigInt?>(
        'node_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      rewardRate: json.valueAsBigInt<BigInt?>(
        'reward_rate',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      stake: json.valueAsBigInt<BigInt?>(
        'stake',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      stakeNotRewarded: json.valueAsBigInt<BigInt?>(
        'stake_not_rewarded',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      stakeRewarded: json.valueAsBigInt<BigInt?>(
        'stake_rewarded',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaNodeStake.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaNodeStake(
      maxStake: decode.getBigInt<BigInt?>(1),
      minStake: decode.getBigInt<BigInt?>(2),
      nodeId: decode.getBigInt<BigInt?>(3),
      rewardRate: decode.getBigInt<BigInt?>(4),
      stake: decode.getBigInt<BigInt?>(5),
      stakeNotRewarded: decode.getBigInt<BigInt?>(6),
      stakeRewarded: decode.getBigInt<BigInt?>(7),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoNodeStake;
}
