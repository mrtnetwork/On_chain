import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexAuctionHouseAuctioneerPublicBuyLayout
    extends MetaplexAuctionHouseProgramLayout {
  final int tradeStateBump;
  final int escrowPaymentBump;
  final BigInt buyerPrice;
  final BigInt tokenSize;
  const MetaplexAuctionHouseAuctioneerPublicBuyLayout(
      {required this.tradeStateBump,
      required this.escrowPaymentBump,
      required this.buyerPrice,
      required this.tokenSize});

  factory MetaplexAuctionHouseAuctioneerPublicBuyLayout.fromBuffer(
      List<int> data) {
    final decode = MetaplexAuctionHouseProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexAuctionHouseProgramInstruction
            .auctioneerPublicBuy.insturction);
    return MetaplexAuctionHouseAuctioneerPublicBuyLayout(
      tradeStateBump: decode["tradeStateBump"],
      escrowPaymentBump: decode["escrowPaymentBump"],
      buyerPrice: decode["buyerPrice"],
      tokenSize: decode["tokenSize"],
    );
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u8("tradeStateBump"),
    LayoutUtils.u8("escrowPaymentBump"),
    LayoutUtils.u64("buyerPrice"),
    LayoutUtils.u64("tokenSize"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexAuctionHouseProgramInstruction.auctioneerPublicBuy.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "tradeStateBump": tradeStateBump,
      "escrowPaymentBump": escrowPaymentBump,
      "buyerPrice": buyerPrice,
      "tokenSize": tokenSize,
    };
  }
}
