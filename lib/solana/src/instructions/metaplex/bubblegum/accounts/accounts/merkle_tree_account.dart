import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/types/types.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static final headerLayout = LayoutUtils.struct([
    LayoutUtils.u8("discriminator"),
    LayoutUtils.wrap(ConcurrentMerkleTreeHeader.staticLayout,
        property: "treeHeader")
  ]);
  static Structure layout(
          {required int maxBufferSize, required int maxDepth}) =>
      LayoutUtils.struct([
        LayoutUtils.u8("discriminator"),
        LayoutUtils.wrap(ConcurrentMerkleTreeHeader.staticLayout,
            property: "treeHeader"),
        LayoutUtils.wrap(
            ConcurrentMerkleTree.staticLayout(
                maxBufferSize: maxBufferSize, maxDepth: maxDepth),
            property: "tree"),
        LayoutUtils.greedyArray(LayoutUtils.publicKey(), property: "canopy"),
      ]);
}

class MerkleTree extends LayoutSerializable {
  final CompressionAccountType accountType;
  final ConcurrentMerkleTreeHeader treeHeader;
  final ConcurrentMerkleTree tree;
  final List<SolAddress> canopy;
  MerkleTree(
      {required this.accountType,
      required this.treeHeader,
      required this.tree,
      required List<SolAddress> canopy})
      : canopy = List<SolAddress>.unmodifiable(canopy);
  factory MerkleTree.fromBuffer(List<int> data) {
    final decodeheader =
        LayoutSerializable.decode(bytes: data, layout: _Utils.headerLayout);
    final accountType =
        CompressionAccountType.fromValue(decodeheader["discriminator"]);
    final header =
        ConcurrentMerkleTreeHeader.fromJson(decodeheader["treeHeader"]);
    final decode = LayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout(
            maxBufferSize: header.field.maxBufferSize,
            maxDepth: header.field.maxDepth));
    return MerkleTree(
        accountType: accountType,
        treeHeader: header,
        tree: ConcurrentMerkleTree.fromJson(decode["tree"]),
        canopy: (decode["canopy"] as List).cast());
  }

  @override
  Structure get layout => _Utils.layout(
      maxBufferSize: treeHeader.field.maxBufferSize,
      maxDepth: treeHeader.field.maxDepth);

  @override
  Map<String, dynamic> serialize() {
    return {
      "discriminator": accountType.value,
      "treeHeader": treeHeader.serialize(),
      "tree": tree.serialize(),
      "canopy": canopy
    };
  }

  @override
  String toString() {
    return "MerkleTree${serialize()}";
  }
}
