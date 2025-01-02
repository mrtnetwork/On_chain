import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class Allocation extends LayoutSerializable {
  final int id;
  final int limit;

  const Allocation({required this.id, required this.limit});
  factory Allocation.fromJson(Map<String, dynamic> json) {
    return Allocation(id: json['id'], limit: json['limit']);
  }

  static final StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.u8(property: 'id'),
    LayoutConst.u32(property: 'limit'),
  ], property: 'allocation');

  @override
  StructLayout get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {'id': id, 'limit': limit};
  }

  @override
  String toString() {
    return 'Allocation${serialize()}';
  }
}
