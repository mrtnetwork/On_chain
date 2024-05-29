import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

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
  static StructLayout staticLayout({required int maxDepth}) =>
      LayoutConst.struct([
        SolanaLayoutUtils.publicKey("root"),
        LayoutConst.array(SolanaLayoutUtils.publicKey(), maxDepth,
            property: "pathNodes"),
        LayoutConst.u64(property: "index")
      ], property: "changeLog");

  @override
  StructLayout get layout => staticLayout(maxDepth: pathNodes.length);

  @override
  Map<String, dynamic> serialize() {
    return {"root": root, "pathNodes": pathNodes, "index": index};
  }

  @override
  String toString() {
    return "ChangeLog${serialize()}";
  }
}
