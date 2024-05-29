import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class GumdropCandyMachineData extends LayoutSerializable {
  final String uuid;
  final BigInt price;
  final BigInt itemsAvailable;
  final BigInt? goLiveDate;

  const GumdropCandyMachineData(
      {required this.uuid,
      required this.price,
      required this.itemsAvailable,
      required this.goLiveDate});
  factory GumdropCandyMachineData.fromJson(Map<String, dynamic> json) {
    return GumdropCandyMachineData(
        uuid: json["uuid"],
        price: json["price"],
        itemsAvailable: json["itemsAvailable"],
        goLiveDate: json["goLiveDate"]);
  }

  static final StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.string(property: "uuid"),
    LayoutConst.u64(property: "price"),
    LayoutConst.u64(property: "itemsAvailable"),
    LayoutConst.optional(LayoutConst.u64(), property: "goLiveDate")
  ], property: "candyMachineData");

  @override
  StructLayout get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "uuid": uuid,
      "price": price,
      "itemsAvailable": itemsAvailable,
      "goLiveDate": goLiveDate
    };
  }

  @override
  String toString() {
    return "GumdropCandyMachineData${serialize()}";
  }
}
