import 'package:on_chain/solana/src/layout/layout.dart';
import 'uses_method.dart';

class Uses extends LayoutSerializable {
  final UseMethod useMethod;
  final BigInt remaining;
  final BigInt total;
  const Uses(
      {required this.useMethod, required this.remaining, required this.total});
  factory Uses.fromJson(Map<String, dynamic> json) {
    return Uses(
        useMethod: UseMethod.fromValue(json["useMethod"]),
        remaining: json["remaining"],
        total: json["total"]);
  }
  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.u8("useMethod"),
    LayoutUtils.u64("remaining"),
    LayoutUtils.u64("total")
  ], "uses");
  @override
  Structure get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "useMethod": useMethod.value,
      "remaining": remaining,
      "total": total
    };
  }

  @override
  String toString() {
    return "Uses${serialize()}";
  }
}
