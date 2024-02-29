import 'package:on_chain/solana/src/layout/layout.dart';

/// Fee rate as a ratio, minted on [UpdateStakePoolBalance] as a proportion of
/// the rewards
/// If either the numerator or the denominator is 0, the fee is considered to be
/// 0
class StakePoolFee extends LayoutSerializable {
  /// denominator of the fee ratio
  final BigInt denominator;

  /// numerator of the fee ratio
  final BigInt numerator;
  const StakePoolFee({required this.denominator, required this.numerator});
  factory StakePoolFee.fromJson(Map<String, dynamic> json) {
    return StakePoolFee(
        denominator: json["denominator"], numerator: json["numerator"]);
  }

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.u64("denominator"),
    LayoutUtils.u64("numerator"),
  ], "fee");

  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {"denominator": denominator, "numerator": numerator};
  }

  @override
  String toString() {
    return "StakePoolFee${serialize()}";
  }
}
