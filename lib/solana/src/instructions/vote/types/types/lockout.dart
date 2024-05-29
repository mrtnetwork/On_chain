import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class Lockout extends LayoutSerializable {
  const Lockout({required this.slot, required this.confirmationCount});
  factory Lockout.fromJson(Map<String, dynamic> json) {
    return Lockout(
        slot: json["slot"], confirmationCount: json["confirmationCount"]);
  }
  final BigInt slot;
  final int confirmationCount;
  static final StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.u64(property: "slot"),
    LayoutConst.u32(property: "confirmationCount")
  ], property: "lockout");
  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {"slot": slot, "confirmationCount": confirmationCount};
  }
}
