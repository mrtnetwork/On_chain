import 'package:on_chain/solana/src/instructions/stake/types/types/authorized.dart';
import 'package:on_chain/solana/src/instructions/stake/types/types/lockup.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class StakeMeta extends LayoutSerializable {
  final StakeLockup lockup;
  final StakeAuthorized authorized;
  final BigInt rentExemptReserve;
  const StakeMeta(
      {required this.lockup,
      required this.authorized,
      required this.rentExemptReserve});
  factory StakeMeta.fromJson(Map<String, dynamic> json) {
    return StakeMeta(
        lockup: StakeLockup.fromJson(json["lockup"]),
        authorized: StakeAuthorized.fromJson(json["authorized"]),
        rentExemptReserve: json["rentExemptReserve"]);
  }

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.u64("rentExemptReserve"),
    StakeAuthorized.staticLayout,
    StakeLockup.staticLayout,
  ], "meta");

  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "rentExemptReserve": rentExemptReserve,
      "authorized": authorized.serialize(),
      "lockup": lockup.serialize()
    };
  }

  @override
  String toString() {
    return "StakeMeta${serialize()}";
  }
}
