import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/ada/src/models/plutus/plutus_data/models/plutus_data.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/protocol/models/ex_units.dart';
import 'package:on_chain/ada/src/models/plutus/redeemer/models/redeemer_tag.dart';

class Redeemer with ADASerialization {
  final RedeemerTag tag;
  final BigInt index;
  final PlutusData data;
  final ExUnits exUnits;

  const Redeemer(
      {required this.tag,
      required this.index,
      required this.data,
      required this.exUnits});
  factory Redeemer.fromCborBytes(List<int> cborBytes) {
    return Redeemer.deserialize(
        CborObject.fromCbor(cborBytes).as<CborListValue>("Redeemer"));
  }
  factory Redeemer.deserialize(CborListValue cbor) {
    return Redeemer(
        tag: RedeemerTag.deserialize(cbor.elementAt<CborIntValue>(0)),
        index: cbor.elementAsInteger(1),
        data: PlutusData.deserialize(cbor.elementAt<CborObject>(2)),
        exUnits: ExUnits.deserialize(cbor.elementAt<CborListValue>(3)));
  }
  factory Redeemer.fromJson(Map<String, dynamic> json) {
    return Redeemer(
        tag: RedeemerTag.fromName(json['tag']),
        index: BigintUtils.parse(json['index']),
        data: PlutusData.fromJson(json['data']),
        exUnits: ExUnits.fromJson(json['ex_units']));
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([
      tag.toCbor(),
      CborUnsignedValue.u64(index),
      data.toCbor(),
      exUnits.toCbor(),
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'tag': tag.toJson(),
      'index': index.toString(),
      'data': data.toJson(),
      'ex_units': exUnits.toJson()
    };
  }
}

enum RedeemersCborContainerType {
  definite,
  inDefinite,
  map,
  set;

  static RedeemersCborContainerType fromName(String? name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () =>
            throw const CborException("Invalid itrable encoding type."));
  }
}

class RedeemersSerializationConfig {
  final RedeemersCborContainerType encoding;
  const RedeemersSerializationConfig(
      {this.encoding = RedeemersCborContainerType.definite});

  factory RedeemersSerializationConfig.fromJson(Map<String, dynamic> json) {
    return RedeemersSerializationConfig(
        encoding: json["encoding"] == null
            ? RedeemersCborContainerType.definite
            : RedeemersCborContainerType.fromName(json["encoding"]));
  }
  Map<String, dynamic> toJson() {
    return {"encoding": encoding.name};
  }
}

class Redeemers with ADASerialization {
  final List<Redeemer> redeemers;
  final RedeemersSerializationConfig serializationConfig;
  const Redeemers(
      {required this.redeemers,
      this.serializationConfig = const RedeemersSerializationConfig()});
  factory Redeemers.deserialize(CborObject cbor) {
    if (cbor is CborMapValue) {
      final redeemerMap = cbor.valueAsMap<CborListValue, CborListValue>();
      final redeemers = redeemerMap.entries.map(((i) {
        return Redeemer(
            tag: RedeemerTag.deserialize(i.key.elementAt<CborIntValue>(0)),
            index: i.key.elementAsInteger(1),
            data: PlutusData.deserialize(i.value.elementAt<CborObject>(0)),
            exUnits: ExUnits.deserialize(i.value.elementAt<CborListValue>(1)));
      })).toList();
      return Redeemers(
          redeemers: redeemers,
          serializationConfig: RedeemersSerializationConfig(
              encoding: RedeemersCborContainerType.map));
    }
    final redeemersList = cbor.as<CborIterableObject>("Redeemers");
    return Redeemers(
        serializationConfig: RedeemersSerializationConfig(
            encoding: RedeemersCborContainerType.fromName(
                redeemersList.encoding.name)),
        redeemers: redeemersList
            .valueAsListOf<CborListValue>()
            .map((e) => Redeemer.deserialize(e))
            .toList());
  }

  factory Redeemers.fromJson(Map<String, dynamic> json) {
    return Redeemers(
        redeemers: (json['redeemers'] as List?)
                ?.map((e) => Redeemer.fromJson(e))
                .toList() ??
            [],
        serializationConfig: RedeemersSerializationConfig.fromJson(
            json["serialization_config"] ?? {}));
  }

  @override
  CborObject toCbor() {
    switch (serializationConfig.encoding) {
      case RedeemersCborContainerType.map:
        return CborMapValue.definite({
          for (final i in redeemers)
            CborListValue.definite([
              i.tag.toCbor(),
              CborUnsignedValue.u64(i.index),
            ]): CborListValue.definite([
              i.data.toCbor(),
              i.exUnits.toCbor(),
            ])
        });
      case RedeemersCborContainerType.definite:
        return CborListValue.definite(
            redeemers.map((e) => e.toCbor()).toList());
      case RedeemersCborContainerType.inDefinite:
        return CborListValue.inDefinite(
            redeemers.map((e) => e.toCbor()).toList());
      case RedeemersCborContainerType.set:
        return CborSetValue(redeemers.map((e) => e.toCbor()).toList());
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "redeemers": redeemers.map((e) => e.toJson()).toList(),
      "serialization_config": serializationConfig.toJson()
    };
  }
}
