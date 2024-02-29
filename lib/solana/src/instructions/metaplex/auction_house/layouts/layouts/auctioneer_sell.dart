import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexAuctionHouseAuctioneerSellLayout
    extends MetaplexAuctionHouseProgramLayout {
  final int tradeStateBump;
  final int freeTradeStateBump;
  final int programAsSignerBump;
  final BigInt tokenSize;
  const MetaplexAuctionHouseAuctioneerSellLayout(
      {required this.tradeStateBump,
      required this.freeTradeStateBump,
      required this.programAsSignerBump,
      required this.tokenSize});

  /// Constructs the layout from raw bytes.
  factory MetaplexAuctionHouseAuctioneerSellLayout.fromBuffer(List<int> data) {
    final decode = MetaplexAuctionHouseProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexAuctionHouseProgramInstruction.auctioneerSell.insturction);
    return MetaplexAuctionHouseAuctioneerSellLayout(
      tradeStateBump: decode["tradeStateBump"],
      freeTradeStateBump: decode["freeTradeStateBump"],
      programAsSignerBump: decode["programAsSignerBump"],
      tokenSize: decode["tokenSize"],
    );
  }

  /// Structure layout definition.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u8("tradeStateBump"),
    LayoutUtils.u8("freeTradeStateBump"),
    LayoutUtils.u8("programAsSignerBump"),
    LayoutUtils.u64("tokenSize"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexAuctionHouseProgramInstruction.auctioneerSell.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "tradeStateBump": tradeStateBump,
      "freeTradeStateBump": freeTradeStateBump,
      "programAsSignerBump": programAsSignerBump,
      "tokenSize": tokenSize
    };
  }
}
