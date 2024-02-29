import 'package:on_chain/solana/src/layout/layout.dart';

class EpochCredits extends LayoutSerializable {
  final BigInt epoch;
  final BigInt credits;
  final BigInt prevCredits;
  const EpochCredits(
      {required this.epoch, required this.credits, required this.prevCredits});
  factory EpochCredits.fromJson(Map<String, dynamic> json) {
    return EpochCredits(
        epoch: json["epoch"],
        credits: json["credits"],
        prevCredits: json["prevCredits"]);
  }

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.u64("epoch"),
    LayoutUtils.u64("credits"),
    LayoutUtils.u64("prevCredits"),
  ], "epochCredits");
  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {"epoch": epoch, "credits": credits, "prevCredits": prevCredits};
  }

  @override
  String toString() {
    return "EpochCredits.${serialize()}";
  }
}
