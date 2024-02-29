import 'package:on_chain/solana/src/layout/layout.dart';

class BlockTimestamp extends LayoutSerializable {
  final BigInt slot;
  final BigInt timestamp;
  const BlockTimestamp({required this.slot, required this.timestamp});
  factory BlockTimestamp.fromJson(Map<String, dynamic> json) {
    return BlockTimestamp(slot: json["slot"], timestamp: json["timestamp"]);
  }

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.u64("slot"),
    LayoutUtils.i64("timestamp"),
  ], "blockTimestamp");
  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {"slot": slot, "timestamp": timestamp};
  }

  @override
  String toString() {
    return "BlockTimestamp${serialize()}";
  }
}
