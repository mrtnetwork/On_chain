import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

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

  static StructLayout get layout => LayoutConst.struct([
        LayoutConst.blob(8, property: 'discriminator'),
        SolanaLayoutUtils.publicKey('bookkeeper'),
        SolanaLayoutUtils.publicKey('buyer'),
        SolanaLayoutUtils.publicKey('seller'),
        SolanaLayoutUtils.publicKey('auctionHouse'),
        SolanaLayoutUtils.publicKey('metadata'),
        LayoutConst.u64(property: 'tokenSize'),
        LayoutConst.u64(property: 'price'),
        LayoutConst.u8(property: 'bump'),
        LayoutConst.i64(property: 'createdAt'),
      ]);
}

class PurchaseReceipt extends BorshLayoutSerializable {
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
    final decode = BorshLayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {'discriminator': _Utils.discriminator});
    return PurchaseReceipt(
        buyer: decode['buyer'],
        bookkeeper: decode['bookkeeper'],
        auctionHouse: decode['auctionHouse'],
        seller: decode['seller'],
        metadata: decode['metadata'],
        price: decode['price'],
        tokenSize: decode['tokenSize'],
        bump: decode['bump'],
        createdAt: decode['createdAt']);
  }

  @override
  StructLayout get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      'discriminator': _Utils.discriminator,
      'bookkeeper': bookkeeper,
      'auctionHouse': auctionHouse,
      'seller': seller,
      'metadata': metadata,
      'buyer': buyer,
      'price': price,
      'tokenSize': tokenSize,
      'bump': bump,
      'createdAt': createdAt,
    };
  }

  @override
  String toString() {
    return 'PurchaseReceipt${serialize()}';
  }
}
