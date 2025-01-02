import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/gumdrop/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class MetaplexGumdropNewDistributorLayout extends MetaplexGumdropProgramLayout {
  final int bump;
  final SolAddress temporal;
  final List<int> root;
  MetaplexGumdropNewDistributorLayout(
      {required this.bump, required this.temporal, required List<int> root})
      : root = List<int>.unmodifiable(root);

  factory MetaplexGumdropNewDistributorLayout.fromBuffer(List<int> data) {
    final decode = MetaplexGumdropProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexGumdropProgramInstruction.newDistributor.insturction);
    return MetaplexGumdropNewDistributorLayout(
        bump: decode['bump'],
        temporal: decode['temporal'],
        root: decode['root']);
  }

  /// StructLayout layout definition.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: 'instruction'),
    LayoutConst.u8(property: 'bump'),
    LayoutConst.blob(32, property: 'root'),
    SolanaLayoutUtils.publicKey('temporal'),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexGumdropProgramInstruction get instruction =>
      MetaplexGumdropProgramInstruction.newDistributor;

  @override
  Map<String, dynamic> serialize() {
    return {'bump': bump, 'root': root, 'temporal': temporal};
  }
}
