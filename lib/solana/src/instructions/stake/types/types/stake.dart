import 'package:on_chain/solana/src/instructions/stake/types/types/delegation.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class StakeStake extends LayoutSerializable {
  final SolanaStakeDelegation delegation;
  final BigInt creditsObserved;

  const StakeStake({required this.delegation, required this.creditsObserved});
  factory StakeStake.fromJson(Map<String, dynamic> json) {
    return StakeStake(
        delegation: SolanaStakeDelegation.fromJson(json['delegation']),
        creditsObserved: json['creditsObserved']);
  }

  static final StructLayout staticLayout = LayoutConst.struct([
    SolanaStakeDelegation.staticLayout,
    LayoutConst.u64(property: 'creditsObserved'),
  ], property: 'stake');

  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'delegation': delegation.serialize(),
      'creditsObserved': creditsObserved
    };
  }

  @override
  String toString() {
    return 'StakeStake${serialize()}';
  }
}
