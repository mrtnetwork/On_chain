import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class NftGate extends LayoutSerializable {
  final SolAddress requiredCollection;

  const NftGate({required this.requiredCollection});
  factory NftGate.fromJson(Map<String, dynamic> json) {
    return NftGate(requiredCollection: json["requiredCollection"]);
  }

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.publicKey("requiredCollection"),
  ], "nftGate");

  @override
  Structure get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {"requiredCollection": requiredCollection};
  }

  @override
  String toString() {
    return "NftGate${serialize()}";
  }
}
