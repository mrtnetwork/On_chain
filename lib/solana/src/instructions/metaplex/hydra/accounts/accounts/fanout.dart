import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/hydra/types/types/member_ship_model.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static const List<int> discriminator = [164, 101, 210, 92, 222, 14, 75, 156];

  static final StructLayout layout = LayoutConst.struct([
    LayoutConst.blob(8, property: 'discriminator'),
    SolanaLayoutUtils.publicKey('authority'),
    LayoutConst.string(property: 'name'),
    SolanaLayoutUtils.publicKey('accountKey'),
    LayoutConst.u64(property: 'totalShares'),
    LayoutConst.u64(property: 'totalMembers'),
    LayoutConst.u64(property: 'totalInflow'),
    LayoutConst.u64(property: 'lastSnapshotAmount'),
    LayoutConst.u8(property: 'bumpSeed'),
    LayoutConst.u8(property: 'accountOwnerBumpSeed'),
    LayoutConst.u64(property: 'totalAvailableShares'),
    LayoutConst.u8(property: 'membershipModel'),
    LayoutConst.optional(SolanaLayoutUtils.publicKey(),
        property: 'membershipMint'),
    LayoutConst.optional(LayoutConst.u64(), property: 'totalStakedShares')
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
        validator: {'discriminator': _Utils.discriminator});
    return Fanout(
        authority: decode['authority'],
        name: decode['name'],
        accountKey: decode['accountKey'],
        totalShares: decode['totalShares'],
        totalMembers: decode['totalMembers'],
        totalInflow: decode['totalInflow'],
        lastSnapshotAmount: decode['lastSnapshotAmount'],
        bumpSeed: decode['bumpSeed'],
        accountOwnerBumpSeed: decode['accountOwnerBumpSeed'],
        totalAvailableShares: decode['totalAvailableShares'],
        membershipModel: MembershipModel.fromValue(decode['membershipModel']),
        membershipMint: decode['membershipMint'],
        totalStakedShares: decode['totalStakedShares']);
  }

  @override
  StructLayout get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      'discriminator': _Utils.discriminator,
      'authority': authority,
      'name': name,
      'accountKey': accountKey,
      'totalShares': totalShares,
      'totalMembers': totalMembers,
      'totalInflow': totalInflow,
      'lastSnapshotAmount': lastSnapshotAmount,
      'bumpSeed': bumpSeed,
      'accountOwnerBumpSeed': accountOwnerBumpSeed,
      'totalAvailableShares': totalAvailableShares,
      'membershipModel': membershipModel.value,
      'membershipMint': membershipMint,
      'totalStakedShares': totalStakedShares
    };
  }

  @override
  String toString() {
    return 'Fanout${serialize()}';
  }
}
