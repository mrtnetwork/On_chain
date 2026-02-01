import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static const List<int> discriminator = [186, 150, 141, 135, 59, 122, 39, 99];
  static StructLayout get layout => LayoutConst.struct([
        LayoutConst.blob(8, property: 'discriminator'),
        SolanaLayoutUtils.publicKey('tradeState'),
        SolanaLayoutUtils.publicKey('bookkeeper'),
        SolanaLayoutUtils.publicKey('auctionHouse'),
        SolanaLayoutUtils.publicKey('buyer'),
        SolanaLayoutUtils.publicKey('metadata'),
        SolanaLayoutUtils.optionPubkey(property: 'tokenAccount'),
        SolanaLayoutUtils.optionPubkey(property: 'purchaseReceipt'),
        LayoutConst.u64(property: 'price'),
        LayoutConst.u64(property: 'tokenSize'),
        LayoutConst.u8(property: 'bump'),
        LayoutConst.u8(property: 'tradeStateBump'),
        LayoutConst.i64(property: 'createdAt'),
        LayoutConst.optional(LayoutConst.i64(), property: 'canceledAt')
      ]);
}

class BidReceipt extends BorshLayoutSerializable {
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
    final decode = BorshLayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {'discriminator': _Utils.discriminator});

    return BidReceipt(
        tradeState: decode['tradeState'],
        bookkeeper: decode['bookkeeper'],
        auctionHouse: decode['auctionHouse'],
        buyer: decode['buyer'],
        metadata: decode['metadata'],
        authority: decode['authority'],
        purchaseReceipt: decode['purchaseReceipt'],
        price: decode['price'],
        tokenSize: decode['tokenSize'],
        tokenAccount: decode['tokenAccount'],
        bump: decode['bump'],
        tradeStateBump: decode['tradeStateBump'],
        createdAt: decode['createdAt'],
        canceledAt: decode['canceledAt']);
  }

  @override
  Map<String, dynamic> serialize() {
    return {
      'discriminator': _Utils.discriminator,
      'tradeState': tradeState,
      'bookkeeper': bookkeeper,
      'auctionHouse': auctionHouse,
      'buyer': buyer,
      'metadata': metadata,
      'authority': authority,
      'purchaseReceipt': purchaseReceipt,
      'price': price,
      'tokenAccount': tokenAccount,
      'tokenSize': tokenSize,
      'bump': bump,
      'tradeStateBump': tradeStateBump,
      'createdAt': createdAt,
      'canceledAt': canceledAt,
    };
  }

  @override
  StructLayout get layout => _Utils.layout;
  @override
  String toString() {
    return 'BidReceipt${serialize()}';
  }
}
