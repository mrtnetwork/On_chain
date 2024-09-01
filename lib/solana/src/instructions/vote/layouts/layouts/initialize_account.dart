import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/vote/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

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
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u32(property: "instruction"),
    LayoutConst.struct([
      SolanaLayoutUtils.publicKey("nodePubkey"),
      SolanaLayoutUtils.publicKey("authorizedVoter"),
      SolanaLayoutUtils.publicKey("authorizedWithdrawer"),
      LayoutConst.u8(property: "commission")
    ], property: "voteInit")
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  VoteProgramInstruction get instruction =>
      VoteProgramInstruction.initializeAccount;

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
