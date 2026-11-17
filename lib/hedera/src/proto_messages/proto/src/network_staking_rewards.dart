import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart" as proto_timestamp;

/// *
///  * # Network Staking Rewards
///  * The information needed to calculate the staking rewards for all nodes in
///  * the network.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in [RFC2119](https://www.ietf.org/rfc/rfc2119)
///  * and clarified in [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.state.token"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * An Hedera Token Service staking reward entity.
///  * This stores values related to the aggregate staking rewards for all nodes in
///  * the network. It is calculated at the beginning of each staking period.
class HederaNetworkStakingRewards extends HederaProtoMessage with Equality {
    /// *
  ///      * A flag indicating that staking rewards are activated on the network.
  ///      * &lt;p&gt;
  ///      * Among other criteria, this is set to true when the balance of 0.0.800
  ///      * (the account that pays rewards) reaches a minimum required balance.
  final bool? stakingRewardsActivated;

    /// *
  ///      * A global snapshot of the `stake_to_reward` value for all nodes at the
  ///      * beginning of the current staking period.
  ///      * &lt;p&gt;
  ///      * The `stake_to_reward` value is the sum of balance and `staked_to_me` for
  ///      * all accounts staked to a node that do not decline staking rewards.&lt;br/&gt;
  ///      * This is needed for calculating rewards for current staking period without
  ///      * considering changes to `stake_to_reward` within the current staking period.&lt;br/&gt;
  ///      * This value SHALL be reset at the beginning of every staking period.
  final BigInt? totalStakedRewardStart;

    /// *
  ///      * A global snapshot of the `stake` value for all nodes at the beginning of
  ///      * the current staking period.
  ///      * &lt;p&gt;
  ///      * The `stake` value is the sum of balance and `staked_to_me` for all
  ///      * accounts staked to a node, and SHALL NOT consider whether the account
  ///      * has accepted or declined rewards.&lt;br/&gt;
  ///      * This value SHALL be reset at the beginning of every staking period.
  final BigInt? totalStakedStart;

    /// *
  ///      * The total staking rewards, in tinybars, that may be collected by all
  ///      * accounts staking to all nodes after the end of this staking period.
  ///      * &lt;p&gt;
  ///      * This SHALL be calculated assuming that no account "renounces" its
  ///      * rewards by setting `decline_reward` to true, or is ineligible for some
  ///      * other reason.&lt;br/&gt;
  ///      * If a node is removed, the `pending_rewards` value of that node SHALL be
  ///      * subtracted from this value.
  final BigInt? pendingRewards;

    /// *
  ///      * The last time a node reward payment was made. This will be set at the
  ///      * end of a staking period.
  final proto_timestamp.HederaTimestamp? lastNodeRewardPaymentsTime;

  const HederaNetworkStakingRewards({
    this.stakingRewardsActivated,
    this.totalStakedRewardStart,
    this.totalStakedStart,
    this.pendingRewards,
    this.lastNodeRewardPaymentsTime,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bool(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.int64(4),
        ProtoFieldConfig.message(5),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        stakingRewardsActivated,
        totalStakedRewardStart,
        totalStakedStart,
        pendingRewards,
        lastNodeRewardPaymentsTime,
      ];


HederaNetworkStakingRewards copyWith(
{bool? stakingRewardsActivated,

BigInt? totalStakedRewardStart,

BigInt? totalStakedStart,

BigInt? pendingRewards,

proto_timestamp.HederaTimestamp? lastNodeRewardPaymentsTime,

}) {
    return HederaNetworkStakingRewards(
stakingRewardsActivated: stakingRewardsActivated ?? this.stakingRewardsActivated,
totalStakedRewardStart: totalStakedRewardStart ?? this.totalStakedRewardStart,
totalStakedStart: totalStakedStart ?? this.totalStakedStart,
pendingRewards: pendingRewards ?? this.pendingRewards,
lastNodeRewardPaymentsTime: lastNodeRewardPaymentsTime ?? this.lastNodeRewardPaymentsTime,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'staking_rewards_activated': stakingRewardsActivated,
      'total_staked_reward_start': config.encodeBigint(totalStakedRewardStart),
      'total_staked_start': config.encodeBigint(totalStakedStart),
      'pending_rewards': config.encodeBigint(pendingRewards),
      'last_node_reward_payments_time': config.encodeMessage(lastNodeRewardPaymentsTime),
    };
  }


  factory HederaNetworkStakingRewards.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaNetworkStakingRewards(
      stakingRewardsActivated: json.valueAsBool<bool?>('staking_rewards_activated', normalizeKeyLookup: config.normalizeKeys),
      totalStakedRewardStart: json.valueAsBigInt<BigInt?>('total_staked_reward_start', normalizeKeyLookup: config.normalizeKeys),
      totalStakedStart: json.valueAsBigInt<BigInt?>('total_staked_start', normalizeKeyLookup: config.normalizeKeys),
      pendingRewards: json.valueAsBigInt<BigInt?>('pending_rewards', normalizeKeyLookup: config.normalizeKeys),
      lastNodeRewardPaymentsTime: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'last_node_reward_payments_time',
        parse: (v) => proto_timestamp.HederaTimestamp.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaNetworkStakingRewards.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaNetworkStakingRewards(
      stakingRewardsActivated: decode.getBool<bool?>(1),
      totalStakedRewardStart: decode.getBigInt<BigInt?>(2),
      totalStakedStart: decode.getBigInt<BigInt?>(3),
      pendingRewards: decode.getBigInt<BigInt?>(4),
      lastNodeRewardPaymentsTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(5, (b) => proto_timestamp.HederaTimestamp.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoNetworkStakingRewards;

}


