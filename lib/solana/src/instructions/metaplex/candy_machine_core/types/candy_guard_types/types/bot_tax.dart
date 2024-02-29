import 'package:on_chain/solana/src/layout/layout.dart';

class BotTax extends LayoutSerializable {
  final BigInt lamports;
  final bool lastInstruction;

  const BotTax({required this.lamports, required this.lastInstruction});
  factory BotTax.fromJson(Map<String, dynamic> json) {
    return BotTax(
        lamports: json["lamports"], lastInstruction: json["lastInstruction"]);
  }

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.u64("lamports"),
    LayoutUtils.boolean(property: "lastInstruction")
  ], "botTax");

  @override
  Structure get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {"lastInstruction": lastInstruction, "lamports": lamports};
  }

  @override
  String toString() {
    return "BotTax${serialize()}";
  }
}
