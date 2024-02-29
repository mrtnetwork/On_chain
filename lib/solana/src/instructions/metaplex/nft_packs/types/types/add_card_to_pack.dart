import 'package:on_chain/solana/src/layout/layout.dart';

class AddCardToPack extends LayoutSerializable {
  final int maxSupply;
  final int weight;
  final int index;
  const AddCardToPack({
    required this.maxSupply,
    required this.weight,
    required this.index,
  });
  factory AddCardToPack.fromJson(Map<String, dynamic> json) {
    return AddCardToPack(
        maxSupply: json["maxSupply"],
        weight: json["weight"],
        index: json["index"]);
  }

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.u32("maxSupply"),
    LayoutUtils.u16("weight"),
    LayoutUtils.u32("index"),
  ], "addCardToPack");
  @override
  Structure get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "maxSupply": maxSupply,
      "weight": weight,
      "index": index,
    };
  }

  @override
  String toString() {
    return "AddCardToPack${serialize()}";
  }
}
