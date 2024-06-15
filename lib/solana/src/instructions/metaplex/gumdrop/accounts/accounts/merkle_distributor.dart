import 'package:blockchain_utils/utils/utils.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static const List<int> discriminator = [77, 119, 139, 70, 84, 247, 12, 26];

  static final StructLayout layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "discriminator"),
    SolanaLayoutUtils.publicKey("base"),
    LayoutConst.u8(property: "bump"),
    LayoutConst.blob(32, property: "root"),
    SolanaLayoutUtils.publicKey("temporal"),
  ]);
}

class MerkleDistributor extends LayoutSerializable {
  static int get size => _Utils.layout.span;
  final SolAddress base;
  final int bump;
  final List<int> root;
  final SolAddress temporal;
  MerkleDistributor(
      {required this.base,
      required this.bump,
      required List<int> root,
      required this.temporal})
      : root = BytesUtils.toBytes(root, unmodifiable: true);
  factory MerkleDistributor.fromBuffer(List<int> data) {
    final decode = LayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {"discriminator": _Utils.discriminator});
    return MerkleDistributor(
        base: decode["base"],
        bump: decode["bump"],
        root: (decode["root"] as List).cast(),
        temporal: decode["temporal"]);
  }

  @override
  StructLayout get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "discriminator": _Utils.discriminator,
      "base": base,
      "bump": bump,
      "root": root,
      "temporal": temporal
    };
  }

  @override
  String toString() {
    return "MerkleDistributor${serialize()}";
  }
}
