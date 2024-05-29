import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class SolPayment extends LayoutSerializable {
  final BigInt lamports;
  final SolAddress destination;

  const SolPayment({required this.lamports, required this.destination});
  factory SolPayment.fromJson(Map<String, dynamic> json) {
    return SolPayment(
        lamports: json["lamports"], destination: json["destination"]);
  }

  static final StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.u64(property: "lamports"),
    SolanaLayoutUtils.publicKey("destination")
  ], property: "solPayment");

  @override
  StructLayout get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {"lamports": lamports, "destination": destination};
  }

  @override
  String toString() {
    return "SolPayment${serialize()}";
  }
}
