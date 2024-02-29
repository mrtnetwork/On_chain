import 'package:on_chain/solana/src/instructions/metaplex/hydra/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexHydraSignMetadataLayout extends MetaplexHydraProgramLayout {
  const MetaplexHydraSignMetadataLayout();

  factory MetaplexHydraSignMetadataLayout.fromBuffer(List<int> data) {
    MetaplexHydraProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexHydraProgramInstruction.processSignMetadata.insturction);
    return MetaplexHydraSignMetadataLayout();
  }

  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.blob(8, property: "instruction")]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexHydraProgramInstruction.processSignMetadata.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
