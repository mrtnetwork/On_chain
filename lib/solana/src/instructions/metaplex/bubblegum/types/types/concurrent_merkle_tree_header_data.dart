import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/layout/layout.dart';
import 'concurrent_merkle_tree_header_data_v1.dart';

class ConcurrentMerkleTreeHeader extends LayoutSerializable {
  const ConcurrentMerkleTreeHeader._(this.name, this.value, this.field);
  final String name;
  final int value;
  final ConcurrentMerkleTreeHeaderDataV1 field;
  factory ConcurrentMerkleTreeHeader.fromJson(Map<String, dynamic> json) {
    final key = json["concurrentMerkleTreeHeader"]["key"];
    final Map<String, dynamic> value =
        Map<String, dynamic>.from(json["concurrentMerkleTreeHeader"]["value"]);
    switch (key) {
      case "V1":
        return ConcurrentMerkleTreeHeader.v1(
            header: ConcurrentMerkleTreeHeaderDataV1.fromJson(value));
      default:
        throw MessageException("Invalid ConcurrentMerkleTreeHeader version.",
            details: {"version": key});
    }
  }

  factory ConcurrentMerkleTreeHeader.v1(
      {required ConcurrentMerkleTreeHeaderDataV1 header}) {
    return ConcurrentMerkleTreeHeader._("V1", 0, header);
  }

  static Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.rustEnum([
      LayoutUtils.wrap(ConcurrentMerkleTreeHeaderDataV1.staticLayout,
          property: "V1")
    ], LayoutUtils.u8(), property: "concurrentMerkleTreeHeader")
  ]);

  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "concurrentMerkleTreeHeader": {name: field.serialize()}
    };
  }

  @override
  String toString() {
    return "ConcurrentMerkleTreeHeader${serialize()}";
  }
}
