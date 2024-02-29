import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static final Structure layout =
      LayoutUtils.struct([LayoutUtils.u32("count")]);
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
  Structure get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {"count": count};
  }

  @override
  String toString() {
    return "AllocationTrackerAccount${serialize()}";
  }
}
