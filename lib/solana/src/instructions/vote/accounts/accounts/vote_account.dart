import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/vote/types/types.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static Structure layout(int version) => LayoutUtils.struct([
        LayoutUtils.publicKey('nodePubkey'),
        LayoutUtils.publicKey('authorizedWithdrawer'),
        LayoutUtils.u8('commission'),
        if (version > 1)
          LayoutUtils.rustVec(
              LayoutUtils.struct([
                LayoutUtils.u8(),
                ...Lockout.staticLayout.fields,
              ], "lockout"),
              property: 'votes')
        else
          LayoutUtils.rustVec(Lockout.staticLayout, property: 'votes'),
        LayoutUtils.optional(LayoutUtils.u64(), property: "rootSlot"),
        LayoutUtils.rustVec(AuthorizedVoter.staticLayout,
            property: 'authorizedVoters'),
        PriorVoters.staticLayout,
        LayoutUtils.rustVec(EpochCredits.staticLayout,
            property: 'epochCredits'),
        LayoutUtils.wrap(BlockTimestamp.staticLayout,
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
    final version = LayoutUtils.u32().decode(data.sublist(0, 4));
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
  Structure get layout => _Utils.layout(version);
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
