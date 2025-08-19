import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/certificates.dart';
import 'package:on_chain/ada/src/models/governance/governance.dart';
import 'package:on_chain/ada/src/models/transaction/input/models/transaction_inputs.dart';
import 'package:on_chain/ada/src/models/transaction/output/models/transaction_outputs.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';
import 'package:on_chain/ada/src/models/mint/models/mint.dart';

import 'package:on_chain/ada/src/models/transaction/output/models/transaction_output.dart';
import 'package:on_chain/ada/src/models/transaction/update/models/update.dart';
import 'package:on_chain/ada/src/models/transaction/withdrawals/withdrawals.dart';

import 'requered_signature.dart';

class TransactionBodySerializationConfig {
  final List<int>? keyOrder;
  const TransactionBodySerializationConfig({this.keyOrder});
  factory TransactionBodySerializationConfig.fromJson(
      Map<String, dynamic> json) {
    return TransactionBodySerializationConfig(
        keyOrder: (json["key_order"] as List?)?.cast());
  }
  Map<String, dynamic> toJson() {
    return {"key_order": keyOrder};
  }
}

class TransactionBody with ADASerialization {
  final TransactionInputs? inputs;
  final TransactionOutputs? outputs;
  final BigInt fee;
  final BigInt? ttl; //certificates
  final Certificates? certificates;
  final Withdrawals? withdrawals;
  final Update? update;
  final AuxiliaryDataHash? auxiliaryDataHash;
  final BigInt? validityStartInterval;
  final Mint? mint;
  final ScriptDataHash? scriptDataHash;
  final TransactionInputs? collateral;
  final RequiredSigners? requiredSigners;
  final ADANetwork? network;
  final TransactionOutput? collateralReturn;
  final BigInt? totalCollateral;

  ///
  final TransactionInputs? referenceInputs;
  final VotingProcedures? votingProcedures;
  final VotingProposals? votingProposals;
  final BigInt? currentTreasuryValue;
  final BigInt? donation;
  final TransactionBodySerializationConfig serializationConfig;
  TransactionBody(
      {required this.inputs,
      required this.outputs,
      required this.fee,
      this.ttl,
      this.certificates,
      this.withdrawals,
      this.update,
      this.auxiliaryDataHash,
      this.validityStartInterval,
      this.mint,
      this.scriptDataHash,
      this.collateral,
      this.requiredSigners,
      this.network,
      this.collateralReturn,
      this.totalCollateral,
      this.referenceInputs,
      this.votingProcedures,
      this.votingProposals,
      this.currentTreasuryValue,
      this.donation,
      this.serializationConfig = const TransactionBodySerializationConfig()});
  factory TransactionBody.fromCborBytes(List<int> bytes) {
    final CborMapValue decode = ADASerialization.desrialize(bytes);
    return TransactionBody.deserialize(
        decode.asMap<CborIntValue, CborObject>());
  }
  factory TransactionBody.deserialize(
      CborMapValue<CborIntValue, CborObject> cbor) {
    return TransactionBody(
        inputs: cbor
            .getIntValueAs<CborObject?>(0)
            ?.convertTo<TransactionInputs, CborObject>(
                (e) => TransactionInputs.deserialize(e)),
        outputs: cbor
            .getIntValueAs<CborObject?>(1)
            ?.convertTo<TransactionOutputs, CborObject>(
                (e) => TransactionOutputs.deserialize(e)),
        fee: cbor.getIntValueAs<CborNumeric>(2).toBigInt(),
        ttl: cbor.getIntValueAs<CborNumeric?>(3)?.toBigInt(),
        withdrawals: cbor
            .getIntValueAs<CborObject?>(5)
            ?.convertTo<Withdrawals, CborMapValue>(
                (e) => Withdrawals.deserialize(e)),
        auxiliaryDataHash: cbor
            .getIntValueAs<CborBytesValue?>(7)
            ?.convertTo<AuxiliaryDataHash, CborBytesValue>(
                (CborBytesValue e) => AuxiliaryDataHash.deserialize(e)),
        certificates: cbor
            .getIntValueAs<CborObject?>(4)
            ?.convertTo<Certificates, CborObject>((e) => Certificates.deserialize(e)),
        update: cbor.getIntValueAs<CborListValue?>(6)?.convertTo<Update, CborListValue>((e) => Update.deserialize(e)),
        validityStartInterval: cbor.getIntValueAs<CborNumeric?>(8)?.toBigInt(),
        mint: cbor.getIntValueAs<CborMapValue?>(9)?.convertTo<Mint, CborMapValue>((e) => Mint.deserialize(e.as("Mint"))),
        scriptDataHash: cbor.getIntValueAs<CborBytesValue?>(11)?.convertTo<ScriptDataHash, CborBytesValue>((e) => ScriptDataHash.deserialize(e)),
        collateral: cbor.getIntValueAs<CborObject?>(13)?.convertTo<TransactionInputs, CborObject>((e) => TransactionInputs.deserialize(e)),
        requiredSigners: cbor.getIntValueAs<CborObject?>(14)?.convertTo<RequiredSigners, CborObject>((e) => RequiredSigners.deserialize(e)),
        network: cbor.getIntValueAs<CborIntValue?>(15)?.convertTo<ADANetwork, CborIntValue>((e) => ADANetwork.fromTag(e.value)),
        collateralReturn: cbor.getIntValueAs<CborObject?>(16)?.convertTo<TransactionOutput, CborObject>((e) => TransactionOutput.deserialize(e)),
        totalCollateral: cbor.getIntValueAs<CborNumeric?>(17)?.toBigInt(),
        referenceInputs: cbor.getIntValueAs<CborObject?>(18)?.convertTo<TransactionInputs, CborObject>((e) => TransactionInputs.deserialize(e)),
        votingProcedures: cbor.getIntValueAs<CborMapValue?>(19)?.convertTo<VotingProcedures, CborMapValue>((e) => VotingProcedures.deserialize(e.as<CborMapValue>("VotingProcedures"))),
        votingProposals: cbor.getIntValueAs<CborObject?>(20)?.convertTo<VotingProposals, CborObject>((e) => VotingProposals.deserialize(e)),
        currentTreasuryValue: cbor.getIntValueAs<CborNumeric?>(21)?.toBigInt(),
        donation: cbor.getIntValueAs<CborNumeric?>(22)?.toBigInt(),
        serializationConfig: TransactionBodySerializationConfig(keyOrder: cbor.value.keys.map((e) => e.value).toList()));
  }
  TransactionBody copyWith({
    TransactionInputs? inputs,
    TransactionOutputs? outputs,
    BigInt? fee,
    BigInt? ttl,
    Certificates? certificates,
    Withdrawals? withdrawals,
    Update? update,
    AuxiliaryDataHash? auxiliaryDataHash,
    BigInt? validityStartInterval,
    Mint? mint,
    ScriptDataHash? scriptDataHash,
    TransactionInputs? collateral,
    RequiredSigners? requiredSigners,
    ADANetwork? network,
    TransactionOutput? collateralReturn,
    BigInt? totalCollateral,
    TransactionInputs? referenceInputs,
  }) {
    return TransactionBody(
      inputs: inputs ?? this.inputs,
      outputs: outputs ?? this.outputs,
      fee: fee ?? this.fee,
      ttl: ttl ?? this.ttl,
      certificates: certificates ?? this.certificates,
      withdrawals: withdrawals ?? this.withdrawals,
      update: update ?? this.update,
      auxiliaryDataHash: auxiliaryDataHash ?? this.auxiliaryDataHash,
      validityStartInterval:
          validityStartInterval ?? this.validityStartInterval,
      mint: mint ?? this.mint,
      scriptDataHash: scriptDataHash ?? this.scriptDataHash,
      collateral: collateral ?? this.collateral,
      requiredSigners: requiredSigners ?? this.requiredSigners,
      network: network ?? this.network,
      collateralReturn: collateralReturn ?? this.collateralReturn,
      totalCollateral: totalCollateral ?? this.totalCollateral,
      referenceInputs: referenceInputs ?? this.referenceInputs,
    );
  }

  @override
  CborObject toCbor() {
    final Map<CborIntValue, CborObject> data = {
      if (inputs != null) CborIntValue(0): inputs!.toCbor(),
      if (outputs != null) CborIntValue(1): outputs!.toCbor(),
      CborIntValue(2): CborUnsignedValue.u64(fee),
      if (ttl != null) ...{const CborIntValue(3): CborUnsignedValue.u64(ttl!)},
      if (certificates != null) ...{
        const CborIntValue(4): certificates!.toCbor()
      },
      if (withdrawals != null) ...{
        const CborIntValue(5): withdrawals!.toCbor(),
      },
      if (update != null) ...{const CborIntValue(6): update!.toCbor()},
      if (auxiliaryDataHash != null) ...{
        CborIntValue(7): auxiliaryDataHash!.toCbor()
      },
      if (validityStartInterval != null) ...{
        const CborIntValue(8): CborUnsignedValue.u64(validityStartInterval!)
      },
      if (mint != null) ...{const CborIntValue(9): mint!.toCbor()},
      if (scriptDataHash != null) ...{
        const CborIntValue(11): scriptDataHash!.toCbor()
      },
      if (collateral != null) const CborIntValue(13): collateral!.toCbor(),
      if (requiredSigners != null)
        const CborIntValue(14): requiredSigners!.toCbor(),
      if (network != null) ...{
        const CborIntValue(15): CborIntValue(network!.value),
      },
      if (collateralReturn != null) ...{
        const CborIntValue(16): collateralReturn!.toCbor()
      },
      if (totalCollateral != null) ...{
        const CborIntValue(17): CborUnsignedValue.u64(totalCollateral!),
      },
      if (referenceInputs != null)
        const CborIntValue(18): referenceInputs!.toCbor(),
      if (votingProcedures != null) ...{
        const CborIntValue(19): votingProcedures!.toCbor()
      },
      if (votingProposals != null) ...{
        const CborIntValue(20): votingProposals!.toCbor()
      },
      if (currentTreasuryValue != null) ...{
        const CborIntValue(21): CborUnsignedValue.u64(currentTreasuryValue!),
      },
      if (donation != null) ...{
        const CborIntValue(22): CborUnsignedValue.u64(donation!),
      },
    };
    Map<CborIntValue, CborObject> sort = {};
    final order = serializationConfig.keyOrder;
    if (order == null) {
      sort = data;
    } else {
      for (final i in order) {
        final key = CborIntValue(i);
        assert(data.containsKey(key), "key does not exists $i");
        if (!data.containsKey(key)) continue;
        sort[key] = data[key]!;
      }
    }

    return CborMapValue.definite(sort);
  }

  TransactionHash toHash() {
    return TransactionHash(QuickCrypto.blake2b256Hash(serialize()));
  }

  factory TransactionBody.fromJson(Map<String, dynamic> json) {
    return TransactionBody(
        inputs: json["inputs"] == null
            ? null
            : TransactionInputs.fromJson(json["inputs"]),
        outputs: json["outputs"] != null
            ? TransactionOutputs.fromJson(json["outputs"])
            : null,
        fee: BigintUtils.parse(json['fee']),
        ttl: BigintUtils.tryParse(json['ttl']),
        certificates: json["certificates"] == null
            ? null
            : Certificates.fromJson(json["certificates"]),
        withdrawals: json['withdrawals'] == null
            ? null
            : Withdrawals.fromJson(json['withdrawals']),
        update: json['update'] == null ? null : Update.fromJson(json['update']),
        auxiliaryDataHash: json['auxiliary_data_hash'] == null
            ? null
            : AuxiliaryDataHash.fromHex(json['auxiliary_data_hash']),
        validityStartInterval:
            BigintUtils.tryParse(json['validity_start_interval']),
        mint: json['mint'] == null ? null : Mint.fromJson(json['mint']),
        scriptDataHash: json['script_data_hash'] == null
            ? null
            : ScriptDataHash.fromHex(json['script_data_hash']),
        collateral: json["collateral"] == null
            ? null
            : TransactionInputs.fromJson(json["collateral"]),
        requiredSigners: json["required_signers"] == null
            ? null
            : RequiredSigners.fromJson(json["required_signers"]),
        network: json['network_id'] == null
            ? null
            : ADANetwork.fromTag(json['network_id']),
        collateralReturn: json['collateral_return'] == null
            ? null
            : TransactionOutput.fromJson(json['collateral_return']),
        referenceInputs: json['reference_inputs'] == null
            ? null
            : TransactionInputs.fromJson(json['reference_inputs']),
        totalCollateral: BigintUtils.tryParse(json['total_collateral']),
        votingProcedures: json["voting_procedures"] == null
            ? null
            : VotingProcedures.fromJson(json["voting_procedures"]),
        votingProposals: json["voting_proposals"] == null
            ? null
            : VotingProposals.fromJson(json["voting_proposals"]),
        currentTreasuryValue:
            BigintUtils.tryParse(json["current_treasury_value"]),
        donation: BigintUtils.tryParse(json["donation"]),
        serializationConfig: TransactionBodySerializationConfig.fromJson(
            json["serialization_config"] ?? {}));
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      'inputs': inputs?.toJson(),
      'outputs': outputs?.toJson(),
      'fee': fee.toString(),
      'ttl': ttl?.toString(),
      'certificates': certificates?.toJson(),
      'withdrawals': withdrawals?.toJson(),
      'update': update?.toJson(),
      'auxiliary_data_hash': auxiliaryDataHash?.toJson(),
      'validity_start_interval': validityStartInterval?.toString(),
      'mint': mint?.toJson(),
      'script_data_hash': scriptDataHash?.toJson(),
      'collateral': collateral?.toJson(),
      'required_signers': requiredSigners?.toJson(),
      'network_id': network?.value,
      'collateral_return': collateralReturn?.toJson(),
      'total_collateral': totalCollateral?.toString(),
      'reference_inputs': referenceInputs?.toJson(),
      'voting_procedures': votingProcedures?.toJson(),
      'voting_proposals': votingProposals?.toJson(),
      'current_treasury_value': currentTreasuryValue?.toString(),
      'donation': donation?.toString(),
      'serialization_config': serializationConfig.toJson()
    };
  }
}
