import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static const List<int> discriminator = [50, 164, 42, 108, 90, 201, 250, 216];

  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "discriminator"),
    LayoutUtils.publicKey("mint"),
    LayoutUtils.publicKey("fanout"),
    LayoutUtils.publicKey("tokenAccount"),
    LayoutUtils.u64("totalInflow"),
    LayoutUtils.u64("lastSnapshotAmount"),
    LayoutUtils.u8("bumpSeed"),
  ]);
}

class FanoutMint extends LayoutSerializable {
  final SolAddress mint;
  final SolAddress fanout;
  final SolAddress tokenAccount;
  final BigInt totalInflow;
  final BigInt lastSnapshotAmount;
  final int bumpSeed;

  const FanoutMint(
      {required this.mint,
      required this.fanout,
      required this.tokenAccount,
      required this.totalInflow,
      required this.lastSnapshotAmount,
      required this.bumpSeed});
  factory FanoutMint.fromBuffer(List<int> data) {
    final decode = LayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {"discriminator": _Utils.discriminator});
    return FanoutMint(
        mint: decode["mint"],
        fanout: decode["fanout"],
        tokenAccount: decode["tokenAccount"],
        totalInflow: decode["totalInflow"],
        lastSnapshotAmount: decode["lastSnapshotAmount"],
        bumpSeed: decode["bumpSeed"]);
  }

  @override
  Structure get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "discriminator": _Utils.discriminator,
      "mint": mint,
      "fanout": fanout,
      "tokenAccount": tokenAccount,
      "totalInflow": totalInflow,
      "lastSnapshotAmount": lastSnapshotAmount,
      "bumpSeed": bumpSeed
    };
  }

  @override
  String toString() {
    return "FanoutMint${serialize()}";
  }
}
