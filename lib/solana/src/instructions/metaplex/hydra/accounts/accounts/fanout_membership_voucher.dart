import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static const List<int> discriminator = [185, 62, 74, 60, 105, 158, 178, 125];

  static final StructLayout layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "discriminator"),
    SolanaLayoutUtils.publicKey("fanout"),
    LayoutConst.u64(property: "totalInflow"),
    LayoutConst.u64(property: "lastInflow"),
    LayoutConst.u8(property: "bumpSeed"),
    SolanaLayoutUtils.publicKey("membershipKey"),
    LayoutConst.u64(property: "shares"),
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
  StructLayout get layout => _Utils.layout;
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
