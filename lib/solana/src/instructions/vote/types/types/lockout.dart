import 'package:on_chain/solana/src/layout/layout.dart';

class Lockout extends LayoutSerializable {
  const Lockout({required this.slot, required this.confirmationCount});
  factory Lockout.fromJson(Map<String, dynamic> json) {
    return Lockout(
        slot: json["slot"], confirmationCount: json["confirmationCount"]);
  }
  final BigInt slot;
  final int confirmationCount;
  static final Structure staticLayout = LayoutUtils.struct(
      [LayoutUtils.u64("slot"), LayoutUtils.u32("confirmationCount")],
      "lockout");
  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {"slot": slot, "confirmationCount": confirmationCount};
  }
}
