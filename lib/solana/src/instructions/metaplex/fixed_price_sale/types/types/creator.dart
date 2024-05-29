import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class Creator extends LayoutSerializable {
  final SolAddress address;
  final bool verified;
  final int share;

  const Creator(
      {required this.address, required this.verified, required this.share});
  factory Creator.fromJson(Map<String, dynamic> json) {
    return Creator(
        address: json["address"],
        verified: json["verified"],
        share: json["share"]);
  }

  static final StructLayout creatorLayout = LayoutConst.struct([
    SolanaLayoutUtils.publicKey("address"),
    LayoutConst.boolean(property: "verified"),
    LayoutConst.u8(property: "share"),
  ], property: "creator");

  @override
  StructLayout get layout => creatorLayout;
  @override
  Map<String, dynamic> serialize() {
    return {"address": address, "verified": verified, "share": share};
  }

  @override
  String toString() {
    return "Creator${serialize()}";
  }
}
