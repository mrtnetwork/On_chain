import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class AddCardToPack extends LayoutSerializable {
  final int maxSupply;
  final int weight;
  final int index;
  const AddCardToPack({
    required this.maxSupply,
    required this.weight,
    required this.index,
  });
  factory AddCardToPack.fromJson(Map<String, dynamic> json) {
    return AddCardToPack(
        maxSupply: json['maxSupply'],
        weight: json['weight'],
        index: json['index']);
  }

  static final StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.u32(property: 'maxSupply'),
    LayoutConst.u16(property: 'weight'),
    LayoutConst.u32(property: 'index'),
  ], property: 'addCardToPack');
  @override
  StructLayout get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {
      'maxSupply': maxSupply,
      'weight': weight,
      'index': index,
    };
  }

  @override
  String toString() {
    return 'AddCardToPack${serialize()}';
  }
}
