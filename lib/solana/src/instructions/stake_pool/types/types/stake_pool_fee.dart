import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Fee rate as a ratio, minted on [UpdateStakePoolBalance] as a proportion of
/// the rewards
/// If either the numerator or the denominator is 0, the fee is considered to be
/// 0
class StakePoolFee extends BorshLayoutSerializable {
  /// denominator of the fee ratio
  final BigInt denominator;

  /// numerator of the fee ratio
  final BigInt numerator;
  const StakePoolFee({required this.denominator, required this.numerator});
  factory StakePoolFee.fromJson(Map<String, dynamic> json) {
    return StakePoolFee(
        denominator: json['denominator'], numerator: json['numerator']);
  }

  static StructLayout get staticLayout => LayoutConst.struct([
        LayoutConst.u64(property: 'denominator'),
        LayoutConst.u64(property: 'numerator'),
      ], property: 'fee');

  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {'denominator': denominator, 'numerator': numerator};
  }

  @override
  String toString() {
    return 'StakePoolFee${serialize()}';
  }
}
