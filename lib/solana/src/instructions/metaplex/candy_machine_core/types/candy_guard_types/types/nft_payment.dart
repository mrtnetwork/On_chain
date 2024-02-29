import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.publicKey("requiredCollection"),
    LayoutUtils.publicKey("destination")
  ], "nftPayment");

  @override
  Structure get layout => staticLayout;
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
