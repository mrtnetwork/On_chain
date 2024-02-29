import 'package:on_chain/solana/src/instructions/stake/types/types.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static Structure layout = LayoutUtils.struct([
    LayoutUtils.rustEnum([
      LayoutUtils.none("Uninitialized"),
      LayoutUtils.struct([
        StakeMeta.staticLayout,
      ], "Initialized"),
      LayoutUtils.struct([
        StakeMeta.staticLayout,
        StakeStake.staticLayout,
        LayoutUtils.u8("stakeFlags")
      ], "Stake"),
      LayoutUtils.none("Uninitialized")
    ], LayoutUtils.u32(), property: "stakeAccount")
  ]);
}

class StakeAccount extends LayoutSerializable {
  final String name;
  final StakeMeta? meta;
  final StakeStake? stake;
  final int? stakeFlags;
  const StakeAccount._(this.name, this.meta, this.stake, this.stakeFlags);
  static const StakeAccount uninitialized =
      StakeAccount._("Uninitialized", null, null, null);
  static const StakeAccount rewardsPool =
      StakeAccount._("RewardsPool", null, null, null);
  factory StakeAccount.initialized({required StakeMeta meta}) {
    return StakeAccount._("Initialized", meta, null, null);
  }
  factory StakeAccount.stake(
      {required StakeMeta meta, required StakeStake stake, int? stakeFlags}) {
    return StakeAccount._("Stake", meta, stake, stakeFlags);
  }
  factory StakeAccount.fromJson(Map<String, dynamic> json) {
    final key = json["stakeAccount"]["key"];
    final Map<String, dynamic> value = json["stakeAccount"]["value"] ?? {};
    switch (key) {
      case "Uninitialized":
        return uninitialized;
      case "RewardsPool":
        return rewardsPool;
      case "Initialized":
        return StakeAccount.initialized(
            meta: StakeMeta.fromJson(value["meta"]));
      default:
        return StakeAccount.stake(
            meta: StakeMeta.fromJson(value["meta"]),
            stake: StakeStake.fromJson(value["stake"]),
            stakeFlags: value["stakeFlags"]);
    }
  }
  factory StakeAccount.fromBuffer(List<int> bytes) {
    final decode = _Utils.layout.decode(bytes);
    return StakeAccount.fromJson(decode);
  }

  @override
  Map<String, dynamic> serialize() {
    return {
      "stakeAccount": {
        name: {
          "meta": meta?.serialize(),
          "stake": stake?.serialize(),
          "stakeFlags": stakeFlags
        }
      }
    };
  }

  @override
  Structure get layout => _Utils.layout;

  @override
  String toString() {
    return "StakeAccount${serialize()}";
  }
}
