import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/vote/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// InitializeAccount layout.
class VoteProgramInitializeAccountLayout extends VoteProgramLayout {
  final SolAddress nodePubkey;
  final SolAddress authorizedVoter;
  final SolAddress authorizedWithdrawer;
  final int commission;

  const VoteProgramInitializeAccountLayout(
      {required this.nodePubkey,
      required this.authorizedVoter,
      required this.authorizedWithdrawer,
      required this.commission});
  factory VoteProgramInitializeAccountLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: VoteProgramInstruction.initializeAccount.insturction);
    final voteData = Map<String, dynamic>.from(decode["voteInit"]);
    return VoteProgramInitializeAccountLayout(
      nodePubkey: voteData["nodePubkey"],
      authorizedVoter: voteData["authorizedVoter"],
      authorizedWithdrawer: voteData["authorizedWithdrawer"],
      commission: voteData["commission"],
    );
  }
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u32("instruction"),
    LayoutUtils.struct([
      LayoutUtils.publicKey("nodePubkey"),
      LayoutUtils.publicKey("authorizedVoter"),
      LayoutUtils.publicKey("authorizedWithdrawer"),
      LayoutUtils.u8("commission")
    ], "voteInit")
  ]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction => VoteProgramInstruction.initializeAccount.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "voteInit": {
        "nodePubkey": nodePubkey,
        "authorizedVoter": authorizedVoter,
        "authorizedWithdrawer": authorizedWithdrawer,
        "commission": commission
      }
    };
  }
}
