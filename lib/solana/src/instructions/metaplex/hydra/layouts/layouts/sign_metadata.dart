import 'package:on_chain/solana/src/instructions/metaplex/hydra/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexHydraSignMetadataLayout extends MetaplexHydraProgramLayout {
  const MetaplexHydraSignMetadataLayout();

  factory MetaplexHydraSignMetadataLayout.fromBuffer(List<int> data) {
    MetaplexHydraProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexHydraProgramInstruction.processSignMetadata.insturction);
    return const MetaplexHydraSignMetadataLayout();
  }

  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.blob(8, property: "instruction")]);

  @override
  StructLayout get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexHydraProgramInstruction.processSignMetadata.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
