import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

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

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
    LayoutConst.u64(property: "amount")
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexTokenMetaDataProgramInstruction get instruction =>
      MetaplexTokenMetaDataProgramInstruction.transferOutOfEscrow;

  @override
  Map<String, dynamic> serialize() {
    return {"amount": amount};
  }
}
