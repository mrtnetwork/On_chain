import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

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

  /// StructLayout layout definition.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "instruction"),
    LayoutConst.u8(property: "escrowPaymentBump"),
    LayoutConst.u8(property: "freeTradeStateBump"),
    LayoutConst.u8(property: "programAsSignerBump"),
    LayoutConst.u64(property: "buyerPrice"),
    LayoutConst.u64(property: "tokenSize"),
    LayoutConst.optional(LayoutConst.u64(), property: "partialOrderSize"),
    LayoutConst.optional(LayoutConst.u64(), property: "partialOrderPrice")
  ]);

  @override
  StructLayout get layout => _layout;

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
