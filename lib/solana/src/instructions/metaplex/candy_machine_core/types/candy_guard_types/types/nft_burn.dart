import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class NftBurn extends LayoutSerializable {
  final SolAddress requiredCollection;

  const NftBurn({required this.requiredCollection});
  factory NftBurn.fromJson(Map<String, dynamic> json) {
    return NftBurn(requiredCollection: json["requiredCollection"]);
  }

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.publicKey("requiredCollection"),
  ], "nftBurn");

  @override
  Structure get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {"requiredCollection": requiredCollection};
  }

  @override
  String toString() {
    return "NftBurn${serialize()}";
  }
}
