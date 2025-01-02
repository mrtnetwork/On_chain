import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexAuctionHouseAuctioneerWithdrawLayout
    extends MetaplexAuctionHouseProgramLayout {
  final int escrowPaymentBump;
  final BigInt amount;
  const MetaplexAuctionHouseAuctioneerWithdrawLayout(
      {required this.escrowPaymentBump, required this.amount});

  /// Constructs the layout from raw bytes.
  factory MetaplexAuctionHouseAuctioneerWithdrawLayout.fromBuffer(
      List<int> data) {
    final decode = MetaplexAuctionHouseProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexAuctionHouseProgramInstruction
            .auctioneerWithdraw.insturction);
    return MetaplexAuctionHouseAuctioneerWithdrawLayout(
        escrowPaymentBump: decode['escrowPaymentBump'],
        amount: decode['amount']);
  }

  /// StructLayout layout definition.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: 'instruction'),
    LayoutConst.u8(property: 'escrowPaymentBump'),
    LayoutConst.u64(property: 'amount'),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexAuctionHouseProgramInstruction get instruction =>
      MetaplexAuctionHouseProgramInstruction.auctioneerWithdraw;

  @override
  Map<String, dynamic> serialize() {
    return {'escrowPaymentBump': escrowPaymentBump, 'amount': amount};
  }
}
