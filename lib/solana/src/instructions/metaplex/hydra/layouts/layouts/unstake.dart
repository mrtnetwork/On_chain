import 'package:on_chain/solana/src/instructions/metaplex/hydra/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexHydraUnstakeLayout extends MetaplexHydraProgramLayout {
  const MetaplexHydraUnstakeLayout();

  factory MetaplexHydraUnstakeLayout.fromBuffer(List<int> data) {
    MetaplexHydraProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexHydraProgramInstruction.processUnstake.insturction);
    return MetaplexHydraUnstakeLayout();
  }

  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.blob(8, property: "instruction")]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexHydraProgramInstruction.processUnstake.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
