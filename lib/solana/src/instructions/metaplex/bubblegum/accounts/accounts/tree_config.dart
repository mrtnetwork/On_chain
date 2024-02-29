import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/types/types.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static const List<int> discriminator = [122, 245, 175, 248, 171, 34, 0, 207];
  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "discriminator"),
    LayoutUtils.publicKey("treeCreator"),
    LayoutUtils.publicKey("treeDelegate"),
    LayoutUtils.u64("totalMintCapacity"),
    LayoutUtils.u64("numMinted"),
    LayoutUtils.boolean(property: "isPublic"),
    LayoutUtils.u8("isDecompressible"),
  ]);
}

class TreeConfig extends LayoutSerializable {
  final SolAddress treeCreator;
  final SolAddress treeDelegate;
  final BigInt totalMintCapacity;
  final BigInt numMinted;
  final bool isPublic;
  final DecompressibleState isDecompressible;
  const TreeConfig(
      {required this.treeCreator,
      required this.treeDelegate,
      required this.totalMintCapacity,
      required this.numMinted,
      required this.isPublic,
      required this.isDecompressible});
  factory TreeConfig.fromBuffer(List<int> data) {
    final decode = LayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {"discriminator": _Utils.discriminator});
    return TreeConfig(
        treeCreator: decode["treeCreator"],
        treeDelegate: decode["treeDelegate"],
        totalMintCapacity: decode["totalMintCapacity"],
        numMinted: decode["numMinted"],
        isPublic: decode["isPublic"],
        isDecompressible:
            DecompressibleState.fromValue(decode["isDecompressible"]));
  }

  @override
  Structure get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "discriminator": _Utils.discriminator,
      "treeCreator": treeCreator,
      "treeDelegate": treeDelegate,
      "totalMintCapacity": totalMintCapacity,
      "numMinted": numMinted,
      "isPublic": isPublic,
      "isDecompressible": isDecompressible.value
    };
  }

  @override
  String toString() {
    return "TreeConfig${serialize()}";
  }
}
