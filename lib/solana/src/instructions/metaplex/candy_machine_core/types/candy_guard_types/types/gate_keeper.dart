import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class Gatekeeper extends LayoutSerializable {
  final bool expireOnUse;
  final SolAddress gatekeeperNetwork;

  const Gatekeeper(
      {required this.expireOnUse, required this.gatekeeperNetwork});
  factory Gatekeeper.fromJson(Map<String, dynamic> json) {
    return Gatekeeper(
        expireOnUse: json["expireOnUse"],
        gatekeeperNetwork: json["gatekeeperNetwork"]);
  }

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.publicKey("gatekeeperNetwork"),
    LayoutUtils.boolean(property: "expireOnUse")
  ], "gatekeeper");

  @override
  Structure get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {"gatekeeperNetwork": gatekeeperNetwork, "expireOnUse": expireOnUse};
  }

  @override
  String toString() {
    return "Gatekeeper${serialize()}";
  }
}
