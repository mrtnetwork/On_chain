import 'package:on_chain/solana/src/instructions/metaplex/auctioneer/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

/// auctioneer sell layout.
class MetaplexAuctioneerSellLayout extends MetaplexAuctioneerProgramLayout {
  final int tradeStateBump;
  final int freeTradeStateBump;
  final int programAsSignerBump;
  final int auctioneerAuthorityBump;
  final BigInt tokenSize;
  final BigInt startTime;
  final BigInt endTime;
  final BigInt? reservePrice;
  final BigInt? minBidIncrement;
  final int? timeExtPeriod;
  final int? timeExtDelta;
  final bool? allowHighBidCancel;
  const MetaplexAuctioneerSellLayout(
      {required this.tradeStateBump,
      required this.freeTradeStateBump,
      required this.programAsSignerBump,
      required this.auctioneerAuthorityBump,
      required this.tokenSize,
      required this.startTime,
      required this.endTime,
      this.reservePrice,
      this.minBidIncrement,
      this.timeExtPeriod,
      this.timeExtDelta,
      this.allowHighBidCancel});

  /// Constructs the layout from raw bytes.
  factory MetaplexAuctioneerSellLayout.fromBuffer(List<int> data) {
    final decode = MetaplexAuctioneerProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexAuctioneerProgramInstruction.sell.insturction);
    return MetaplexAuctioneerSellLayout(
        tradeStateBump: decode["tradeStateBump"],
        freeTradeStateBump: decode["freeTradeStateBump"],
        programAsSignerBump: decode["programAsSignerBump"],
        auctioneerAuthorityBump: decode["auctioneerAuthorityBump"],
        tokenSize: decode["tokenSize"],
        startTime: decode["startTime"],
        endTime: decode["endTime"],
        allowHighBidCancel: decode["allowHighBidCancel"],
        minBidIncrement: decode["minBidIncrement"],
        reservePrice: decode["reservePrice"],
        timeExtDelta: decode["timeExtDelta"],
        timeExtPeriod: decode["timeExtPeriod"]);
  }

  /// StructLayout layout definition.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "instruction"),
    LayoutConst.u8(property: "tradeStateBump"),
    LayoutConst.u8(property: "freeTradeStateBump"),
    LayoutConst.u8(property: "programAsSignerBump"),
    LayoutConst.u8(property: "auctioneerAuthorityBump"),
    LayoutConst.u64(property: "tokenSize"),
    LayoutConst.i64(property: "startTime"),
    LayoutConst.i64(property: "endTime"),
    LayoutConst.optional(LayoutConst.u64(), property: "reservePrice"),
    LayoutConst.optional(LayoutConst.u64(), property: "minBidIncrement"),
    LayoutConst.optional(LayoutConst.u32(), property: "timeExtPeriod"),
    LayoutConst.optional(LayoutConst.u32(), property: "timeExtDelta"),
    LayoutConst.optional(LayoutConst.boolean(), property: "allowHighBidCancel"),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexAuctioneerProgramInstruction.sell.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "tradeStateBump": tradeStateBump,
      "freeTradeStateBump": freeTradeStateBump,
      "programAsSignerBump": programAsSignerBump,
      "auctioneerAuthorityBump": auctioneerAuthorityBump,
      "tokenSize": tokenSize,
      "startTime": startTime,
      "endTime": endTime,
      "reservePrice": reservePrice,
      "minBidIncrement": minBidIncrement,
      "timeExtPeriod": timeExtPeriod,
      "timeExtDelta": timeExtDelta,
      "allowHighBidCancel": allowHighBidCancel
    };
  }
}
