import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/certificate/core/certificate.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';
import 'package:on_chain/ada/src/models/mint/models/mint.dart';
import 'package:on_chain/ada/src/models/transaction/input/transaction_input.dart';
import 'package:on_chain/ada/src/models/transaction/output/models/transaction_output.dart';
import 'package:on_chain/ada/src/models/update/models/update.dart';
import 'package:on_chain/ada/src/models/utils.dart';
import 'package:on_chain/ada/src/models/withdrawals/withdrawals.dart';

class TransactionBody with ADASerialization {
  final List<TransactionInput> inputs;
  final List<TransactionOutput> outputs;
  final BigInt fee;
  final BigInt? ttl;
  final List<Certificate>? certs;
  final Withdrawals? withdrawals;
  final Update? update;
  final AuxiliaryDataHash? auxiliaryDataHash;
  final BigInt? validityStartInterval;
  final Mint? mint;
  final ScriptDataHash? scriptDataHash;
  final List<TransactionInput>? collateral;
  final List<Ed25519KeyHash>? requiredSigners;
  final ADANetwork? network;
  final TransactionOutput? collateralReturn;
  final BigInt? totalCollateral;
  final List<TransactionInput>? referenceInputs;
  TransactionBody(
      {required List<TransactionInput> inputs,
      required List<TransactionOutput> outputs,
      required this.fee,
      this.ttl,
      List<Certificate>? certs,
      this.withdrawals,
      this.update,
      this.auxiliaryDataHash,
      this.validityStartInterval,
      this.mint,
      this.scriptDataHash,
      List<TransactionInput>? collateral,
      List<Ed25519KeyHash>? requiredSigners,
      this.network,
      this.collateralReturn,
      this.totalCollateral,
      List<TransactionInput>? referenceInputs})
      : inputs = List<TransactionInput>.unmodifiable(inputs),
        outputs = List<TransactionOutput>.unmodifiable(outputs),
        certs = AdaTransactionUtils.unmodifiable(certs),
        collateral = AdaTransactionUtils.unmodifiable(collateral),
        requiredSigners = AdaTransactionUtils.unmodifiable(requiredSigners),
        referenceInputs = AdaTransactionUtils.unmodifiable(referenceInputs);
  factory TransactionBody.fromCborBytes(List<int> bytes) {
    final CborMapValue decode = ADASerialization.desrialize(bytes);
    return TransactionBody.deserialize(decode);
  }
  factory TransactionBody.deserialize(CborMapValue cbor) {
    return TransactionBody(
        inputs: cbor
            .getIterableFromIntKey(0)!
            .map((e) => TransactionInput.deserialize(e))
            .toList(),
        outputs: cbor
            .getIterableFromIntKey(1)!
            .map((e) => TransactionOutput.deserialize(e))
            .toList(),
        fee: cbor.getValueFromIntKey<CborObject>(2).getInteger(),
        ttl: cbor.getValueFromIntKey<CborObject?>(3)?.getInteger(),
        withdrawals: cbor
            .getValueFromIntKey<CborObject?>(5)
            ?.castTo<Withdrawals, CborMapValue>(
                (e) => Withdrawals.deserialize(e)),
        auxiliaryDataHash: cbor
            .getValueFromIntKey<CborObject?>(7)
            ?.castTo<AuxiliaryDataHash, CborBytesValue>(
                (CborBytesValue e) => AuxiliaryDataHash.deserialize(e)),
        certs: cbor
            .getValueFromIntKey<CborObject?>(4)
            ?.castTo<List<Certificate>, CborListValue<CborObject>>((CborListValue<CborObject> e) =>
                e.value.map((e) => Certificate.deserialize(e.cast())).toList()),
        update: cbor
            .getValueFromIntKey<CborListValue?>(6)
            ?.castTo<Update, CborListValue>((e) => Update.deserialize(e)),
        validityStartInterval: cbor.getValueFromIntKey<CborObject?>(8)?.getInteger(),
        mint: cbor.getValueFromIntKey<CborMapValue?>(9)?.castTo<Mint, CborMapValue>((e) => Mint.deserialize(e.cast())),
        scriptDataHash: cbor.getValueFromIntKey<CborBytesValue?>(11)?.castTo<ScriptDataHash, CborBytesValue>((e) => ScriptDataHash.deserialize(e)),
        collateral: cbor.getValueFromIntKey<CborListValue?>(13)?.castTo<List<TransactionInput>, CborListValue<CborObject>>((e) => e.value.map((e) => TransactionInput.deserialize(e.cast())).toList()),
        requiredSigners: cbor.getValueFromIntKey<CborListValue?>(14)?.castTo<List<Ed25519KeyHash>, CborListValue<CborObject>>((e) => e.value.map((e) => Ed25519KeyHash.deserialize(e.cast())).toList()),
        network: cbor.getValueFromIntKey<CborIntValue?>(15)?.castTo<ADANetwork, CborIntValue>((e) => ADANetwork.fromTag(e.value)),
        collateralReturn: cbor.getValueFromIntKey<CborObject?>(16)?.castTo<TransactionOutput, CborObject>((e) => TransactionOutput.deserialize(e)),
        totalCollateral: cbor.getValueFromIntKey<CborObject?>(17)?.getInteger(),
        referenceInputs: cbor.getValueFromIntKey<CborListValue?>(18)?.castTo<List<TransactionInput>, CborListValue<CborObject>>((e) => e.value.map((e) => TransactionInput.deserialize(e.cast())).toList()));
  }
  TransactionBody copyWith({
    List<TransactionInput>? inputs,
    List<TransactionOutput>? outputs,
    BigInt? fee,
    BigInt? ttl,
    List<Certificate>? certs,
    Withdrawals? withdrawals,
    Update? update,
    AuxiliaryDataHash? auxiliaryDataHash,
    BigInt? validityStartInterval,
    Mint? mint,
    ScriptDataHash? scriptDataHash,
    List<TransactionInput>? collateral,
    List<Ed25519KeyHash>? requiredSigners,
    ADANetwork? network,
    TransactionOutput? collateralReturn,
    BigInt? totalCollateral,
    List<TransactionInput>? referenceInputs,
  }) {
    return TransactionBody(
      inputs: inputs ?? this.inputs,
      outputs: outputs ?? this.outputs,
      fee: fee ?? this.fee,
      ttl: ttl ?? this.ttl,
      certs: certs ?? this.certs,
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
    return CborMapValue.fixedLength({
      0: CborListValue.fixedLength(inputs.map((e) => e.toCbor()).toList()),
      1: CborListValue.fixedLength(outputs.map((e) => e.toCbor()).toList()),
      2: CborUnsignedValue.u64(fee),
      if (ttl != null) ...{const CborIntValue(3): CborUnsignedValue.u64(ttl!)},
      if (certs?.isNotEmpty ?? false) ...{
        const CborIntValue(4):
            CborListValue.fixedLength(certs!.map((e) => e.toCbor()).toList())
      },
      if (withdrawals != null) ...{
        const CborIntValue(5): withdrawals!.toCbor(),
      },
      if (update != null) ...{const CborIntValue(6): update!.toCbor()},
      if (auxiliaryDataHash != null) ...{7: auxiliaryDataHash!.toCbor()},
      if (validityStartInterval != null) ...{
        const CborIntValue(8): CborUnsignedValue.u64(validityStartInterval!)
      },
      if (mint != null) ...{const CborIntValue(9): mint!.toCbor()},
      if (scriptDataHash != null) ...{
        const CborIntValue(11): scriptDataHash!.toCbor()
      },
      if (collateral?.isNotEmpty ?? false) ...{
        const CborIntValue(13): CborListValue.fixedLength(
            collateral!.map((e) => e.toCbor()).toList())
      },
      if (requiredSigners?.isNotEmpty ?? false) ...{
        const CborIntValue(14): CborListValue.fixedLength(
            requiredSigners!.map((e) => e.toCbor()).toList())
      },
      if (network != null) ...{
        const CborIntValue(15): CborIntValue(network!.value),
      },
      if (collateralReturn != null) ...{
        const CborIntValue(16): collateralReturn!.toCbor()
      },
      if (totalCollateral != null) ...{
        const CborIntValue(17): CborUnsignedValue.u64(totalCollateral!),
      },
      if (referenceInputs?.isNotEmpty ?? false) ...{
        const CborIntValue(18): CborListValue.fixedLength(
            referenceInputs!.map((e) => e.toCbor()).toList())
      }
    });
  }

  TransactionHash toHash() {
    return TransactionHash(QuickCrypto.blake2b256Hash(serialize()));
  }

  factory TransactionBody.fromJson(Map<String, dynamic> json) {
    return TransactionBody(
        inputs: (json['inputs'] as List)
            .map((e) => TransactionInput.fromJson(e))
            .toList(),
        outputs: (json['outputs'] as List)
            .map((e) => TransactionOutput.fromJson(e))
            .toList(),
        fee: BigintUtils.parse(json['fee']),
        ttl: BigintUtils.tryParse(json['ttl']),
        certs: (json['certs'] as List?)
            ?.map((e) => Certificate.fromJson(e))
            .toList(),
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
        collateral: (json['collateral'] as List?)
            ?.map((e) => TransactionInput.fromJson(e))
            .toList(),
        requiredSigners: (json['required_signers'] as List?)
            ?.map((e) => Ed25519KeyHash.fromHex(e))
            .toList(),
        network: json['network_id'] == null
            ? null
            : ADANetwork.fromTag(json['network_id']),
        collateralReturn: json['collateral_return'] == null
            ? null
            : TransactionOutput.fromJson(json['collateral_return']),
        referenceInputs: (json['reference_inputs'] as List?)
            ?.map((e) => TransactionInput.fromJson(e))
            .toList(),
        totalCollateral: BigintUtils.tryParse(json['reference_inputs']));
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      'inputs': inputs.map((e) => e.toJson()).toList(),
      'outputs': outputs.map((e) => e.toJson()).toList(),
      'fee': fee.toString(),
      'ttl': ttl?.toString(),
      'certs': certs?.map((e) => e.toJson()).toList(),
      'withdrawals': withdrawals?.toJson(),
      'update': update?.toJson(),
      'auxiliary_data_hash': auxiliaryDataHash?.toJson(),
      'validity_start_interval': validityStartInterval?.toString(),
      'mint': mint?.toJson(),
      'script_data_hash': scriptDataHash?.toJson(),
      'collateral': collateral?.map((e) => e.toJson()).toList(),
      'required_signers': requiredSigners?.map((e) => e.toJson()).toList(),
      'network_id': network?.value,
      'collateral_return': collateralReturn?.toJson(),
      'total_collateral': totalCollateral?.toString(),
      'reference_inputs': referenceInputs?.map((e) => e.toJson()).toList()
    };
  }
}
