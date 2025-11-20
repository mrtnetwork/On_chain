import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/ada/src/address/era/core/address.dart';
import 'package:on_chain/ada/src/address/era/shelly/ada_reward_address.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/pool/relay/core/relay.dart';
import 'package:on_chain/ada/src/models/protocol/models/unit_interval.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/pool/pool_meta_data.dart';

/// Represents pool parameters with serialization support.
class PoolParams with InternalCborSerialization {
  /// The operator of the pool.
  final Ed25519KeyHash operator;

  /// The VRF key hash of the pool.
  final VRFKeyHash vrfKeyHash;

  /// The pledge of the pool.
  final BigInt pledge;

  /// The cost of the pool.
  final BigInt cost;

  /// The margin of the pool.
  final UnitInterval margin;

  /// The reward account of the pool.
  final ADARewardAddress rewardAccount;

  /// The list of pool owners.
  final List<Ed25519KeyHash> poolOwners;

  /// The list of relays.
  final List<Relay> relays;

  /// The pool metadata.
  final PoolMetadata? poolMetadata;

  /// Constructs a PoolParams object with the specified parameters.
  PoolParams({
    required this.operator,
    required this.vrfKeyHash,
    required this.pledge,
    required this.cost,
    required this.margin,
    required this.rewardAccount,
    required List<Ed25519KeyHash> poolOwners,
    required List<Relay> relays,
    this.poolMetadata,
  })  : poolOwners = List<Ed25519KeyHash>.unmodifiable(poolOwners),
        relays = List<Relay>.unmodifiable(relays);

  /// Deserializes a PoolParams object from its CBOR representation.
  factory PoolParams.deserialize(CborListValue cbor) {
    return PoolParams(
      operator: Ed25519KeyHash.deserialize(cbor.elementAt<CborBytesValue>(0)),
      vrfKeyHash: VRFKeyHash.deserialize(cbor.elementAt<CborBytesValue>(1)),
      pledge: cbor.elementAsInteger(2),
      cost: cbor.elementAsInteger(3),
      margin: UnitInterval.deserialize(cbor.elementAt<CborTagValue>(4)),
      rewardAccount: ADAAddress.deserialize(cbor.elementAt<CborBytesValue>(5)),
      poolOwners: cbor
          .elementAt<CborListValue>(6)
          .valueAsListOf<CborBytesValue>()
          .map((e) => Ed25519KeyHash.deserialize(e))
          .toList(),
      relays: cbor
          .elementAt<CborListValue>(7)
          .valueAsListOf<CborListValue>()
          .map((e) => Relay.deserialize(e))
          .toList(),
      poolMetadata: cbor
          .elementAt<CborListValue?>(8)
          ?.convertTo<PoolMetadata, CborListValue>(
              (e) => PoolMetadata.deserialize(e)),
    );
  }
  PoolParams copyWith({
    Ed25519KeyHash? operator,
    VRFKeyHash? vrfKeyHash,
    BigInt? pledge,
    BigInt? cost,
    UnitInterval? margin,
    ADARewardAddress? rewardAccount,
    List<Ed25519KeyHash>? poolOwners,
    List<Relay>? relays,
    PoolMetadata? poolMetadata,
  }) {
    return PoolParams(
      operator: operator ?? this.operator,
      vrfKeyHash: vrfKeyHash ?? this.vrfKeyHash,
      pledge: pledge ?? this.pledge,
      cost: cost ?? this.cost,
      margin: margin ?? this.margin,
      rewardAccount: rewardAccount ?? this.rewardAccount,
      poolOwners: poolOwners ?? this.poolOwners,
      relays: relays ?? this.relays,
      poolMetadata: poolMetadata ?? this.poolMetadata,
    );
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite(<CborObject>[
      operator.toCbor(),
      vrfKeyHash.toCbor(),
      CborUnsignedValue.u64(pledge),
      CborUnsignedValue.u64(cost),
      margin.toCbor(),
      rewardAccount.toCbor(),
      CborListValue.definite(poolOwners.map((e) => e.toCbor()).toList()),
      CborListValue.definite(relays.map((e) => e.toCbor()).toList()),
      poolMetadata?.toCbor() ?? const CborNullValue()
    ]);
  }

  factory PoolParams.fromJson(Map<String, dynamic> json) {
    return PoolParams(
        operator: Ed25519KeyHash.fromHex(json['operator']),
        vrfKeyHash: VRFKeyHash.fromHex(json['vrf_keyhash']),
        pledge: BigintUtils.parse(json['pledge']),
        cost: BigintUtils.parse(json['cost']),
        margin: UnitInterval.fromJson(json['margin']),
        rewardAccount: ADARewardAddress(json['reward_account']),
        poolOwners: (json['pool_owners'] as List)
            .map((e) => Ed25519KeyHash.fromHex(e))
            .toList(),
        relays: (json['relays'] as List).map((e) => Relay.fromJson(e)).toList(),
        poolMetadata: json['pool_metadata'] == null
            ? null
            : PoolMetadata.fromJson(json['pool_metadata']));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'operator': operator.toJson(),
      'vrf_keyhash': vrfKeyHash.toJson(),
      'pledge': pledge.toString(),
      'cost': cost.toString(),
      'margin': margin.toJson(),
      'reward_account': rewardAccount.toJson(),
      'pool_owners': poolOwners.map((e) => e.toJson()).toList(),
      'relays': relays.map((e) => e.toJson()).toList(),
      'pool_metadata': poolMetadata?.toJson()
    };
  }
}
