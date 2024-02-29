import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class Path extends LayoutSerializable {
  final List<SolAddress> proof;
  final SolAddress leaf;
  final int index;
  final int padding;

  Path(
      {required List<SolAddress> proof,
      required this.index,
      required this.leaf,
      required this.padding})
      : proof = List<SolAddress>.unmodifiable(proof);
  factory Path.fromJson(Map<String, dynamic> json) {
    return Path(
        proof: (json["proof"] as List).cast(),
        index: json["index"],
        leaf: json["leaf"],
        padding: json["padding"]);
  }
  static Structure staticLayout({required int maxDepth}) => LayoutUtils.struct([
        LayoutUtils.array(LayoutUtils.publicKey(), maxDepth, property: "proof"),
        LayoutUtils.publicKey("leaf"),
        LayoutUtils.u32("index"),
        LayoutUtils.u32("padding"),
      ], "path");

  @override
  Structure get layout => staticLayout(maxDepth: proof.length);

  @override
  Map<String, dynamic> serialize() {
    return {"proof": proof, "leaf": leaf, "index": index, "padding": padding};
  }

  @override
  String toString() {
    return "Path${serialize()}";
  }
}
