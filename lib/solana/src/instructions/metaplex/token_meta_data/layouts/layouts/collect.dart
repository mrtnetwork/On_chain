import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/encoding/encoding.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaplexTokenMetaDataCollectLayout
    extends MetaplexTokenMetaDataProgramLayout {
  const MetaplexTokenMetaDataCollectLayout();

  factory MetaplexTokenMetaDataCollectLayout.fromBuffer(List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: data,
      instruction: MetaplexTokenMetaDataProgramInstruction.collect.instruction,
    );
    return const MetaplexTokenMetaDataCollectLayout();
  }

  static StructLayout get _layout =>
      LayoutConst.struct([LayoutConst.u8(property: 'instruction')]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexTokenMetaDataProgramInstruction get instruction =>
      MetaplexTokenMetaDataProgramInstruction.collect;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
