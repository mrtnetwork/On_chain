import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

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
