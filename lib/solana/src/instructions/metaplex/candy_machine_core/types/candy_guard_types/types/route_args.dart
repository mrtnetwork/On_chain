import 'package:blockchain_utils/binary/binary.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

import 'guard_type.dart';

class RouteArgs extends LayoutSerializable {
  final GuardType guard;
  final List<int> data;

  RouteArgs({required this.guard, required List<int> data})
      : data = BytesUtils.toBytes(data, unmodifiable: true);
  factory RouteArgs.fromJson(Map<String, dynamic> json) {
    return RouteArgs(
        guard: GuardType.fromValue(json["guard"]),
        data: (json["data"] as List).cast());
  }

  static final Structure staticLayout = LayoutUtils.struct(
      [LayoutUtils.u8("guard"), LayoutUtils.vecU8("data")], "routeArgs");

  @override
  Structure get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {"guard": guard.value, "data": data};
  }

  @override
  String toString() {
    return "RouteArgs${serialize()}";
  }
}
