import 'package:on_chain/solana/src/instructions/stake/types/types/delegation.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class StakeStake extends LayoutSerializable {
  final StakeDelegation delegation;
  final BigInt creditsObserved;

  const StakeStake({required this.delegation, required this.creditsObserved});
  factory StakeStake.fromJson(Map<String, dynamic> json) {
    return StakeStake(
        delegation: StakeDelegation.fromJson(json["delegation"]),
        creditsObserved: json["creditsObserved"]);
  }

  static final Structure staticLayout = LayoutUtils.struct([
    StakeDelegation.staticLayout,
    LayoutUtils.u64("creditsObserved"),
  ], "stake");

  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "delegation": delegation.serialize(),
      "creditsObserved": creditsObserved
    };
  }

  @override
  String toString() {
    return "StakeStake${serialize()}";
  }
}
