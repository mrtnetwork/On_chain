import 'package:on_chain/solana/src/instructions/metaplex/auctioneer/types/types.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class _Utils {
  static const List<int> discriminator = [183, 196, 26, 41, 131, 46, 184, 115];

  static final StructLayout layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "discriminator"),
    LayoutConst.u8(property: "version"),
    LayoutConst.i64(property: "startTime"),
    LayoutConst.i64(property: "endTime"),
    Bid.staticLayout,
    LayoutConst.u8(property: "bump"),
    LayoutConst.u64(property: "reservePrice"),
    LayoutConst.u64(property: "minBidIncrement"),
    LayoutConst.u32(property: "timeExtPeriod"),
    LayoutConst.u32(property: "timeExtDelta"),
    LayoutConst.boolean(property: "allowHighBidCancel")
  ]);
}

class ListingConfig extends LayoutSerializable {
  static int get size => _Utils.layout.span;
  final BigInt startTime;
  final BigInt endTime;
  final Bid bid;
  final int bump;
  final BigInt reservePrice;
  final BigInt minBidIncrement;
  final int timeExtPeriod;
  final int timeExtDelta;
  final bool allowHighBidCancel;
  static const ListingConfigVersion version = ListingConfigVersion.v0;
  const ListingConfig(
      {required this.bump,
      required this.startTime,
      required this.endTime,
      required this.bid,
      required this.reservePrice,
      required this.minBidIncrement,
      required this.timeExtPeriod,
      required this.timeExtDelta,
      required this.allowHighBidCancel});
  factory ListingConfig.fromBuffer(List<int> data) {
    final decode = LayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {"discriminator": _Utils.discriminator});
    return ListingConfig(
        bump: decode["bump"],
        startTime: decode["startTime"],
        endTime: decode["endTime"],
        bid: Bid.fromJson(decode["highestBid"]),
        reservePrice: decode["reservePrice"],
        minBidIncrement: decode["minBidIncrement"],
        timeExtPeriod: decode["timeExtPeriod"],
        timeExtDelta: decode["timeExtDelta"],
        allowHighBidCancel: decode["allowHighBidCancel"]);
  }
  @override
  StructLayout get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "discriminator": _Utils.discriminator,
      "version": version.value,
      "startTime": startTime,
      "endTime": endTime,
      "highestBid": bid.serialize(),
      "bump": bump,
      "reservePrice": reservePrice,
      "minBidIncrement": minBidIncrement,
      "timeExtPeriod": timeExtPeriod,
      "timeExtDelta": timeExtDelta,
      "allowHighBidCancel": allowHighBidCancel
    };
  }

  @override
  String toString() {
    return "ListingConfig${serialize()}";
  }
}
