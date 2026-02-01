import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class EpochCredits extends BorshLayoutSerializable {
  final BigInt epoch;
  final BigInt credits;
  final BigInt prevCredits;
  const EpochCredits(
      {required this.epoch, required this.credits, required this.prevCredits});
  factory EpochCredits.fromJson(Map<String, dynamic> json) {
    return EpochCredits(
        epoch: json['epoch'],
        credits: json['credits'],
        prevCredits: json['prevCredits']);
  }

  static StructLayout get staticLayout => LayoutConst.struct([
        LayoutConst.u64(property: 'epoch'),
        LayoutConst.u64(property: 'credits'),
        LayoutConst.u64(property: 'prevCredits'),
      ], property: 'epochCredits');
  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {'epoch': epoch, 'credits': credits, 'prevCredits': prevCredits};
  }

  @override
  String toString() {
    return 'EpochCredits.${serialize()}';
  }
}
