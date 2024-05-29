import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

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

  static final StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.i64(property: "timestamp"),
    LayoutConst.u64(property: "epoch"),
    SolanaLayoutUtils.publicKey("custodian")
  ], property: "lockup");

  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {"timestamp": timestamp, "epoch": epoch, "custodian": custodian};
  }

  @override
  String toString() {
    return "StakeLockup${serialize()}";
  }
}
