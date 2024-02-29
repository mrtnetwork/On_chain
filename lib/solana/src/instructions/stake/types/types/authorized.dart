import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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

  static final Structure staticLayout = LayoutUtils.struct(
      [LayoutUtils.publicKey("staker"), LayoutUtils.publicKey("withdrawer")],
      "authorized");

  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {"withdrawer": withdrawer, "staker": staker};
  }

  @override
  String toString() {
    return "StakeAuthorized${serialize()}";
  }
}
