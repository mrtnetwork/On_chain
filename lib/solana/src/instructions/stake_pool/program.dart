import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/program_layouts/core/program_layout.dart';
import 'package:on_chain/solana/src/models/account/account_meta.dart';
import 'package:on_chain/solana/src/instructions/spl_token/constant.dart';
import 'package:on_chain/solana/src/instructions/stake/constant.dart';
import 'package:on_chain/solana/src/instructions/stake_pool/constant.dart';
import 'package:on_chain/solana/src/instructions/stake_pool/layouts/layouts.dart';
import 'package:on_chain/solana/src/instructions/system/constant.dart';
import 'package:on_chain/solana/src/models/transaction/instruction.dart';

class StakePoolProgram extends TransactionInstruction {
  StakePoolProgram({
    required List<AccountMeta> keys,
    required SolAddress programId,
    required ProgramLayout layout,
  }) : super(keys: keys, layout: layout, programId: programId);
  factory StakePoolProgram.fromBytes({
    required List<AccountMeta> keys,
    required List<int> instructionBytes,
    SolAddress programId = StakePoolProgramConst.programId,
  }) {
    return StakePoolProgram(
        layout: StakePoolProgramLayout.fromBytes(instructionBytes),
        keys: keys,
        programId: programId);
  }

  /// Cleans up validator stake account entries marked as `ReadyForRemoval`
  factory StakePoolProgram.cleanupRemovedValidatorEntries({
    /// Stake pool
    required SolAddress stakePool,

    /// Validator stake list storage account
    required SolAddress validatorList,
  }) {
    return StakePoolProgram(
        layout: StakePoolCleanupRemovedValidatorEntriesLayout(),
        keys: [
          stakePool.toReadOnly(),
          validatorList.toWritable(),
        ],
        programId: StakePoolProgramConst.programId);
  }

  ///  Updates balances of validator and transient stake accounts in the pool
  ///
  ///  While going through the pairs of validator and transient stake
  ///  accounts, if the transient stake is inactive, it is merged into the
  ///  reserve stake account. If the transient stake is active and has
  ///  matching credits observed, it is merged into the canonical
  ///  validator stake account. In all other states, nothing is done, and
  ///  the balance is simply added to the canonical stake account balance.
  factory StakePoolProgram.updateValidatorListBalance({
    /// Stake pool
    required SolAddress stakePool,

    /// Stake pool withdraw authority
    required SolAddress withdrawAuthority,

    /// Validator stake list storage account
    required SolAddress validatorList,

    /// Reserve stake account
    required SolAddress reserveStake,

    /// pairs of validator and transient stake accounts
    required List<SolAddress> validatorAndTransientStakePairs,
    required StakePoolUpdateValidatorListBalanceLayout layout,
  }) {
    return StakePoolProgram(
        layout: layout,
        keys: [
          stakePool.toReadOnly(),
          withdrawAuthority.toReadOnly(),
          validatorList.toWritable(),
          reserveStake.toWritable(),
          SystemProgramConst.sysvarClockPubkey.toReadOnly(),
          SystemProgramConst.sysvarStakeHistoryPubkey.toReadOnly(),
          StakeProgramConst.programId.toReadOnly(),
          ...validatorAndTransientStakePairs.map((e) => e.toWritable())
        ],
        programId: StakePoolProgramConst.programId);
  }

  /// Updates total pool balance based on balances in the reserve and
  /// validator list
  factory StakePoolProgram.updateStakePoolBalance({
    /// Stake pool
    required SolAddress stakePool,

    /// Stake pool withdraw authority
    required SolAddress withdrawAuthority,

    /// Validator stake list storage account
    required SolAddress validatorList,

    /// Reserve stake account
    required SolAddress reserveStake,

    /// Account to receive pool fee tokens
    required SolAddress managerFeeAccount,

    /// Pool mint account
    required SolAddress poolMint,
  }) {
    return StakePoolProgram(
        layout: StakePoolUpdateStakePoolBalanceLayout(),
        keys: [
          stakePool.toWritable(),
          withdrawAuthority.toReadOnly(),
          validatorList.toWritable(),
          reserveStake.toReadOnly(),
          managerFeeAccount.toWritable(),
          poolMint.toWritable(),
          SPLTokenProgramConst.tokenProgramId.toReadOnly()
        ],
        programId: StakePoolProgramConst.programId);
  }

  /// (Staker only) Decrease active stake on a validator, eventually moving it
  /// to the reserve
  ///
  /// Internally, this instruction splits a validator stake account into its
  /// corresponding transient stake account and deactivates it.
  ///
  /// In order to rebalance the pool without taking custody, the staker needs
  /// a way of reducing the stake on a stake account. This instruction splits
  /// some amount of stake, up to the total activated stake, from the
  /// canonical validator stake account, into its "transient" stake
  /// account.
  factory StakePoolProgram.decreaseValidatorStake({
    /// Stake pool
    required SolAddress stakePool,

    /// Stake pool staker
    required SolAddress staker,

    /// Stake pool withdraw authority
    required SolAddress withdrawAuthority,

    /// Validator list
    required SolAddress validatorList,

    /// Canonical stake account to split from
    required SolAddress validatorStake,

    /// Transient stake account to receive split
    required SolAddress transientStake,
    required StakePoolDecreaseValidatorStakeLayout layout,
  }) {
    return StakePoolProgram(
        layout: layout,
        keys: [
          stakePool.toReadOnly(),
          staker.toSigner(),
          withdrawAuthority.toReadOnly(),
          validatorList.toWritable(),
          validatorStake.toWritable(),
          transientStake.toWritable(),
          SystemProgramConst.sysvarClockPubkey.toReadOnly(),
          SystemProgramConst.sysvarRentPubkey.toReadOnly(),
          SystemProgramConst.programId.toReadOnly(),
          StakeProgramConst.programId.toReadOnly(),
        ],
        programId: StakePoolProgramConst.programId);
  }

  /// (Staker only) Decrease active stake on a validator, eventually moving it
  /// to the reserve
  ///
  /// Internally, this instruction:
  /// * withdraws enough lamports to make the transient account rent-exempt
  /// * splits from a validator stake account into a transient stake account
  /// * deactivates the transient stake account
  ///
  /// In order to rebalance the pool without taking custody, the staker needs
  /// a way of reducing the stake on a stake account. This instruction splits
  /// some amount of stake, up to the total activated stake, from the
  /// canonical validator stake account, into its "transient" stake
  /// account.
  /// The instruction only succeeds if the transient stake account does not
  /// exist.
  factory StakePoolProgram.decreaseValidatorStakeWithReserve({
    /// Stake pool
    required SolAddress stakePool,

    /// Stake pool staker
    required SolAddress staker,

    /// Stake pool withdraw authority
    required SolAddress withdrawAuthority,

    /// Validator list
    required SolAddress validatorList,

    /// Canonical stake account to split from
    required SolAddress validatorStake,

    /// Transient stake account to receive split
    required SolAddress transientStake,

    /// Reserve stake account, to fund rent exempt reserve
    required SolAddress reserveStake,
    required StakePoolDecreaseValidatorStakeWithReserveLayout layout,
  }) {
    return StakePoolProgram(
        layout: layout,
        keys: [
          stakePool.toReadOnly(),
          staker.toSigner(),
          withdrawAuthority.toReadOnly(),
          validatorList.toWritable(),
          reserveStake.toWritable(),
          validatorStake.toWritable(),
          transientStake.toWritable(),
          SystemProgramConst.sysvarClockPubkey.toReadOnly(),
          SystemProgramConst.sysvarStakeHistoryPubkey.toReadOnly(),
          SystemProgramConst.programId.toReadOnly(),
          StakeProgramConst.programId.toReadOnly(),
        ],
        programId: StakePoolProgramConst.programId);
  }

  /// (Staker only) Decrease active stake again from a validator, eventually
  /// moving it to the reserve
  ///
  /// Works regardless if the transient stake account already exists.
  ///
  /// Internally, this instruction:
  ///
  ///  withdraws rent-exempt reserve lamports from the reserve into the
  ///  ephemeral stake
  ///
  ///  splits a validator stake account into an ephemeral stake account
  ///  deactivates the ephemeral account
  ///
  ///  merges or splits the ephemeral account into the transient stake
  ///  account delegated to the appropriate validator
  ///
  factory StakePoolProgram.decreaseAdditionalValidatorStake({
    /// Stake pool
    required SolAddress stakePool,

    /// Stake pool staker
    required SolAddress staker,

    /// Stake pool withdraw authority
    required SolAddress withdrawAuthority,

    /// Validator list
    required SolAddress validatorList,

    /// Canonical stake account to split from
    required SolAddress validatorStake,

    /// Transient stake account
    required SolAddress transientStake,

    /// Reserve stake account, to fund rent exempt reserve
    required SolAddress reserveStake,

    ///  Uninitialized ephemeral stake account to receive stake
    required SolAddress ephemeralStake,
    required StakePoolDecreaseAdditionalValidatorStakeLayout layout,
  }) {
    return StakePoolProgram(
        layout: layout,
        keys: [
          stakePool.toReadOnly(),
          staker.toSigner(),
          withdrawAuthority.toReadOnly(),
          validatorList.toWritable(),
          reserveStake.toWritable(),
          validatorStake.toWritable(),
          ephemeralStake.toWritable(),
          transientStake.toWritable(),
          SystemProgramConst.sysvarClockPubkey.toReadOnly(),
          SystemProgramConst.sysvarStakeHistoryPubkey.toReadOnly(),
          SystemProgramConst.programId.toReadOnly(),
          StakeProgramConst.programId.toReadOnly()
        ],
        programId: StakePoolProgramConst.programId);
  }

  /// (Staker only) Increase stake on a validator from the reserve account
  ///
  /// Internally, this instruction splits reserve stake into a transient stake
  /// account and delegate to the appropriate validator.
  /// `UpdateValidatorListBalance` will do the work of merging once it's
  /// ready.
  ///
  factory StakePoolProgram.increaseValidatorStake({
    /// Stake pool
    required SolAddress stakePool,

    /// Stake pool staker
    required SolAddress staker,

    /// Stake pool withdraw authority
    required SolAddress withdrawAuthority,

    /// Validator list
    required SolAddress validatorList,

    /// Stake pool reserve stake
    required SolAddress reserveStake,

    /// Transient stake account
    required SolAddress transientStake,

    /// Validator stake account
    required SolAddress validatorStake,

    /// Validator vote account to delegate to
    required SolAddress validatorVote,
    required StakePoolIncreaseValidatorStakeLayout layout,
  }) {
    return StakePoolProgram(
        layout: layout,
        keys: [
          stakePool.toReadOnly(),
          staker.toSigner(),
          withdrawAuthority.toReadOnly(),
          validatorList.toWritable(),
          reserveStake.toWritable(),
          transientStake.toWritable(),
          validatorStake.toReadOnly(),
          validatorVote.toReadOnly(),
          SystemProgramConst.sysvarClockPubkey.toReadOnly(),
          SystemProgramConst.sysvarRentPubkey.toReadOnly(),
          SystemProgramConst.sysvarStakeHistoryPubkey.toReadOnly(),
          StakeProgramConst.stakeConfigId.toReadOnly(),
          SystemProgramConst.programId.toReadOnly(),
          StakeProgramConst.programId.toReadOnly()
        ],
        programId: StakePoolProgramConst.programId);
  }

  /// (Staker only) Increase stake on a validator again in an epoch.
  ///
  /// Works regardless if the transient stake account exists.
  ///
  /// Internally, this instruction splits reserve stake into an ephemeral
  /// stake account, activates it, then merges or splits it into the
  /// transient stake account delegated to the appropriate validator.
  /// `UpdateValidatorListBalance` will do the work of merging once it's
  /// ready.
  ///
  factory StakePoolProgram.increaseAdditionalValidatorStake({
    /// Stake pool
    required SolAddress stakePool,

    /// Stake pool staker
    required SolAddress staker,

    /// Stake pool withdraw authority
    required SolAddress withdrawAuthority,

    /// Validator list
    required SolAddress validatorList,

    /// Stake pool reserve stake
    required SolAddress reserveStake,

    /// Transient stake account
    required SolAddress transientStake,

    /// Validator stake account
    required SolAddress validatorStake,

    /// Validator vote account to delegate to
    required SolAddress validatorVote,
    required StakePoolIncreaseAdditionalValidatorStakeLayout layout,

    /// Uninitialized ephemeral stake account to receive stake
    required SolAddress ephemeralStake,
  }) {
    return StakePoolProgram(
        layout: layout,
        keys: [
          stakePool.toReadOnly(),
          staker.toSigner(),
          withdrawAuthority.toReadOnly(),
          validatorList.toWritable(),
          reserveStake.toWritable(),
          ephemeralStake.toWritable(),
          transientStake.toWritable(),
          validatorStake.toReadOnly(),
          validatorVote.toReadOnly(),
          SystemProgramConst.sysvarClockPubkey.toReadOnly(),
          SystemProgramConst.sysvarStakeHistoryPubkey.toReadOnly(),
          StakeProgramConst.stakeConfigId.toReadOnly(),
          SystemProgramConst.programId.toReadOnly(),
          StakeProgramConst.programId.toReadOnly()
        ],
        programId: StakePoolProgramConst.programId);
  }

  /// Deposit some stake into the pool. The output is a "pool" token
  /// representing ownership into the pool. Inputs are converted to the
  /// current ratio.
  factory StakePoolProgram.depositStake({
    /// Stake pool
    required SolAddress stakePool,

    /// Validator stake list storage account
    required SolAddress validatorList,

    /// Stake pool deposit authority
    required SolAddress depositAuthority,

    /// Stake pool withdraw authority
    required SolAddress withdrawAuthority,

    /// Stake account to join the pool (withdraw authority for the
    /// stake account should be first set to the stake pool deposit
    /// authority)
    required SolAddress depositStake,

    /// Validator stake account for the stake account to be merged
    required SolAddress validatorStake,

    /// Reserve stake account, to withdraw rent exempt reserve
    required SolAddress reserveStake,

    /// User account to receive pool tokens
    required SolAddress destinationPoolAccount,

    /// Account to receive pool fee tokens
    required SolAddress managerFeeAccount,

    /// Account to receive a portion of pool fee tokens as referral
    /// fees
    required SolAddress referralPoolAccount,

    /// Pool token mint account
    required SolAddress poolMint,
  }) {
    return StakePoolProgram(
        layout: StakePoolDepositStakeLayout(),
        keys: [
          stakePool.toWritable(),
          validatorList.toWritable(),
          depositAuthority.toReadOnly(),
          withdrawAuthority.toReadOnly(),
          depositStake.toWritable(),
          validatorStake.toWritable(),
          reserveStake.toWritable(),
          destinationPoolAccount.toWritable(),
          managerFeeAccount.toWritable(),
          referralPoolAccount.toWritable(),
          poolMint.toWritable(),
          SystemProgramConst.sysvarClockPubkey.toReadOnly(),
          SystemProgramConst.sysvarStakeHistoryPubkey.toReadOnly(),
          SPLTokenProgramConst.tokenProgramId.toReadOnly(),
          StakeProgramConst.programId.toReadOnly()
        ],
        programId: StakePoolProgramConst.programId);
  }

  /// Withdraw the token from the pool at the current ratio.
  factory StakePoolProgram.withdrawStake({
    /// Stake pool
    required SolAddress stakePool,

    /// Validator stake list storage account
    required SolAddress validatorList,

    /// Stake pool withdraw authority
    required SolAddress withdrawAuthority,

    /// Validator or reserve stake account to split
    required SolAddress validatorStake,

    /// Unitialized stake account to receive withdrawal
    required SolAddress destinationStake,

    /// User account to set as a new withdraw authority
    required SolAddress destinationStakeAuthority,

    /// User transfer authority, for pool token account
    required SolAddress sourceTransferAuthority,

    /// User account with pool tokens to burn from
    required SolAddress sourcePoolAccount,

    /// Account to receive pool fee tokens
    required SolAddress managerFeeAccount,

    /// Pool token mint account
    required SolAddress poolMint,
    required StakePoolWithdrawStakeLayout layout,
  }) {
    return StakePoolProgram(
        layout: layout,
        keys: [
          stakePool.toWritable(),
          validatorList.toWritable(),
          withdrawAuthority.toReadOnly(),
          validatorStake.toWritable(),
          destinationStake.toWritable(),
          destinationStakeAuthority.toReadOnly(),
          sourceTransferAuthority.toSigner(),
          sourcePoolAccount.toWritable(),
          managerFeeAccount.toWritable(),
          poolMint.toWritable(),
          SystemProgramConst.sysvarClockPubkey.toReadOnly(),
          SPLTokenProgramConst.tokenProgramId.toReadOnly(),
          StakeProgramConst.programId.toReadOnly()
        ],
        programId: StakePoolProgramConst.programId);
  }

  /// Withdraw SOL directly from the pool's reserve account.
  factory StakePoolProgram.withdrawSol({
    /// Stake pool
    required SolAddress stakePool,

    /// User account to burn pool tokens
    required SolAddress sourcePoolAccount,

    /// Stake pool withdraw authority
    required SolAddress withdrawAuthority,

    /// Reserve stake account, to withdraw SOL
    required SolAddress reserveStake,

    /// Account receiving the lamports from the reserve, must be a
    /// system account
    required SolAddress destinationSystemAccount,

    /// User transfer authority, for pool token account
    required SolAddress sourceTransferAuthority,

    /// Account to receive pool fee tokens
    required SolAddress managerFeeAccount,

    /// Pool token mint account
    required SolAddress poolMint,
    required StakePoolWithdrawSolLayout layout,

    /// Stake pool sol withdraw authority
    SolAddress? solWithdrawAuthority,
  }) {
    return StakePoolProgram(
        layout: layout,
        keys: [
          stakePool.toWritable(),
          withdrawAuthority.toReadOnly(),
          sourceTransferAuthority.toSigner(),
          sourcePoolAccount.toWritable(),
          reserveStake.toWritable(),
          destinationSystemAccount.toWritable(),
          managerFeeAccount.toWritable(),
          poolMint.toWritable(),
          SystemProgramConst.sysvarClockPubkey.toReadOnly(),
          SystemProgramConst.sysvarStakeHistoryPubkey.toReadOnly(),
          StakeProgramConst.programId.toReadOnly(),
          SPLTokenProgramConst.tokenProgramId.toReadOnly(),
          if (solWithdrawAuthority != null) solWithdrawAuthority.toSigner()
        ],
        programId: StakePoolProgramConst.programId);
  }

  /// Deposit SOL directly into the pool's reserve account. The output is a
  /// "pool" token representing ownership into the pool. Inputs are
  /// converted to the current ratio.
  factory StakePoolProgram.depositSol({
    /// Stake pool
    required SolAddress stakePool,

    /// Stake pool withdraw authority
    required SolAddress withdrawAuthority,

    /// Reserve stake account, to deposit SOL
    required SolAddress reserveStake,

    /// Account providing the lamports to be deposited into the pool
    required SolAddress fundingAccount,

    /// User account to receive pool tokens
    required SolAddress destinationPoolAccount,

    /// Account to receive fee tokens
    required SolAddress managerFeeAccount,

    /// Account to receive a portion of fee as referral fees
    required SolAddress referralPoolAccount,

    /// Pool token mint account
    required SolAddress poolMint,
    required StakePoolDepositSolLayout layout,

    /// Stake pool sol deposit authority.
    SolAddress? depositAuthority,
  }) {
    return StakePoolProgram(
        layout: layout,
        keys: [
          stakePool.toWritable(),
          withdrawAuthority.toReadOnly(),
          reserveStake.toWritable(),
          fundingAccount.toSignerAndWritable(),
          destinationPoolAccount.toWritable(),
          managerFeeAccount.toWritable(),
          referralPoolAccount.toWritable(),
          poolMint.toWritable(),
          SystemProgramConst.programId.toReadOnly(),
          SPLTokenProgramConst.tokenProgramId.toReadOnly(),
          if (depositAuthority != null) depositAuthority.toSigner(),
        ],
        programId: StakePoolProgramConst.programId);
  }

  /// (Staker only) Redelegate active stake on a validator, eventually moving
  /// it to another
  ///
  /// Internally, this instruction splits a validator stake account into its
  /// corresponding transient stake account, redelegates it to an ephemeral
  /// stake account, then merges that stake into the destination transient
  /// stake account.
  ///
  /// In order to rebalance the pool without taking custody, the staker needs
  /// a way of reducing the stake on a stake account. This instruction splits
  /// some amount of stake, up to the total activated stake, from the
  /// canonical validator stake account, into its "transient" stake
  /// account.
  ///
  /// The instruction only succeeds if the source transient stake account and
  /// ephemeral stake account do not exist.
  ///
  /// The amount of lamports to move must be at least rent-exemption plus the
  /// minimum delegation amount. Rent-exemption plus minimum delegation
  /// is required for the destination ephemeral stake account.
  ///
  /// The rent-exemption for the source transient account comes from the stake
  /// pool reserve, if needed.
  ///
  factory StakePoolProgram.redelegate({
    /// Stake pool
    required SolAddress stakePool,

    /// Stake pool staker
    required SolAddress staker,

    /// Stake pool withdraw authority
    required SolAddress stakePoolWithdrawAuthority,

    /// Validator list
    required SolAddress validatorList,

    /// Reserve stake account, to withdraw rent exempt reserve
    required SolAddress reserveStake,

    /// Source canonical stake account to split from
    required SolAddress sourceValidatorStake,

    /// Source transient stake account to receive split and be
    /// redelegated
    required SolAddress sourceTransientStake,

    /// Uninitialized ephemeral stake account to receive redelegation
    required SolAddress ephemeralStake,

    /// Destination transient stake account to receive ephemeral stake
    /// by merge
    required SolAddress destinationTransientStake,

    /// Destination stake account to receive transient stake after
    /// activation
    required SolAddress destinationValidatorStake,

    /// Destination validator vote account
    required SolAddress validator,
    required StakePoolReDelegateLayout layout,
  }) {
    return StakePoolProgram(
        layout: layout,
        keys: [
          stakePool.toReadOnly(),
          staker.toSigner(),
          stakePoolWithdrawAuthority.toReadOnly(),
          validatorList.toWritable(),
          reserveStake.toWritable(),
          sourceValidatorStake.toWritable(),
          sourceTransientStake.toWritable(),
          ephemeralStake.toWritable(),
          destinationTransientStake.toWritable(),
          destinationValidatorStake.toReadOnly(),
          validator.toReadOnly(),
          SystemProgramConst.sysvarClockPubkey.toReadOnly(),
          SystemProgramConst.sysvarStakeHistoryPubkey.toReadOnly(),
          StakeProgramConst.stakeConfigId.toReadOnly(),
          SystemProgramConst.programId.toReadOnly(),
          StakeProgramConst.programId.toReadOnly()
        ],
        programId: StakePoolProgramConst.programId);
  }

  /// Create token metadata for the stake-pool token in the
  /// metaplex-token program
  factory StakePoolProgram.createTokenMetadata({
    /// Stake pool
    required SolAddress stakePool,

    /// Manager
    required SolAddress manager,

    /// Token metadata account
    required SolAddress tokenMetadata,

    /// Stake pool withdraw authority
    required SolAddress withdrawAuthority,

    /// Pool token mint account
    required SolAddress poolMint,

    /// Payer for creation of token metadata account
    required SolAddress payer,
    required StakePoolCreateTokenMetaDataLayout layout,
  }) {
    return StakePoolProgram(
        layout: layout,
        keys: [
          stakePool.toReadOnly(),
          manager.toSigner(),
          withdrawAuthority.toReadOnly(),
          poolMint.toReadOnly(),
          payer.toSignerAndWritable(),
          tokenMetadata.toWritable(),
          SPLTokenProgramConst.metaDataProgramId.toReadOnly(),
          SystemProgramConst.programId.toReadOnly(),
          SystemProgramConst.sysvarRentPubkey.toReadOnly(),
        ],
        programId: StakePoolProgramConst.programId);
  }

  /// Update token metadata for the stake-pool token in the
  /// metaplex-token program
  factory StakePoolProgram.updateTokenMetadata(
      {
      /// Stake pool
      required SolAddress stakePool,

      /// Manager
      required SolAddress manager,

      /// Token metadata account
      required SolAddress tokenMetadata,

      /// Stake pool withdraw authority
      required SolAddress withdrawAuthority,
      required StakePoolUpdateTokenMetaDataLayout layout}) {
    return StakePoolProgram(
        layout: layout,
        keys: [
          stakePool.toReadOnly(),
          manager.toSigner(),
          withdrawAuthority.toReadOnly(),
          tokenMetadata.toWritable(),
          SPLTokenProgramConst.metaDataProgramId.toReadOnly(),
        ],
        programId: StakePoolProgramConst.programId);
  }
}
