import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/models/native_script/models/native_scripts.dart';
import 'package:on_chain/ada/src/models/plutus/plutus_data/plutus.dart';
import 'package:on_chain/ada/src/models/plutus/plutus_script/models/plutus_scripts.dart';
import 'package:on_chain/ada/src/models/transaction/witnesses/models/bootstrap_witnesses.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/plutus/redeemer/models/redeemer.dart';

import 'vkey_witnesses.dart';

class TransactionWitnessSetSerializationConfig {
  final List<int>? orderKeys;
  const TransactionWitnessSetSerializationConfig({this.orderKeys});
  factory TransactionWitnessSetSerializationConfig.fromJson(
      Map<String, dynamic> json) {
    return TransactionWitnessSetSerializationConfig(
        orderKeys: (json["order_keys"] as List?)?.cast());
  }
  Map<String, dynamic> toJson() {
    return {"order_keys": orderKeys};
  }
}

/// Represents a set of transaction witnesses.
class TransactionWitnessSet with ADASerialization {
  final VkeyWitnesses? vKeys;
  final NativeScripts? nativeScripts;
  final BootstrapWitnesses? bootstraps;
  final PlutusScripts? plutusScriptsV1;
  final PlutusScripts? plutusScriptsV2;
  final PlutusScripts? plutusScriptsV3;
  final PlutusList? plutusData;
  final Redeemers? redeemers;
  final TransactionWitnessSetSerializationConfig serializationConfig;

  /// Constructor for creating a TransactionWitnessSet.
  TransactionWitnessSet(
      {this.vKeys,
      this.nativeScripts,
      this.bootstraps,
      this.plutusScriptsV1,
      this.plutusScriptsV2,
      this.plutusScriptsV3,
      this.plutusData,
      this.redeemers,
      this.serializationConfig =
          const TransactionWitnessSetSerializationConfig()});
  factory TransactionWitnessSet.fromCborBytes(List<int> cborBytes) {
    return TransactionWitnessSet.deserialize(CborObject.fromCbor(cborBytes)
        .as<CborMapValue>("TransactionWitnessSet"));
  }
  factory TransactionWitnessSet.deserialize(CborMapValue cbor) {
    return TransactionWitnessSet(
        vKeys: cbor
            .getIntValueAs<CborObject?>(0)
            ?.convertTo<VkeyWitnesses, CborObject>(
                (e) => VkeyWitnesses.deserialize(e)),
        nativeScripts: cbor
            .getIntValueAs<CborObject?>(1)
            ?.convertTo<NativeScripts, CborObject>(
                (e) => NativeScripts.deserialize(e)),
        bootstraps: cbor
            .getIntValueAs<CborObject?>(2)
            ?.convertTo<BootstrapWitnesses, CborObject>(
                (e) => BootstrapWitnesses.deserialize(e)),
        plutusScriptsV1: cbor
            .getIntValueAs<CborObject?>(3)
            ?.convertTo<PlutusScripts, CborObject>(
                (e) => PlutusScripts.deserialize(e)),
        plutusScriptsV2: cbor
            .getIntValueAs<CborObject?>(6)
            ?.convertTo<PlutusScripts, CborObject>((e) => PlutusScripts.deserialize(e)),
        plutusScriptsV3: cbor.getIntValueAs<CborObject?>(7)?.convertTo<PlutusScripts, CborObject>((e) => PlutusScripts.deserialize(e)),
        plutusData: cbor.getIntValueAs<CborObject?>(4)?.convertTo<PlutusList, CborObject>((e) => PlutusList.deserialize(e)),
        redeemers: cbor.getIntValueAs<CborObject?>(5)?.convertTo<Redeemers, CborObject>((e) => Redeemers.deserialize(e)),
        serializationConfig: TransactionWitnessSetSerializationConfig(orderKeys: cbor.value.keys.map((e) => e.value).cast<int>().toList()));
  }
  TransactionWitnessSet copyWith({
    VkeyWitnesses? vKeys,
    NativeScripts? nativeScripts,
    BootstrapWitnesses? bootstraps,
    PlutusScripts? plutusScriptsV1,
    PlutusScripts? plutusScriptsV2,
    PlutusScripts? plutusScriptsV3,
    PlutusList? plutusData,
    Redeemers? redeemers,
  }) {
    return TransactionWitnessSet(
      vKeys: vKeys ?? this.vKeys,
      nativeScripts: nativeScripts ?? this.nativeScripts,
      bootstraps: bootstraps ?? this.bootstraps,
      plutusScriptsV1: plutusScriptsV1 ?? this.plutusScriptsV1,
      plutusScriptsV2: plutusScriptsV2 ?? this.plutusScriptsV2,
      plutusScriptsV3: plutusScriptsV2 ?? this.plutusScriptsV3,
      plutusData: plutusData ?? this.plutusData,
      redeemers: redeemers ?? this.redeemers,
    );
  }

  @override
  CborObject toCbor() {
    Map<CborIntValue, CborObject> data = {
      if (vKeys != null) const CborIntValue(0): vKeys!.toCbor(),
      if (nativeScripts != null) const CborIntValue(1): nativeScripts!.toCbor(),
      if (bootstraps != null) const CborIntValue(2): bootstraps!.toCbor(),
      if (plutusScriptsV1 != null)
        const CborIntValue(3): plutusScriptsV1!.toCbor(),
      if (plutusScriptsV2 != null)
        const CborIntValue(6): plutusScriptsV2!.toCbor(),
      if (plutusScriptsV3 != null)
        const CborIntValue(7): plutusScriptsV3!.toCbor(),
      if (plutusData != null) const CborIntValue(4): plutusData!.toCbor(),
      if (redeemers != null) const CborIntValue(5): redeemers!.toCbor(),
    };
    final order = serializationConfig.orderKeys;
    if (order != null) {
      final Map<CborIntValue, CborObject> sort = {};
      for (final i in order) {
        final key = CborIntValue(i);
        assert(data.containsKey(key), "key does not exists $i");
        if (!data.containsKey(key)) continue;
        sort[key] = data[key]!;
      }
      data = sort;
    }
    return CborMapValue.definite(data);
  }

  factory TransactionWitnessSet.fromJson(Map<String, dynamic> json) {
    return TransactionWitnessSet(
        vKeys: json['vkeys'] == null
            ? null
            : VkeyWitnesses.fromJson(json['vkeys']),
        nativeScripts: json['native_scripts'] == null
            ? null
            : NativeScripts.fromJson(json['native_scripts']),
        redeemers: json['redeemers'] == null
            ? null
            : Redeemers.fromJson(json["redeemers"]),
        bootstraps: json['bootstraps'] == null
            ? null
            : BootstrapWitnesses.fromJson(json['bootstraps']),
        plutusScriptsV1: json['plutus_v1'] == null
            ? null
            : PlutusScripts.fromJson(json['plutus_v1']),
        plutusScriptsV2: json['plutus_v2'] == null
            ? null
            : PlutusScripts.fromJson(json['plutus_v2']),
        plutusScriptsV3: json['plutus_v3'] == null
            ? null
            : PlutusScripts.fromJson(json['plutus_v3']),
        serializationConfig: TransactionWitnessSetSerializationConfig.fromJson(
            json["serialization_config"] ?? {}),
        plutusData: (json['plutus_data'] == null
            ? null
            : PlutusData.fromJson(json['plutus_data']) as PlutusList));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'vkeys': vKeys?.toJson(),
      'native_scripts': nativeScripts?.toJson(),
      'bootstraps': bootstraps?.toJson(),
      'plutus_v1': plutusScriptsV1?.toJson(),
      'plutus_v2': plutusScriptsV2?.toJson(),
      'plutus_v3': plutusScriptsV3?.toJson(),
      'plutus_data': plutusData?.toJson(),
      'redeemers': redeemers?.toJson(),
      'serialization_config': serializationConfig.toJson()
    };
  }
}
