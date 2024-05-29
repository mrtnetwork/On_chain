import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MintLimit extends LayoutSerializable {
  final int id;
  final int limit;

  const MintLimit({required this.id, required this.limit});
  factory MintLimit.fromJson(Map<String, dynamic> json) {
    return MintLimit(id: json["id"], limit: json["limit"]);
  }

  static final StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.u8(property: "id"),
    LayoutConst.u16(property: "limit"),
  ], property: "mintLimit");

  @override
  StructLayout get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {"id": id, "limit": limit};
  }

  @override
  String toString() {
    return "MintLimit${serialize()}";
  }
}
