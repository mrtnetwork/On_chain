import 'package:on_chain/solana/src/instructions/metaplex/hydra/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexHydraRemoveMemberLayout extends MetaplexHydraProgramLayout {
  const MetaplexHydraRemoveMemberLayout();

  factory MetaplexHydraRemoveMemberLayout.fromBuffer(List<int> data) {
    MetaplexHydraProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexHydraProgramInstruction.processRemoveMember.insturction);
    return MetaplexHydraRemoveMemberLayout();
  }

  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.blob(8, property: "instruction")]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexHydraProgramInstruction.processRemoveMember.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
