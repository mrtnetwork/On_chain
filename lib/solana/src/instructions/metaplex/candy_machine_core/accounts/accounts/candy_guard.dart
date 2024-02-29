import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static const List<int> discriminator = [44, 207, 199, 184, 112, 103, 34, 181];
  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "discriminator"),
    LayoutUtils.publicKey("base"),
    LayoutUtils.u8("bump"),
    LayoutUtils.publicKey("authority"),
  ]);
}

class CandyGaurdAccount extends LayoutSerializable {
  final SolAddress base;
  final int bump;
  final SolAddress authority;
  const CandyGaurdAccount(
      {required this.base, required this.bump, required this.authority});
  factory CandyGaurdAccount.fromBuffer(List<int> data) {
    final decode = LayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {"discriminator": _Utils.discriminator});
    return CandyGaurdAccount(
        base: decode["base"],
        bump: decode["bump"],
        authority: decode["authority"]);
  }

  @override
  Structure get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "discriminator": _Utils.discriminator,
      "bump": bump,
      "base": base,
      "authority": authority,
    };
  }

  @override
  String toString() {
    return "CandyGaurdAccount${serialize()}";
  }
}
