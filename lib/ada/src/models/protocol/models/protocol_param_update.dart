import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/ada/src/models/protocol/models/ex_units.dart';
import 'package:on_chain/ada/src/models/protocol/models/unit_interval.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/block/models/header/header/protocol_version.dart';
import 'package:on_chain/ada/src/models/plutus/cost_model/cost_model.dart';

import 'ex_unit_prices.dart';
import 'nonce.dart';

class PoolVotingThresholds with InternalCborSerialization {
  final UnitInterval motionNoConfidence;
  final UnitInterval committeeNormal;
  final UnitInterval committeeNoConfidence;
  final UnitInterval hardForkInitiation;
  final UnitInterval securityRelevantThreshold;
  const PoolVotingThresholds(
      {required this.motionNoConfidence,
      required this.committeeNormal,
      required this.committeeNoConfidence,
      required this.hardForkInitiation,
      required this.securityRelevantThreshold});
  factory PoolVotingThresholds.deserialize(CborListValue cbor) {
    return PoolVotingThresholds(
        motionNoConfidence:
            UnitInterval.deserialize(cbor.elementAt<CborTagValue>(0)),
        committeeNormal:
            UnitInterval.deserialize(cbor.elementAt<CborTagValue>(1)),
        committeeNoConfidence:
            UnitInterval.deserialize(cbor.elementAt<CborTagValue>(2)),
        hardForkInitiation:
            UnitInterval.deserialize(cbor.elementAt<CborTagValue>(3)),
        securityRelevantThreshold:
            UnitInterval.deserialize(cbor.elementAt<CborTagValue>(4)));
  }
  factory PoolVotingThresholds.fromJson(Map<String, dynamic> json) {
    return PoolVotingThresholds(
        motionNoConfidence: UnitInterval.fromJson(json["motion_no_confidence"]),
        committeeNormal: UnitInterval.fromJson(json["committee_normal"]),
        committeeNoConfidence:
            UnitInterval.fromJson(json["committee_no_confidence"]),
        hardForkInitiation: UnitInterval.fromJson(json["hard_fork_initiation"]),
        securityRelevantThreshold:
            UnitInterval.fromJson(json["security_relevant_threshold"]));
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([
      motionNoConfidence.toCbor(),
      committeeNormal.toCbor(),
      committeeNoConfidence.toCbor(),
      hardForkInitiation.toCbor(),
      securityRelevantThreshold.toCbor()
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "motion_no_confidence": motionNoConfidence.toJson(),
      "committee_normal": committeeNormal.toJson(),
      "committee_no_confidence": committeeNoConfidence.toJson(),
      "hard_fork_initiation": hardForkInitiation.toJson(),
      "security_relevant_threshold": securityRelevantThreshold.toJson()
    };
  }
}

class DRepVotingThresholds with InternalCborSerialization {
  final UnitInterval motionNoConfidence;
  final UnitInterval committeeNormal;
  final UnitInterval committeeNoConfidence;
  final UnitInterval updateConstitution;
  final UnitInterval hardForkInitiation;
  final UnitInterval ppNetworkGroup;
  final UnitInterval ppEconomicGroup;
  final UnitInterval ppTechnicalGroup;
  final UnitInterval ppGovernanceGroup;
  final UnitInterval treasuryWithdrawal;
  const DRepVotingThresholds({
    required this.motionNoConfidence,
    required this.committeeNormal,
    required this.committeeNoConfidence,
    required this.updateConstitution,
    required this.hardForkInitiation,
    required this.ppNetworkGroup,
    required this.ppEconomicGroup,
    required this.ppTechnicalGroup,
    required this.ppGovernanceGroup,
    required this.treasuryWithdrawal,
  });
  factory DRepVotingThresholds.deserialize(CborListValue cbor) {
    return DRepVotingThresholds(
      motionNoConfidence:
          UnitInterval.deserialize(cbor.elementAt<CborTagValue>(0)),
      committeeNormal:
          UnitInterval.deserialize(cbor.elementAt<CborTagValue>(1)),
      committeeNoConfidence:
          UnitInterval.deserialize(cbor.elementAt<CborTagValue>(2)),
      updateConstitution:
          UnitInterval.deserialize(cbor.elementAt<CborTagValue>(3)),
      hardForkInitiation:
          UnitInterval.deserialize(cbor.elementAt<CborTagValue>(4)),
      ppNetworkGroup: UnitInterval.deserialize(cbor.elementAt<CborTagValue>(5)),
      ppEconomicGroup:
          UnitInterval.deserialize(cbor.elementAt<CborTagValue>(6)),
      ppTechnicalGroup:
          UnitInterval.deserialize(cbor.elementAt<CborTagValue>(7)),
      ppGovernanceGroup:
          UnitInterval.deserialize(cbor.elementAt<CborTagValue>(8)),
      treasuryWithdrawal:
          UnitInterval.deserialize(cbor.elementAt<CborTagValue>(9)),
    );
  }
  factory DRepVotingThresholds.fromJson(Map<String, dynamic> json) {
    return DRepVotingThresholds(
        motionNoConfidence: UnitInterval.fromJson(json["motion_no_confidence"]),
        committeeNormal: UnitInterval.fromJson(json["committee_normal"]),
        committeeNoConfidence:
            UnitInterval.fromJson(json["committee_no_confidence"]),
        hardForkInitiation: UnitInterval.fromJson(json["hard_fork_initiation"]),
        updateConstitution: UnitInterval.fromJson(json["update_constitution"]),
        ppEconomicGroup: UnitInterval.fromJson(json["pp_economic_group"]),
        ppGovernanceGroup: UnitInterval.fromJson(json["pp_governance_group"]),
        ppNetworkGroup: UnitInterval.fromJson(json["pp_network_group"]),
        ppTechnicalGroup: UnitInterval.fromJson(json["pp_technical_group"]),
        treasuryWithdrawal: UnitInterval.fromJson(json["treasury_withdrawal"]));
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([
      motionNoConfidence.toCbor(),
      committeeNormal.toCbor(),
      committeeNoConfidence.toCbor(),
      updateConstitution.toCbor(),
      hardForkInitiation.toCbor(),
      ppNetworkGroup.toCbor(),
      ppEconomicGroup.toCbor(),
      ppTechnicalGroup.toCbor(),
      ppGovernanceGroup.toCbor(),
      treasuryWithdrawal.toCbor()
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "motion_no_confidence": motionNoConfidence.toJson(),
      "committee_normal": committeeNormal.toJson(),
      "committee_no_confidence": committeeNoConfidence.toJson(),
      "hard_fork_initiation": hardForkInitiation.toJson(),
      "update_constitution": updateConstitution.toJson(),
      "pp_network_group": ppNetworkGroup.toJson(),
      "pp_economic_group": ppEconomicGroup.toJson(),
      "pp_technical_group": ppTechnicalGroup.toJson(),
      "pp_governance_group": ppGovernanceGroup.toJson(),
      "treasury_withdrawal": treasuryWithdrawal.toJson()
    };
  }
}

class ProtocolParamUpdate with InternalCborSerialization {
  final BigInt? minfeeA;
  final BigInt? minFeeB;
  final int? maxBlockBodySize;
  final int? maxTxSize;
  final int? maxBlockHeaderSize;
  final BigInt? keyDeposit;
  final BigInt? poolDeposit;
  final int? maxEpoch;
  final int? nOpt;
  final UnitInterval? poolPledgeInfluence;
  final UnitInterval? expansionRate;
  final UnitInterval? treasuryGrowthRate;

  final UnitInterval? d;
  final Nonce? extraEntropy;
  final ProtocolVersion? protocolVersion;
  final BigInt? minPoolCost;
  final BigInt? adaPerUtxoByte;
  final Costmdls? costModel;
  final ExUnitPrices? executionCosts;
  final ExUnits? maxTxExUnits;
  final ExUnits? maxBlockExUnits;
  final int? maxValueSize;
  final int? collateralPercentage;
  final int? maxCollateralInputs;
  final PoolVotingThresholds? poolVotingThresholds;
  final DRepVotingThresholds? drepVotingThresholds;
  final int? minCommitteeSize;
  final int? committeeTermLimit;
  final int? governanceActionValidityPeriod;
  final int? governanceActionDeposit;
  final BigInt? drepDeposit;
  final int? drepInactivityPeriod;
  final UnitInterval? refScriptCoinsPerByte;

  const ProtocolParamUpdate({
    this.minfeeA,
    this.minFeeB,
    this.maxBlockBodySize,
    this.maxTxSize,
    this.maxBlockHeaderSize,
    this.keyDeposit,
    this.poolDeposit,
    this.maxEpoch,
    this.nOpt,
    this.poolPledgeInfluence,
    this.expansionRate,
    this.treasuryGrowthRate,
    this.d,
    this.extraEntropy,
    this.protocolVersion,
    this.minPoolCost,
    this.adaPerUtxoByte,
    this.costModel,
    this.executionCosts,
    this.maxTxExUnits,
    this.maxBlockExUnits,
    this.maxValueSize,
    this.collateralPercentage,
    this.maxCollateralInputs,
    this.poolVotingThresholds,
    this.drepVotingThresholds,
    this.minCommitteeSize,
    this.committeeTermLimit,
    this.governanceActionValidityPeriod,
    this.governanceActionDeposit,
    this.drepDeposit,
    this.drepInactivityPeriod,
    this.refScriptCoinsPerByte,
  });
  factory ProtocolParamUpdate.fromCborBytes(List<int> cborBytes) {
    return ProtocolParamUpdate.deserialize(
        CborObject.fromCbor(cborBytes).as<CborMapValue>());
  }
  factory ProtocolParamUpdate.deserialize(CborMapValue cbor) {
    return ProtocolParamUpdate(
      minfeeA: cbor.getIntValueAs<CborNumeric?>(0)?.toBigInt(),
      minFeeB: cbor.getIntValueAs<CborNumeric?>(1)?.toBigInt(),
      maxBlockBodySize: cbor.getIntValueAs<CborIntValue?>(2)?.value,
      maxTxSize: cbor.getIntValueAs<CborIntValue?>(3)?.value,
      maxBlockHeaderSize: cbor.getIntValueAs<CborIntValue?>(4)?.value,
      keyDeposit: cbor.getIntValueAs<CborNumeric?>(5)?.toBigInt(),
      poolDeposit: cbor.getIntValueAs<CborNumeric?>(6)?.toBigInt(),
      maxEpoch: cbor.getIntValueAs<CborIntValue?>(7)?.value,
      nOpt: cbor.getIntValueAs<CborIntValue?>(8)?.value,
      poolPledgeInfluence: cbor
          .getIntValueAs<CborTagValue?>(9)
          ?.convertTo<UnitInterval, CborTagValue>(
              (e) => UnitInterval.deserialize(e)),
      expansionRate: cbor
          .getIntValueAs<CborTagValue?>(10)
          ?.convertTo<UnitInterval, CborTagValue>(
              (e) => UnitInterval.deserialize(e)),
      treasuryGrowthRate: cbor
          .getIntValueAs<CborTagValue?>(11)
          ?.convertTo<UnitInterval, CborTagValue>(
              (e) => UnitInterval.deserialize(e)),
      d: cbor
          .getIntValueAs<CborTagValue?>(12)
          ?.convertTo<UnitInterval, CborTagValue>(
              (e) => UnitInterval.deserialize(e)),
      extraEntropy: cbor
          .getIntValueAs<CborListValue?>(13)
          ?.convertTo<Nonce, CborListValue>((e) => Nonce.deserialize(e)),
      protocolVersion: cbor
          .getIntValueAs<CborListValue?>(14)
          ?.convertTo<ProtocolVersion, CborListValue>(
              (e) => ProtocolVersion.deserialize(e)),
      minPoolCost: cbor.getIntValueAs<CborNumeric?>(16)?.toBigInt(),
      adaPerUtxoByte: cbor.getIntValueAs<CborNumeric?>(17)?.toBigInt(),
      costModel: cbor
          .getIntValueAs<CborMapValue?>(18)
          ?.convertTo<Costmdls, CborMapValue>((e) => Costmdls.deserialize(e)),
      executionCosts: cbor
          .getIntValueAs<CborListValue?>(19)
          ?.convertTo<ExUnitPrices, CborListValue>(
              (e) => ExUnitPrices.deserialize(e)),
      maxTxExUnits: cbor
          .getIntValueAs<CborListValue?>(20)
          ?.convertTo<ExUnits, CborListValue>((e) => ExUnits.deserialize(e)),
      maxBlockExUnits: cbor
          .getIntValueAs<CborListValue?>(21)
          ?.convertTo<ExUnits, CborListValue>((e) => ExUnits.deserialize(e)),
      maxValueSize: cbor.getIntValueAs<CborIntValue?>(22)?.value,
      collateralPercentage: cbor.getIntValueAs<CborIntValue?>(23)?.value,
      maxCollateralInputs: cbor.getIntValueAs<CborIntValue?>(24)?.value,
      poolVotingThresholds: cbor
          .getIntValueAs<CborListValue?>(25)
          ?.convertTo<PoolVotingThresholds, CborListValue>(
              (e) => PoolVotingThresholds.deserialize(e)),
      drepVotingThresholds: cbor
          .getIntValueAs<CborListValue?>(26)
          ?.convertTo<DRepVotingThresholds, CborListValue>(
              (e) => DRepVotingThresholds.deserialize(e)),
      minCommitteeSize: cbor.getIntValueAs<CborIntValue?>(27)?.value,
      committeeTermLimit: cbor.getIntValueAs<CborIntValue?>(28)?.value,
      governanceActionValidityPeriod:
          cbor.getIntValueAs<CborIntValue?>(29)?.value,
      governanceActionDeposit: cbor.getIntValueAs<CborIntValue?>(30)?.value,
      drepDeposit: cbor.getIntValueAs<CborNumeric?>(31)?.toBigInt(),
      drepInactivityPeriod: cbor.getIntValueAs<CborIntValue?>(32)?.value,
      refScriptCoinsPerByte: cbor
          .getIntValueAs<CborTagValue?>(33)
          ?.convertTo<UnitInterval, CborTagValue>(
              (e) => UnitInterval.deserialize(e)),
    );
  }
  ProtocolParamUpdate copyWith({
    BigInt? minfeeA,
    BigInt? minFeeB,
    int? maxBlockBodySize,
    int? maxTxSize,
    int? maxBlockHeaderSize,
    BigInt? keyDeposit,
    BigInt? poolDeposit,
    int? maxEpoch,
    int? nOpt,
    UnitInterval? poolPledgeInfluence,
    UnitInterval? expansionRate,
    UnitInterval? treasuryGrowthRate,
    UnitInterval? d,
    Nonce? extraEntropy,
    ProtocolVersion? protocolVersion,
    BigInt? minPoolCost,
    BigInt? adaPerUtxoByte,
    Costmdls? costModel,
    ExUnitPrices? executionCosts,
    ExUnits? maxTxExUnits,
    ExUnits? maxBlockExUnits,
    int? maxValueSize,
    int? collateralPercentage,
    int? maxCollateralInputs,
  }) {
    return ProtocolParamUpdate(
      minfeeA: minfeeA ?? this.minfeeA,
      minFeeB: minFeeB ?? this.minFeeB,
      maxBlockBodySize: maxBlockBodySize ?? this.maxBlockBodySize,
      maxTxSize: maxTxSize ?? this.maxTxSize,
      maxBlockHeaderSize: maxBlockHeaderSize ?? this.maxBlockHeaderSize,
      keyDeposit: keyDeposit ?? this.keyDeposit,
      poolDeposit: poolDeposit ?? this.poolDeposit,
      maxEpoch: maxEpoch ?? this.maxEpoch,
      nOpt: nOpt ?? this.nOpt,
      poolPledgeInfluence: poolPledgeInfluence ?? this.poolPledgeInfluence,
      expansionRate: expansionRate ?? this.expansionRate,
      treasuryGrowthRate: treasuryGrowthRate ?? this.treasuryGrowthRate,
      d: d ?? this.d,
      extraEntropy: extraEntropy ?? this.extraEntropy,
      protocolVersion: protocolVersion ?? this.protocolVersion,
      minPoolCost: minPoolCost ?? this.minPoolCost,
      adaPerUtxoByte: adaPerUtxoByte ?? this.adaPerUtxoByte,
      costModel: costModel ?? this.costModel,
      executionCosts: executionCosts ?? this.executionCosts,
      maxTxExUnits: maxTxExUnits ?? this.maxTxExUnits,
      maxBlockExUnits: maxBlockExUnits ?? this.maxBlockExUnits,
      maxValueSize: maxValueSize ?? this.maxValueSize,
      collateralPercentage: collateralPercentage ?? this.collateralPercentage,
      maxCollateralInputs: maxCollateralInputs ?? this.maxCollateralInputs,
    );
  }

  @override
  CborObject toCbor() {
    return CborMapValue.definite({
      if (minfeeA != null)
        const CborIntValue(0): CborUnsignedValue.u64(minfeeA!),
      if (minFeeB != null)
        const CborIntValue(1): CborUnsignedValue.u64(minFeeB!),
      if (maxBlockBodySize != null)
        const CborIntValue(2): CborUnsignedValue.u32(maxBlockBodySize!),
      if (maxTxSize != null)
        const CborIntValue(3): CborUnsignedValue.u32(maxTxSize!),
      if (maxBlockHeaderSize != null)
        const CborIntValue(4): CborUnsignedValue.u32(maxBlockHeaderSize!),
      if (keyDeposit != null)
        const CborIntValue(5): CborUnsignedValue.u64(keyDeposit!),
      if (poolDeposit != null)
        const CborIntValue(6): CborUnsignedValue.u64(poolDeposit!),
      if (maxEpoch != null)
        const CborIntValue(7): CborUnsignedValue.u32(maxEpoch!),
      if (nOpt != null) const CborIntValue(8): CborUnsignedValue.u32(nOpt!),
      if (poolPledgeInfluence != null)
        const CborIntValue(9): poolPledgeInfluence!.toCbor(),
      if (expansionRate != null)
        const CborIntValue(10): expansionRate!.toCbor(),
      if (treasuryGrowthRate != null)
        const CborIntValue(11): treasuryGrowthRate!.toCbor(),
      if (d != null) const CborIntValue(12): d!.toCbor(),
      if (extraEntropy != null) const CborIntValue(13): extraEntropy!.toCbor(),
      if (protocolVersion != null)
        const CborIntValue(14): protocolVersion!.toCbor(),
      if (minPoolCost != null)
        const CborIntValue(16): CborUnsignedValue.u64(minPoolCost!),
      if (adaPerUtxoByte != null)
        const CborIntValue(17): CborUnsignedValue.u64(adaPerUtxoByte!),
      if (costModel != null) const CborIntValue(18): costModel!.toCbor(),
      if (executionCosts != null)
        const CborIntValue(19): executionCosts!.toCbor(),
      if (maxTxExUnits != null) const CborIntValue(20): maxTxExUnits!.toCbor(),
      if (maxBlockExUnits != null)
        const CborIntValue(21): maxBlockExUnits!.toCbor(),
      if (maxValueSize != null)
        const CborIntValue(22): CborUnsignedValue.u32(maxValueSize!),
      if (collateralPercentage != null)
        const CborIntValue(23): CborUnsignedValue.u32(collateralPercentage!),
      if (maxCollateralInputs != null)
        const CborIntValue(24): CborUnsignedValue.u32(maxCollateralInputs!),
      if (poolVotingThresholds != null)
        const CborIntValue(25): poolVotingThresholds!.toCbor(),
      if (drepVotingThresholds != null)
        const CborIntValue(26): drepVotingThresholds!.toCbor(),
      if (minCommitteeSize != null)
        const CborIntValue(27): CborUnsignedValue.u32(minCommitteeSize!),
      if (committeeTermLimit != null)
        const CborIntValue(28): CborUnsignedValue.u32(committeeTermLimit!),
      if (governanceActionValidityPeriod != null)
        const CborIntValue(29):
            CborUnsignedValue.u32(governanceActionValidityPeriod!),
      if (governanceActionDeposit != null)
        const CborIntValue(30): CborUnsignedValue.u32(governanceActionDeposit!),
      if (drepDeposit != null)
        const CborIntValue(31): CborUnsignedValue.u64(drepDeposit!),
      if (drepInactivityPeriod != null)
        const CborIntValue(32): CborUnsignedValue.u64(drepInactivityPeriod!),
      if (refScriptCoinsPerByte != null)
        const CborIntValue(33): CborUnsignedValue.u64(refScriptCoinsPerByte!),
    });
  }

  factory ProtocolParamUpdate.fromJson(Map<String, dynamic> json) {
    return ProtocolParamUpdate(
        minfeeA: BigintUtils.tryParse(json['minfee_a']),
        minFeeB: BigintUtils.tryParse(json['minFeeB']),
        maxBlockBodySize: json['max_block_body_size'],
        maxTxSize: json['max_tx_size'],
        maxBlockHeaderSize: json['max_block_header_size'],
        keyDeposit: BigintUtils.tryParse(json['key_deposit']),
        poolDeposit: BigintUtils.tryParse(json['pool_deposit']),
        maxEpoch: json['max_epoch'],
        nOpt: json['n_opt'],
        poolPledgeInfluence: json['pool_pledge_influence'] == null
            ? null
            : UnitInterval.fromJson(json['pool_pledge_influence']),
        expansionRate: json['expansion_rate'] == null
            ? null
            : UnitInterval.fromJson(json['expansion_rate']),
        treasuryGrowthRate: json['treasury_growth_rate'] == null
            ? null
            : UnitInterval.fromJson(json['treasury_growth_rate']),
        d: json['d'] == null ? null : UnitInterval.fromJson(json['d']),
        extraEntropy: json['extra_entropy'] == null
            ? null
            : Nonce.fromJson(json['extra_entropy']),
        protocolVersion: json['protocol_version'] == null
            ? null
            : ProtocolVersion.fromJson(json['protocol_version']),
        minPoolCost: BigintUtils.tryParse(json['min_pool_cost']),
        adaPerUtxoByte: BigintUtils.tryParse(json['ada_per_utxo_byte']),
        costModel: json['cost_models'] == null
            ? null
            : Costmdls.fromJson(json['cost_models']),
        executionCosts: json['execution_costs'] == null
            ? null
            : ExUnitPrices.fromJson(json['execution_costs']),
        maxTxExUnits: json['max_tx_ex_units'] == null
            ? null
            : ExUnits.fromJson(json['max_tx_ex_units']),
        maxBlockExUnits: json['max_block_ex_units'] == null
            ? null
            : ExUnits.fromJson(json['max_block_ex_units']),
        maxValueSize: json['max_value_size'],
        collateralPercentage: json['collateral_percentage'],
        maxCollateralInputs: json['max_collateral_inputs'],
        poolVotingThresholds: json["pool_voting_thresholds"] == null
            ? null
            : PoolVotingThresholds.fromJson(json["pool_voting_thresholds"]),
        drepVotingThresholds: json["drep_voting_thresholds"] == null
            ? null
            : DRepVotingThresholds.fromJson(json["drep_voting_thresholds"]),
        minCommitteeSize: json["min_committee_size"],
        committeeTermLimit: json["committee_term_limit"],
        governanceActionValidityPeriod:
            json["governance_action_validity_period"],
        governanceActionDeposit: json["governance_action_deposit"],
        drepDeposit: BigintUtils.tryParse(json["drep_deposit"]),
        drepInactivityPeriod: json["drep_inactivity_period"],
        refScriptCoinsPerByte: json["ref_script_coins_per_byte"]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'minfee_a': minfeeA?.toString(),
      'minfee_b': minFeeB?.toString(),
      'max_block_body_size': maxBlockBodySize,
      'max_tx_size': maxTxSize,
      'max_block_header_size': maxBlockHeaderSize,
      'key_deposit': keyDeposit?.toString(),
      'pool_deposit': poolDeposit?.toString(),
      'max_epoch': maxEpoch,
      'n_opt': nOpt,
      'pool_pledge_influence': poolPledgeInfluence?.toJson(),
      'expansion_rate': expansionRate?.toJson(),
      'treasury_growth_rate': treasuryGrowthRate?.toJson(),
      'd': d?.toJson(),
      'extra_entropy': extraEntropy?.toJson(),
      'protocol_version': protocolVersion?.toJson(),
      'min_pool_cost': minPoolCost?.toString(),
      'ada_per_utxo_byte': adaPerUtxoByte?.toString(),
      'cost_models': costModel?.toJson(),
      'execution_costs': executionCosts?.toJson(),
      'max_tx_ex_units': maxTxExUnits?.toJson(),
      'max_block_ex_units': maxBlockExUnits?.toJson(),
      'max_value_size': maxValueSize,
      'collateral_percentage': collateralPercentage,
      'max_collateral_inputs': maxCollateralInputs,
      "pool_voting_thresholds": poolVotingThresholds?.toJson(),
      "drep_voting_thresholds": drepVotingThresholds?.toJson(),
      "min_committee_size": minCommitteeSize,
      "committee_term_limit": committeeTermLimit,
      "governance_action_validity_period": governanceActionValidityPeriod,
      "governance_action_deposit": governanceActionDeposit,
      "drep_deposit": drepDeposit?.toString(),
      "drep_inactivity_period": drepInactivityPeriod,
      "ref_script_coins_per_byte": refScriptCoinsPerByte
    };
  }
}
