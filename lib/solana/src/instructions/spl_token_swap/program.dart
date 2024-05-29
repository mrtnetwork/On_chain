import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/models/account/account_meta.dart';
import 'package:on_chain/solana/src/models/transaction/instruction.dart';
import 'layouts/layouts.dart';

/// Instructions supported by the token swap program.
class SPLTokenSwapProgram extends TransactionInstruction {
  SPLTokenSwapProgram({
    required List<AccountMeta> keys,
    required SolAddress programId,
    required ProgramLayout layout,
  }) : super(keys: keys, layout: layout, programId: programId);
  factory SPLTokenSwapProgram.fromBytes({
    required List<AccountMeta> keys,
    required List<int> instructionBytes,
    required SolAddress programId,
  }) {
    return SPLTokenSwapProgram(
        layout: SPLTokenSwapProgramLayout.fromBytes(instructionBytes),
        keys: keys,
        programId: programId);
  }

  /// Initializes a new swap
  factory SPLTokenSwapProgram.create(
      {
      /// New Token-swap to create.
      required SolAddress tokenSwapAccount,

      /// swap authority derived from
      required SolAddress authority,

      /// token_a Account. Must be non zero, owned by swap authority.
      required SolAddress tokenAccountA,

      /// token_b Account. Must be non zero, owned by swap authority.
      required SolAddress tokenAccountB,

      /// Pool Token Account to deposit trading and withdraw fees.
      required SolAddress tokenPool,
      required SolAddress feeAccount,

      /// Pool Token Account to deposit the initial pool token
      required SolAddress tokenAccountPool,

      /// Pool Token program id
      required SolAddress poolTokenProgramId,
      required SolAddress swapProgramId,
      required SPLTokenSwapInitSwapLayout layout}) {
    return SPLTokenSwapProgram(
        layout: layout,
        keys: [
          tokenSwapAccount.toWritable(),
          authority.toReadOnly(),
          tokenAccountA.toReadOnly(),
          tokenAccountB.toReadOnly(),
          tokenPool.toWritable(),
          feeAccount.toReadOnly(),
          tokenAccountPool.toWritable(),
          poolTokenProgramId.toReadOnly(),
        ],
        programId: swapProgramId);
  }

  /// Swap the tokens in the pool.
  factory SPLTokenSwapProgram.swap({
    /// Token-swap
    required SolAddress tokenSwap,

    /// swap authority
    required SolAddress authority,

    /// user transfer authority
    required SolAddress userTransferAuthority,

    /// token_(A|B) SOURCE Account, amount is transferable by
    /// user transfer authority,
    required SolAddress userSource,

    /// token_(A|B) Base Account to swap INTO.  Must be the
    /// SOURCE token.
    required SolAddress poolSource,

    /// token_(A|B) Base Account to swap FROM.  Must be the
    /// DESTINATION token.
    required SolAddress poolDestination,

    /// token_(A|B) DESTINATION Account assigned to USER as
    /// the owner.
    required SolAddress userDestination,

    /// Pool token mint, to generate trading fees
    required SolAddress poolMint,

    /// Fee account, to receive trading fees
    required SolAddress feeAccount,

    /// Token (A|B) SOURCE mint
    required SolAddress sourceMint,

    /// Token (A|B) DESTINATION mint
    required SolAddress destinationMint,

    /// Token (A|B) SOURCE program id
    required SolAddress sourceTokenProgramId,

    /// Token (A|B) DESTINATION program id
    required SolAddress destinationTokenProgramId,

    /// Pool Token program id
    required SolAddress poolTokenProgramId,
    required SPLTokenSwapSwapLayout layout,
    required SolAddress swapProgramId,

    /// Host fee account to receive additional
    /// trading fees
    SolAddress? hostFeeAccount,
  }) {
    return SPLTokenSwapProgram(
        layout: layout,
        keys: [
          tokenSwap.toReadOnly(),
          authority.toReadOnly(),
          userTransferAuthority.toSigner(),
          userSource.toWritable(),
          poolSource.toWritable(),
          poolDestination.toWritable(),
          userDestination.toWritable(),
          poolMint.toWritable(),
          feeAccount.toWritable(),
          sourceMint.toReadOnly(),
          destinationMint.toReadOnly(),
          sourceTokenProgramId.toReadOnly(),
          destinationTokenProgramId.toReadOnly(),
          poolTokenProgramId.toReadOnly(),
          if (hostFeeAccount != null) hostFeeAccount.toWritable()
        ],
        programId: swapProgramId);
  }

  ///  Deposit both types of tokens into the pool.  The output is a "pool"
  ///  token representing ownership in the pool. Inputs are converted to
  ///  the current ratio.
  factory SPLTokenSwapProgram.deposit(
      {
      /// Token-swap
      required SolAddress tokenSwap,

      /// swap authority
      required SolAddress authority,

      /// user transfer authority
      required SolAddress userTransferAuthority,
      // token_a user transfer authority can transfer amount
      required SolAddress sourceA,

      /// token_b user transfer authority can transfer amount
      required SolAddress sourceB,

      /// token_a Base Account to deposit into.
      required SolAddress intoA,

      /// token_b Base Account to deposit into.
      required SolAddress intoB,

      /// Pool MINT account, swap authority is the owner.
      required SolAddress poolToken,

      /// Pool Account to deposit the generated tokens
      required SolAddress poolAccount,

      /// Token A mint
      required SolAddress mintA,

      /// Token B mint
      required SolAddress mintB,
      required SolAddress swapProgramId,

      /// Token A program id
      required SolAddress tokenProgramIdA,

      /// Token B program id
      required SolAddress tokenProgramIdB,

      /// Pool Token program id
      required SolAddress poolTokenProgramId,
      required SPLTokenSwapDepositLayout layout}) {
    return SPLTokenSwapProgram(
        layout: layout,
        keys: [
          tokenSwap.toReadOnly(),
          authority.toReadOnly(),
          userTransferAuthority.toSigner(),
          sourceA.toWritable(),
          sourceB.toWritable(),
          intoA.toWritable(),
          intoB.toWritable(),
          poolToken.toWritable(),
          poolAccount.toWritable(),
          mintA.toReadOnly(),
          mintB.toReadOnly(),
          tokenProgramIdA.toReadOnly(),
          tokenProgramIdB.toReadOnly(),
          poolTokenProgramId.toReadOnly(),
        ],
        programId: swapProgramId);
  }

  /// Deposit one type of tokens into the pool. The output is a "pool"
  /// token representing ownership into the pool. Input token is
  /// converted as if a swap and deposit all token types were performed.
  factory SPLTokenSwapProgram.depoitSingleToken({
    /// Token-swap
    required SolAddress tokenSwap,

    /// swap authority
    required SolAddress authority,

    ///  user transfer authority
    required SolAddress userTransferAuthority,

    /// SOURCE Account, amount is transferable by
    /// user transfer authority,
    required SolAddress source,

    /// token_a Swap Account, may deposit INTO.
    required SolAddress intoA,

    /// token_b Swap Account, may deposit INTO.
    required SolAddress intoB,

    /// Pool MINT account, swap authority is the owner.
    required SolAddress poolToken,

    /// Pool Account to deposit the generated tokens, user is
    /// the owner.
    required SolAddress poolAccount,

    /// Token (A|B) SOURCE mint
    required SolAddress sourceMint,

    /// Token (A|B) SOURCE program id
    required SolAddress sourceTokenProgramId,

    /// Pool Token program id
    required SolAddress poolTokenProgramId,
    required SPLTokenSwapDepositSingleTokenLayout layout,
    required SolAddress swapProgramId,
  }) {
    return SPLTokenSwapProgram(
        layout: layout,
        keys: [
          tokenSwap.toReadOnly(),
          authority.toReadOnly(),
          userTransferAuthority.toSigner(),
          source.toWritable(),
          intoA.toWritable(),
          intoB.toWritable(),
          poolToken.toWritable(),
          poolAccount.toWritable(),
          sourceMint.toReadOnly(),
          sourceTokenProgramId.toReadOnly(),
          poolTokenProgramId.toReadOnly(),
        ],
        programId: swapProgramId);
  }

  /// Withdraw both types of tokens from the pool at the current ratio,
  /// given pool tokens. The pool tokens are burned in exchange for an
  /// equivalent amount of token A and B.
  factory SPLTokenSwapProgram.withdraw({
    /// Token-swap
    required SolAddress tokenSwap,

    /// swap authority
    required SolAddress authority,

    /// user transfer authority
    required SolAddress userTransferAuthority,

    /// Pool mint account, swap authority is the owner
    required SolAddress poolMint,

    /// Fee account, to receive withdrawal fees
    required SolAddress feeAccount,

    /// SOURCE Pool account, amount is transferable by user
    /// transfer authority.
    required SolAddress sourcePoolAccount,

    /// token_a Swap Account to withdraw FROM.
    required SolAddress fromA,

    /// token_b Swap Account to withdraw FROM.
    required SolAddress fromB,

    /// token_a user Account to credit.
    required SolAddress userAccountA,

    /// token_b user Account to credit.
    required SolAddress userAccountB,

    /// Token A mint
    required SolAddress mintA,

    /// Token B mint
    required SolAddress mintB,

    /// Pool Token program id
    required SolAddress poolTokenProgramId,

    /// Token A program id
    required SolAddress tokenProgramIdA,

    /// Token B program id
    required SolAddress tokenProgramIdB,
    required SPLTokenSwapWithdrawLayout layout,
    required SolAddress swapProgramId,
  }) {
    return SPLTokenSwapProgram(
        layout: layout,
        keys: [
          tokenSwap.toReadOnly(),
          authority.toReadOnly(),
          userTransferAuthority.toSigner(),
          poolMint.toWritable(),
          sourcePoolAccount.toWritable(),
          fromA.toWritable(),
          fromB.toWritable(),
          userAccountA.toWritable(),
          userAccountB.toWritable(),
          feeAccount.toWritable(),
          mintA.toReadOnly(),
          mintB.toReadOnly(),
          poolTokenProgramId.toReadOnly(),
          tokenProgramIdA.toReadOnly(),
          tokenProgramIdB.toReadOnly(),
        ],
        programId: swapProgramId);
  }

  /// Withdraw one token type from the pool at the current ratio given the
  /// exact amount out expected.
  factory SPLTokenSwapProgram.withdrawSingleToken({
    /// Token-swap
    required SolAddress tokenSwap,

    /// swap authority
    required SolAddress authority,

    /// user transfer authority
    required SolAddress userTransferAuthority,

    /// Pool mint account, swap authority is the owner
    required SolAddress poolMint,

    /// Fee account, to receive withdrawal fees
    required SolAddress feeAccount,

    /// SOURCE Pool account, amount is transferable by user
    /// transfer authority.
    required SolAddress sourcePoolAccount,

    /// token_a Swap Account to potentially withdraw from.
    required SolAddress fromA,

    /// token_b Swap Account to potentially withdraw from.
    required SolAddress fromB,

    /// Destination account
    required SolAddress destinationAccount,

    /// Token (A|B) DESTINATION mint
    required SolAddress destinationMint,

    /// Pool Token program id
    required SolAddress poolTokenProgramId,

    /// Token (A|B) DESTINATION program id
    required SolAddress destinationTokenProgramId,
    required SPLTokenSwapWithdrawSingleTokenLayout layout,
    required SolAddress swapProgramId,
  }) {
    return SPLTokenSwapProgram(
        layout: layout,
        keys: [
          tokenSwap.toReadOnly(),
          authority.toReadOnly(),
          userTransferAuthority.toSigner(),
          poolMint.toWritable(),
          sourcePoolAccount.toWritable(),
          fromA.toWritable(),
          fromB.toWritable(),
          destinationAccount.toWritable(),
          feeAccount.toWritable(),
          destinationMint.toReadOnly(),
          poolTokenProgramId.toReadOnly(),
          destinationTokenProgramId.toReadOnly()
        ],
        programId: swapProgramId);
  }
}
