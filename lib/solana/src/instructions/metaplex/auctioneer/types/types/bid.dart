import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';
import 'listing_config_version.dart';

class Bid extends LayoutSerializable {
  final BigInt amount;
  final SolAddress buyerTradeState;
  static const ListingConfigVersion version = ListingConfigVersion.v0;
  const Bid({required this.amount, required this.buyerTradeState});
  factory Bid.fromJson(Map<String, dynamic> json) {
    return Bid(
        amount: json["amount"], buyerTradeState: json["buyerTradeState"]);
  }

  static final StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.u8(property: "version"),
    LayoutConst.u64(property: "amount"),
    SolanaLayoutUtils.publicKey("buyerTradeState")
  ], property: "highestBid");
  @override
  StructLayout get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "version": version.value,
      "amount": amount,
      "buyerTradeState": buyerTradeState,
    };
  }

  @override
  String toString() {
    return "Bid${serialize()}";
  }
}
