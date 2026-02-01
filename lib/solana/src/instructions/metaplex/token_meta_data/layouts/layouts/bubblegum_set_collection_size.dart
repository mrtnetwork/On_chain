import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaplexTokenMetaDataBubblegumSetCollectionSizeLayout
    extends MetaplexTokenMetaDataProgramLayout {
  final BigInt size;
  const MetaplexTokenMetaDataBubblegumSetCollectionSizeLayout(
      {required this.size});

  factory MetaplexTokenMetaDataBubblegumSetCollectionSizeLayout.fromBuffer(
      List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .bubblegumSetCollectionSize.insturction);
    return MetaplexTokenMetaDataBubblegumSetCollectionSizeLayout(
        size: decode['size']);
  }

  static StructLayout get _layout => LayoutConst.struct([
        LayoutConst.u8(property: 'instruction'),
        LayoutConst.u64(property: 'size')
      ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexTokenMetaDataProgramInstruction get instruction =>
      MetaplexTokenMetaDataProgramInstruction.bubblegumSetCollectionSize;

  @override
  Map<String, dynamic> serialize() {
    return {'size': size};
  }
}
