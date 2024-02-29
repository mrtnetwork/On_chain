import 'package:on_chain/solana/src/layout/layout.dart';

class Allocation extends LayoutSerializable {
  final int id;
  final int limit;

  const Allocation({required this.id, required this.limit});
  factory Allocation.fromJson(Map<String, dynamic> json) {
    return Allocation(id: json["id"], limit: json["limit"]);
  }

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.u8("id"),
    LayoutUtils.u32("limit"),
  ], "allocation");

  @override
  Structure get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {"id": id, "limit": limit};
  }

  @override
  String toString() {
    return "Allocation${serialize()}";
  }
}
