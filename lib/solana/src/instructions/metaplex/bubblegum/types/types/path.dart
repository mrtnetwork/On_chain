import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class Path extends BorshLayoutSerializable {
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
        proof: (json['proof'] as List).cast(),
        index: json['index'],
        leaf: json['leaf'],
        padding: json['padding']);
  }
  static StructLayout staticLayout({required int maxDepth}) =>
      LayoutConst.struct([
        LayoutConst.array(SolanaLayoutUtils.publicKey(), maxDepth,
            property: 'proof'),
        SolanaLayoutUtils.publicKey('leaf'),
        LayoutConst.u32(property: 'index'),
        LayoutConst.u32(property: 'padding'),
      ], property: 'path');

  @override
  StructLayout get layout => staticLayout(maxDepth: proof.length);

  @override
  Map<String, dynamic> serialize() {
    return {'proof': proof, 'leaf': leaf, 'index': index, 'padding': padding};
  }

  @override
  String toString() {
    return 'Path${serialize()}';
  }
}
