import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/models/account/account_meta.dart';
import 'package:on_chain/solana/src/instructions/system/constant.dart';
import 'package:on_chain/solana/src/instructions/vote/layouts/layouts.dart';
import 'package:on_chain/solana/src/instructions/vote/constant.dart';
import 'package:on_chain/solana/src/models/transaction/instruction.dart';

/// class for transactions to interact with the Vote program
class VoteProgram extends TransactionInstruction {
  VoteProgram({
    required super.keys,
    required super.programId,
    required ProgramLayout layout,
  }) : super(data: layout.toBytes());
  factory VoteProgram.fromBytes({
    required List<AccountMeta> keys,
    required List<int> instructionBytes,
    SolAddress programId = VoteProgramConst.programId,
  }) {
    return VoteProgram(
        layout: VoteProgramLayout.fromBytes(instructionBytes),
        keys: keys,
        programId: programId);
  }

  /// Generate an Initialize instruction.
  factory VoteProgram.initializeAccount(
      {required VoteProgramInitializeAccountLayout layout,
      required SolAddress votePubKey,
      required SolAddress nodePubKey}) {
    return VoteProgram(
        layout: layout,
        keys: [
          votePubKey.toWritable(),
          SystemProgramConst.sysvarRentPubkey.toReadOnly(),
          SystemProgramConst.sysvarClockPubkey.toReadOnly(),
          nodePubKey.toSigner(),
        ],
        programId: VoteProgramConst.programId);
  }

  /// Generate a transaction that authorizes a new Voter or Withdrawer on the Vote account.
  factory VoteProgram.authorize(
      {required VoteProgramAuthorizeLayout layout,
      required SolAddress votePubkey,
      required SolAddress authorizedPubkey}) {
    return VoteProgram(
        layout: layout,
        keys: [
          votePubkey.toWritable(),
          SystemProgramConst.sysvarClockPubkey.toReadOnly(),
          authorizedPubkey.toSigner(),
        ],
        programId: VoteProgramConst.programId);
  }

  /// Generate a transaction that authorizes a new Voter or Withdrawer on the Vote account
  /// where the current Voter or Withdrawer authority is a derived key.
  factory VoteProgram.authorizeWithSeed(
      {required VoteProgramAuthorizeWithSeedLayout layout,
      required SolAddress votePubkey,
      required SolAddress currentAuthorityDerivedKeyBasePubkey}) {
    return VoteProgram(
        layout: layout,
        keys: [
          votePubkey.toWritable(),
          SystemProgramConst.sysvarClockPubkey.toReadOnly(),
          currentAuthorityDerivedKeyBasePubkey.toSigner(),
        ],
        programId: VoteProgramConst.programId);
  }

  /// Generate a transaction to withdraw from a Vote account.
  factory VoteProgram.withdraw({
    required VoteProgramWithdrawLayout layout,
    required SolAddress votePubkey,
    required SolAddress authorizedWithdrawerPubkey,
    required SolAddress toPubkey,
  }) {
    return VoteProgram(
        layout: layout,
        keys: [
          votePubkey.toWritable(),
          toPubkey.toWritable(),
          authorizedWithdrawerPubkey.toSigner(),
        ],
        programId: VoteProgramConst.programId);
  }
}
