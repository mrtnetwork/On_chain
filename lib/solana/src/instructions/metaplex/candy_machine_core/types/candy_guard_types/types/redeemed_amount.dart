import 'package:on_chain/solana/src/layout/layout.dart';

class RedeemedAmount extends LayoutSerializable {
  final BigInt maximum;

  const RedeemedAmount({required this.maximum});
  factory RedeemedAmount.fromJson(Map<String, dynamic> json) {
    return RedeemedAmount(maximum: json["maximum"]);
  }

  static final Structure staticLayout =
      LayoutUtils.struct([LayoutUtils.u64("maximum")], "redeemedAmount");

  @override
  Structure get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {"maximum": maximum};
  }

  @override
  String toString() {
    return "RedeemedAmount${serialize()}";
  }
}
