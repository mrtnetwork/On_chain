import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

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

  static final StructLayout staticLayout = LayoutConst.struct([
    SolanaLayoutUtils.publicKey("voterPubkey"),
    LayoutConst.u64(property: "stake"),
    LayoutConst.u64(property: "activationEpoch"),
    LayoutConst.u64(property: "deactivationEpoch"),
    LayoutConst.f64(property: "warmupCooldownRate")
  ], property: "delegation");

  @override
  StructLayout get layout => staticLayout;

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
