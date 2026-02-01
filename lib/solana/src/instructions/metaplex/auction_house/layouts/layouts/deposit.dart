import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexAuctionHouseDepositLayout
    extends MetaplexAuctionHouseProgramLayout {
  final int escrowPaymentBump;
  final BigInt amount;
  const MetaplexAuctionHouseDepositLayout(
      {required this.escrowPaymentBump, required this.amount});

  /// Constructs the layout from raw bytes.
  factory MetaplexAuctionHouseDepositLayout.fromBuffer(List<int> data) {
    final decode = MetaplexAuctionHouseProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexAuctionHouseProgramInstruction.deposit.insturction);
    return MetaplexAuctionHouseDepositLayout(
        amount: decode['amount'],
        escrowPaymentBump: decode['escrowPaymentBump']);
  }

  /// StructLayout layout definition.
  static StructLayout get _layout => LayoutConst.struct([
        LayoutConst.blob(8, property: 'instruction'),
        LayoutConst.u8(property: 'escrowPaymentBump'),
        LayoutConst.u64(property: 'amount'),
      ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexAuctionHouseProgramInstruction get instruction =>
      MetaplexAuctionHouseProgramInstruction.deposit;

  @override
  Map<String, dynamic> serialize() {
    return {'amount': amount, 'escrowPaymentBump': escrowPaymentBump};
  }
}
