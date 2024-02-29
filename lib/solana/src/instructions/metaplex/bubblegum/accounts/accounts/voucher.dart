import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/types/types/leaf_schame_record.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static const List<int> discriminator = [191, 204, 149, 234, 213, 165, 13, 65];
  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "discriminator"),
    LeafSchemaV1.staticLayout,
    LayoutUtils.u32("index"),
    LayoutUtils.publicKey("merkleTree"),
  ]);
}

class Voucher extends LayoutSerializable {
  final LeafSchemaV1 leafSchema;
  final int index;
  final SolAddress merkleTree;
  const Voucher(
      {required this.leafSchema,
      required this.index,
      required this.merkleTree});
  factory Voucher.fromBuffer(List<int> data) {
    final decode = LayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {"discriminator": _Utils.discriminator});
    return Voucher(
        leafSchema: LeafSchemaV1.fromJson(decode["leafschema"]),
        index: decode["index"],
        merkleTree: decode["merkleTree"]);
  }

  @override
  Structure get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "discriminator": _Utils.discriminator,
      "leafschema": leafSchema.serialize(),
      "merkleTree": merkleTree,
      "index": index
    };
  }

  @override
  String toString() {
    return "Voucher${serialize()}";
  }
}
