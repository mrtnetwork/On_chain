import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/vote/types/types.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static StructLayout layout(int version) => LayoutConst.struct([
        SolanaLayoutUtils.publicKey('nodePubkey'),
        SolanaLayoutUtils.publicKey('authorizedWithdrawer'),
        LayoutConst.u8(property: 'commission'),
        if (version > 1)
          LayoutConst.rustVec(
              LayoutConst.struct([
                LayoutConst.u8(),
                ...Lockout.staticLayout.fields,
              ], property: "lockout"),
              property: 'votes')
        else
          LayoutConst.rustVec(Lockout.staticLayout, property: 'votes'),
        LayoutConst.optional(LayoutConst.u64(), property: "rootSlot"),
        LayoutConst.rustVec(AuthorizedVoter.staticLayout,
            property: 'authorizedVoters'),
        PriorVoters.staticLayout,
        LayoutConst.rustVec(EpochCredits.staticLayout,
            property: 'epochCredits'),
        LayoutConst.wrap(BlockTimestamp.staticLayout,
            property: "lastTimestamp"),
      ]);
}

class VoteAccount extends LayoutSerializable {
  final List<AuthorizedVoter> authorizedVoters;
  final SolAddress authorizedWithdrawer;
  final int commission;
  final int version;
  final List<EpochCredits> epochCredits;
  final BlockTimestamp lastTimestamp;
  final SolAddress nodePubkey;
  final PriorVoters priorVoter;
  final BigInt? rootSlot;
  final List<Lockout> votes;

  const VoteAccount(
      {required this.authorizedVoters,
      required this.authorizedWithdrawer,
      required this.commission,
      required this.epochCredits,
      required this.lastTimestamp,
      required this.nodePubkey,
      required this.priorVoter,
      required this.rootSlot,
      required this.votes,
      required this.version});
  factory VoteAccount.fromBuffer(List<int> data) {
    final version = LayoutConst.u32().deserialize(data.sublist(0, 4)).value;
    final decode = LayoutSerializable.decode(
        bytes: data.sublist(4), layout: _Utils.layout(version));
    return VoteAccount(
        version: version,
        authorizedVoters: (decode["authorizedVoters"] as List)
            .map((e) => AuthorizedVoter.fromJson(e))
            .toList(),
        authorizedWithdrawer: decode["authorizedWithdrawer"],
        commission: decode["commission"],
        epochCredits: (decode["epochCredits"] as List)
            .map((e) => EpochCredits.fromJson(e))
            .toList(),
        lastTimestamp: BlockTimestamp.fromJson(decode["lastTimestamp"]),
        nodePubkey: decode["nodePubkey"],
        priorVoter: PriorVoters.fromJson(decode["priorVoters"]),
        rootSlot: decode["rootSlot"],
        votes:
            (decode["votes"] as List).map((e) => Lockout.fromJson(e)).toList());
  }

  @override
  StructLayout get layout => _Utils.layout(version);
  @override
  Map<String, dynamic> serialize() {
    return {
      "authorizedVoters": authorizedVoters.map((e) => e.serialize()).toList(),
      "authorizedWithdrawer": authorizedWithdrawer,
      "commission": commission,
      "epochCredits": epochCredits.map((e) => e.serialize()).toList(),
      "lastTimestamp": lastTimestamp.serialize(),
      "nodePubkey": nodePubkey,
      "priorVoters": priorVoter.serialize(),
      "rootSlot": rootSlot,
      "votes": votes.map((e) => e.serialize()).toList()
    };
  }

  @override
  String toString() {
    return "VoteAccount.${serialize()}";
  }
}
