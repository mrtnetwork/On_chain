import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static const List<int> discriminator = [240, 71, 225, 94, 200, 75, 84, 231];

  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "discriminator"),
    LayoutUtils.publicKey("tradeState"),
    LayoutUtils.publicKey("bookkeeper"),
    LayoutUtils.publicKey("auctionHouse"),
    LayoutUtils.publicKey("seller"),
    LayoutUtils.publicKey("metadata"),
    LayoutUtils.optionPubkey(property: "purchaseReceipt"),
    LayoutUtils.u64("price"),
    LayoutUtils.u64("tokenSize"),
    LayoutUtils.u8("bump"),
    LayoutUtils.u8("tradeStateBump"),
    LayoutUtils.i64("createdAt"),
    LayoutUtils.optional(LayoutUtils.i64(), property: "canceledAt")
  ]);
}

class ListingReceipt extends LayoutSerializable {
  final SolAddress tradeState;
  final SolAddress bookkeeper;
  final SolAddress auctionHouse;
  final SolAddress seller;
  final SolAddress metadata;
  final SolAddress? purchaseReceipt;
  final BigInt price;
  final BigInt tokenSize;
  final int bump;
  final int tradeStateBump;
  final BigInt createdAt;
  final BigInt? canceledAt;

  const ListingReceipt(
      {required this.tradeState,
      required this.bookkeeper,
      required this.auctionHouse,
      required this.seller,
      required this.metadata,
      required this.purchaseReceipt,
      required this.price,
      required this.tokenSize,
      required this.bump,
      required this.tradeStateBump,
      required this.createdAt,
      required this.canceledAt});
  factory ListingReceipt.fromBuffer(List<int> data) {
    final decode = LayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {"discriminator": _Utils.discriminator});
    return ListingReceipt(
        tradeState: decode["tradeState"],
        bookkeeper: decode["bookkeeper"],
        auctionHouse: decode["auctionHouse"],
        seller: decode["seller"],
        metadata: decode["metadata"],
        purchaseReceipt: decode["purchaseReceipt"],
        price: decode["price"],
        tokenSize: decode["tokenSize"],
        bump: decode["bump"],
        tradeStateBump: decode["tradeStateBump"],
        createdAt: decode["createdAt"],
        canceledAt: decode["canceledAt"]);
  }

  @override
  Map<String, dynamic> serialize() {
    return {
      "discriminator": _Utils.discriminator,
      "tradeState": tradeState,
      "bookkeeper": bookkeeper,
      "auctionHouse": auctionHouse,
      "seller": seller,
      "metadata": metadata,
      "purchaseReceipt": purchaseReceipt,
      "price": price,
      "tokenSize": tokenSize,
      "bump": bump,
      "tradeStateBump": tradeStateBump,
      "createdAt": createdAt,
      "canceledAt": canceledAt,
    };
  }

  @override
  Structure get layout => _Utils.layout;
  @override
  String toString() {
    return "ListingReceipt${serialize()}";
  }
}
