import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class AllocationTracker extends BorshLayoutSerializable {
  final int count;

  const AllocationTracker({required this.count});
  factory AllocationTracker.fromJson(Map<String, dynamic> json) {
    return AllocationTracker(count: json['count']);
  }

  static StructLayout get staticLayout => LayoutConst.struct([
        LayoutConst.u32(property: 'count'),
      ], property: 'allocationTracker');

  @override
  StructLayout get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {'count': count};
  }

  @override
  String toString() {
    return 'AllocationTracker${serialize()}';
  }
}
