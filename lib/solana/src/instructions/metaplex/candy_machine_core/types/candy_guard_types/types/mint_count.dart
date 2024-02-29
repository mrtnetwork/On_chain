import 'package:on_chain/solana/src/layout/layout.dart';

class MintCounter extends LayoutSerializable {
  final int count;

  const MintCounter({required this.count});
  factory MintCounter.fromJson(Map<String, dynamic> json) {
    return MintCounter(count: json["count"]);
  }

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.u16("count"),
  ], "mintCounter");

  @override
  Structure get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {"count": count};
  }

  @override
  String toString() {
    return "MintCounter${serialize()}";
  }
}
