import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/instructions.dart';
import 'package:on_chain/solana/src/models/models.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Instructions supported by the lending program.
class TokenLendingProgram extends TransactionInstruction {
  TokenLendingProgram({
    required super.keys,
    required super.programId,
    required ProgramLayout layout,
  }) : super(data: layout.toBytes());
  factory TokenLendingProgram.fromBytes({
    required List<AccountMeta> keys,
    required List<int> instructionBytes,
    SolAddress programId = TokenLendingProgramConst.lendingProgramId,
  }) {
    return TokenLendingProgram(
        layout: TokenLendingProgramLayout.fromBytes(instructionBytes),
        keys: keys,
        programId: programId);
  }

  /// Borrow liquidity from a reserve by depositing collateral tokens.
  /// Requires a refreshed obligation and reserve.
  factory TokenLendingProgram.borrowObligationLiquidity({
    /// Destination liquidity token account. Minted by borrow
    /// reserve liquidity mint.
    required SolAddress destinationLiquidity,

    /// Source borrow reserve liquidity supply SPL Token
    /// account.
    required SolAddress sourceLiquidity,

    /// Borrow reserve account
    required SolAddress borrowReserve,

    /// Borrow reserve liquidity fee receiver account. Must be
    /// the fee account specified at InitReserve.
    required SolAddress borrowReserveLiquidityFeeReceiver,

    /// Obligation account
    required SolAddress obligation,

    /// Lending market account.
    required SolAddress lendingMarket,

    /// Derived lending market authority.
    required SolAddress lendingMarketAuthority,

    /// Obligation owner.
    required SolAddress obligationOwner,
    required TokenLendingBorrowObligationLiquidityLayout layout,
    SolAddress? hostFeeReceiver,
  }) {
    return TokenLendingProgram(keys: [
      sourceLiquidity.toWritable(),
      destinationLiquidity.toWritable(),
      borrowReserve.toWritable(),
      borrowReserveLiquidityFeeReceiver.toWritable(),
      obligation.toWritable(),
      lendingMarket.toReadOnly(),
      lendingMarketAuthority.toReadOnly(),
      obligationOwner.toSigner(),
      SystemProgramConst.sysvarClockPubkey.toReadOnly(),
      SPLTokenProgramConst.tokenProgramId.toReadOnly(),
      if (hostFeeReceiver != null) hostFeeReceiver.toWritable()
    ], programId: TokenLendingProgramConst.lendingProgramId, layout: layout);
  }

  /// Deposit collateral to an obligation. Requires a refreshed reserve.
  factory TokenLendingProgram.depositObligationCollateral({
    /// Source collateral token account
    required SolAddress sourceCollateral,

    /// Destination deposit reserve collateral supply SPL Token account.
    required SolAddress destinationCollateral,

    /// Deposit reserve account
    required SolAddress depositReserve,

    /// Obligation account.
    required SolAddress obligation,

    /// Lending market account.
    required SolAddress lendingMarket,

    /// Obligation owner.
    required SolAddress obligationOwner,

    /// User transfer authority
    required SolAddress transferAuthority,
    required TokenLendingDepositObligationCollateralLayout layout,
  }) {
    return TokenLendingProgram(keys: [
      sourceCollateral.toWritable(),
      destinationCollateral.toWritable(),
      depositReserve.toReadOnly(),
      obligation.toWritable(),
      lendingMarket.toReadOnly(),
      obligationOwner.toSigner(),
      transferAuthority.toSigner(),
      SystemProgramConst.sysvarClockPubkey.toReadOnly(),
      SPLTokenProgramConst.tokenProgramId.toReadOnly(),
    ], programId: TokenLendingProgramConst.lendingProgramId, layout: layout);
  }

  /// Deposit liquidity into a reserve in exchange for collateral. Collateral
  /// represents a share of the reserve liquidity pool.
  factory TokenLendingProgram.depositReserveLiquidity(
      {
      /// Source liquidity token account.
      required SolAddress sourceLiquidity,

      /// Destination collateral token account.
      required SolAddress destinationCollateral,

      /// Reserve account.
      required SolAddress reserve,

      /// Reserve liquidity supply SPL Token account
      required SolAddress reserveLiquiditySupply,

      /// Reserve collateral SPL Token mint.
      required SolAddress reserveCollateralMint,

      /// Lending market account.
      required SolAddress lendingMarket,

      /// Derived lending market authority.
      required SolAddress lendingMarketAuthority,

      /// User transfer authority
      required SolAddress transferAuthority,
      required TokenLendingDepositReserveLiquidityLayout layout}) {
    return TokenLendingProgram(keys: [
      sourceLiquidity.toWritable(),
      destinationCollateral.toWritable(),
      reserve.toWritable(),
      reserveLiquiditySupply.toWritable(),
      reserveCollateralMint.toWritable(),
      lendingMarket.toReadOnly(),
      lendingMarketAuthority.toReadOnly(),
      transferAuthority.toSigner(),
      SystemProgramConst.sysvarClockPubkey.toReadOnly(),
      SPLTokenProgramConst.tokenProgramId.toReadOnly(),
    ], programId: TokenLendingProgramConst.lendingProgramId, layout: layout);
  }

  /// Make a flash loan.
  factory TokenLendingProgram.flashLoan(
      {
      /// Source liquidity token account.
      required SolAddress sourceLiquidity,

      /// Destination liquidity token account
      required SolAddress destinationLiquidity,

      /// Reserve account.
      required SolAddress liquidityReserve,

      /// Flash loan fee receiver account.
      required SolAddress flashLoanFeeReceiver,

      /// Host fee receiver.
      required SolAddress hostFeeReceiver,

      /// Lending market account.
      required SolAddress lendingMarket,

      /// Derived lending market authority.
      required SolAddress lendingMarketAuthority,

      /// Flash loan receiver program id.
      required SolAddress flashLoanProgram,
      required SolAddress transferAuthority,
      required TokenLendingFlashLoanLayout layout}) {
    return TokenLendingProgram(keys: [
      sourceLiquidity.toWritable(),
      destinationLiquidity.toWritable(),
      liquidityReserve.toWritable(),
      flashLoanFeeReceiver.toWritable(),
      hostFeeReceiver.toWritable(),
      lendingMarket.toReadOnly(),
      lendingMarketAuthority.toReadOnly(),
      SPLTokenProgramConst.tokenProgramId.toReadOnly(),
      flashLoanProgram.toReadOnly(),
      transferAuthority.toSigner()
    ], programId: TokenLendingProgramConst.lendingProgramId, layout: layout);
  }

  /// Initializes a new lending market.
  factory TokenLendingProgram.initLendingMarket(
      {
      /// Lending market account
      required SolAddress lendingMarket,
      required TokenLendingInitLendingMarketLayout layout}) {
    return TokenLendingProgram(keys: [
      lendingMarket.toWritable(),
      SystemProgramConst.sysvarRentPubkey.toReadOnly(),
      SPLTokenProgramConst.tokenProgramId.toReadOnly(),
      TokenLendingProgramConst.oracleProgramId.toReadOnly(),
    ], programId: TokenLendingProgramConst.lendingProgramId, layout: layout);
  }

  /// Initializes a new lending market obligation.
  factory TokenLendingProgram.initObligation({
    /// Obligation account
    required SolAddress obligation,

    /// Lending market account.
    required SolAddress lendingMarket,

    /// Obligation owner.
    required SolAddress obligationOwner,
  }) {
    return TokenLendingProgram(
        keys: [
          obligation.toWritable(),
          lendingMarket.toReadOnly(),
          obligationOwner.toSigner(),
          SystemProgramConst.sysvarClockPubkey.toReadOnly(),
          SystemProgramConst.sysvarRentPubkey.toReadOnly(),
          SPLTokenProgramConst.tokenProgramId.toReadOnly(),
        ],
        programId: TokenLendingProgramConst.lendingProgramId,
        layout: const TokenLendingInitObligationLayout());
  }

  /// Initializes a new lending market reserve.
  factory TokenLendingProgram.initReserve(
      {
      /// Source liquidity token account.
      required SolAddress sourceLiquidity,

      /// Destination collateral token account
      required SolAddress destinationCollateral,

      /// Reserve liquidity SPL Token mint.
      required SolAddress reserve,

      /// Reserve liquidity SPL Token mint.
      required SolAddress liquidityMint,

      /// Reserve liquidity supply SPL Token account
      required SolAddress liquiditySupply,

      /// Reserve liquidity fee receiver
      required SolAddress liquidityFeeReceiver,

      /// Pyth product account.
      required SolAddress pythProduct,

      /// Pyth price account.
      required SolAddress pythPrice,

      /// Reserve collateral SPL Token mint
      required SolAddress collateralMint,

      /// Reserve collateral token supply
      required SolAddress collateralSupply,

      /// Lending market account.
      required SolAddress lendingMarket,

      /// Derived lending market authority.
      required SolAddress lendingMarketAuthority,

      /// Lending market owner.
      required SolAddress lendingMarketOwner,

      /// User transfer authority
      required SolAddress transferAuthority,
      required TokenLendingInitReserveLayout layout}) {
    return TokenLendingProgram(keys: [
      sourceLiquidity.toWritable(),
      destinationCollateral.toWritable(),
      reserve.toWritable(),
      liquidityMint.toReadOnly(),
      liquiditySupply.toWritable(),
      liquidityFeeReceiver.toWritable(),
      collateralMint.toWritable(),
      collateralSupply.toWritable(),
      pythProduct.toReadOnly(),
      pythPrice.toReadOnly(),
      lendingMarket.toWritable(),
      lendingMarketAuthority.toReadOnly(),
      transferAuthority.toSigner(),
      SystemProgramConst.sysvarClockPubkey.toReadOnly(),
      SystemProgramConst.sysvarRentPubkey.toReadOnly(),
      SPLTokenProgramConst.tokenProgramId.toReadOnly(),
    ], programId: TokenLendingProgramConst.lendingProgramId, layout: layout);
  }

  /// Repay borrowed liquidity to a reserve to receive collateral at a
  /// discount from an unhealthy obligation. Requires a refreshed
  /// obligation and reserves.
  factory TokenLendingProgram.liquidateObligation(
      {
      /// Source liquidity token account. Minted by repay
      /// reserve liquidity mint.
      required SolAddress sourceLiquidity,

      /// Destination collateral token account.
      required SolAddress destinationCollateral,

      /// Repay reserve account
      required SolAddress repayReserve,

      /// Repay reserve liquidity supply SPL Token account.
      required SolAddress repayReserveLiquiditySupply,

      /// Withdraw reserve account
      required SolAddress withdrawReserve,

      /// Withdraw reserve collateral supply SPL Token account.
      required SolAddress withdrawReserveCollateralSupply,

      /// Obligation account
      required SolAddress obligation,

      /// Lending market account.
      required SolAddress lendingMarket,

      /// Derived lending market authority.
      required SolAddress lendingMarketAuthority,

      /// User transfer authority
      required SolAddress transferAuthority,
      required TokenLendingLiquidateObligationLayout layout}) {
    return TokenLendingProgram(keys: [
      sourceLiquidity.toWritable(),
      destinationCollateral.toWritable(),
      repayReserve.toWritable(),
      repayReserveLiquiditySupply.toWritable(),
      withdrawReserve.toReadOnly(),
      withdrawReserveCollateralSupply.toWritable(),
      obligation.toWritable(),
      lendingMarket.toReadOnly(),
      lendingMarketAuthority.toReadOnly(),
      transferAuthority.toSigner(),
      SystemProgramConst.sysvarClockPubkey.toReadOnly(),
      SPLTokenProgramConst.tokenProgramId.toReadOnly(),
    ], programId: TokenLendingProgramConst.lendingProgramId, layout: layout);
  }

  /// Redeem collateral from a reserve in exchange for liquidity.
  factory TokenLendingProgram.redeemReserveCollateral(
      {
      /// Source collateral token account.
      required SolAddress sourceCollateral,

      /// Destination liquidity token account.
      required SolAddress destinationLiquidity,

      /// Reserve account.
      required SolAddress reserve,

      /// Reserve collateral SPL Token mint.
      required SolAddress reserveCollateralMint,

      /// Reserve liquidity supply SPL Token account.
      required SolAddress reserveLiquiditySupply,

      /// Lending market account.
      required SolAddress lendingMarket,

      /// Derived lending market authority.
      required SolAddress lendingMarketAuthority,

      /// User transfer authority
      required SolAddress transferAuthority,
      required TokenLendingRedeemReserveCollateralLayout layout}) {
    return TokenLendingProgram(keys: [
      sourceCollateral.toWritable(),
      destinationLiquidity.toWritable(),
      reserve.toWritable(),
      reserveCollateralMint.toWritable(),
      reserveLiquiditySupply.toWritable(),
      lendingMarket.toReadOnly(),
      lendingMarketAuthority.toReadOnly(),
      transferAuthority.toSigner(),
      SystemProgramConst.sysvarClockPubkey.toReadOnly(),
      SPLTokenProgramConst.tokenProgramId.toReadOnly(),
    ], programId: TokenLendingProgramConst.lendingProgramId, layout: layout);
  }

  /// Refresh an obligation's accrued interest and collateral and liquidity
  /// prices. Requires refreshed reserves, as all obligation collateral
  /// deposit reserves in order, followed by all liquidity borrow reserves
  /// in order.
  factory TokenLendingProgram.refreshObligation(
      {
      /// Obligation account.
      required SolAddress obligation,

      /// Collateral deposit reserve accounts
      required List<SolAddress> depositReserves,

      /// Liquidity borrow reserve accounts
      required List<SolAddress> borrowReserves}) {
    return TokenLendingProgram(
        keys: [
          obligation.toWritable(),
          SystemProgramConst.sysvarClockPubkey.toReadOnly(),
          ...depositReserves.map((e) => e.toReadOnly()),
          ...borrowReserves.map((e) => e.toReadOnly())
        ],
        programId: TokenLendingProgramConst.lendingProgramId,
        layout: const TokenLendingRefreshObligationLayout());
  }

  /// Accrue interest and update market price of liquidity on a reserve.
  factory TokenLendingProgram.refreshReserve({
    /// Reserve account.
    required SolAddress reserve,

    //// Reserve liquidity oracle account. Must be the Pyth price
    ///  account specified at InitReserve.
    required SolAddress oracle,
  }) {
    return TokenLendingProgram(
        keys: [
          reserve.toWritable(),
          oracle.toReadOnly(),
          SystemProgramConst.sysvarClockPubkey.toReadOnly(),
        ],
        programId: TokenLendingProgramConst.lendingProgramId,
        layout: const TokenLendingRefreshReserveLayout());
  }

  /// Repay borrowed liquidity to a reserve. Requires a refreshed obligation
  /// and reserve.
  factory TokenLendingProgram.repayObligationLiquidity({
    /// Source liquidity token account.
    required SolAddress sourceLiquidity,

    /// Destination repay reserve liquidity supply SPL Token account.
    required SolAddress destinationLiquidity,

    /// Repay reserve account.
    required SolAddress repayReserve,

    /// Obligation account.
    required SolAddress obligation,

    /// Lending market account.
    required SolAddress lendingMarket,

    /// User transfer authority
    required SolAddress transferAuthority,
    required TokenLendingRepayObligationLiquidityLayout layout,
  }) {
    return TokenLendingProgram(keys: [
      sourceLiquidity.toWritable(),
      destinationLiquidity.toWritable(),
      repayReserve.toWritable(),
      obligation.toWritable(),
      lendingMarket.toReadOnly(),
      transferAuthority.toSigner(),
      SystemProgramConst.sysvarClockPubkey.toReadOnly(),
      SPLTokenProgramConst.tokenProgramId.toReadOnly(),
    ], programId: TokenLendingProgramConst.lendingProgramId, layout: layout);
  }

  /// Sets the new owner of a lending market.
  factory TokenLendingProgram.setLendingMarketOwner({
    /// Lending market account.
    required SolAddress lendingMarket,

    /// Current owner.
    required SolAddress currentOwner,
    required TokenLendingSetLendingMarketOwnerLayout layout,
  }) {
    return TokenLendingProgram(keys: [
      lendingMarket.toWritable(),
      currentOwner.toSigner(),
    ], programId: TokenLendingProgramConst.lendingProgramId, layout: layout);
  }

  /// Withdraw collateral from an obligation. Requires a refreshed obligation
  /// and reserve.
  factory TokenLendingProgram.withdrawObligationCollateral({
    /// Source withdraw reserve collateral supply SPL Token account.
    required SolAddress sourceCollateral,

    /// Destination collateral token account. Minted by
    /// withdraw reserve collateral mint.
    required SolAddress destinationCollateral,

    /// Withdraw reserve account.
    required SolAddress withdrawReserve,

    /// Obligation account
    required SolAddress obligation,

    /// Lending market account
    required SolAddress lendingMarket,

    /// Derived lending market authority
    required SolAddress lendingMarketAuthority,

    /// Obligation owner.
    required SolAddress obligationOwner,
    required TokenLendingWithdrawObligationCollateralLayout layout,
  }) {
    return TokenLendingProgram(keys: [
      sourceCollateral.toWritable(),
      destinationCollateral.toWritable(),
      withdrawReserve.toReadOnly(),
      obligation.toWritable(),
      lendingMarket.toReadOnly(),
      lendingMarketAuthority.toReadOnly(),
      obligationOwner.toSigner(),
      SystemProgramConst.sysvarClockPubkey.toReadOnly(),
      SPLTokenProgramConst.tokenProgramId.toReadOnly(),
    ], programId: TokenLendingProgramConst.lendingProgramId, layout: layout);
  }
}
