import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaplexTokenMetaDataUtilizeLayout
    extends MetaplexTokenMetaDataProgramLayout {
  final BigInt numberOfUses;
  const MetaplexTokenMetaDataUtilizeLayout({required this.numberOfUses});

  factory MetaplexTokenMetaDataUtilizeLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexTokenMetaDataProgramInstruction.utilize.insturction);
    return MetaplexTokenMetaDataUtilizeLayout(
        numberOfUses: decode["numberOfUses"]);
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
    LayoutConst.u64(property: "numberOfUses")
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexTokenMetaDataProgramInstruction get instruction =>
      MetaplexTokenMetaDataProgramInstruction.utilize;

  @override
  Map<String, dynamic> serialize() {
    return {"numberOfUses": numberOfUses};
  }
}
