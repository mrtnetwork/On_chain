import 'package:blockchain_utils/helper/extensions/extensions.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

import 'guard_type.dart';

class RouteArgs extends BorshLayoutSerializable {
  final GuardType guard;
  final List<int> data;

  RouteArgs({required this.guard, required List<int> data})
      : data = data = data.asImmutableBytes;
  factory RouteArgs.fromJson(Map<String, dynamic> json) {
    return RouteArgs(
        guard: GuardType.fromValue(json['guard']),
        data: (json['data'] as List).cast());
  }

  static StructLayout get staticLayout => LayoutConst.struct(
      [LayoutConst.u8(property: 'guard'), LayoutConst.vecU8(property: 'data')],
      property: 'routeArgs');

  @override
  StructLayout get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {'guard': guard.value, 'data': data};
  }

  @override
  String toString() {
    return 'RouteArgs${serialize()}';
  }
}
