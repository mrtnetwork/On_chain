import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaplexTokenMetaDataUnverifyCollectionLayout
    extends MetaplexTokenMetaDataProgramLayout {
  const MetaplexTokenMetaDataUnverifyCollectionLayout();

  factory MetaplexTokenMetaDataUnverifyCollectionLayout.fromBuffer(
      List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .unverifyCollection.insturction);
    return const MetaplexTokenMetaDataUnverifyCollectionLayout();
  }

  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.u8(property: 'instruction')]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexTokenMetaDataProgramInstruction get instruction =>
      MetaplexTokenMetaDataProgramInstruction.unverifyCollection;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
