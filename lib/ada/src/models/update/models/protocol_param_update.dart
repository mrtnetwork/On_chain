import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/numbers/numbers.dart';
import 'package:on_chain/ada/src/models/ex_units.dart';
import 'package:on_chain/ada/src/models/unit_interval.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/header/header/protocol_version.dart';
import 'package:on_chain/ada/src/models/plutus/cost_model/cost_model.dart';

import 'ex_unit_prices.dart';
import 'nonce.dart';

class ProtocolParamUpdate with ADASerialization {
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
  const ProtocolParamUpdate(
      {this.minfeeA,
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
      this.maxCollateralInputs});
  factory ProtocolParamUpdate.fromCborBytes(List<int> cborBytes) {
    return ProtocolParamUpdate.deserialize(
        CborObject.fromCbor(cborBytes).cast());
  }
  factory ProtocolParamUpdate.deserialize(CborMapValue cbor) {
    return ProtocolParamUpdate(
        minfeeA: cbor.getValueFromIntKey<CborObject?>(0)?.getInteger(),
        minFeeB: cbor.getValueFromIntKey<CborObject?>(1)?.getInteger(),
        maxBlockBodySize: cbor.getValueFromIntKey<CborIntValue?>(2)?.value,
        maxTxSize: cbor.getValueFromIntKey<CborIntValue?>(3)?.value,
        maxBlockHeaderSize: cbor.getValueFromIntKey<CborIntValue?>(4)?.value,
        keyDeposit: cbor.getValueFromIntKey<CborObject?>(5)?.getInteger(),
        poolDeposit: cbor.getValueFromIntKey<CborObject?>(6)?.getInteger(),
        maxEpoch: cbor.getValueFromIntKey<CborIntValue?>(7)?.value,
        nOpt: cbor.getValueFromIntKey<CborIntValue?>(8)?.value,
        poolPledgeInfluence: cbor
            .getValueFromIntKey<CborTagValue?>(9)
            ?.to<UnitInterval, CborTagValue>(
                (e) => UnitInterval.deserialize(e)),
        expansionRate: cbor.getValueFromIntKey<CborTagValue?>(10)?.to<UnitInterval, CborTagValue>(
            (e) => UnitInterval.deserialize(e)),
        treasuryGrowthRate: cbor
            .getValueFromIntKey<CborTagValue?>(11)
            ?.to<UnitInterval, CborTagValue>(
                (e) => UnitInterval.deserialize(e)),
        d: cbor.getValueFromIntKey<CborTagValue?>(12)?.to<UnitInterval, CborTagValue>(
            (e) => UnitInterval.deserialize(e)),
        extraEntropy: cbor
            .getValueFromIntKey<CborListValue?>(13)
            ?.to<Nonce, CborListValue>((e) => Nonce.deserialize(e)),
        protocolVersion: cbor
            .getValueFromIntKey<CborListValue?>(14)
            ?.to<ProtocolVersion, CborListValue>((e) => ProtocolVersion.deserialize(e)),
        minPoolCost: cbor.getValueFromIntKey<CborObject?>(16)?.getInteger(),
        adaPerUtxoByte: cbor.getValueFromIntKey<CborObject?>(17)?.getInteger(),
        costModel: cbor.getValueFromIntKey<CborMapValue?>(18)?.to<Costmdls, CborMapValue>((e) => Costmdls.deserialize(e)),
        executionCosts: cbor.getValueFromIntKey<CborListValue?>(19)?.to<ExUnitPrices, CborListValue>((e) => ExUnitPrices.deserialize(e)),
        maxTxExUnits: cbor.getValueFromIntKey<CborListValue?>(20)?.to<ExUnits, CborListValue>((e) => ExUnits.deserialize(e)),
        maxBlockExUnits: cbor.getValueFromIntKey<CborListValue?>(21)?.to<ExUnits, CborListValue>((e) => ExUnits.deserialize(e)),
        maxValueSize: cbor.getValueFromIntKey<CborIntValue?>(22)?.value,
        collateralPercentage: cbor.getValueFromIntKey<CborIntValue?>(23)?.value,
        maxCollateralInputs: cbor.getValueFromIntKey<CborIntValue?>(24)?.value);
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
    return CborMapValue.fixedLength({
      if (minfeeA != null) ...{
        CborIntValue(0): CborUnsignedValue.u64(minfeeA!),
      },
      if (minFeeB != null) ...{
        CborIntValue(1): CborUnsignedValue.u64(minFeeB!),
      },
      if (maxBlockBodySize != null) ...{
        CborIntValue(2): CborUnsignedValue.u32(maxBlockBodySize!),
      },
      if (maxTxSize != null) ...{
        CborIntValue(3): CborUnsignedValue.u32(maxTxSize!),
      },
      if (maxBlockHeaderSize != null) ...{
        CborIntValue(4): CborUnsignedValue.u32(maxBlockHeaderSize!),
      },
      if (keyDeposit != null) ...{
        CborIntValue(5): CborUnsignedValue.u64(keyDeposit!),
      },
      if (poolDeposit != null) ...{
        CborIntValue(6): CborUnsignedValue.u64(poolDeposit!),
      },
      if (maxEpoch != null) ...{
        CborIntValue(7): CborUnsignedValue.u32(maxEpoch!),
      },
      if (nOpt != null) ...{
        CborIntValue(8): CborUnsignedValue.u32(nOpt!),
      },
      if (poolPledgeInfluence != null) ...{
        CborIntValue(9): poolPledgeInfluence!.toCbor(),
      },
      if (expansionRate != null) ...{
        CborIntValue(10): expansionRate!.toCbor(),
      },
      if (treasuryGrowthRate != null) ...{
        CborIntValue(11): treasuryGrowthRate!.toCbor(),
      },
      if (d != null) ...{
        CborIntValue(12): d!.toCbor(),
      },
      if (extraEntropy != null) ...{
        CborIntValue(13): extraEntropy!.toCbor(),
      },
      if (protocolVersion != null) ...{
        CborIntValue(14): protocolVersion!.toCbor(),
      },
      if (minPoolCost != null) ...{
        CborIntValue(16): CborUnsignedValue.u64(minPoolCost!),
      },
      if (adaPerUtxoByte != null) ...{
        CborIntValue(17): CborUnsignedValue.u64(adaPerUtxoByte!),
      },
      if (costModel != null) ...{
        CborIntValue(18): costModel!.toCbor(),
      },
      if (executionCosts != null) ...{
        CborIntValue(19): executionCosts!.toCbor(),
      },
      if (maxTxExUnits != null) ...{
        CborIntValue(20): maxTxExUnits!.toCbor(),
      },
      if (maxBlockExUnits != null) ...{
        CborIntValue(21): maxBlockExUnits!.toCbor(),
      },
      if (maxValueSize != null) ...{
        CborIntValue(22): CborUnsignedValue.u32(maxValueSize!),
      },
      if (collateralPercentage != null) ...{
        CborIntValue(23): CborUnsignedValue.u32(collateralPercentage!),
      },
      if (maxCollateralInputs != null) ...{
        CborIntValue(24): CborUnsignedValue.u32(maxCollateralInputs!),
      },
    });
  }

  factory ProtocolParamUpdate.fromJson(Map<String, dynamic> json) {
    return ProtocolParamUpdate(
        minfeeA: BigintUtils.tryParse(json["minfee_a"]),
        minFeeB: BigintUtils.tryParse(json["minFeeB"]),
        maxBlockBodySize: json["max_block_body_size"],
        maxTxSize: json["max_tx_size"],
        maxBlockHeaderSize: json["max_block_header_size"],
        keyDeposit: BigintUtils.tryParse(json["key_deposit"]),
        poolDeposit: BigintUtils.tryParse(json["pool_deposit"]),
        maxEpoch: json["max_epoch"],
        nOpt: json["n_opt"],
        poolPledgeInfluence: json["pool_pledge_influence"] == null
            ? null
            : UnitInterval.fromJson(json["pool_pledge_influence"]),
        expansionRate: json["expansion_rate"] == null
            ? null
            : UnitInterval.fromJson(json["expansion_rate"]),
        treasuryGrowthRate: json["treasury_growth_rate"] == null
            ? null
            : UnitInterval.fromJson(json["treasury_growth_rate"]),
        d: json["d"] == null ? null : UnitInterval.fromJson(json["d"]),
        extraEntropy: json["extra_entropy"] == null
            ? null
            : Nonce.fromJson(json["extra_entropy"]),
        protocolVersion: json["protocol_version"] == null
            ? null
            : ProtocolVersion.fromJson(json["protocol_version"]),
        minPoolCost: BigintUtils.tryParse(json["min_pool_cost"]),
        adaPerUtxoByte: BigintUtils.tryParse(json["ada_per_utxo_byte"]),
        costModel: json["cost_models"] == null
            ? null
            : Costmdls.fromJson(json["cost_models"]),
        executionCosts: json["execution_costs"] == null
            ? null
            : ExUnitPrices.fromJson(json["execution_costs"]),
        maxTxExUnits: json["max_tx_ex_units"] == null
            ? null
            : ExUnits.fromJson(json["max_tx_ex_units"]),
        maxBlockExUnits: json["max_block_ex_units"] == null
            ? null
            : ExUnits.fromJson(json["max_block_ex_units"]),
        maxValueSize: json["max_value_size"],
        collateralPercentage: json["collateral_percentage"],
        maxCollateralInputs: json["max_collateral_inputs"]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "minfee_a": minfeeA?.toString(),
      "minfee_b": minFeeB?.toString(),
      "max_block_body_size": maxBlockBodySize,
      "max_tx_size": maxTxSize,
      "max_block_header_size": maxBlockHeaderSize,
      "key_deposit": keyDeposit?.toString(),
      "pool_deposit": poolDeposit?.toString(),
      "max_epoch": maxEpoch,
      "n_opt": nOpt,
      "pool_pledge_influence": poolPledgeInfluence?.toJson(),
      "expansion_rate": expansionRate?.toJson(),
      "treasury_growth_rate": treasuryGrowthRate?.toJson(),
      "d": d?.toJson(),
      "extra_entropy": extraEntropy?.toJson(),
      "protocol_version": protocolVersion?.toJson(),
      "min_pool_cost": minPoolCost?.toString(),
      "ada_per_utxo_byte": adaPerUtxoByte?.toString(),
      "cost_models": costModel?.toJson(),
      "execution_costs": executionCosts?.toJson(),
      "max_tx_ex_units": maxTxExUnits?.toJson(),
      "max_block_ex_units": maxBlockExUnits?.toJson(),
      "max_value_size": maxValueSize,
      "collateral_percentage": collateralPercentage,
      "max_collateral_inputs": maxCollateralInputs
    };
  }
}
