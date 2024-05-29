import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

/// Stake account authority info
class StakeAuthorized extends LayoutSerializable {
  /// stake authority
  final SolAddress staker;

  /// withdraw authority
  final SolAddress withdrawer;
  const StakeAuthorized({required this.staker, required this.withdrawer});
  factory StakeAuthorized.fromJson(Map<String, dynamic> json) {
    return StakeAuthorized(
        staker: json["staker"], withdrawer: json["withdrawer"]);
  }

  static final StructLayout staticLayout = LayoutConst.struct([
    SolanaLayoutUtils.publicKey("staker"),
    SolanaLayoutUtils.publicKey("withdrawer")
  ], property: "authorized");

  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {"withdrawer": withdrawer, "staker": staker};
  }

  @override
  String toString() {
    return "StakeAuthorized${serialize()}";
  }
}
