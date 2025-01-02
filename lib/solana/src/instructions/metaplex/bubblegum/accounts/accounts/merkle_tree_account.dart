import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/types/types.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static final headerLayout = LayoutConst.struct([
    LayoutConst.u8(property: 'discriminator'),
    LayoutConst.wrap(ConcurrentMerkleTreeHeader.staticLayout,
        property: 'treeHeader')
  ]);
  static StructLayout layout(
          {required int maxBufferSize, required int maxDepth}) =>
      LayoutConst.struct([
        LayoutConst.u8(property: 'discriminator'),
        LayoutConst.wrap(ConcurrentMerkleTreeHeader.staticLayout,
            property: 'treeHeader'),
        LayoutConst.wrap(
            ConcurrentMerkleTree.staticLayout(
                maxBufferSize: maxBufferSize, maxDepth: maxDepth),
            property: 'tree'),
        LayoutConst.greedyArray(SolanaLayoutUtils.publicKey(),
            property: 'canopy'),
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
        CompressionAccountType.fromValue(decodeheader['discriminator']);
    final header =
        ConcurrentMerkleTreeHeader.fromJson(decodeheader['treeHeader']);
    final decode = LayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout(
            maxBufferSize: header.field.maxBufferSize,
            maxDepth: header.field.maxDepth));
    return MerkleTree(
        accountType: accountType,
        treeHeader: header,
        tree: ConcurrentMerkleTree.fromJson(decode['tree']),
        canopy: (decode['canopy'] as List).cast());
  }

  @override
  StructLayout get layout => _Utils.layout(
      maxBufferSize: treeHeader.field.maxBufferSize,
      maxDepth: treeHeader.field.maxDepth);

  @override
  Map<String, dynamic> serialize() {
    return {
      'discriminator': accountType.value,
      'treeHeader': treeHeader.serialize(),
      'tree': tree.serialize(),
      'canopy': canopy
    };
  }

  @override
  String toString() {
    return 'MerkleTree${serialize()}';
  }
}
