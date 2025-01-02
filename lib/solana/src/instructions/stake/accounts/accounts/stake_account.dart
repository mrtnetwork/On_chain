import 'package:on_chain/solana/src/instructions/stake/types/types.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class _Utils {
  static StructLayout layout = LayoutConst.struct([
    LayoutConst.rustEnum([
      LayoutConst.none(property: 'Uninitialized'),
      LayoutConst.struct([
        StakeMeta.staticLayout,
      ], property: 'Initialized'),
      LayoutConst.struct([
        StakeMeta.staticLayout,
        StakeStake.staticLayout,
        LayoutConst.u8(property: 'stakeFlags')
      ], property: 'Stake'),
      LayoutConst.none(property: 'Uninitialized')
    ], discriminant: LayoutConst.u32(), property: 'stakeAccount')
  ]);
}

class StakeAccount extends LayoutSerializable {
  final String name;
  final StakeMeta? meta;
  final StakeStake? stake;
  final int? stakeFlags;
  const StakeAccount._(this.name, this.meta, this.stake, this.stakeFlags);
  static const StakeAccount uninitialized =
      StakeAccount._('Uninitialized', null, null, null);
  static const StakeAccount rewardsPool =
      StakeAccount._('RewardsPool', null, null, null);
  factory StakeAccount.initialized({required StakeMeta meta}) {
    return StakeAccount._('Initialized', meta, null, null);
  }
  factory StakeAccount.stake(
      {required StakeMeta meta, required StakeStake stake, int? stakeFlags}) {
    return StakeAccount._('Stake', meta, stake, stakeFlags);
  }
  factory StakeAccount.fromJson(Map<String, dynamic> json) {
    final key = json['stakeAccount']['key'];
    final Map<String, dynamic> value = json['stakeAccount']['value'] ?? {};
    switch (key) {
      case 'Uninitialized':
        return uninitialized;
      case 'RewardsPool':
        return rewardsPool;
      case 'Initialized':
        return StakeAccount.initialized(
            meta: StakeMeta.fromJson(value['meta']));
      default:
        return StakeAccount.stake(
            meta: StakeMeta.fromJson(value['meta']),
            stake: StakeStake.fromJson(value['stake']),
            stakeFlags: value['stakeFlags']);
    }
  }
  factory StakeAccount.fromBuffer(List<int> bytes) {
    final decode = _Utils.layout.deserialize(bytes).value;
    return StakeAccount.fromJson(decode);
  }

  @override
  Map<String, dynamic> serialize() {
    return {
      'stakeAccount': {
        name: {
          'meta': meta?.serialize(),
          'stake': stake?.serialize(),
          'stakeFlags': stakeFlags
        }
      }
    };
  }

  @override
  StructLayout get layout => _Utils.layout;

  @override
  String toString() {
    return 'StakeAccount${serialize()}';
  }
}
