import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexAuctionHouseSellLayout extends MetaplexAuctionHouseProgramLayout {
  final int tradeStateBump;
  final int freeTradeStateBump;
  final int programAsSignerBump;
  final BigInt buyerPrice;
  final BigInt tokenSize;
  const MetaplexAuctionHouseSellLayout(
      {required this.tradeStateBump,
      required this.freeTradeStateBump,
      required this.programAsSignerBump,
      required this.buyerPrice,
      required this.tokenSize});

  factory MetaplexAuctionHouseSellLayout.fromBuffer(List<int> data) {
    final decode = MetaplexAuctionHouseProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexAuctionHouseProgramInstruction.sell.insturction);
    return MetaplexAuctionHouseSellLayout(
        tradeStateBump: decode["tradeStateBump"],
        freeTradeStateBump: decode["freeTradeStateBump"],
        programAsSignerBump: decode["programAsSignerBump"],
        buyerPrice: decode["buyerPrice"],
        tokenSize: decode["tokenSize"]);
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "instruction"),
    LayoutConst.u8(property: "tradeStateBump"),
    LayoutConst.u8(property: "freeTradeStateBump"),
    LayoutConst.u8(property: "programAsSignerBump"),
    LayoutConst.u64(property: "buyerPrice"),
    LayoutConst.u64(property: "tokenSize"),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexAuctionHouseProgramInstruction get instruction =>
      MetaplexAuctionHouseProgramInstruction.sell;

  @override
  Map<String, dynamic> serialize() {
    return {
      "tradeStateBump": tradeStateBump,
      "freeTradeStateBump": freeTradeStateBump,
      "programAsSignerBump": programAsSignerBump,
      "buyerPrice": buyerPrice,
      "tokenSize": tokenSize
    };
  }
}
