import 'package:on_chain/solana/src/instructions/instructions.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class PriorVoters extends LayoutSerializable {
  final List<PriorVoter> voters;
  final BigInt id;
  final bool isEmpty;
  const PriorVoters(
      {required this.voters, required this.id, required this.isEmpty});
  factory PriorVoters.fromJson(Map<String, dynamic> json) {
    return PriorVoters(
        id: json['id'],
        isEmpty: json['isEmpty'],
        voters: (json['voters'] as List)
            .map((e) => PriorVoter.fromJson(e))
            .toList());
  }

  static final StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.array(PriorVoter.staticLayout, 32, property: 'voters'),
    LayoutConst.u64(property: 'id'),
    LayoutConst.boolean(property: 'isEmpty'),
  ], property: 'priorVoters');
  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'id': id,
      'isEmpty': isEmpty,
      'voters': voters.map((e) => e.serialize()).toList()
    };
  }
}
