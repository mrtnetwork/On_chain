import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexAuctionHouseAuctioneerExecutePartialSaleLayout
    extends MetaplexAuctionHouseProgramLayout {
  final int escrowPaymentBump;
  final int freeTradeStateBump;
  final int programAsSignerBump;
  final BigInt buyerPrice;
  final BigInt tokenSize;
  final BigInt? partialOrderSize;
  final BigInt? partialOrderPrice;
  const MetaplexAuctionHouseAuctioneerExecutePartialSaleLayout(
      {required this.escrowPaymentBump,
      required this.freeTradeStateBump,
      required this.programAsSignerBump,
      required this.buyerPrice,
      required this.tokenSize,
      this.partialOrderSize,
      this.partialOrderPrice});

  factory MetaplexAuctionHouseAuctioneerExecutePartialSaleLayout.fromBuffer(
      List<int> data) {
    final decode = MetaplexAuctionHouseProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexAuctionHouseProgramInstruction
            .auctioneerExecutePartialSale.insturction);
    return MetaplexAuctionHouseAuctioneerExecutePartialSaleLayout(
        escrowPaymentBump: decode["escrowPaymentBump"],
        freeTradeStateBump: decode["freeTradeStateBump"],
        programAsSignerBump: decode["programAsSignerBump"],
        buyerPrice: decode["buyerPrice"],
        tokenSize: decode["tokenSize"],
        partialOrderPrice: decode["partialOrderPrice"],
        partialOrderSize: decode["partialOrderSize"]);
  }

  /// Structure layout definition.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u8("escrowPaymentBump"),
    LayoutUtils.u8("freeTradeStateBump"),
    LayoutUtils.u8("programAsSignerBump"),
    LayoutUtils.u64("buyerPrice"),
    LayoutUtils.u64("tokenSize"),
    LayoutUtils.optional(LayoutUtils.u64(), property: "partialOrderSize"),
    LayoutUtils.optional(LayoutUtils.u64(), property: "partialOrderPrice")
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction => MetaplexAuctionHouseProgramInstruction
      .auctioneerExecutePartialSale.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "escrowPaymentBump": escrowPaymentBump,
      "freeTradeStateBump": freeTradeStateBump,
      "programAsSignerBump": programAsSignerBump,
      "buyerPrice": buyerPrice,
      "tokenSize": tokenSize,
      "partialOrderSize": partialOrderSize,
      "partialOrderPrice": partialOrderPrice,
    };
  }
}
