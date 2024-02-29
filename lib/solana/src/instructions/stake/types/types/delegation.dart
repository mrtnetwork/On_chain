import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class StakeDelegation extends LayoutSerializable {
  final SolAddress voterPubkey;
  final BigInt stake;
  final BigInt activationEpoch;
  final BigInt deactivationEpoch;
  final double warmupCooldownRate;

  const StakeDelegation(
      {required this.voterPubkey,
      required this.stake,
      required this.activationEpoch,
      required this.deactivationEpoch,
      required this.warmupCooldownRate});
  factory StakeDelegation.fromJson(Map<String, dynamic> json) {
    return StakeDelegation(
        voterPubkey: json["voterPubkey"],
        stake: json["stake"],
        activationEpoch: json["activationEpoch"],
        deactivationEpoch: json["deactivationEpoch"],
        warmupCooldownRate: json["warmupCooldownRate"]);
  }

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.publicKey("voterPubkey"),
    LayoutUtils.u64("stake"),
    LayoutUtils.u64("activationEpoch"),
    LayoutUtils.u64("deactivationEpoch"),
    LayoutUtils.f64("warmupCooldownRate")
  ], "delegation");

  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "voterPubkey": voterPubkey,
      "stake": stake,
      "activationEpoch": activationEpoch,
      "deactivationEpoch": deactivationEpoch,
      "warmupCooldownRate": warmupCooldownRate
    };
  }

  @override
  String toString() {
    return "StakeDelegation${serialize()}";
  }
}
