import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MintCounter extends LayoutSerializable {
  final int count;

  const MintCounter({required this.count});
  factory MintCounter.fromJson(Map<String, dynamic> json) {
    return MintCounter(count: json['count']);
  }

  static final StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.u16(property: 'count'),
  ], property: 'mintCounter');

  @override
  StructLayout get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {'count': count};
  }

  @override
  String toString() {
    return 'MintCounter${serialize()}';
  }
}
