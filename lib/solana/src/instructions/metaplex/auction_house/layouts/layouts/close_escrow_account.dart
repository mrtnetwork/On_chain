import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexAuctionHouseCloseEscrowAccountLayout
    extends MetaplexAuctionHouseProgramLayout {
  final int escrowPaymentBump;
  const MetaplexAuctionHouseCloseEscrowAccountLayout(
      {required this.escrowPaymentBump});

  /// Constructs the layout from raw bytes.
  factory MetaplexAuctionHouseCloseEscrowAccountLayout.fromBuffer(
      List<int> data) {
    final decode = MetaplexAuctionHouseProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexAuctionHouseProgramInstruction
            .closeEscrowAccount.insturction);
    return MetaplexAuctionHouseCloseEscrowAccountLayout(
        escrowPaymentBump: decode['escrowPaymentBump']);
  }

  /// StructLayout layout definition.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: 'instruction'),
    LayoutConst.u8(property: 'escrowPaymentBump'),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexAuctionHouseProgramInstruction get instruction =>
      MetaplexAuctionHouseProgramInstruction.closeEscrowAccount;

  @override
  Map<String, dynamic> serialize() {
    return {'escrowPaymentBump': escrowPaymentBump};
  }
}
