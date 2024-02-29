import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static const List<int> discriminator = [133, 118, 20, 210, 1, 54, 172, 116];
  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "discriminator"),
    LayoutUtils.publicKey("treasuryMint"),
    LayoutUtils.publicKey("mintA"),
    LayoutUtils.publicKey("mintB"),
    LayoutUtils.publicKey("tokenAEscrow"),
    LayoutUtils.publicKey("tokenBEscrow"),
    LayoutUtils.publicKey("authority"),
    LayoutUtils.u8("bump"),
    LayoutUtils.u8("tokenAEscrowBump"),
    LayoutUtils.u8("tokenBEscrowBump"),
    LayoutUtils.u64("price"),
    LayoutUtils.boolean(property: "paid"),
    LayoutUtils.boolean(property: "paysEveryTime")
  ]);
}

class EntangledPair extends LayoutSerializable {
  static int get size => _Utils.layout.span;
  final SolAddress treasuryMint;
  final SolAddress mintA;
  final SolAddress mintB;
  final SolAddress tokenAEscrow;
  final SolAddress tokenBEscrow;
  final SolAddress authority;
  final int bump;
  final int tokenAEscrowBump;
  final int tokenBEscrowBump;
  final BigInt price;
  final bool paid;
  final bool paysEveryTime;

  const EntangledPair(
      {required this.treasuryMint,
      required this.mintA,
      required this.mintB,
      required this.tokenAEscrow,
      required this.tokenBEscrow,
      required this.authority,
      required this.bump,
      required this.tokenAEscrowBump,
      required this.tokenBEscrowBump,
      required this.price,
      required this.paid,
      required this.paysEveryTime});
  factory EntangledPair.fromBuffer(List<int> data) {
    final decode = LayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {"discriminator": _Utils.discriminator});
    return EntangledPair(
        treasuryMint: decode["treasuryMint"],
        mintA: decode["mintA"],
        mintB: decode["mintB"],
        tokenAEscrow: decode["tokenAEscrow"],
        tokenBEscrow: decode["tokenBEscrow"],
        authority: decode["authority"],
        bump: decode["bump"],
        tokenAEscrowBump: decode["tokenAEscrowBump"],
        tokenBEscrowBump: decode["tokenBEscrowBump"],
        price: decode["price"],
        paid: decode["paid"],
        paysEveryTime: decode["paysEveryTime"]);
  }

  @override
  Structure get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "discriminator": _Utils.discriminator,
      "treasuryMint": treasuryMint,
      "mintA": mintA,
      "mintB": mintB,
      "tokenAEscrow": tokenAEscrow,
      "tokenBEscrow": tokenBEscrow,
      "authority": authority,
      "bump": bump,
      "tokenAEscrowBump": tokenAEscrowBump,
      "tokenBEscrowBump": tokenBEscrowBump,
      "price": price,
      "paid": paid,
      "paysEveryTime": paysEveryTime
    };
  }

  @override
  String toString() {
    return "EntangledPair${serialize()}";
  }
}
