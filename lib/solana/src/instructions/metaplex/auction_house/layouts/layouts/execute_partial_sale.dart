import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexAuctionHouseExecutePartialSaleLayout
    extends MetaplexAuctionHouseProgramLayout {
  final int escrowPaymentBump;
  final int freeTradeStateBump;
  final int programAsSignerBump;
  final BigInt buyerPrice;
  final BigInt tokenSize;
  final BigInt? partialOrderSize;
  final BigInt? partialOrderPrice;
  const MetaplexAuctionHouseExecutePartialSaleLayout(
      {required this.escrowPaymentBump,
      required this.freeTradeStateBump,
      required this.programAsSignerBump,
      required this.buyerPrice,
      required this.tokenSize,
      this.partialOrderSize,
      this.partialOrderPrice});

  /// Constructs the layout from raw bytes.
  factory MetaplexAuctionHouseExecutePartialSaleLayout.fromBuffer(
      List<int> data) {
    final decode = MetaplexAuctionHouseProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexAuctionHouseProgramInstruction
            .executePartialSale.insturction);
    return MetaplexAuctionHouseExecutePartialSaleLayout(
        escrowPaymentBump: decode["escrowPaymentBump"],
        freeTradeStateBump: decode["freeTradeStateBump"],
        programAsSignerBump: decode["programAsSignerBump"],
        buyerPrice: decode["buyerPrice"],
        tokenSize: decode["tokenSize"],
        partialOrderSize: decode["partialOrderSize"],
        partialOrderPrice: decode["partialOrderPrice"]);
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
  List<int> get instruction =>
      MetaplexAuctionHouseProgramInstruction.executePartialSale.insturction;

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
