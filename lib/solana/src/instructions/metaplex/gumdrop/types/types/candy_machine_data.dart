import 'package:on_chain/solana/src/layout/layout.dart';

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

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.string("uuid"),
    LayoutUtils.u64("price"),
    LayoutUtils.u64("itemsAvailable"),
    LayoutUtils.optional(LayoutUtils.u64(), property: "goLiveDate")
  ], "candyMachineData");

  @override
  Structure get layout => staticLayout;
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
