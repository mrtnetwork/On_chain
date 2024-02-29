import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static const List<int> discriminator = [
    79,
    127,
    222,
    137,
    154,
    131,
    150,
    134
  ];

  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "discriminator"),
    LayoutUtils.publicKey("bookkeeper"),
    LayoutUtils.publicKey("buyer"),
    LayoutUtils.publicKey("seller"),
    LayoutUtils.publicKey("auctionHouse"),
    LayoutUtils.publicKey("metadata"),
    LayoutUtils.u64("tokenSize"),
    LayoutUtils.u64("price"),
    LayoutUtils.u8("bump"),
    LayoutUtils.i64("createdAt"),
  ]);
}

class PurchaseReceipt extends LayoutSerializable {
  static int get size => _Utils.layout.span;
  final SolAddress bookkeeper;
  final SolAddress buyer;
  final SolAddress seller;
  final SolAddress auctionHouse;
  final SolAddress metadata;
  final BigInt tokenSize;
  final BigInt price;
  final int bump;
  final BigInt createdAt;

  const PurchaseReceipt(
      {required this.bookkeeper,
      required this.buyer,
      required this.auctionHouse,
      required this.seller,
      required this.metadata,
      required this.price,
      required this.tokenSize,
      required this.bump,
      required this.createdAt});
  factory PurchaseReceipt.fromBuffer(List<int> data) {
    final decode = LayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {"discriminator": _Utils.discriminator});
    return PurchaseReceipt(
        buyer: decode["buyer"],
        bookkeeper: decode["bookkeeper"],
        auctionHouse: decode["auctionHouse"],
        seller: decode["seller"],
        metadata: decode["metadata"],
        price: decode["price"],
        tokenSize: decode["tokenSize"],
        bump: decode["bump"],
        createdAt: decode["createdAt"]);
  }

  @override
  Structure get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "discriminator": _Utils.discriminator,
      "bookkeeper": bookkeeper,
      "auctionHouse": auctionHouse,
      "seller": seller,
      "metadata": metadata,
      "buyer": buyer,
      "price": price,
      "tokenSize": tokenSize,
      "bump": bump,
      "createdAt": createdAt,
    };
  }

  @override
  String toString() {
    return "PurchaseReceipt${serialize()}";
  }
}
