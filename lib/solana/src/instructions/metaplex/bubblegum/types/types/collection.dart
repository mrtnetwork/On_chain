import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class Collection extends LayoutSerializable {
  final bool verified;
  final SolAddress key;
  const Collection({required this.verified, required this.key});
  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(verified: json["verified"], key: json["key"]);
  }
  static final Structure staticLayout = LayoutUtils.struct(
      [LayoutUtils.boolean(property: "verified"), LayoutUtils.publicKey("key")],
      "collection");

  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {"verified": verified, "key": key};
  }

  @override
  String toString() {
    return "Collection${serialize()}";
  }
}
