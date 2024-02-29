import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class ChangeLog extends LayoutSerializable {
  final SolAddress root;
  final List<SolAddress> pathNodes;
  final BigInt index;
  ChangeLog(
      {required this.root,
      required List<SolAddress> pathNodes,
      required this.index})
      : pathNodes = List<SolAddress>.unmodifiable(pathNodes);
  factory ChangeLog.fromJson(Map<String, dynamic> json) {
    return ChangeLog(
        root: json["root"],
        pathNodes: (json["pathNodes"] as List).cast(),
        index: json["index"]);
  }
  static Structure staticLayout({required int maxDepth}) => LayoutUtils.struct([
        LayoutUtils.publicKey("root"),
        LayoutUtils.array(LayoutUtils.publicKey(), maxDepth,
            property: "pathNodes"),
        LayoutUtils.u64("index")
      ], "changeLog");

  @override
  Structure get layout => staticLayout(maxDepth: pathNodes.length);

  @override
  Map<String, dynamic> serialize() {
    return {"root": root, "pathNodes": pathNodes, "index": index};
  }

  @override
  String toString() {
    return "ChangeLog${serialize()}";
  }
}
