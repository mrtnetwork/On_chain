import 'package:on_chain/solana/src/instructions/instructions.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class PriorVoters extends LayoutSerializable {
  final List<PriorVoter> voters;
  final BigInt id;
  final bool isEmpty;
  const PriorVoters(
      {required this.voters, required this.id, required this.isEmpty});
  factory PriorVoters.fromJson(Map<String, dynamic> json) {
    return PriorVoters(
        id: json["id"],
        isEmpty: json["isEmpty"],
        voters: (json["voters"] as List)
            .map((e) => PriorVoter.fromJson(e))
            .toList());
  }

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.array(PriorVoter.staticLayout, 32, property: 'voters'),
    LayoutUtils.u64("id"),
    LayoutUtils.boolean(property: "isEmpty"),
  ], "priorVoters");
  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "id": id,
      "isEmpty": isEmpty,
      "voters": voters.map((e) => e.serialize()).toList()
    };
  }
}
