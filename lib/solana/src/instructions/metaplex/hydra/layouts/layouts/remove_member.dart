import 'package:on_chain/solana/src/instructions/metaplex/hydra/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/encoding/encoding.dart';

class MetaplexHydraRemoveMemberLayout extends MetaplexHydraProgramLayout {
  const MetaplexHydraRemoveMemberLayout();

  factory MetaplexHydraRemoveMemberLayout.fromBuffer(List<int> data) {
    MetaplexHydraProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: data,
      instruction:
          MetaplexHydraProgramInstruction.processRemoveMember.instruction,
    );
    return const MetaplexHydraRemoveMemberLayout();
  }

  static StructLayout get _layout =>
      LayoutConst.struct([LayoutConst.blob(8, property: 'instruction')]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexHydraProgramInstruction get instruction =>
      MetaplexHydraProgramInstruction.processRemoveMember;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
