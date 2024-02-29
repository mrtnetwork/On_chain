import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.u8("version"),
    LayoutUtils.u64("amount"),
    LayoutUtils.publicKey("buyerTradeState")
  ], "highestBid");
  @override
  Structure get layout => staticLayout;
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
