import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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

  /// Structure layout definition.
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
      MetaplexAuctionHouseProgramInstruction.auctioneerBuy.insturction;

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
