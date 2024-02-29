import 'package:on_chain/solana/src/layout/layout.dart';

class AllocationTracker extends LayoutSerializable {
  final int count;

  const AllocationTracker({required this.count});
  factory AllocationTracker.fromJson(Map<String, dynamic> json) {
    return AllocationTracker(count: json["count"]);
  }

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.u32("count"),
  ], "allocationTracker");

  @override
  Structure get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {"count": count};
  }

  @override
  String toString() {
    return "AllocationTracker${serialize()}";
  }
}
