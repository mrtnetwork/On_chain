import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class FreezeSolPayment extends LayoutSerializable {
  final BigInt lamports;
  final SolAddress destination;

  const FreezeSolPayment({required this.lamports, required this.destination});
  factory FreezeSolPayment.fromJson(Map<String, dynamic> json) {
    return FreezeSolPayment(
        lamports: json["lamports"], destination: json["destination"]);
  }

  static final Structure staticLayout = LayoutUtils.struct(
      [LayoutUtils.u64("lamports"), LayoutUtils.publicKey("destination")],
      "freezeSolPayment");

  @override
  Structure get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {"lamports": lamports, "destination": destination};
  }

  @override
  String toString() {
    return "FreezeSolPayment${serialize()}";
  }
}
