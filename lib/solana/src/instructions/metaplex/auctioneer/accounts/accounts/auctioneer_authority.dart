import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static const List<int> discriminator = [228, 74, 255, 245, 96, 83, 197, 12];
  static final Structure layout = LayoutUtils.struct(
      [LayoutUtils.blob(8, property: "discriminator"), LayoutUtils.u8("bump")]);
}

class AuctioneerAuthority extends LayoutSerializable {
  static int get size => _Utils.layout.span;
  final int bump;
  const AuctioneerAuthority({required this.bump});
  factory AuctioneerAuthority.fromBuffer(List<int> data) {
    final decode = LayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {"discriminator": _Utils.discriminator});

    return AuctioneerAuthority(bump: decode["bump"]);
  }

  @override
  Structure get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "discriminator": _Utils.discriminator,
      "bump": bump,
    };
  }

  @override
  String toString() {
    return "AuctioneerAuthority${serialize()}";
  }
}
