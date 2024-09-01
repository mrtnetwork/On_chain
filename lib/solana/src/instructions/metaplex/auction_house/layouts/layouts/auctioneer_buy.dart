import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexAuctionHouseAuctioneerBuyLayout
    extends MetaplexAuctionHouseProgramLayout {
  final int tradeStateBump;
  final int escrowPaymentBump;
  final BigInt buyerPrice;
  final BigInt tokenSize;
  const MetaplexAuctionHouseAuctioneerBuyLayout(
      {required this.tradeStateBump,
      required this.escrowPaymentBump,
      required this.buyerPrice,
      required this.tokenSize});

  /// Constructs the layout from raw bytes.
  factory MetaplexAuctionHouseAuctioneerBuyLayout.fromBuffer(List<int> data) {
    final decode = MetaplexAuctionHouseProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexAuctionHouseProgramInstruction.auctioneerBuy.insturction);
    return MetaplexAuctionHouseAuctioneerBuyLayout(
        buyerPrice: decode["buyerPrice"],
        escrowPaymentBump: decode["escrowPaymentBump"],
        tokenSize: decode["tokenSize"],
        tradeStateBump: decode["tradeStateBump"]);
  }

  /// StructLayout layout definition.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "instruction"),
    LayoutConst.u8(property: "tradeStateBump"),
    LayoutConst.u8(property: "escrowPaymentBump"),
    LayoutConst.u64(property: "buyerPrice"),
    LayoutConst.u64(property: "tokenSize"),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexAuctionHouseProgramInstruction get instruction =>
      MetaplexAuctionHouseProgramInstruction.auctioneerBuy;

  @override
  Map<String, dynamic> serialize() {
    return {
      "tradeStateBump": tradeStateBump,
      "escrowPaymentBump": escrowPaymentBump,
      "buyerPrice": buyerPrice,
      "tokenSize": tokenSize
    };
  }
}
