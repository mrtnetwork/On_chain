import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class BlockTimestamp extends LayoutSerializable {
  final BigInt slot;
  final BigInt timestamp;
  const BlockTimestamp({required this.slot, required this.timestamp});
  factory BlockTimestamp.fromJson(Map<String, dynamic> json) {
    return BlockTimestamp(slot: json['slot'], timestamp: json['timestamp']);
  }

  static final StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.u64(property: 'slot'),
    LayoutConst.i64(property: 'timestamp'),
  ], property: 'blockTimestamp');
  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {'slot': slot, 'timestamp': timestamp};
  }

  @override
  String toString() {
    return 'BlockTimestamp${serialize()}';
  }
}
