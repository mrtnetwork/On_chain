import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

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

  /// StructLayout layout definition.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "instruction"),
    LayoutConst.u8(property: "tradeStateBump"),
    LayoutConst.u8(property: "freeTradeStateBump"),
    LayoutConst.u8(property: "programAsSignerBump"),
    LayoutConst.u64(property: "tokenSize"),
  ]);

  @override
  StructLayout get layout => _layout;

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
