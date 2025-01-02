import 'package:on_chain/solana/src/instructions/metaplex/auctioneer/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

/// auctioneer deposit layout
class MetaplexAuctioneerDepositLayout extends MetaplexAuctioneerProgramLayout {
  final int escrowPaymentBump;
  final int auctioneerAuthorityBump;
  final BigInt amount;
  const MetaplexAuctioneerDepositLayout(
      {required this.escrowPaymentBump,
      required this.auctioneerAuthorityBump,
      required this.amount});

  factory MetaplexAuctioneerDepositLayout.fromBuffer(List<int> data) {
    final decode = MetaplexAuctioneerProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexAuctioneerProgramInstruction.deposit.insturction);
    return MetaplexAuctioneerDepositLayout(
        amount: decode['amount'],
        auctioneerAuthorityBump: decode['auctioneerAuthorityBump'],
        escrowPaymentBump: decode['escrowPaymentBump']);
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: 'instruction'),
    LayoutConst.u8(property: 'escrowPaymentBump'),
    LayoutConst.u8(property: 'auctioneerAuthorityBump'),
    LayoutConst.u64(property: 'amount'),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexAuctioneerProgramInstruction get instruction =>
      MetaplexAuctioneerProgramInstruction.deposit;

  @override
  Map<String, dynamic> serialize() {
    return {
      'escrowPaymentBump': escrowPaymentBump,
      'auctioneerAuthorityBump': auctioneerAuthorityBump,
      'amount': amount
    };
  }
}
