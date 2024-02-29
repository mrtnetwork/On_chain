import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static const List<int> discriminator = [186, 150, 141, 135, 59, 122, 39, 99];
  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "discriminator"),
    LayoutUtils.publicKey("tradeState"),
    LayoutUtils.publicKey("bookkeeper"),
    LayoutUtils.publicKey("auctionHouse"),
    LayoutUtils.publicKey("buyer"),
    LayoutUtils.publicKey("metadata"),
    LayoutUtils.optionPubkey(property: "tokenAccount"),
    LayoutUtils.optionPubkey(property: "purchaseReceipt"),
    LayoutUtils.u64("price"),
    LayoutUtils.u64("tokenSize"),
    LayoutUtils.u8("bump"),
    LayoutUtils.u8("tradeStateBump"),
    LayoutUtils.i64("createdAt"),
    LayoutUtils.optional(LayoutUtils.i64(), property: "canceledAt")
  ]);
}

class BidReceipt extends LayoutSerializable {
  final SolAddress tradeState;
  final SolAddress bookkeeper;
  final SolAddress auctionHouse;
  final SolAddress buyer;
  final SolAddress metadata;
  final SolAddress? authority;
  final SolAddress? purchaseReceipt;
  final SolAddress? tokenAccount;
  final BigInt price;
  final BigInt tokenSize;
  final int bump;
  final int tradeStateBump;
  final BigInt createdAt;
  final BigInt? canceledAt;

  const BidReceipt(
      {required this.tradeState,
      required this.bookkeeper,
      required this.auctionHouse,
      required this.buyer,
      required this.metadata,
      this.authority,
      this.purchaseReceipt,
      required this.price,
      this.tokenAccount,
      required this.tokenSize,
      required this.bump,
      required this.tradeStateBump,
      required this.createdAt,
      this.canceledAt});
  factory BidReceipt.fromBuffer(List<int> data) {
    final decode = LayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {"discriminator": _Utils.discriminator});

    return BidReceipt(
        tradeState: decode["tradeState"],
        bookkeeper: decode["bookkeeper"],
        auctionHouse: decode["auctionHouse"],
        buyer: decode["buyer"],
        metadata: decode["metadata"],
        authority: decode["authority"],
        purchaseReceipt: decode["purchaseReceipt"],
        price: decode["price"],
        tokenSize: decode["tokenSize"],
        tokenAccount: decode["tokenAccount"],
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
      "buyer": buyer,
      "metadata": metadata,
      "authority": authority,
      "purchaseReceipt": purchaseReceipt,
      "price": price,
      "tokenAccount": tokenAccount,
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
    return "BidReceipt${serialize()}";
  }
}
