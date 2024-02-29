import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class ProgramGate extends LayoutSerializable {
  final List<SolAddress> additional;

  const ProgramGate({required this.additional});
  factory ProgramGate.fromJson(Map<String, dynamic> json) {
    return ProgramGate(additional: (json["additional"] as List).cast());
  }

  static final Structure staticLayout = LayoutUtils.struct(
      [LayoutUtils.vec(LayoutUtils.publicKey(), property: "additional")],
      "programGate");

  @override
  Structure get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {"additional": additional};
  }

  @override
  String toString() {
    return "ProgramGate${serialize()}";
  }
}
