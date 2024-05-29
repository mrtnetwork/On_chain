import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class RedeemedAmount extends LayoutSerializable {
  final BigInt maximum;

  const RedeemedAmount({required this.maximum});
  factory RedeemedAmount.fromJson(Map<String, dynamic> json) {
    return RedeemedAmount(maximum: json["maximum"]);
  }

  static final StructLayout staticLayout = LayoutConst.struct(
      [LayoutConst.u64(property: "maximum")],
      property: "redeemedAmount");

  @override
  StructLayout get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {"maximum": maximum};
  }

  @override
  String toString() {
    return "RedeemedAmount${serialize()}";
  }
}
