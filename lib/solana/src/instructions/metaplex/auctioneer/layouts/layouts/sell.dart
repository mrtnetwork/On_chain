import 'package:on_chain/solana/src/instructions/metaplex/auctioneer/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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

  /// Structure layout definition.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u8("tradeStateBump"),
    LayoutUtils.u8("freeTradeStateBump"),
    LayoutUtils.u8("programAsSignerBump"),
    LayoutUtils.u8("auctioneerAuthorityBump"),
    LayoutUtils.u64("tokenSize"),
    LayoutUtils.i64("startTime"),
    LayoutUtils.i64("endTime"),
    LayoutUtils.optional(LayoutUtils.u64(), property: "reservePrice"),
    LayoutUtils.optional(LayoutUtils.u64(), property: "minBidIncrement"),
    LayoutUtils.optional(LayoutUtils.u32(), property: "timeExtPeriod"),
    LayoutUtils.optional(LayoutUtils.u32(), property: "timeExtDelta"),
    LayoutUtils.optional(LayoutUtils.boolean(), property: "allowHighBidCancel"),
  ]);

  @override
  Structure get layout => _layout;

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
