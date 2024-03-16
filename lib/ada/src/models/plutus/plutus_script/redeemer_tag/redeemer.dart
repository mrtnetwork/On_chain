import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/numbers/numbers.dart';
import 'package:on_chain/ada/src/models/plutus/plutus/core/plutus.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/ex_units.dart';
import 'package:on_chain/ada/src/models/plutus/plutus_script/redeemer_tag/redeemer_tag.dart';

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
    return Redeemer.deserialize(CborObject.fromCbor(cborBytes).cast());
  }
  factory Redeemer.deserialize(CborListValue cbor) {
    return Redeemer(
        tag: RedeemerTag.deserialize(cbor.getIndex(0)),
        index: cbor.getIndex<CborObject>(1).getInteger(),
        data: PlutusData.deserialize(cbor.getIndex(2)),
        exUnits: ExUnits.deserialize(cbor.getIndex(3)));
  }
  factory Redeemer.fromJson(Map<String, dynamic> json) {
    return Redeemer(
        tag: RedeemerTag.fromName(json["tag"]),
        index: BigintUtils.parse(json["index"]),
        data: PlutusData.fromJson(json["data"]),
        exUnits: ExUnits.fromJson(json["ex_units"]));
  }

  @override
  CborObject toCbor() {
    return CborListValue.fixedLength([
      tag.toCbor(),
      CborUnsignedValue.u64(index),
      data.toCbor(),
      exUnits.toCbor(),
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "tag": tag.toJson(),
      "index": index.toString(),
      "data": data.toJson(),
      "ex_units": exUnits.toJson()
    };
  }
}
