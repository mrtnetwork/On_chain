import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static const List<int> discriminator = [185, 62, 74, 60, 105, 158, 178, 125];

  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "discriminator"),
    LayoutUtils.publicKey("fanout"),
    LayoutUtils.u64("totalInflow"),
    LayoutUtils.u64("lastInflow"),
    LayoutUtils.u8("bumpSeed"),
    LayoutUtils.publicKey("membershipKey"),
    LayoutUtils.u64("shares"),
  ]);
}

class FanoutMembershipVoucher extends LayoutSerializable {
  final SolAddress fanout;
  final BigInt totalInflow;
  final BigInt lastInflow;
  final int bumpSeed;
  final SolAddress membershipKey;
  final BigInt shares;

  const FanoutMembershipVoucher(
      {required this.fanout,
      required this.bumpSeed,
      required this.lastInflow,
      required this.membershipKey,
      required this.shares,
      required this.totalInflow});
  factory FanoutMembershipVoucher.fromBuffer(List<int> data) {
    final decode = LayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {"discriminator": _Utils.discriminator});
    return FanoutMembershipVoucher(
        fanout: decode["fanout"],
        bumpSeed: decode["bumpSeed"],
        lastInflow: decode["lastInflow"],
        membershipKey: decode["membershipKey"],
        shares: decode["shares"],
        totalInflow: decode["totalInflow"]);
  }

  @override
  Structure get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "discriminator": _Utils.discriminator,
      "fanout": fanout,
      "totalInflow": totalInflow,
      "lastInflow": lastInflow,
      "bumpSeed": bumpSeed,
      "membershipKey": membershipKey,
      "shares": shares,
    };
  }

  @override
  String toString() {
    return "FanoutMembershipVoucher${serialize()}";
  }
}
