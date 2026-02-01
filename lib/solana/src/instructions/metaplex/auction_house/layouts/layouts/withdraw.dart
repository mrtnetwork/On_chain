import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexAuctionHouseWithdrawLayout
    extends MetaplexAuctionHouseProgramLayout {
  final BigInt amount;
  final int escrowPaymentBump;
  const MetaplexAuctionHouseWithdrawLayout(
      {required this.amount, required this.escrowPaymentBump});

  factory MetaplexAuctionHouseWithdrawLayout.fromBuffer(List<int> data) {
    final decode = MetaplexAuctionHouseProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexAuctionHouseProgramInstruction.withdraw.insturction);
    return MetaplexAuctionHouseWithdrawLayout(
        amount: decode['amount'],
        escrowPaymentBump: decode['escrowPaymentBump']);
  }

  static StructLayout get _layout => LayoutConst.struct([
        LayoutConst.blob(8, property: 'instruction'),
        LayoutConst.u8(property: 'escrowPaymentBump'),
        LayoutConst.u64(property: 'amount'),
      ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexAuctionHouseProgramInstruction get instruction =>
      MetaplexAuctionHouseProgramInstruction.withdraw;

  @override
  Map<String, dynamic> serialize() {
    return {'escrowPaymentBump': escrowPaymentBump, 'amount': amount};
  }
}
