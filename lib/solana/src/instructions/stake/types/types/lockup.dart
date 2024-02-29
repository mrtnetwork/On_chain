import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Stake account lockup info
class StakeLockup extends LayoutSerializable {
  /// Unix timestamp of lockup expiration
  final BigInt timestamp;

  /// Epoch of lockup expiration
  final BigInt epoch;

  /// Lockup custodian authority
  final SolAddress custodian;
  const StakeLockup(
      {required this.timestamp, required this.epoch, required this.custodian});
  factory StakeLockup.fromJson(Map<String, dynamic> json) {
    return StakeLockup(
        timestamp: json["timestamp"],
        epoch: json["epoch"],
        custodian: json["custodian"]);
  }

  static final defaultLockup = StakeLockup(
    custodian: SolAddress.defaultPubKey,
    epoch: BigInt.zero,
    timestamp: BigInt.zero,
  );

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.i64("timestamp"),
    LayoutUtils.u64("epoch"),
    LayoutUtils.publicKey("custodian")
  ], "lockup");

  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {"timestamp": timestamp, "epoch": epoch, "custodian": custodian};
  }

  @override
  String toString() {
    return "StakeLockup${serialize()}";
  }
}
