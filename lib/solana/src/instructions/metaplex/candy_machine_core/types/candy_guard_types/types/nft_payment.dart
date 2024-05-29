import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class NFTPayment extends LayoutSerializable {
  final SolAddress requiredCollection;
  final SolAddress destination;

  const NFTPayment(
      {required this.requiredCollection, required this.destination});
  factory NFTPayment.fromJson(Map<String, dynamic> json) {
    return NFTPayment(
        requiredCollection: json["requiredCollection"],
        destination: json["destination"]);
  }

  static final StructLayout staticLayout = LayoutConst.struct([
    SolanaLayoutUtils.publicKey("requiredCollection"),
    SolanaLayoutUtils.publicKey("destination")
  ], property: "nftPayment");

  @override
  StructLayout get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "destination": destination,
      "requiredCollection": requiredCollection
    };
  }

  @override
  String toString() {
    return "NFTPayment${serialize()}";
  }
}
