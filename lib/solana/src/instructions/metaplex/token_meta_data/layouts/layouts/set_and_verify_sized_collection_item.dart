import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaplexTokenMetaDataSetAndVerifySizedCollectionItemLayout
    extends MetaplexTokenMetaDataProgramLayout {
  const MetaplexTokenMetaDataSetAndVerifySizedCollectionItemLayout();

  factory MetaplexTokenMetaDataSetAndVerifySizedCollectionItemLayout.fromBuffer(
      List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .setAndVerifySizedCollectionItem.insturction);
    return const MetaplexTokenMetaDataSetAndVerifySizedCollectionItemLayout();
  }

  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.u8(property: "instruction")]);

  @override
  StructLayout get layout => _layout;

  @override
  int get instruction => MetaplexTokenMetaDataProgramInstruction
      .setAndVerifySizedCollectionItem.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
