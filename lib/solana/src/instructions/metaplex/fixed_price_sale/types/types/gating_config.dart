import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class GatingConfig extends LayoutSerializable {
  final SolAddress collection;
  final bool expireOnUse;
  final BigInt? gatingTime;
  const GatingConfig(
      {required this.collection, required this.expireOnUse, this.gatingTime});
  factory GatingConfig.fromJson(Map<String, dynamic> json) {
    return GatingConfig(
        collection: json["collection"],
        expireOnUse: json["expireOnUse"],
        gatingTime: json["gatingTime"]);
  }

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.publicKey("collection"),
    LayoutUtils.boolean(property: "expireOnUse"),
    LayoutUtils.optional(LayoutUtils.u64(), property: "gatingTime")
  ], "gatingConfig");

  @override
  Structure get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "collection": collection,
      "expireOnUse": expireOnUse,
      "gatingTime": gatingTime
    };
  }

  @override
  String toString() {
    return "GatingConfig${serialize()}";
  }
}
