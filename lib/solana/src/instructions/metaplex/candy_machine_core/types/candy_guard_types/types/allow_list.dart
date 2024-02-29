import 'package:blockchain_utils/binary/binary.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class AllowList extends LayoutSerializable {
  final List<int> merkleRoot;

  AllowList({required List<int> merkleRoot})
      : merkleRoot = BytesUtils.toBytes(merkleRoot, unmodifiable: true);
  factory AllowList.fromJson(Map<String, dynamic> json) {
    return AllowList(merkleRoot: (json["merkleRoot"] as List).cast());
  }

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.blob(32, property: "merkleRoot"),
  ], "allowList");

  @override
  Structure get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {"merkleRoot": merkleRoot};
  }

  @override
  String toString() {
    return "AllowList${serialize()}";
  }
}
