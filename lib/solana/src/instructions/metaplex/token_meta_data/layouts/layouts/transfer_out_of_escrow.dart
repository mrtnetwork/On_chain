import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexTokenMetaDataTransferOutOfEscrowLayout
    extends MetaplexTokenMetaDataProgramLayout {
  final BigInt amount;
  const MetaplexTokenMetaDataTransferOutOfEscrowLayout({required this.amount});

  factory MetaplexTokenMetaDataTransferOutOfEscrowLayout.fromBuffer(
      List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .transferOutOfEscrow.insturction);
    return MetaplexTokenMetaDataTransferOutOfEscrowLayout(
        amount: decode["amount"]);
  }

  static final Structure _layout = LayoutUtils.struct(
      [LayoutUtils.u8("instruction"), LayoutUtils.u64("amount")]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      MetaplexTokenMetaDataProgramInstruction.transferOutOfEscrow.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"amount": amount};
  }
}
