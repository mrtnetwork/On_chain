import 'package:on_chain/solana/src/instructions/metaplex/auctioneer/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

/// auctioneer withdraw layout.
class MetaplexAuctioneerWithdrawLayout extends MetaplexAuctioneerProgramLayout {
  final int escrowPaymentBump;
  final int auctioneerAuthorityBump;
  final BigInt amount;
  const MetaplexAuctioneerWithdrawLayout(
      {required this.escrowPaymentBump,
      required this.auctioneerAuthorityBump,
      required this.amount});

  /// Constructs the layout from raw bytes.
  factory MetaplexAuctioneerWithdrawLayout.fromBuffer(List<int> data) {
    final decode = MetaplexAuctioneerProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexAuctioneerProgramInstruction.withdraw.insturction);
    return MetaplexAuctioneerWithdrawLayout(
        escrowPaymentBump: decode['escrowPaymentBump'],
        auctioneerAuthorityBump: decode['auctioneerAuthorityBump'],
        amount: decode['amount']);
  }

  /// StructLayout layout definition.
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
      MetaplexAuctioneerProgramInstruction.withdraw;

  @override
  Map<String, dynamic> serialize() {
    return {
      'escrowPaymentBump': escrowPaymentBump,
      'auctioneerAuthorityBump': auctioneerAuthorityBump,
      'amount': amount
    };
  }
}
