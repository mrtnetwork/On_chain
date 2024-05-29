import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class _Utils {
  static final StructLayout layout =
      LayoutConst.struct([LayoutConst.u32(property: "count")]);
}

class AllocationTrackerAccount extends LayoutSerializable {
  final int count;

  const AllocationTrackerAccount({required this.count});
  factory AllocationTrackerAccount.fromBuffer(List<int> data) {
    final decode =
        LayoutSerializable.decode(bytes: data, layout: _Utils.layout);
    return AllocationTrackerAccount(count: decode["count"]);
  }

  @override
  StructLayout get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {"count": count};
  }

  @override
  String toString() {
    return "AllocationTrackerAccount${serialize()}";
  }
}
