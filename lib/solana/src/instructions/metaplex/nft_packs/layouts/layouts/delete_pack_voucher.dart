import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexNFTPacksDeletePackVoucherLayout
    extends MetaplexNFTPacksProgramLayout {
  const MetaplexNFTPacksDeletePackVoucherLayout();

  factory MetaplexNFTPacksDeletePackVoucherLayout.fromBuffer(List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexNFTPacksProgramInstruction.deletePackVoucher.insturction);
    return MetaplexNFTPacksDeletePackVoucherLayout();
  }

  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u8("instruction")]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      MetaplexNFTPacksProgramInstruction.deletePackVoucher.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
