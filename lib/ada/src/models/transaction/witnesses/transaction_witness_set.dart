import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/models/plutus/plutus/plutus.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/plutus/plutus_script/language/language.dart';
import 'package:on_chain/ada/src/models/native_script/core/native_script.dart';
import 'package:on_chain/ada/src/models/plutus/plutus_script/redeemer_tag/redeemer.dart';
import 'package:on_chain/ada/src/models/plutus/plutus_script/script/plutus_script.dart';
import 'package:on_chain/ada/src/models/transaction/witnesses/bootstrap_witness.dart';
import 'package:on_chain/ada/src/models/transaction/witnesses/vkey_witness.dart';
import 'package:on_chain/ada/src/models/utils.dart';

/// Represents a set of transaction witnesses.
class TransactionWitnessSet with ADASerialization {
  final List<Vkeywitness>? vKeys;
  final List<NativeScript>? nativeScripts;
  final List<BootstrapWitness>? bootstraps;
  final List<PlutusScript>? plutusScripts;
  final PlutusList? plutusData;
  final List<Redeemer>? redeemers;

  /// Constructor for creating a TransactionWitnessSet.
  TransactionWitnessSet(
      {List<Vkeywitness>? vKeys,
      List<NativeScript>? nativeScripts,
      List<BootstrapWitness>? bootstraps,
      List<PlutusScript>? plutusScripts,
      this.plutusData,
      List<Redeemer>? redeemers})
      : vKeys = AdaTransactionUtils.unmodifiable(vKeys),
        nativeScripts = AdaTransactionUtils.unmodifiable(nativeScripts),
        bootstraps = AdaTransactionUtils.unmodifiable(bootstraps),
        plutusScripts = AdaTransactionUtils.unmodifiable(plutusScripts),
        redeemers = AdaTransactionUtils.unmodifiable(redeemers);
  factory TransactionWitnessSet.fromCborBytes(List<int> cborBytes) {
    return TransactionWitnessSet.deserialize(
        CborObject.fromCbor(cborBytes).cast());
  }
  factory TransactionWitnessSet.deserialize(CborMapValue cbor) {
    final v1 = cbor
        .getValueFromIntKey<CborListValue?>(3)
        ?.to<List<PlutusScript>, CborListValue<CborObject>>((e) {
      return e.value.map((i) => PlutusScript.deserialize(i.cast())).toList();
    });
    final v2 = cbor
        .getValueFromIntKey<CborListValue?>(6)
        ?.to<List<PlutusScript>, CborListValue<CborObject>>((e) => e.value
            .map((i) =>
                PlutusScript.deserialize(i.cast(), language: Language.plutusV2))
            .toList());
    return TransactionWitnessSet(
        vKeys: cbor
            .getValueFromIntKey<CborListValue?>(0)
            ?.value
            .map((e) => Vkeywitness.deserialize(e))
            .toList(),
        nativeScripts: cbor
            .getValueFromIntKey<CborListValue?>(1)
            ?.to<List<NativeScript>, CborListValue<CborObject>>((e) => e.value
                .map((e) => NativeScript.deserialize(e.cast()))
                .toList()),
        bootstraps: cbor
            .getValueFromIntKey<CborListValue?>(2)
            ?.to<List<BootstrapWitness>, CborListValue<CborObject>>((e) => e.value
                .map((e) => BootstrapWitness.deserialize(e.cast()))
                .toList()),
        plutusScripts:
            v1 == null && v2 == null ? null : [...v1 ?? [], ...v2 ?? []],
        plutusData: cbor
            .getValueFromIntKey<CborListValue?>(4)
            ?.to<PlutusList, CborListValue>((e) => PlutusList.deserialize(e)),
        redeemers: cbor.getValueFromIntKey<CborListValue?>(5)?.to<List<Redeemer>, CborListValue<CborObject>>(
            (e) => e.value.map((i) => Redeemer.deserialize(i.cast())).toList()));
  }
  TransactionWitnessSet copyWith({
    List<Vkeywitness>? vKeys,
    List<NativeScript>? nativeScripts,
    List<BootstrapWitness>? bootstraps,
    List<PlutusScript>? plutusScripts,
    PlutusList? plutusData,
    List<Redeemer>? redeemers,
  }) {
    return TransactionWitnessSet(
      vKeys: vKeys ?? this.vKeys,
      nativeScripts: nativeScripts ?? this.nativeScripts,
      bootstraps: bootstraps ?? this.bootstraps,
      plutusScripts: plutusScripts ?? this.plutusScripts,
      plutusData: plutusData ?? this.plutusData,
      redeemers: redeemers ?? this.redeemers,
    );
  }

  @override
  CborObject toCbor() {
    final plutusVersion1 = plutusScripts
            ?.where((element) => element.language == Language.plutusV1)
            .toList() ??
        [];
    final plutusVersion2 = plutusScripts
            ?.where((element) => element.language == Language.plutusV2)
            .toList() ??
        [];
    return CborMapValue.fixedLength({
      if (vKeys?.isNotEmpty ?? false) ...{
        CborIntValue(0):
            CborListValue.fixedLength(vKeys!.map((e) => e.toCbor()).toList())
      },
      if (nativeScripts?.isNotEmpty ?? false) ...{
        CborIntValue(1): CborListValue.fixedLength(
            nativeScripts!.map((e) => e.toCbor()).toList()),
      },
      if (bootstraps?.isNotEmpty ?? false) ...{
        CborIntValue(2): CborListValue.fixedLength(
            bootstraps!.map((e) => e.toCbor()).toList()),
      },
      if (plutusScripts != null) ...{
        CborIntValue(3): CborListValue.fixedLength(
            plutusVersion1.map((e) => e.toCbor()).toList()),
        if (plutusVersion2.isNotEmpty)
          CborIntValue(6): CborListValue.fixedLength(
              plutusVersion2.map((e) => e.toCbor()).toList()),
      },
      if (plutusData != null) ...{CborIntValue(4): plutusData!.toCbor()},
      if (redeemers?.isNotEmpty ?? false) ...{
        CborIntValue(5): CborListValue.fixedLength(
            redeemers!.map((e) => e.toCbor()).toList()),
      },
    });
  }

  factory TransactionWitnessSet.fromJson(Map<String, dynamic> json) {
    return TransactionWitnessSet(
        vKeys: (json["vkeys"] as List?)
            ?.map((e) => Vkeywitness.fromJson(e))
            .toList(),
        nativeScripts: (json["native_scripts"] as List?)
            ?.map((e) => NativeScript.fromJson(e))
            .toList(),
        redeemers: (json["redeemers"] as List?)
            ?.map((e) => Redeemer.fromJson(e))
            .toList(),
        bootstraps: (json["bootstraps"] as List?)
            ?.map((e) => BootstrapWitness.fromJson(e))
            .toList(),
        plutusScripts: (json["plutus_scripts"] as List?)
            ?.map((e) => PlutusScript.fromJson(e))
            .toList(),
        plutusData: (json["plutus_data"] == null
            ? null
            : PlutusData.fromJson(json["plutus_data"]) as PlutusList));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "vkeys": vKeys?.map((e) => e.toJson()).toList(),
      "native_scripts": nativeScripts?.map((e) => e.toJson()).toList(),
      "bootstraps": bootstraps?.map((e) => e.toJson()).toList(),
      "plutus_scripts": plutusScripts?.map((e) => e.toJson()).toList(),
      "plutus_data": plutusData?.toJson(),
      "redeemers": redeemers?.map((e) => e.toJson()).toList()
    };
  }
}
