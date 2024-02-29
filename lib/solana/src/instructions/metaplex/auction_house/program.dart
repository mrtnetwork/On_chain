import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/associated_token_account/constant.dart';
import 'package:on_chain/solana/src/instructions/instructions.dart';
import 'package:on_chain/solana/src/models/account/account_meta.dart';
import 'package:on_chain/solana/src/models/transaction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexAuctionHouseProgram extends TransactionInstruction {
  MetaplexAuctionHouseProgram({
    required List<AccountMeta> keys,
    required SolAddress programId,
    required ProgramLayout layout,
  }) : super(keys: keys, layout: layout, programId: programId);

  /// Create a new Auction House instance.
  factory MetaplexAuctionHouseProgram.createAuctionHouse({
    required MetaplexAuctionHouseCreateAuctionHouseLayout layout,

    /// Treasury mint account, either native SOL mint or a SPL token mint.
    required SolAddress treasuryMint,

    /// Key paying SOL fees for setting up the Auction House.
    required SolAddress payer,

    /// Authority key for the Auction House.
    required SolAddress authority,

    /// Account that pays for fees if the marketplace executes sales.
    required SolAddress feeWithdrawalDestination,

    /// SOL or SPL token account to receive Auction House fees. If treasury mint is native this will be the same as the `treasury_withdrawl_destination_owner`.
    required SolAddress treasuryWithdrawalDestination,

    /// Owner of the `treasury_withdrawal_destination` account or the same address if the `treasury_mint` is native.
    required SolAddress treasuryWithdrawalDestinationOwner,

    /// Auction House instance PDA account.
    required SolAddress auctionHouse,

    /// Auction House instance fee account.
    required SolAddress auctionHouseFeeAccount,

    /// Auction House instance treasury PDA account.
    required SolAddress auctionHouseTreasury,
    SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress associatedTokenProgramId =
        AssociatedTokenAccountProgramConst.associatedTokenProgramId,
    SolAddress rent = SystemProgramConst.sysvarRentPubkey,
  }) {
    return MetaplexAuctionHouseProgram(keys: [
      treasuryMint.toReadOnly(),
      payer.toSignerAndWritable(),
      authority.toReadOnly(),
      feeWithdrawalDestination.toWritable(),
      treasuryWithdrawalDestination.toWritable(),
      treasuryWithdrawalDestinationOwner.toReadOnly(),
      auctionHouse.toWritable(),
      auctionHouseFeeAccount.toWritable(),
      auctionHouseTreasury.toWritable(),
      tokenProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      associatedTokenProgramId.toReadOnly(),
      rent.toReadOnly(),
    ], programId: MetaplexAuctionHouseProgramConst.programId, layout: layout);
  }
  factory MetaplexAuctionHouseProgram.delegateAuctioneer({
    /// Auction House instance PDA account.
    required SolAddress auctionHouse,
    required SolAddress authority,

    /// The auctioneer authority - the program PDA running this auction
    required SolAddress auctioneerAuthority,

    /// The auctioneer PDA owned by Auction House storing scopes.
    required SolAddress ahAuctioneerPda,
    required MetaplexAuctionHouseDelegateAuctioneerLayout layout,
    SolAddress systemProgram = SystemProgramConst.programId,
  }) {
    return MetaplexAuctionHouseProgram(keys: [
      auctionHouse.toWritable(),
      authority.toSignerAndWritable(),
      auctioneerAuthority.toReadOnly(),
      ahAuctioneerPda.toWritable(),
      systemProgram.toReadOnly(),
    ], programId: MetaplexAuctionHouseProgramConst.programId, layout: layout);
  }
  factory MetaplexAuctionHouseProgram.auctioneerBuy({
    required MetaplexAuctionHouseAuctioneerBuyLayout layout,
    required SolAddress wallet,
    required SolAddress paymentAccount,
    required SolAddress transferAuthority,
    required SolAddress treasuryMint,
    required SolAddress tokenAccount,
    required SolAddress metadata,
    required SolAddress escrowPaymentAccount,
    required SolAddress authority,
    required SolAddress auctioneerAuthority,
    required SolAddress auctionHouse,
    required SolAddress auctionHouseFeeAccount,
    required SolAddress buyerTradeState,
    required SolAddress ahAuctioneerPda,
    SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress rent = SystemProgramConst.sysvarRentPubkey,
  }) {
    return MetaplexAuctionHouseProgram(keys: [
      wallet.toWritable(),
      paymentAccount.toWritable(),
      transferAuthority.toReadOnly(),
      treasuryMint.toReadOnly(),
      tokenAccount.toReadOnly(),
      metadata.toReadOnly(),
      escrowPaymentAccount.toWritable(),
      authority.toReadOnly(),
      auctioneerAuthority.toSigner(),
      auctionHouse.toReadOnly(),
      auctionHouseFeeAccount.toWritable(),
      buyerTradeState.toWritable(),
      ahAuctioneerPda.toReadOnly(),
      tokenProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      rent.toReadOnly()
    ], programId: MetaplexAuctionHouseProgramConst.programId, layout: layout);
  }

  /// Cancel, but with an auctioneer
  factory MetaplexAuctionHouseProgram.auctioneerCancel(
      {required SolAddress wallet,
      required SolAddress tokenAccount,
      required SolAddress tokenMint,
      required SolAddress authority,
      required SolAddress auctioneerAuthority,
      required SolAddress auctionHouse,
      required SolAddress auctionHouseFeeAccount,
      required SolAddress tradeState,
      required SolAddress ahAuctioneerPda,
      required MetaplexAuctionHouseAuctioneerCancelLayout layout,
      SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId}) {
    return MetaplexAuctionHouseProgram(keys: [
      wallet.toWritable(),
      tokenAccount.toWritable(),
      tokenMint.toReadOnly(),
      authority.toReadOnly(),
      auctioneerAuthority.toSigner(),
      auctionHouse.toReadOnly(),
      auctionHouseFeeAccount.toWritable(),
      tradeState.toWritable(),
      ahAuctioneerPda.toReadOnly(),
      tokenProgram.toReadOnly()
    ], programId: MetaplexAuctionHouseProgramConst.programId, layout: layout);
  }

  /// Deposit `amount` into the escrow payment account for your specific wallet.
  factory MetaplexAuctionHouseProgram.auctioneerDeposit(
      {required SolAddress wallet,
      required SolAddress paymentAccount,
      required SolAddress transferAuthority,
      required SolAddress escrowPaymentAccount,
      required SolAddress treasuryMint,
      required SolAddress authority,
      required SolAddress auctioneerAuthority,
      required SolAddress auctionHouse,
      required SolAddress auctionHouseFeeAccount,
      required SolAddress ahAuctioneerPda,
      required MetaplexAuctionHouseAuctioneerDepositLayout layout,
      SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
      SolAddress systemProgram = SystemProgramConst.programId,
      SolAddress rent = SystemProgramConst.sysvarRentPubkey}) {
    return MetaplexAuctionHouseProgram(keys: [
      wallet.toSigner(),
      paymentAccount.toWritable(),
      transferAuthority.toReadOnly(),
      escrowPaymentAccount.toWritable(),
      treasuryMint.toReadOnly(),
      authority.toReadOnly(),
      auctioneerAuthority.toSigner(),
      auctionHouse.toReadOnly(),
      auctionHouseFeeAccount.toWritable(),
      ahAuctioneerPda.toReadOnly(),
      tokenProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      rent.toReadOnly(),
    ], programId: MetaplexAuctionHouseProgramConst.programId, layout: layout);
  }
  factory MetaplexAuctionHouseProgram.auctioneerExecutePartialSale(
      {required SolAddress buyer,
      required SolAddress seller,
      required SolAddress tokenAccount,
      required SolAddress tokenMint,
      required SolAddress metadata,
      required SolAddress treasuryMint,
      required SolAddress escrowPaymentAccount,
      required SolAddress sellerPaymentReceiptAccount,
      required SolAddress buyerReceiptTokenAccount,
      required SolAddress authority,
      required SolAddress auctioneerAuthority,
      required SolAddress auctionHouse,
      required SolAddress auctionHouseFeeAccount,
      required SolAddress auctionHouseTreasury,
      required SolAddress buyerTradeState,
      required SolAddress sellerTradeState,
      required SolAddress freeTradeState,
      required SolAddress ahAuctioneerPda,
      required SolAddress programAsSigner,
      required MetaplexAuctionHouseAuctioneerExecutePartialSaleLayout layout,
      SolAddress ataProgram =
          AssociatedTokenAccountProgramConst.associatedTokenProgramId,
      SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
      SolAddress systemProgram = SystemProgramConst.programId,
      SolAddress rent = SystemProgramConst.sysvarRentPubkey}) {
    return MetaplexAuctionHouseProgram(keys: [
      buyer.toWritable(),
      seller.toWritable(),
      tokenAccount.toWritable(),
      tokenMint.toReadOnly(),
      metadata.toReadOnly(),
      treasuryMint.toReadOnly(),
      escrowPaymentAccount.toWritable(),
      sellerPaymentReceiptAccount.toWritable(),
      buyerReceiptTokenAccount.toWritable(),
      authority.toReadOnly(),
      auctioneerAuthority.toSigner(),
      auctionHouse.toReadOnly(),
      auctionHouseFeeAccount.toWritable(),
      auctionHouseTreasury.toWritable(),
      buyerTradeState.toWritable(),
      sellerTradeState.toWritable(),
      freeTradeState.toWritable(),
      ahAuctioneerPda.toReadOnly(),
      tokenProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      ataProgram.toReadOnly(),
      programAsSigner.toReadOnly(),
      rent.toReadOnly()
    ], programId: MetaplexAuctionHouseProgramConst.programId, layout: layout);
  }
  factory MetaplexAuctionHouseProgram.auctioneerExecuteSale(
      {required SolAddress buyer,
      required SolAddress seller,
      required SolAddress tokenAccount,
      required SolAddress tokenMint,
      required SolAddress metadata,
      required SolAddress treasuryMint,
      required SolAddress escrowPaymentAccount,
      required SolAddress sellerPaymentReceiptAccount,
      required SolAddress buyerReceiptTokenAccount,
      required SolAddress authority,
      required SolAddress auctioneerAuthority,
      required SolAddress auctionHouse,
      required SolAddress auctionHouseFeeAccount,
      required SolAddress auctionHouseTreasury,
      required SolAddress buyerTradeState,
      required SolAddress sellerTradeState,
      required SolAddress freeTradeState,
      required SolAddress ahAuctioneerPda,
      required SolAddress programAsSigner,
      required MetaplexAuctionHouseAuctioneerExecuteSaleLayout layout,
      SolAddress ataProgram =
          AssociatedTokenAccountProgramConst.associatedTokenProgramId,
      SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
      SolAddress systemProgram = SystemProgramConst.programId,
      SolAddress rent = SystemProgramConst.sysvarRentPubkey}) {
    return MetaplexAuctionHouseProgram(keys: [
      buyer.toWritable(),
      seller.toWritable(),
      tokenAccount.toWritable(),
      tokenMint.toReadOnly(),
      metadata.toReadOnly(),
      treasuryMint.toReadOnly(),
      escrowPaymentAccount.toWritable(),
      sellerPaymentReceiptAccount.toWritable(),
      buyerReceiptTokenAccount.toWritable(),
      authority.toReadOnly(),
      auctioneerAuthority.toSigner(),
      auctionHouse.toReadOnly(),
      auctionHouseFeeAccount.toWritable(),
      auctionHouseTreasury.toWritable(),
      buyerTradeState.toWritable(),
      sellerTradeState.toWritable(),
      freeTradeState.toWritable(),
      ahAuctioneerPda.toReadOnly(),
      tokenProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      ataProgram.toReadOnly(),
      programAsSigner.toReadOnly(),
      rent.toReadOnly(),
    ], programId: MetaplexAuctionHouseProgramConst.programId, layout: layout);
  }

  /// Create a public buy bid by creating a `public_buyer_trade_state` account and an `escrow_payment` account and funding the escrow with the necessary SOL or SPL token amount.
  factory MetaplexAuctionHouseProgram.auctioneerPublicBuy(
      {required SolAddress wallet,
      required SolAddress paymentAccount,
      required SolAddress transferAuthority,
      required SolAddress treasuryMint,
      required SolAddress tokenAccount,
      required SolAddress metadata,
      required SolAddress escrowPaymentAccount,
      required SolAddress authority,
      required SolAddress auctioneerAuthority,
      required SolAddress auctionHouse,
      required SolAddress auctionHouseFeeAccount,
      required SolAddress buyerTradeState,
      required SolAddress ahAuctioneerPda,
      required MetaplexAuctionHouseAuctioneerPublicBuyLayout layout,
      SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
      SolAddress systemProgram = SystemProgramConst.programId,
      SolAddress rent = SystemProgramConst.sysvarRentPubkey}) {
    return MetaplexAuctionHouseProgram(keys: [
      wallet.toSigner(),
      paymentAccount.toWritable(),
      transferAuthority.toReadOnly(),
      treasuryMint.toReadOnly(),
      tokenAccount.toReadOnly(),
      metadata.toReadOnly(),
      escrowPaymentAccount.toWritable(),
      authority.toReadOnly(),
      auctioneerAuthority.toSigner(),
      auctionHouse.toReadOnly(),
      auctionHouseFeeAccount.toWritable(),
      buyerTradeState.toWritable(),
      ahAuctioneerPda.toReadOnly(),
      tokenProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      rent.toReadOnly(),
    ], programId: MetaplexAuctionHouseProgramConst.programId, layout: layout);
  }
  factory MetaplexAuctionHouseProgram.auctioneerSell(
      {required SolAddress wallet,
      required SolAddress tokenAccount,
      required SolAddress metadata,
      required SolAddress authority,
      required SolAddress auctioneerAuthority,
      required SolAddress auctionHouse,
      required SolAddress auctionHouseFeeAccount,
      required SolAddress sellerTradeState,
      required SolAddress freeSellerTradeState,
      required SolAddress ahAuctioneerPda,
      required SolAddress programAsSigner,
      required MetaplexAuctionHouseAuctioneerSellLayout layout,
      SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
      SolAddress systemProgram = SystemProgramConst.programId,
      SolAddress rent = SystemProgramConst.sysvarRentPubkey}) {
    return MetaplexAuctionHouseProgram(keys: [
      wallet.toWritable(),
      tokenAccount.toWritable(),
      metadata.toReadOnly(),
      authority.toReadOnly(),
      auctioneerAuthority.toSigner(),
      auctionHouse.toReadOnly(),
      auctionHouseFeeAccount.toWritable(),
      sellerTradeState.toWritable(),
      freeSellerTradeState.toWritable(),
      ahAuctioneerPda.toReadOnly(),
      programAsSigner.toReadOnly(),
      tokenProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      rent.toReadOnly(),
    ], programId: MetaplexAuctionHouseProgramConst.programId, layout: layout);
  }

  /// Withdraw `amount` from the escrow payment account for your specific wallet.
  factory MetaplexAuctionHouseProgram.auctioneerWithdraw({
    required SolAddress wallet,
    required SolAddress receiptAccount,
    required SolAddress escrowPaymentAccount,
    required SolAddress treasuryMint,
    required SolAddress authority,
    required SolAddress auctioneerAuthority,
    required SolAddress auctionHouse,
    required SolAddress auctionHouseFeeAccount,
    required SolAddress ahAuctioneerPda,
    required MetaplexAuctionHouseAuctioneerWithdrawLayout layout,
    SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress rent = SystemProgramConst.sysvarRentPubkey,
    SolAddress ataProgram =
        AssociatedTokenAccountProgramConst.associatedTokenProgramId,
  }) {
    return MetaplexAuctionHouseProgram(keys: [
      wallet.toReadOnly(),
      receiptAccount.toWritable(),
      escrowPaymentAccount.toWritable(),
      treasuryMint.toReadOnly(),
      authority.toReadOnly(),
      auctioneerAuthority.toSigner(),
      auctionHouse.toReadOnly(),
      auctionHouseFeeAccount.toWritable(),
      ahAuctioneerPda.toReadOnly(),
      tokenProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      ataProgram.toReadOnly(),
      rent.toReadOnly(),
    ], programId: MetaplexAuctionHouseProgramConst.programId, layout: layout);
  }

  /// Create a private buy bid by creating a `buyer_trade_state` account and an `escrow_payment` account and funding the escrow with the necessary SOL or SPL token amount.
  factory MetaplexAuctionHouseProgram.buy({
    required SolAddress wallet,
    required SolAddress paymentAccount,
    required SolAddress transferAuthority,
    required SolAddress treasuryMint,
    required SolAddress tokenAccount,
    required SolAddress metadata,
    required SolAddress escrowPaymentAccount,
    required SolAddress authority,
    required SolAddress auctionHouse,
    required SolAddress auctionHouseFeeAccount,
    required SolAddress buyerTradeState,
    required MetaplexAuctionHouseBuyLayout layout,
    SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress rent = SystemProgramConst.sysvarRentPubkey,
  }) {
    return MetaplexAuctionHouseProgram(keys: [
      wallet.toSigner(),
      paymentAccount.toWritable(),
      transferAuthority.toReadOnly(),
      treasuryMint.toReadOnly(),
      tokenAccount.toReadOnly(),
      metadata.toReadOnly(),
      escrowPaymentAccount.toWritable(),
      authority.toReadOnly(),
      auctionHouse.toReadOnly(),
      auctionHouseFeeAccount.toWritable(),
      buyerTradeState.toWritable(),
      tokenProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      rent.toReadOnly()
    ], programId: MetaplexAuctionHouseProgramConst.programId, layout: layout);
  }

  /// Cancel a bid or ask by revoking the token delegate, transferring all lamports from the trade state account to the fee payer, and setting the trade state account data to zero so it can be garbage collected.
  factory MetaplexAuctionHouseProgram.cancel({
    required SolAddress wallet,
    required SolAddress tokenAccount,
    required SolAddress tokenMint,
    required SolAddress authority,
    required SolAddress auctionHouse,
    required SolAddress auctionHouseFeeAccount,
    required SolAddress tradeState,
    required MetaplexAuctionHouseCancelLayout layout,
    SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
  }) {
    return MetaplexAuctionHouseProgram(keys: [
      wallet.toWritable(),
      tokenAccount.toWritable(),
      tokenMint.toReadOnly(),
      authority.toReadOnly(),
      auctionHouse.toReadOnly(),
      auctionHouseFeeAccount.toWritable(),
      tradeState.toWritable(),
      tokenProgram.toReadOnly(),
    ], programId: MetaplexAuctionHouseProgramConst.programId, layout: layout);
  }

  /// Cancel an active bid receipt by setting the `canceled_at` field to the current time.
  factory MetaplexAuctionHouseProgram.cancelBidReceipt({
    required SolAddress receipt,
    required SolAddress instruction,
    SolAddress systemProgram = SystemProgramConst.programId,
  }) {
    return MetaplexAuctionHouseProgram(
        keys: [
          receipt.toWritable(),
          systemProgram.toReadOnly(),
          instruction.toReadOnly(),
        ],
        programId: MetaplexAuctionHouseProgramConst.programId,
        layout: MetaplexAuctionHouseCancelBidReceiptLayout());
  }

  /// Cancel an active listing receipt by setting the `canceled_at` field to the current time.
  factory MetaplexAuctionHouseProgram.cancelListingReceipt({
    required SolAddress receipt,
    required SolAddress instruction,
    SolAddress systemProgram = SystemProgramConst.programId,
  }) {
    return MetaplexAuctionHouseProgram(
        keys: [
          receipt.toWritable(),
          systemProgram.toReadOnly(),
          instruction.toReadOnly(),
        ],
        programId: MetaplexAuctionHouseProgramConst.programId,
        layout: MetaplexAuctionHouseCancelListingReceiptLayout());
  }
  factory MetaplexAuctionHouseProgram.cancelRemainingAccounts({
    required SolAddress metadataProgram,
    required SolAddress delegateRecord,
    required SolAddress programAsSigner,
    required SolAddress metadata,
    required SolAddress edition,
    required SolAddress tokenRecord,
    required SolAddress tokenMint,
    required SolAddress authRulesProgram,
    required SolAddress authRules,
    required SolAddress sysvarInstructions,
    SolAddress systemProgram = SystemProgramConst.programId,
  }) {
    return MetaplexAuctionHouseProgram(
        keys: [
          metadataProgram.toReadOnly(),
          delegateRecord.toWritable(),
          programAsSigner.toReadOnly(),
          metadata.toWritable(),
          edition.toReadOnly(),
          tokenRecord.toWritable(),
          tokenMint.toReadOnly(),
          authRulesProgram.toReadOnly(),
          authRules.toReadOnly(),
          sysvarInstructions.toReadOnly(),
          systemProgram.toReadOnly()
        ],
        programId: MetaplexAuctionHouseProgramConst.programId,
        layout: MetaplexAuctionHouseCancelRemainingAccountsLayout());
  }

  /// Close the escrow account of the user.
  factory MetaplexAuctionHouseProgram.closeEscrowAccount({
    /// User wallet account.
    required SolAddress wallet,

    /// Buyer escrow payment account PDA.
    required SolAddress escrowPaymentAccount,

    /// Auction House instance PDA account.
    required SolAddress auctionHouse,
    required MetaplexAuctionHouseCloseEscrowAccountLayout layout,
    SolAddress systemProgram = SystemProgramConst.programId,
  }) {
    return MetaplexAuctionHouseProgram(keys: [
      wallet.toSigner(),
      escrowPaymentAccount.toWritable(),
      auctionHouse.toReadOnly(),
      systemProgram.toReadOnly()
    ], programId: MetaplexAuctionHouseProgramConst.programId, layout: layout);
  }

  /// Deposit `amount` into the escrow payment account for your specific wallet.
  factory MetaplexAuctionHouseProgram.deposit(
      {required SolAddress wallet,
      required SolAddress paymentAccount,
      required SolAddress transferAuthority,
      required SolAddress escrowPaymentAccount,
      required SolAddress treasuryMint,
      required SolAddress authority,
      required SolAddress auctionHouse,
      required SolAddress auctionHouseFeeAccount,
      required MetaplexAuctionHouseDepositLayout layout,
      SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
      SolAddress systemProgram = SystemProgramConst.programId,
      SolAddress rent = SystemProgramConst.sysvarRentPubkey}) {
    return MetaplexAuctionHouseProgram(keys: [
      wallet.toSigner(),
      paymentAccount.toWritable(),
      transferAuthority.toReadOnly(),
      escrowPaymentAccount.toWritable(),
      treasuryMint.toReadOnly(),
      authority.toReadOnly(),
      auctionHouse.toReadOnly(),
      auctionHouseFeeAccount.toWritable(),
      tokenProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      rent.toReadOnly(),
    ], programId: MetaplexAuctionHouseProgramConst.programId, layout: layout);
  }
  factory MetaplexAuctionHouseProgram.executePartialSale(
      {required SolAddress buyer,
      required SolAddress seller,
      required SolAddress tokenAccount,
      required SolAddress tokenMint,
      required SolAddress metadata,
      required SolAddress treasuryMint,
      required SolAddress escrowPaymentAccount,
      required SolAddress sellerPaymentReceiptAccount,
      required SolAddress buyerReceiptTokenAccount,
      required SolAddress authority,
      required SolAddress auctionHouse,
      required SolAddress auctionHouseFeeAccount,
      required SolAddress auctionHouseTreasury,
      required SolAddress buyerTradeState,
      required SolAddress sellerTradeState,
      required SolAddress freeTradeState,
      SolAddress ataProgram =
          AssociatedTokenAccountProgramConst.associatedTokenProgramId,
      required SolAddress programAsSigner,
      required MetaplexAuctionHouseExecutePartialSaleLayout layout,
      SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
      SolAddress systemProgram = SystemProgramConst.programId,
      SolAddress rent = SystemProgramConst.sysvarRentPubkey}) {
    return MetaplexAuctionHouseProgram(keys: [
      buyer.toWritable(),
      seller.toWritable(),
      tokenAccount.toWritable(),
      tokenMint.toReadOnly(),
      metadata.toReadOnly(),
      treasuryMint.toReadOnly(),
      escrowPaymentAccount.toWritable(),
      sellerPaymentReceiptAccount.toWritable(),
      buyerReceiptTokenAccount.toWritable(),
      authority.toReadOnly(),
      auctionHouse.toReadOnly(),
      auctionHouseFeeAccount.toWritable(),
      auctionHouseTreasury.toWritable(),
      buyerTradeState.toWritable(),
      sellerTradeState.toWritable(),
      freeTradeState.toWritable(),
      tokenProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      ataProgram.toReadOnly(),
      programAsSigner.toReadOnly(),
      rent.toReadOnly(),
    ], programId: MetaplexAuctionHouseProgramConst.programId, layout: layout);
  }
  factory MetaplexAuctionHouseProgram.executeSale(
      {required SolAddress buyer,
      required SolAddress seller,
      required SolAddress tokenAccount,
      required SolAddress tokenMint,
      required SolAddress metadata,
      required SolAddress treasuryMint,
      required SolAddress escrowPaymentAccount,
      required SolAddress sellerPaymentReceiptAccount,
      required SolAddress buyerReceiptTokenAccount,
      required SolAddress authority,
      required SolAddress auctionHouse,
      required SolAddress auctionHouseFeeAccount,
      required SolAddress auctionHouseTreasury,
      required SolAddress buyerTradeState,
      required SolAddress sellerTradeState,
      required SolAddress freeTradeState,
      required SolAddress programAsSigner,
      required MetaplexAuctionHouseExecuteSaleLayout layout,
      SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
      SolAddress systemProgram = SystemProgramConst.programId,
      SolAddress rent = SystemProgramConst.sysvarRentPubkey,
      SolAddress ataProgram =
          AssociatedTokenAccountProgramConst.associatedTokenProgramId}) {
    return MetaplexAuctionHouseProgram(keys: [
      buyer.toWritable(),
      seller.toWritable(),
      tokenAccount.toWritable(),
      tokenMint.toReadOnly(),
      metadata.toReadOnly(),
      treasuryMint.toReadOnly(),
      escrowPaymentAccount.toWritable(),
      sellerPaymentReceiptAccount.toWritable(),
      buyerReceiptTokenAccount.toWritable(),
      authority.toReadOnly(),
      auctionHouse.toReadOnly(),
      auctionHouseFeeAccount.toWritable(),
      auctionHouseTreasury.toWritable(),
      buyerTradeState.toWritable(),
      sellerTradeState.toWritable(),
      freeTradeState.toWritable(),
      tokenProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      ataProgram.toReadOnly(),
      programAsSigner.toReadOnly(),
      rent.toReadOnly(),
    ], programId: MetaplexAuctionHouseProgramConst.programId, layout: layout);
  }
  factory MetaplexAuctionHouseProgram.executeSaleRemainingAccounts({
    required SolAddress metadataProgram,
    required SolAddress edition,
    required SolAddress ownerTr,
    required SolAddress destinationTr,
    required SolAddress authRulesProgram,
    required SolAddress authRules,
    required SolAddress sysvarInstructions,
  }) {
    return MetaplexAuctionHouseProgram(
        keys: [
          metadataProgram.toReadOnly(),
          edition.toReadOnly(),
          ownerTr.toWritable(),
          destinationTr.toWritable(),
          authRulesProgram.toReadOnly(),
          authRules.toReadOnly(),
          sysvarInstructions.toReadOnly()
        ],
        programId: MetaplexAuctionHouseProgramConst.programId,
        layout: MetaplexAuctionHouseExecuteSaleRemainingAccountsLayout());
  }

  /// Create a bid receipt by creating a `bid_receipt` account.
  factory MetaplexAuctionHouseProgram.printBidReceipt({
    required SolAddress receipt,
    required SolAddress bookkeeper,
    required SolAddress instruction,
    required MetaplexAuctionHousePrintBidReceiptLayout layout,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress rent = SystemProgramConst.sysvarRentPubkey,
  }) {
    return MetaplexAuctionHouseProgram(keys: [
      receipt.toWritable(),
      bookkeeper.toSignerAndWritable(),
      systemProgram.toReadOnly(),
      rent.toReadOnly(),
      instruction.toReadOnly(),
    ], programId: MetaplexAuctionHouseProgramConst.programId, layout: layout);
  }

  /// Create a listing receipt by creating a `listing_receipt` account.
  factory MetaplexAuctionHouseProgram.printListingReceipt({
    required SolAddress receipt,
    required SolAddress bookkeeper,
    required SolAddress instruction,
    required MetaplexAuctionHousePrintListingReceiptLayout layout,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress rent = SystemProgramConst.sysvarRentPubkey,
  }) {
    return MetaplexAuctionHouseProgram(keys: [
      receipt.toWritable(),
      bookkeeper.toSignerAndWritable(),
      systemProgram.toReadOnly(),
      rent.toReadOnly(),
      instruction.toReadOnly(),
    ], programId: MetaplexAuctionHouseProgramConst.programId, layout: layout);
  }

  /// Create a purchase receipt by creating a `purchase_receipt` account.
  factory MetaplexAuctionHouseProgram.printPurchaseReceipt({
    required SolAddress purchaseReceipt,
    required SolAddress listingReceipt,
    required SolAddress bidReceipt,
    required SolAddress bookkeeper,
    required SolAddress instruction,
    required MetaplexAuctionHousePrintPurchaseReceiptLayout layout,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress rent = SystemProgramConst.sysvarRentPubkey,
  }) {
    return MetaplexAuctionHouseProgram(keys: [
      purchaseReceipt.toWritable(),
      listingReceipt.toWritable(),
      bidReceipt.toWritable(),
      bookkeeper.toSignerAndWritable(),
      systemProgram.toReadOnly(),
      rent.toReadOnly(),
      instruction.toReadOnly()
    ], programId: MetaplexAuctionHouseProgramConst.programId, layout: layout);
  }

  /// Create a public buy bid by creating a `public_buyer_trade_state` account and an `escrow_payment` account and funding the escrow with the necessary SOL or SPL token amount.
  factory MetaplexAuctionHouseProgram.publicBuy({
    required SolAddress wallet,
    required SolAddress paymentAccount,
    required SolAddress transferAuthority,
    required SolAddress treasuryMint,
    required SolAddress tokenAccount,
    required SolAddress metadata,
    required SolAddress escrowPaymentAccount,
    required SolAddress authority,
    required SolAddress auctionHouse,
    required SolAddress auctionHouseFeeAccount,
    required SolAddress buyerTradeState,
    required MetaplexAuctionHousePublicBuyLayout layout,
    SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress rent = SystemProgramConst.sysvarRentPubkey,
  }) {
    return MetaplexAuctionHouseProgram(keys: [
      wallet.toSigner(),
      paymentAccount.toWritable(),
      transferAuthority.toReadOnly(),
      treasuryMint.toReadOnly(),
      tokenAccount.toReadOnly(),
      metadata.toReadOnly(),
      escrowPaymentAccount.toWritable(),
      authority.toReadOnly(),
      auctionHouse.toReadOnly(),
      auctionHouseFeeAccount.toWritable(),
      buyerTradeState.toWritable(),
      tokenProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      rent.toReadOnly(),
    ], programId: MetaplexAuctionHouseProgramConst.programId, layout: layout);
  }
  factory MetaplexAuctionHouseProgram.sell({
    required SolAddress wallet,
    required SolAddress tokenAccount,
    required SolAddress metadata,
    required SolAddress authority,
    required SolAddress auctionHouse,
    required SolAddress auctionHouseFeeAccount,
    required SolAddress sellerTradeState,
    required SolAddress freeSellerTradeState,
    required SolAddress programAsSigner,
    required MetaplexAuctionHouseSellLayout layout,
    SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress rent = SystemProgramConst.sysvarRentPubkey,
  }) {
    return MetaplexAuctionHouseProgram(keys: [
      wallet.toReadOnly(),
      tokenAccount.toWritable(),
      metadata.toReadOnly(),
      authority.toReadOnly(),
      auctionHouse.toReadOnly(),
      auctionHouseFeeAccount.toWritable(),
      sellerTradeState.toWritable(),
      freeSellerTradeState.toWritable(),
      tokenProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      programAsSigner.toReadOnly(),
      rent.toReadOnly(),
    ], programId: MetaplexAuctionHouseProgramConst.programId, layout: layout);
  }
  factory MetaplexAuctionHouseProgram.sellRemainingAccounts({
    required SolAddress metadataProgram,
    required SolAddress delegateRecord,
    required SolAddress tokenRecord,
    required SolAddress tokenMint,
    required SolAddress edition,
    required SolAddress authRulesProgram,
    required SolAddress authRules,
    required SolAddress sysvarInstructions,
  }) {
    return MetaplexAuctionHouseProgram(
        keys: [
          metadataProgram.toReadOnly(),
          delegateRecord.toWritable(),
          tokenRecord.toWritable(),
          tokenMint.toReadOnly(),
          edition.toReadOnly(),
          authRulesProgram.toReadOnly(),
          authRules.toReadOnly(),
          sysvarInstructions.toReadOnly(),
        ],
        programId: MetaplexAuctionHouseProgramConst.programId,
        layout: MetaplexAuctionHouseSellRemainingAccountsLayout());
  }
  factory MetaplexAuctionHouseProgram.updateAuctioneer({
    required SolAddress auctionHouse,
    required SolAddress authority,
    required SolAddress auctioneerAuthority,
    required SolAddress ahAuctioneerPda,
    required MetaplexAuctionHouseUpdateAuctioneerLayout layout,
    SolAddress systemProgram = SystemProgramConst.programId,
  }) {
    return MetaplexAuctionHouseProgram(keys: [
      auctionHouse.toWritable(),
      authority.toSignerAndWritable(),
      auctioneerAuthority.toReadOnly(),
      ahAuctioneerPda.toWritable(),
      systemProgram.toReadOnly(),
    ], programId: MetaplexAuctionHouseProgramConst.programId, layout: layout);
  }

  /// Update Auction House values such as seller fee basis points, update authority, treasury account, etc.
  factory MetaplexAuctionHouseProgram.updateAuctionHouse(
      {
      /// Treasury mint account, either native SOL mint or a SPL token mint.
      required SolAddress treasuryMint,

      /// Key paying SOL fees for setting up the Auction House.
      required SolAddress payer,

      /// Authority key for the Auction House.
      required SolAddress authority,

      /// New authority key for the Auction House.
      required SolAddress newAuthority,

      /// Account that pays for fees if the marketplace executes sales.
      required SolAddress feeWithdrawalDestination,

      /// SOL or SPL token account to receive Auction House fees. If treasury mint is native this will be the same as the `treasury_withdrawl_destination_owner`.
      required SolAddress treasuryWithdrawalDestination,

      /// Owner of the `treasury_withdrawal_destination` account or the same address if the `treasury_mint` is native.
      required SolAddress treasuryWithdrawalDestinationOwner,

      /// Auction House instance PDA account.
      required SolAddress auctionHouse,
      required MetaplexAuctionHouseUpdateAuctionHouseLayout layout,
      SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
      SolAddress systemProgram = SystemProgramConst.programId,
      SolAddress rent = SystemProgramConst.sysvarRentPubkey,
      SolAddress ataProgram =
          AssociatedTokenAccountProgramConst.associatedTokenProgramId}) {
    return MetaplexAuctionHouseProgram(keys: [
      treasuryMint.toReadOnly(),
      payer.toSigner(),
      authority.toSigner(),
      newAuthority.toReadOnly(),
      feeWithdrawalDestination.toWritable(),
      treasuryWithdrawalDestination.toWritable(),
      treasuryWithdrawalDestinationOwner.toReadOnly(),
      auctionHouse.toWritable(),
      tokenProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      ataProgram.toReadOnly(),
      rent.toReadOnly()
    ], programId: MetaplexAuctionHouseProgramConst.programId, layout: layout);
  }

  /// Withdraw `amount` from the escrow payment account for your specific wallet.
  factory MetaplexAuctionHouseProgram.withdraw(
      {required SolAddress wallet,
      required SolAddress receiptAccount,
      required SolAddress escrowPaymentAccount,
      required SolAddress treasuryMint,
      required SolAddress authority,
      required SolAddress auctionHouse,
      required SolAddress auctionHouseFeeAccount,
      required MetaplexAuctionHouseWithdrawLayout layout,
      SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
      SolAddress systemProgram = SystemProgramConst.programId,
      SolAddress rent = SystemProgramConst.sysvarRentPubkey,
      SolAddress ataProgram =
          AssociatedTokenAccountProgramConst.associatedTokenProgramId}) {
    return MetaplexAuctionHouseProgram(keys: [
      wallet.toReadOnly(),
      receiptAccount.toWritable(),
      escrowPaymentAccount.toWritable(),
      treasuryMint.toReadOnly(),
      authority.toReadOnly(),
      auctionHouse.toReadOnly(),
      auctionHouseFeeAccount.toWritable(),
      tokenProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      ataProgram.toReadOnly(),
      rent.toReadOnly()
    ], programId: MetaplexAuctionHouseProgramConst.programId, layout: layout);
  }

  /// Withdraw `amount` from the Auction House Fee Account to a provided destination account.
  factory MetaplexAuctionHouseProgram.withdrawFromFee({
    /// Authority key for the Auction House.
    required SolAddress authority,

    /// Account that pays for fees if the marketplace executes sales.
    required SolAddress feeWithdrawalDestination,

    /// Auction House instance fee account.
    required SolAddress auctionHouseFeeAccount,

    /// Auction House instance PDA account.
    required SolAddress auctionHouse,
    required MetaplexAuctionHouseWithdrawFromFeeLayout layout,
    SolAddress systemProgram = SystemProgramConst.programId,
  }) {
    return MetaplexAuctionHouseProgram(keys: [
      authority.toSigner(),
      feeWithdrawalDestination.toWritable(),
      auctionHouseFeeAccount.toWritable(),
      auctionHouse.toWritable(),
      systemProgram.toReadOnly()
    ], programId: MetaplexAuctionHouseProgramConst.programId, layout: layout);
  }

  /// Withdraw `amount` from the Auction House Treasury Account to a provided destination account.
  factory MetaplexAuctionHouseProgram.withdrawFromTreasury({
    /// Treasury mint account, either native SOL mint or a SPL token mint.
    required SolAddress treasuryMint,

    /// Authority key for the Auction House.
    required SolAddress authority,

    /// SOL or SPL token account to receive Auction House fees. If treasury mint is native this will be the same as the `treasury_withdrawl_destination_owner`.
    required SolAddress treasuryWithdrawalDestination,

    /// Auction House treasury PDA account.
    required SolAddress auctionHouseTreasury,

    /// Auction House instance PDA account.
    required SolAddress auctionHouse,
    required MetaplexAuctionHouseWithdrawFromTreasuryLayout layout,
    SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
    SolAddress systemProgram = SystemProgramConst.programId,
  }) {
    return MetaplexAuctionHouseProgram(keys: [
      treasuryMint.toReadOnly(),
      authority.toSigner(),
      treasuryWithdrawalDestination.toWritable(),
      auctionHouseTreasury.toWritable(),
      auctionHouse.toWritable(),
      tokenProgram.toReadOnly(),
      systemProgram.toReadOnly()
    ], programId: MetaplexAuctionHouseProgramConst.programId, layout: layout);
  }
}
