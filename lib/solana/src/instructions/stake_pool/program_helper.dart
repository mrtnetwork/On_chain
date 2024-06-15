import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/instructions.dart';
import 'package:on_chain/solana/src/instructions/stake_pool/rpc/rpcs/get_stake_validator_list_account.dart';
import 'package:on_chain/solana/src/models/models.dart';
import 'package:on_chain/solana/src/rpc/rpc.dart';
import 'dart:math' as math;
import 'utils.dart';

class StakePoolProgramHelper {
  /// Creates instructions required to deposit stake to stake pool.
  static Future<List<TransactionInstruction>> depositStake({
    required SolanaRPC rpc,
    required SolAddress stakePoolAddress,
    required SolAddress authorizedPubkey,
    required SolAddress validatorVote,
    required SolAddress depositStake,
    required SolAddress? poolTokenReceiverAccount,
  }) async {
    final stakePool = await rpc
        .request(SolanaRPCGetStakePoolAccount(address: stakePoolAddress));
    if (stakePool == null) {
      throw const MessageException("Stake pool account does not found.");
    }
    final withdrawAuthority =
        StakePoolProgramUtils.findWithdrawAuthorityProgramAddress(
            stakePoolAddress: stakePoolAddress);
    final validatorStake = StakePoolProgramUtils.findStakeProgramAddress(
        voteAccountAddress: validatorVote, stakePoolAddress: stakePoolAddress);
    final instructions = <TransactionInstruction>[];
    final poolMint = stakePool.poolMint;
    // Create token account if not specified
    if (poolTokenReceiverAccount == null) {
      final associatedAddress =
          AssociatedTokenAccountProgramUtils.associatedTokenAccount(
              mint: poolMint, owner: authorizedPubkey);
      instructions.add(
          AssociatedTokenAccountProgram.associatedTokenAccountIdempotent(
              payer: authorizedPubkey,
              associatedToken: associatedAddress.address,
              owner: authorizedPubkey,
              mint: poolMint));
      poolTokenReceiverAccount = associatedAddress.address;
    }
    instructions.add(StakeProgram.authorize(
      stakePubkey: depositStake,
      authorizedPubkey: authorizedPubkey,
      layout: StakeAuthorizeLayout(
          newAuthorized: stakePool.stakeDepositAuthority,
          stakeAuthorizationType: 0),
    ));

    instructions.add(StakeProgram.authorize(
      stakePubkey: depositStake,
      authorizedPubkey: authorizedPubkey,
      layout: StakeAuthorizeLayout(
          newAuthorized: stakePool.stakeDepositAuthority,
          stakeAuthorizationType: 1),
    ));

    instructions.add(StakePoolProgram.depositStake(
      stakePool: stakePoolAddress,
      validatorList: stakePool.validatorList,
      depositAuthority: stakePool.stakeDepositAuthority,
      reserveStake: stakePool.reserveStake,
      managerFeeAccount: stakePool.managerFeeAccount,
      referralPoolAccount: poolTokenReceiverAccount,
      destinationPoolAccount: poolTokenReceiverAccount,
      withdrawAuthority: withdrawAuthority.address,
      depositStake: depositStake,
      validatorStake: validatorStake.address,
      poolMint: poolMint,
    ));

    return instructions;
  }

  /// Creates instructions required to deposit sol to stake pool.
  static Future<List<TransactionInstruction>> depositSol({
    required SolanaRPC connection,
    required SolAddress stakePoolAddress,
    required SolAddress from,
    required SolAddress userSolTransfer,
    required BigInt lamports,
    SolAddress? destinationTokenAccount,
    SolAddress? referrerTokenAccount,
    required SolAddress depositAuthority,
  }) async {
    final fromBalance =
        await connection.request(SolanaRPCGetBalance(account: from));
    if (fromBalance < lamports) {
      throw const MessageException('Not enough SOL to deposit into pool.');
    }

    final stakePool = await connection
        .request(SolanaRPCGetStakePoolAccount(address: stakePoolAddress));
    if (stakePool == null) {
      throw const MessageException("Stake pool account does not found.");
    }

    final instructions = <TransactionInstruction>[];

    // Create the ephemeral SOL account
    instructions.add(SystemProgram.transfer(
      from: from,
      to: userSolTransfer,
      layout: SystemTransferLayout(lamports: lamports),
    ));

    // Create token account if not specified
    if (destinationTokenAccount == null) {
      final associatedAddress =
          AssociatedTokenAccountProgramUtils.associatedTokenAccount(
              mint: stakePool.poolMint, owner: from);
      instructions
          .add(AssociatedTokenAccountProgram.associatedTokenAccountIdempotent(
        payer: from,
        associatedToken: associatedAddress.address,
        owner: from,
        mint: stakePool.poolMint,
      ));
      destinationTokenAccount = associatedAddress.address;
    }

    final withdrawAuthority =
        StakePoolProgramUtils.findWithdrawAuthorityProgramAddress(
            stakePoolAddress: stakePoolAddress);
    instructions.add(StakePoolProgram.depositSol(
      stakePool: stakePoolAddress,
      reserveStake: stakePool.reserveStake,
      fundingAccount: userSolTransfer,
      destinationPoolAccount: destinationTokenAccount,
      managerFeeAccount: stakePool.managerFeeAccount,
      referralPoolAccount: referrerTokenAccount ?? destinationTokenAccount,
      poolMint: stakePool.poolMint,
      layout: StakePoolDepositSolLayout(lamports: lamports),
      withdrawAuthority: withdrawAuthority.address,
      depositAuthority: depositAuthority,
    ));

    return instructions;
  }

  /// Creates instructions required to withdraw SOL directly from a stake pool.
  static Future<List<TransactionInstruction>> withdrawSol({
    required SolanaRPC connection,
    required SolAddress stakePoolAddress,
    required SolAddress tokenOwner,
    required SolAddress solReceiver,
    required SolAddress userTransferAuthority,
    required BigInt poolAmountLamports,
    SolAddress? solWithdrawAuthority,
  }) async {
    final stakePool = await connection
        .request(SolanaRPCGetStakePoolAccount(address: stakePoolAddress));
    if (stakePool == null) {
      throw const MessageException("Stake pool account does not found.");
    }

    final poolTokenAccount =
        AssociatedTokenAccountProgramUtils.associatedTokenAccount(
      mint: stakePool.poolMint,
      owner: tokenOwner,
    );

    final tokenAccount = await connection
        .request(SolanaRPCGetAccountInfo(account: poolTokenAccount.address));
    if (tokenAccount == null) {
      throw const MessageException("Token account not found.");
    }
    // Check withdrawFrom balance
    if (tokenAccount.lamports < poolAmountLamports) {
      throw const MessageException('Not enough token balance to withdraw.');
    }

    // Construct transaction to withdraw from withdrawAccounts account list
    final instructions = <TransactionInstruction>[];

    instructions.add(
      SPLTokenProgram.approve(
        account: poolTokenAccount.address,
        delegate: userTransferAuthority,
        owner: tokenOwner,
        layout: SPLTokenApproveLayout(amount: poolAmountLamports),
      ),
    );

    final poolWithdrawAuthority =
        StakePoolProgramUtils.findWithdrawAuthorityProgramAddress(
            stakePoolAddress: stakePoolAddress);

    if (solWithdrawAuthority != null) {
      if (stakePool.solWithdrawAuthority == null) {
        throw const MessageException(
            'SOL withdraw authority specified in arguments but stake pool has none');
      }
      if (solWithdrawAuthority.address !=
          stakePool.solWithdrawAuthority?.address) {
        throw const MessageException("Invalid deposit withdraw specified");
      }
    }

    instructions.add(StakePoolProgram.withdrawSol(
      stakePool: stakePoolAddress,
      withdrawAuthority: poolWithdrawAuthority.address,
      reserveStake: stakePool.reserveStake,
      sourcePoolAccount: poolTokenAccount.address,
      sourceTransferAuthority: userTransferAuthority,
      destinationSystemAccount: solReceiver,
      managerFeeAccount: stakePool.managerFeeAccount,
      poolMint: stakePool.poolMint,
      layout: StakePoolWithdrawSolLayout(poolTokens: poolAmountLamports),
      solWithdrawAuthority: solWithdrawAuthority,
    ));

    return instructions;
  }

  /// Creates instructions required to increase validator stake.
  static Future<List<TransactionInstruction>> increaseValidatorStake({
    required SolanaRPC connection,
    required SolAddress stakePoolAddress,
    required SolAddress validatorVote,
    required BigInt lamports,
    BigInt? ephemeralStakeSeed,
  }) async {
    final stakePool = await connection
        .request(SolanaRPCGetStakePoolAccount(address: stakePoolAddress));
    if (stakePool == null) {
      throw const MessageException("Stake pool account does not found.");
    }
    final validatorList = await connection.request(
        SolanaRPCGetStakePoolValidatorListAccount(
            address: stakePool.validatorList.address));
    if (validatorList == null) {
      throw const MessageException("Validator list account does not found.");
    }

    final validatorInfo = validatorList.validators.firstWhere(
      (v) => v.voteAccountAddress.address == validatorVote.address,
      orElse: () => throw const MessageException(
          'Vote account not found in validator list'),
    );

    final withdrawAuthority =
        StakePoolProgramUtils.findWithdrawAuthorityProgramAddress(
      stakePoolAddress: stakePoolAddress,
    );
// bump up by one to avoid reuse
    final transientStakeSeed =
        validatorInfo.transientSeedSuffixStart + BigInt.one;

    final transientStake =
        StakePoolProgramUtils.findTransientStakeProgramAddress(
      voteAccountAddress: validatorInfo.voteAccountAddress,
      stakePoolAddress: stakePoolAddress,
      seed: transientStakeSeed,
    );

    final validatorStake = StakePoolProgramUtils.findStakeProgramAddress(
      voteAccountAddress: validatorInfo.voteAccountAddress,
      stakePoolAddress: stakePoolAddress,
    );

    final instructions = <TransactionInstruction>[];

    if (ephemeralStakeSeed != null) {
      final ephemeralStake =
          StakePoolProgramUtils.findEphemeralStakeProgramAddress(
        stakePoolAddress: stakePoolAddress,
        seed: ephemeralStakeSeed,
      );
      instructions.add(
        StakePoolProgram.increaseAdditionalValidatorStake(
            stakePool: stakePoolAddress,
            staker: stakePool.staker,
            validatorList: stakePool.validatorList,
            reserveStake: stakePool.reserveStake,
            withdrawAuthority: withdrawAuthority.address,
            transientStake: transientStake.address,
            validatorStake: validatorStake.address,
            validatorVote: validatorVote,
            ephemeralStake: ephemeralStake.address,
            layout: StakePoolIncreaseAdditionalValidatorStakeLayout(
                lamports: lamports,
                ephemeralStakeSeed: ephemeralStakeSeed,
                transientStakeSeed: transientStakeSeed)),
      );
    } else {
      instructions.add(
        StakePoolProgram.increaseValidatorStake(
          stakePool: stakePoolAddress,
          staker: stakePool.staker,
          validatorList: stakePool.validatorList,
          reserveStake: stakePool.reserveStake,
          withdrawAuthority: withdrawAuthority.address,
          transientStake: transientStake.address,
          validatorStake: validatorStake.address,
          validatorVote: validatorVote,
          layout: StakePoolIncreaseValidatorStakeLayout(
              lamports: lamports, transientStakeSeed: transientStakeSeed),
        ),
      );
    }

    return instructions;
  }

  /// Creates instructions required to decrease validator stake.
  static Future<List<TransactionInstruction>> decreaseValidatorStake(
    SolanaRPC connection,
    SolAddress stakePoolAddress,
    SolAddress validatorVote,
    BigInt lamports, {
    BigInt? ephemeralStakeSeed,
  }) async {
    final stakePool = await connection
        .request(SolanaRPCGetStakePoolAccount(address: stakePoolAddress));
    if (stakePool == null) {
      throw const MessageException("Stake pool account does not found.");
    }
    final validatorList = await connection.request(
        SolanaRPCGetStakePoolValidatorListAccount(
            address: stakePool.validatorList.address));
    if (validatorList == null) {
      throw const MessageException("Validator list account does not found.");
    }

    final validatorInfo = validatorList.validators.firstWhere(
      (v) => v.voteAccountAddress.address == validatorVote.address,
      orElse: () => throw const MessageException(
          'Vote account not found in validator list'),
    );

    final withdrawAuthority =
        StakePoolProgramUtils.findWithdrawAuthorityProgramAddress(
            stakePoolAddress: stakePoolAddress);

    final validatorStake = StakePoolProgramUtils.findStakeProgramAddress(
      voteAccountAddress: validatorInfo.voteAccountAddress,
      stakePoolAddress: stakePoolAddress,
    );
    // bump up by one to avoid reuse
    final transientStakeSeed =
        validatorInfo.transientSeedSuffixStart + BigInt.one;

    final transientStake =
        StakePoolProgramUtils.findTransientStakeProgramAddress(
      voteAccountAddress: validatorInfo.voteAccountAddress,
      stakePoolAddress: stakePoolAddress,
      seed: transientStakeSeed,
    );

    final instructions = <TransactionInstruction>[];

    if (ephemeralStakeSeed != null) {
      final ephemeralStake =
          StakePoolProgramUtils.findEphemeralStakeProgramAddress(
        stakePoolAddress: stakePoolAddress,
        seed: ephemeralStakeSeed,
      );
      instructions.add(
        StakePoolProgram.decreaseAdditionalValidatorStake(
            stakePool: stakePoolAddress,
            staker: stakePool.staker,
            validatorList: stakePool.validatorList,
            reserveStake: stakePool.reserveStake,
            withdrawAuthority: withdrawAuthority.address,
            validatorStake: validatorStake.address,
            transientStake: transientStake.address,
            ephemeralStake: ephemeralStake.address,
            layout: StakePoolDecreaseAdditionalValidatorStakeLayout(
                lamports: lamports,
                ephemeralStakeSeed: ephemeralStakeSeed,
                transientStakeSeed: transientStakeSeed)),
      );
    } else {
      instructions.add(
        StakePoolProgram.decreaseValidatorStakeWithReserve(
            stakePool: stakePoolAddress,
            staker: stakePool.staker,
            validatorList: stakePool.validatorList,
            reserveStake: stakePool.reserveStake,
            withdrawAuthority: withdrawAuthority.address,
            validatorStake: validatorStake.address,
            transientStake: transientStake.address,
            layout: StakePoolDecreaseValidatorStakeWithReserveLayout(
                lamports: lamports, transientStakeSeed: transientStakeSeed)),
      );
    }

    return instructions;
  }

  /// Creates instructions required to completely update a stake pool after epoch change.
  static Future<
          Tuple<List<TransactionInstruction>, List<TransactionInstruction>>>
      updateStakePool(SolanaRPC connection, StakePoolAccount stakePool,
          {bool noMerge = false}) async {
    final stakePoolAddress = stakePool.address;

    final validatorList = await connection.request(
        SolanaRPCGetStakePoolValidatorListAccount(
            address: stakePool.validatorList.address));
    if (validatorList == null) {
      throw const MessageException("Validator list account does not found.");
    }
    final withdrawAuthority =
        StakePoolProgramUtils.findWithdrawAuthorityProgramAddress(
      stakePoolAddress: stakePoolAddress,
    );

    final updateListInstructions = <TransactionInstruction>[];
    final instructions = <TransactionInstruction>[];

    int startIndex = 0;
    List<List<ValidatorStakeInfo>> validatorChunks =
        _arrayChunk(validatorList.validators, 5);

    for (final validatorChunk in validatorChunks) {
      final List<SolAddress> validatorAndTransientStakePairs = [];

      for (final validator in validatorChunk) {
        final validatorStake = StakePoolProgramUtils.findStakeProgramAddress(
            voteAccountAddress: validator.voteAccountAddress,
            stakePoolAddress: stakePoolAddress);
        validatorAndTransientStakePairs.add(validatorStake.address);
        final transientStake =
            StakePoolProgramUtils.findTransientStakeProgramAddress(
          voteAccountAddress: validator.voteAccountAddress,
          stakePoolAddress: stakePoolAddress,
          seed: validator.transientSeedSuffixStart,
        );
        validatorAndTransientStakePairs.add(transientStake.address);
      }
      updateListInstructions.add(
        StakePoolProgram.updateValidatorListBalance(
          stakePool: stakePoolAddress,
          validatorList: stakePool.validatorList,
          reserveStake: stakePool.reserveStake,
          validatorAndTransientStakePairs: validatorAndTransientStakePairs,
          withdrawAuthority: withdrawAuthority.address,
          layout: StakePoolUpdateValidatorListBalanceLayout(
              startIndex: startIndex, noMerge: noMerge),
        ),
      );
      startIndex += 5;
    }

    instructions.add(
      StakePoolProgram.updateStakePoolBalance(
        stakePool: stakePoolAddress,
        validatorList: stakePool.validatorList,
        reserveStake: stakePool.reserveStake,
        managerFeeAccount: stakePool.managerFeeAccount,
        poolMint: stakePool.poolMint,
        withdrawAuthority: withdrawAuthority.address,
      ),
    );

    instructions.add(
      StakePoolProgram.cleanupRemovedValidatorEntries(
        stakePool: stakePoolAddress,
        validatorList: stakePool.validatorList,
      ),
    );
    return Tuple(updateListInstructions, instructions);
  }

  /// Creates instructions required to redelegate stake.
  static Future<List<TransactionInstruction>> redelegate({
    required SolanaRPC connection,
    required SolAddress stakePoolAddress,
    required SolAddress sourceVoteAccount,
    required BigInt sourceTransientStakeSeed,
    required SolAddress destinationVoteAccount,
    required BigInt destinationTransientStakeSeed,
    required BigInt ephemeralStakeSeed,
    required BigInt lamports,
  }) async {
    final stakePool = await connection
        .request(SolanaRPCGetStakePoolAccount(address: stakePoolAddress));
    if (stakePool == null) {
      throw const MessageException("Stake pool account does not found.");
    }

    final stakePoolWithdrawAuthority =
        StakePoolProgramUtils.findWithdrawAuthorityProgramAddress(
      stakePoolAddress: stakePoolAddress,
    );

    final sourceValidatorStake = StakePoolProgramUtils.findStakeProgramAddress(
      voteAccountAddress: sourceVoteAccount,
      stakePoolAddress: stakePoolAddress,
    );

    final sourceTransientStake =
        StakePoolProgramUtils.findTransientStakeProgramAddress(
      voteAccountAddress: sourceVoteAccount,
      stakePoolAddress: stakePoolAddress,
      seed: sourceTransientStakeSeed,
    );

    final destinationValidatorStake =
        StakePoolProgramUtils.findStakeProgramAddress(
      voteAccountAddress: destinationVoteAccount,
      stakePoolAddress: stakePoolAddress,
    );

    final destinationTransientStake =
        StakePoolProgramUtils.findTransientStakeProgramAddress(
      voteAccountAddress: destinationVoteAccount,
      stakePoolAddress: stakePoolAddress,
      seed: destinationTransientStakeSeed,
    );
    final ephemeralStake =
        StakePoolProgramUtils.findEphemeralStakeProgramAddress(
      stakePoolAddress: stakePoolAddress,
      seed: ephemeralStakeSeed,
    );

    final instructions = <TransactionInstruction>[];

    instructions.add(
      StakePoolProgram.redelegate(
          stakePool: stakePool.address,
          staker: stakePool.staker,
          validatorList: stakePool.validatorList,
          reserveStake: stakePool.reserveStake,
          stakePoolWithdrawAuthority: stakePoolWithdrawAuthority.address,
          ephemeralStake: ephemeralStake.address,
          sourceValidatorStake: sourceValidatorStake.address,
          sourceTransientStake: sourceTransientStake.address,
          destinationValidatorStake: destinationValidatorStake.address,
          destinationTransientStake: destinationTransientStake.address,
          validator: destinationVoteAccount,
          layout: StakePoolReDelegateLayout(
              lamports: lamports,
              sourceTransientStakeSeed: sourceTransientStakeSeed,
              ephemeralStakeSeed: ephemeralStakeSeed,
              destinationTransientStakeSeed: destinationTransientStakeSeed)),
    );

    return instructions;
  }

  /// Creates instructions required to create pool token metadata.
  static Future<List<TransactionInstruction>> createPoolTokenMetadata({
    required SolanaRPC rpc,
    required SolAddress stakePoolAddress,
    required SolAddress payer,
    required String name,
    required String symbol,
    required String uri,
  }) async {
    final stakePool = await rpc
        .request(SolanaRPCGetStakePoolAccount(address: stakePoolAddress));
    if (stakePool == null) {
      throw const MessageException("Stake pool account does not found.");
    }

    final withdrawAuthority =
        StakePoolProgramUtils.findWithdrawAuthorityProgramAddress(
      stakePoolAddress: stakePoolAddress,
    );
    final tokenMetadata = StakePoolProgramUtils.findMetadataAddress(
        stakePoolMintAddress: stakePool.poolMint);
    final instructions = <TransactionInstruction>[];
    instructions.add(
      StakePoolProgram.createTokenMetadata(
          stakePool: stakePoolAddress,
          poolMint: stakePool.poolMint,
          payer: payer,
          manager: stakePool.manager,
          tokenMetadata: tokenMetadata.address,
          withdrawAuthority: withdrawAuthority.address,
          layout: StakePoolCreateTokenMetaDataLayout(
              name: name, uri: uri, symbol: symbol)),
    );

    return instructions;
  }

  /// Creates instructions required to update pool token metadata.
  static Future<List<TransactionInstruction>> updatePoolTokenMetadata({
    required SolanaRPC rpc,
    required SolAddress stakePoolAddress,
    required String name,
    required String symbol,
    required String uri,
  }) async {
    final stakePool = await rpc
        .request(SolanaRPCGetStakePoolAccount(address: stakePoolAddress));
    if (stakePool == null) {
      throw const MessageException("Stake pool account does not found.");
    }

    final withdrawAuthority =
        StakePoolProgramUtils.findWithdrawAuthorityProgramAddress(
            stakePoolAddress: stakePoolAddress);

    final tokenMetadata = StakePoolProgramUtils.findMetadataAddress(
        stakePoolMintAddress: stakePool.poolMint);

    final instructions = <TransactionInstruction>[];
    instructions.add(
      StakePoolProgram.updateTokenMetadata(
          stakePool: stakePoolAddress,
          manager: stakePool.manager,
          tokenMetadata: tokenMetadata.address,
          withdrawAuthority: withdrawAuthority.address,
          layout: StakePoolUpdateTokenMetaDataLayout(
              name: name, uri: uri, symbol: symbol)),
    );

    return instructions;
  }

  static Future<List<WithdrawAccount>> prepareWithdrawAccounts({
    required SolanaRPC connection,
    required StakePoolAccount stakePool,
    required SolAddress stakePoolAddress,
    required BigInt amount,
    bool skipFee = false,
    Comparator<ValidatorAccount>? compareFn,
  }) async {
    final validatorList = await connection.request(
        SolanaRPCGetStakePoolValidatorListAccount(
            address: stakePool.validatorList.address));
    if (validatorList == null || validatorList.validators.isEmpty) {
      throw const MessageException("Validator list account does not found.");
    }

    final minBalanceForRentExemption = await connection.request(
        SolanaRPCGetMinimumBalanceForRentExemption(
            size: StakeProgramConst.stakeProgramSpace.toInt()));
    final minBalance =
        minBalanceForRentExemption + StakePoolProgramConst.minimumActiveStake;

    final List<ValidatorAccount> accounts = [];

    // Prepare accounts
    for (final validator in validatorList.validators) {
      if (validator.status != ValidatorStakeInfoStatus.active) {
        continue;
      }

      final stakeAccountAddress = StakePoolProgramUtils.findStakeProgramAddress(
        voteAccountAddress: validator.voteAccountAddress,
        stakePoolAddress: stakePoolAddress,
      );

      if (validator.activeStakeLamports != BigInt.zero) {
        final isPreferred =
            stakePool.preferredWithdrawValidatorVoteAddress?.address ==
                validator.voteAccountAddress.address;
        accounts.add(ValidatorAccount(
          type: isPreferred
              ? ValidatorAccountType.preferred
              : ValidatorAccountType.active,
          voteAddress: validator.voteAccountAddress,
          stakeAddress: stakeAccountAddress.address,
          lamports: validator.activeStakeLamports,
        ));
      }

      final transientStakeLamports =
          validator.transientStakeLamports - minBalance;
      if (transientStakeLamports > BigInt.zero) {
        final transientStakeAccountAddress =
            StakePoolProgramUtils.findTransientStakeProgramAddress(
          voteAccountAddress: validator.voteAccountAddress,
          stakePoolAddress: stakePoolAddress,
          seed: validator.transientSeedSuffixStart,
        );
        accounts.add(ValidatorAccount(
          type: ValidatorAccountType.transient,
          voteAddress: validator.voteAccountAddress,
          stakeAddress: transientStakeAccountAddress.address,
          lamports: transientStakeLamports,
        ));
      }
    }

    // Sort from highest to lowest balance
    accounts.sort(compareFn ?? (a, b) => b.lamports.compareTo(a.lamports));

    final reserveStake = await connection
        .request(SolanaRPCGetAccountInfo(account: stakePool.reserveStake));

    final reserveStakeBalance =
        (reserveStake?.lamports ?? BigInt.zero) - minBalanceForRentExemption;
    if (reserveStakeBalance > BigInt.zero) {
      accounts.add(
        ValidatorAccount(
          type: ValidatorAccountType.reserve,
          stakeAddress: stakePool.reserveStake,
          lamports: reserveStakeBalance,
        ),
      );
    }

    // Prepare the list of accounts to withdraw from
    final withdrawFrom = <WithdrawAccount>[];
    BigInt remainingAmount = amount;

    final fee = stakePool.stakeWithdrawalFee;
    final inverseFee = StakePoolFee(
      numerator: fee.denominator - fee.numerator,
      denominator: fee.denominator,
    );

    for (final type in ValidatorAccountType.values) {
      final filteredAccounts = accounts.where((a) => a.type == type);
      for (final i in filteredAccounts) {
        if (i.lamports <= minBalance &&
            type == ValidatorAccountType.transient) {
          continue;
        }
        BigInt availableForWithdrawal =
            calcPoolTokensForDeposit(stakePool, i.lamports);
        if (!skipFee && inverseFee.numerator != BigInt.zero) {
          availableForWithdrawal = BigRational(
            availableForWithdrawal * inverseFee.denominator,
            denominator: inverseFee.numerator,
          ).toBigInt();
        }

        final poolAmount = availableForWithdrawal < remainingAmount
            ? availableForWithdrawal
            : remainingAmount;
        if (poolAmount <= BigInt.zero) {
          continue;
        }

        // Those accounts will be withdrawn completely with `claim` instruction
        withdrawFrom.add(WithdrawAccount(
            stakeAddress: i.stakeAddress,
            voteAddress: i.voteAddress,
            poolAmount: poolAmount));
        remainingAmount -= poolAmount;

        if (remainingAmount == BigInt.zero) {
          break;
        }
      }

      if (remainingAmount == BigInt.zero) {
        break;
      }
    }

    // Not enough stake to withdraw the specified amount
    if (remainingAmount > BigInt.zero) {
      throw const MessageException(
          'No stake accounts found in this pool with enough balance to withdraw.');
    }

    return withdrawFrom;
  }

  ///  Calculate the pool tokens that should be minted for a deposit of [stakeLamports]
  static BigInt calcPoolTokensForDeposit(
      StakePoolAccount stakePoolAccount, BigInt stakeLamports) {
    if (stakePoolAccount.poolTokenSupply == BigInt.zero ||
        stakePoolAccount.totalLamports == BigInt.zero) {
      return stakeLamports;
    }
    final numerator = stakeLamports * stakePoolAccount.poolTokenSupply;
    if (numerator == BigInt.zero) return BigInt.zero;
    return BigRational(numerator, denominator: stakePoolAccount.totalLamports)
        .toBigInt();
  }

  static List<List<T>> _arrayChunk<T>(List<T> array, int size) {
    final result = <List<T>>[];
    for (int i = 0; i < array.length; i += size) {
      result.add(array.sublist(i, math.min(i + size, array.length)));
    }
    return result;
  }
}
