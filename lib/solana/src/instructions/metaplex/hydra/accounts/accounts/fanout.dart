import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/hydra/types/types/member_ship_model.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static const List<int> discriminator = [164, 101, 210, 92, 222, 14, 75, 156];

  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "discriminator"),
    LayoutUtils.publicKey("authority"),
    LayoutUtils.string("name"),
    LayoutUtils.publicKey("accountKey"),
    LayoutUtils.u64("totalShares"),
    LayoutUtils.u64("totalMembers"),
    LayoutUtils.u64("totalInflow"),
    LayoutUtils.u64("lastSnapshotAmount"),
    LayoutUtils.u8("bumpSeed"),
    LayoutUtils.u8("accountOwnerBumpSeed"),
    LayoutUtils.u64("totalAvailableShares"),
    LayoutUtils.u8("membershipModel"),
    LayoutUtils.optional(LayoutUtils.publicKey(), property: "membershipMint"),
    LayoutUtils.optional(LayoutUtils.u64(), property: "totalStakedShares")
  ]);
}

class Fanout extends LayoutSerializable {
  final SolAddress authority;
  final String name;
  final SolAddress accountKey;
  final BigInt totalShares;
  final BigInt totalMembers;
  final BigInt totalInflow;
  final BigInt lastSnapshotAmount;
  final int bumpSeed;
  final int accountOwnerBumpSeed;
  final BigInt totalAvailableShares;
  final MembershipModel membershipModel;
  final SolAddress? membershipMint;
  final BigInt? totalStakedShares;

  const Fanout(
      {required this.authority,
      required this.name,
      required this.accountKey,
      required this.totalShares,
      required this.totalMembers,
      required this.totalInflow,
      required this.lastSnapshotAmount,
      required this.bumpSeed,
      required this.accountOwnerBumpSeed,
      required this.totalAvailableShares,
      required this.membershipModel,
      this.membershipMint,
      this.totalStakedShares});
  factory Fanout.fromBuffer(List<int> data) {
    final decode = LayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {"discriminator": _Utils.discriminator});
    return Fanout(
        authority: decode["authority"],
        name: decode["name"],
        accountKey: decode["accountKey"],
        totalShares: decode["totalShares"],
        totalMembers: decode["totalMembers"],
        totalInflow: decode["totalInflow"],
        lastSnapshotAmount: decode["lastSnapshotAmount"],
        bumpSeed: decode["bumpSeed"],
        accountOwnerBumpSeed: decode["accountOwnerBumpSeed"],
        totalAvailableShares: decode["totalAvailableShares"],
        membershipModel: MembershipModel.fromValue(decode["membershipModel"]),
        membershipMint: decode["membershipMint"],
        totalStakedShares: decode["totalStakedShares"]);
  }

  @override
  Structure get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "discriminator": _Utils.discriminator,
      "authority": authority,
      "name": name,
      "accountKey": accountKey,
      "totalShares": totalShares,
      "totalMembers": totalMembers,
      "totalInflow": totalInflow,
      "lastSnapshotAmount": lastSnapshotAmount,
      "bumpSeed": bumpSeed,
      "accountOwnerBumpSeed": accountOwnerBumpSeed,
      "totalAvailableShares": totalAvailableShares,
      "membershipModel": membershipModel.value,
      "membershipMint": membershipMint,
      "totalStakedShares": totalStakedShares
    };
  }

  @override
  String toString() {
    return "Fanout${serialize()}";
  }
}
