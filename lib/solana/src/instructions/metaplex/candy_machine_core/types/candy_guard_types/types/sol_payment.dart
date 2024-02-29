import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class SolPayment extends LayoutSerializable {
  final BigInt lamports;
  final SolAddress destination;

  const SolPayment({required this.lamports, required this.destination});
  factory SolPayment.fromJson(Map<String, dynamic> json) {
    return SolPayment(
        lamports: json["lamports"], destination: json["destination"]);
  }

  static final Structure staticLayout = LayoutUtils.struct(
      [LayoutUtils.u64("lamports"), LayoutUtils.publicKey("destination")],
      "solPayment");

  @override
  Structure get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {"lamports": lamports, "destination": destination};
  }

  @override
  String toString() {
    return "SolPayment${serialize()}";
  }
}
