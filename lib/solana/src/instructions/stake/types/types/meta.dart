import 'package:on_chain/solana/src/instructions/stake/types/types/authorized.dart';
import 'package:on_chain/solana/src/instructions/stake/types/types/lockup.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class StakeMeta extends BorshLayoutSerializable {
  final StakeLockup lockup;
  final StakeAuthorized authorized;
  final BigInt rentExemptReserve;
  const StakeMeta(
      {required this.lockup,
      required this.authorized,
      required this.rentExemptReserve});
  factory StakeMeta.fromJson(Map<String, dynamic> json) {
    return StakeMeta(
        lockup: StakeLockup.fromJson(json['lockup']),
        authorized: StakeAuthorized.fromJson(json['authorized']),
        rentExemptReserve: json['rentExemptReserve']);
  }

  static StructLayout get staticLayout => LayoutConst.struct([
        LayoutConst.u64(property: 'rentExemptReserve'),
        StakeAuthorized.staticLayout,
        StakeLockup.staticLayout,
      ], property: 'meta');

  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'rentExemptReserve': rentExemptReserve,
      'authorized': authorized.serialize(),
      'lockup': lockup.serialize()
    };
  }

  @override
  String toString() {
    return 'StakeMeta${serialize()}';
  }
}
