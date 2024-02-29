import 'package:on_chain/solana/src/layout/layout.dart';

class MintLimit extends LayoutSerializable {
  final int id;
  final int limit;

  const MintLimit({required this.id, required this.limit});
  factory MintLimit.fromJson(Map<String, dynamic> json) {
    return MintLimit(id: json["id"], limit: json["limit"]);
  }

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.u8("id"),
    LayoutUtils.u16("limit"),
  ], "mintLimit");

  @override
  Structure get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {"id": id, "limit": limit};
  }

  @override
  String toString() {
    return "MintLimit${serialize()}";
  }
}
