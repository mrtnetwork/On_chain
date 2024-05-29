import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/models/account/account_meta.dart';
import 'package:on_chain/solana/src/instructions/stake/constant.dart';
import 'package:on_chain/solana/src/instructions/stake/layouts/layouts.dart';
import 'package:on_chain/solana/src/instructions/system/constant.dart';
import 'package:on_chain/solana/src/models/transaction/instruction.dart';

class StakeProgram extends TransactionInstruction {
  StakeProgram({
    required List<AccountMeta> keys,
    required SolAddress programId,
    required ProgramLayout layout,
  }) : super(keys: keys, layout: layout, programId: programId);
  factory StakeProgram.fromBytes({
    required List<AccountMeta> keys,
    required List<int> instructionBytes,
    SolAddress programId = StakeProgramConst.programId,
  }) {
    return StakeProgram(
        layout: StakeProgramLayout.fromBytes(instructionBytes),
        keys: keys,
        programId: programId);
  }

  /// Generate an Initialize instruction to add to a Stake Create transactio
  factory StakeProgram.initialize(
      {required StakeInitializeLayout layout,
      required SolAddress stakePubkey}) {
    return StakeProgram(
        layout: layout,
        keys: [
          stakePubkey.toWritable(),
          SystemProgramConst.sysvarRentPubkey.toReadOnly(),
        ],
        programId: StakeProgramConst.programId);
  }

  /// Generate a Transaction that delegates Stake tokens to a validator
  /// Vote PublicKey. This transaction can also be used to redelegate Stake
  /// to a new validator Vote PublicKey.
  factory StakeProgram.delegate(
      {required SolAddress stakePubkey,
      required SolAddress authorizedPubkey,
      required SolAddress votePubkey}) {
    return StakeProgram(
        layout: const StakeDelegateLayout(),
        keys: [
          stakePubkey.toWritable(),
          votePubkey.toReadOnly(),
          SystemProgramConst.sysvarClockPubkey.toReadOnly(),
          SystemProgramConst.sysvarStakeHistoryPubkey.toReadOnly(),
          StakeProgramConst.stakeConfigId.toReadOnly(),
          authorizedPubkey.toSigner(),
        ],
        programId: StakeProgramConst.programId);
  }

  /// Generate a Transaction that authorizes a new PublicKey as Staker
  /// or Withdrawer on the Stake account.
  factory StakeProgram.authorize(
      {required StakeAuthorizeLayout layout,
      required SolAddress stakePubkey,
      required SolAddress authorizedPubkey,
      SolAddress? custodianPubkey}) {
    return StakeProgram(
        layout: layout,
        keys: [
          stakePubkey.toWritable(),
          SystemProgramConst.sysvarClockPubkey.toWritable(),
          authorizedPubkey.toSigner(),
          if (custodianPubkey != null) custodianPubkey.toSigner(),
        ],
        programId: StakeProgramConst.programId);
  }

  /// Generate a Transaction that authorizes a new PublicKey as Staker
  /// or Withdrawer on the Stake account.
  factory StakeProgram.authorizeWithSeed(
      {required StakeAuthorizeWithSeedLayout layout,
      required SolAddress stakePubkey,
      required SolAddress authorityBase,
      SolAddress? custodianPubkey}) {
    return StakeProgram(
        layout: layout,
        keys: [
          stakePubkey.toWritable(),
          authorityBase.toSigner(),
          SystemProgramConst.sysvarClockPubkey.toReadOnly(),
          if (custodianPubkey != null) custodianPubkey.toSigner(),
        ],
        programId: StakeProgramConst.programId);
  }

  /// Generate a Transaction that splits Stake tokens into another stake account
  factory StakeProgram.split(
      {required StakeSplitLayout layout,
      required SolAddress stakePubkey,
      required SolAddress authorizedPubkey,
      required SolAddress splitStakePubkey}) {
    return StakeProgram(
        layout: layout,
        keys: [
          stakePubkey.toWritable(),
          splitStakePubkey.toWritable(),
          authorizedPubkey.toSigner(),
        ],
        programId: StakeProgramConst.programId);
  }

  /// Generate a Transaction that merges Stake accounts.
  factory StakeProgram.merge(
      {required SolAddress stakePubkey,
      required SolAddress authorizedPubkey,
      required SolAddress sourceStakePubKey}) {
    return StakeProgram(
        layout: const StakeMergeLayout(),
        keys: [
          stakePubkey.toWritable(),
          sourceStakePubKey.toWritable(),
          SystemProgramConst.sysvarClockPubkey.toReadOnly(),
          SystemProgramConst.sysvarStakeHistoryPubkey.toReadOnly(),
          authorizedPubkey.toSigner(),
        ],
        programId: StakeProgramConst.programId);
  }

  /// Generate a Transaction that withdraws deactivated Stake tokens.
  factory StakeProgram.withdraw(
      {required StakeWithdrawLayout layout,
      required SolAddress stakePubkey,
      required SolAddress authorizedPubkey,
      required SolAddress toPubkey,
      SolAddress? custodianPubkey}) {
    return StakeProgram(
        layout: layout,
        keys: [
          stakePubkey.toWritable(),
          toPubkey.toWritable(),
          SystemProgramConst.sysvarClockPubkey.toReadOnly(),
          SystemProgramConst.sysvarStakeHistoryPubkey.toReadOnly(),
          authorizedPubkey.toSigner(),
          if (custodianPubkey != null) custodianPubkey.toSigner(),
        ],
        programId: StakeProgramConst.programId);
  }

  /// Generate a Transaction that deactivates Stake tokens.
  factory StakeProgram.deactivate(
      {required SolAddress stakePubkey, required SolAddress authorizedPubkey}) {
    return StakeProgram(
        layout: const StakeDeactivateLayout(),
        keys: [
          stakePubkey.toWritable(),
          SystemProgramConst.sysvarClockPubkey.toReadOnly(),
          authorizedPubkey.toSigner(),
        ],
        programId: StakeProgramConst.programId);
  }
}
