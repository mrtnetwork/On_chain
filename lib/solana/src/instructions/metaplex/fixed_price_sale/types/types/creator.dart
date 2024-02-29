import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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

  static final Structure creatorLayout = LayoutUtils.struct([
    LayoutUtils.publicKey("address"),
    LayoutUtils.boolean(property: "verified"),
    LayoutUtils.u8("share"),
  ], "creator");

  @override
  Structure get layout => creatorLayout;
  @override
  Map<String, dynamic> serialize() {
    return {"address": address, "verified": verified, "share": share};
  }

  @override
  String toString() {
    return "Creator${serialize()}";
  }
}
