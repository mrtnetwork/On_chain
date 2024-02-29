import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/associated_token_account/constant.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auctioneer/layouts/layouts.dart';
import 'package:on_chain/solana/src/layout/program_layouts/program_layout.dart';
import 'package:on_chain/solana/src/instructions/spl_token/spl_token.dart';
import 'package:on_chain/solana/src/instructions/system/system.dart';
import 'package:on_chain/solana/src/models/models.dart';
import 'constant.dart';

class MetaplexAuctioneerProgram extends TransactionInstruction {
  MetaplexAuctioneerProgram({
    required List<AccountMeta> keys,
    required SolAddress programId,
    required ProgramLayout layout,
  }) : super(keys: keys, layout: layout, programId: programId);

  /// Authorize the Auctioneer to manage an Auction House.
  factory MetaplexAuctioneerProgram.authorize({
    /// User wallet account.
    required SolAddress wallet,

    /// Auction House instance PDA account.
    required SolAddress auctionHouse,

    /// The auctioneer program PDA running this auction.
    required SolAddress auctioneerAuthority,
    SolAddress systemProgram = SystemProgramConst.programId,
  }) {
    return MetaplexAuctioneerProgram(
        keys: [
          wallet.toSignerAndWritable(),
          auctionHouse.toReadOnly(),
          auctioneerAuthority.toWritable(),
          systemProgram.toReadOnly(),
        ],
        programId: MetaplexAuctioneerProgramConst.programId,
        layout: MetaplexAuctioneerAuthorizeLayout());
  }

  /// Create a private buy bid by creating a `buyer_trade_state` account and an `escrow_payment` account and funding the escrow with the necessary SOL or SPL token amount.
  factory MetaplexAuctioneerProgram.buy(
      {
      /// Auction House Program
      required SolAddress auctionHouseProgram,
      // Accounts used for Auctioneer
      /// The Listing Config used for listing settings
      required SolAddress listingConfig,

      /// The seller of the NFT
      required SolAddress seller,

      /// User wallet account.
      required SolAddress wallet,

      /// User SOL or SPL account to transfer funds from.
      required SolAddress paymentAccount,

      /// SPL token account transfer authority.
      required SolAddress transferAuthority,

      /// Auction House instance treasury mint account.
      required SolAddress treasuryMint,

      /// SPL token account.
      required SolAddress tokenAccount,

      /// SPL token account metadata.
      required SolAddress metadata,

      /// Buyer escrow payment account PDA.
      required SolAddress escrowPaymentAccount,

      /// Auction House instance authority account.
      required SolAddress authority,

      /// Auction House instance PDA account.
      required SolAddress auctionHouse,

      /// Auction House instance fee account.
      required SolAddress auctionHouseFeeAccount,

      /// Buyer trade state PDA.
      required SolAddress buyerTradeState,

      /// The auctioneer program PDA running this auction.
      required SolAddress auctioneerAuthority,

      /// The auctioneer PDA owned by Auction House storing scopes.
      required SolAddress ahAuctioneerPda,
      required MetaplexAuctioneerBuyLayout layout,
      SolAddress tokenProgramId = SPLTokenProgramConst.tokenProgramId,
      SolAddress systemProgram = SystemProgramConst.programId,
      SolAddress rent = SystemProgramConst.sysvarRentPubkey}) {
    return MetaplexAuctioneerProgram(keys: [
      auctionHouseProgram.toReadOnly(),
      listingConfig.toWritable(),
      seller.toReadOnly(),
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
      auctioneerAuthority.toReadOnly(),
      ahAuctioneerPda.toReadOnly(),
      tokenProgramId.toReadOnly(),
      systemProgram.toReadOnly(),
      rent.toReadOnly(),
    ], programId: MetaplexAuctioneerProgramConst.programId, layout: layout);
  }

  /// Cancel a bid or ask by revoking the token delegate, transferring all lamports from the trade state account to the fee payer, and setting the trade state account data to zero so it can be garbage collected.
  factory MetaplexAuctioneerProgram.cancel(
      {
      /// Auction House Program
      required SolAddress auctionHouseProgram,

      /// The Listing Config used for listing settings
      required SolAddress listingConfig,

      /// The seller of the NFT
      required SolAddress seller,

      /// User wallet account.
      required SolAddress wallet,

      /// SPL token account containing the token of the sale to be canceled.
      required SolAddress tokenAccount,

      /// Token mint account of SPL token.
      required SolAddress tokenMint,

      /// Auction House instance authority account.
      required SolAddress authority,

      /// Auction House instance PDA account.
      required SolAddress auctionHouse,

      /// Auction House instance fee account.
      required SolAddress auctionHouseFeeAccount,

      /// Trade state PDA account representing the bid or ask to be canceled.
      required SolAddress tradeState,

      /// The auctioneer program PDA running this auction.
      required SolAddress auctioneerAuthority,

      /// The auctioneer PDA owned by Auction House storing scopes.
      required SolAddress ahAuctioneerPda,
      required MetaplexAuctioneerCancelLayout layout,
      SolAddress tokenProgramId = SPLTokenProgramConst.tokenProgramId}) {
    return MetaplexAuctioneerProgram(keys: [
      auctionHouseProgram.toReadOnly(),
      listingConfig.toWritable(),
      seller.toReadOnly(),
      wallet.toWritable(),
      tokenAccount.toWritable(),
      tokenMint.toReadOnly(),
      authority.toReadOnly(),
      auctionHouse.toReadOnly(),
      auctionHouseFeeAccount.toWritable(),
      tradeState.toWritable(),
      auctioneerAuthority.toReadOnly(),
      ahAuctioneerPda.toReadOnly(),
      tokenProgramId.toReadOnly(),
    ], programId: MetaplexAuctioneerProgramConst.programId, layout: layout);
  }

  /// Deposit `amount` into the escrow payment account for your specific wallet.
  factory MetaplexAuctioneerProgram.deposit(
      {
      /// Auction House Program
      required SolAddress auctionHouseProgram,

      /// User wallet account.
      required SolAddress wallet,

      /// User SOL or SPL account to transfer funds from.
      required SolAddress paymentAccount,

      /// SPL token account transfer authority.
      required SolAddress transferAuthority,

      /// Buyer escrow payment account PDA.
      required SolAddress escrowPaymentAccount,

      /// Auction House instance treasury mint account.
      required SolAddress treasuryMint,

      /// Auction House instance authority account.
      required SolAddress authority,

      /// Auction House instance PDA account.
      required SolAddress auctionHouse,

      /// Auction House instance fee account.
      required SolAddress auctionHouseFeeAccount,

      /// The auctioneer program PDA running this auction.
      required SolAddress auctioneerAuthority,

      /// The auctioneer PDA owned by Auction House storing scopes.
      required SolAddress ahAuctioneerPda,
      required MetaplexAuctioneerDepositLayout layout,
      SolAddress tokenProgramId = SPLTokenProgramConst.tokenProgramId,
      SolAddress systemProgram = SystemProgramConst.programId,
      SolAddress rent = SystemProgramConst.sysvarRentPubkey}) {
    return MetaplexAuctioneerProgram(keys: [
      auctionHouseProgram.toReadOnly(),
      wallet.toSigner(),
      paymentAccount.toWritable(),
      transferAuthority.toReadOnly(),
      escrowPaymentAccount.toWritable(),
      treasuryMint.toReadOnly(),
      authority.toReadOnly(),
      auctionHouse.toReadOnly(),
      auctionHouseFeeAccount.toWritable(),
      auctioneerAuthority.toReadOnly(),
      ahAuctioneerPda.toReadOnly(),
      tokenProgramId.toReadOnly(),
      systemProgram.toReadOnly(),
      rent.toReadOnly()
    ], programId: MetaplexAuctioneerProgramConst.programId, layout: layout);
  }

  /// Execute sale between provided buyer and seller trade state accounts transferring funds to seller wallet and token to buyer wallet.
  factory MetaplexAuctioneerProgram.executeSale(
      {
      /// Auction House Program
      required SolAddress auctionHouseProgram,

      /// The Listing Config used for listing settings
      required SolAddress listingConfig,

      /// Buyer user wallet account.
      required SolAddress buyer,

      /// Seller user wallet account.
      required SolAddress seller,

      /// Token account where the SPL token is stored.
      required SolAddress tokenAccount,

      /// Token mint account for the SPL token.
      required SolAddress tokenMint,

      /// Metaplex metadata account decorating SPL mint account.
      required SolAddress metadata,

      /// Auction House treasury mint account.
      required SolAddress treasuryMint,

      /// Buyer escrow payment account.
      required SolAddress escrowPaymentAccount,

      /// Seller SOL or SPL account to receive payment at.
      required SolAddress sellerPaymentReceiptAccount,

      /// Buyer SPL token account to receive purchased item at.
      required SolAddress buyerReceiptTokenAccount,

      /// Auction House instance authority.
      required SolAddress authority,

      /// Auction House instance PDA account.
      required SolAddress auctionHouse,

      /// Auction House instance fee account.
      required SolAddress auctionHouseFeeAccount,

      /// Auction House instance treasury account.
      required SolAddress auctionHouseTreasury,

      /// Buyer trade state PDA account encoding the buy order.
      required SolAddress buyerTradeState,

      /// Seller trade state PDA account encoding the sell order.
      required SolAddress sellerTradeState,

      /// Free seller trade state PDA account encoding a free sell order.
      required SolAddress freeTradeState,

      /// The auctioneer program PDA running this auction.
      required SolAddress auctioneerAuthority,

      /// The auctioneer PDA owned by Auction House storing scopes.
      required SolAddress ahAuctioneerPda,
      required SolAddress programAsSigner,
      required MetaplexAuctioneerExecuteSaleLayout layout,
      SolAddress tokenProgramId = SPLTokenProgramConst.tokenProgramId,
      SolAddress systemProgram = SystemProgramConst.programId,
      SolAddress rent = SystemProgramConst.sysvarRentPubkey,
      SolAddress ata =
          AssociatedTokenAccountProgramConst.associatedTokenProgramId}) {
    return MetaplexAuctioneerProgram(keys: [
      auctionHouseProgram.toReadOnly(),
      listingConfig.toWritable(),
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
      auctioneerAuthority.toReadOnly(),
      ahAuctioneerPda.toReadOnly(),
      tokenProgramId.toReadOnly(),
      systemProgram.toReadOnly(),
      ata.toReadOnly(),
      programAsSigner.toReadOnly(),
      rent.toReadOnly(),
    ], programId: MetaplexAuctioneerProgramConst.programId, layout: layout);
  }

  /// Create a sell bid by creating a `seller_trade_state` account and approving the program as the token delegate.
  factory MetaplexAuctioneerProgram.sell(
      {
      /// Auction House Program used for CPI call
      required SolAddress auctionHouseProgram,

      /// The Listing Config used for listing settings
      required SolAddress listingConfig,

      /// User wallet account.
      required SolAddress wallet,

      /// SPL token account containing token for sale.
      required SolAddress tokenAccount,

      /// Metaplex metadata account decorating SPL mint account.
      required SolAddress metadata,

      /// Auction House authority account.
      required SolAddress authority,

      /// Auction House instance PDA account.
      required SolAddress auctionHouse,

      /// Auction House instance fee account.
      required SolAddress auctionHouseFeeAccount,

      /// Seller trade state PDA account encoding the sell order.
      required SolAddress sellerTradeState,

      /// Free seller trade state PDA account encoding a free sell order.
      required SolAddress freeSellerTradeState,

      /// The auctioneer program PDA running this auction.
      required SolAddress auctioneerAuthority,

      /// The auctioneer PDA owned by Auction House storing scopes.
      required SolAddress ahAuctioneerPda,
      required SolAddress programAsSigner,
      required MetaplexAuctioneerSellLayout layout,
      SolAddress tokenProgramId = SPLTokenProgramConst.tokenProgramId,
      SolAddress systemProgram = SystemProgramConst.programId,
      SolAddress rent = SystemProgramConst.sysvarRentPubkey,
      SolAddress ata =
          AssociatedTokenAccountProgramConst.associatedTokenProgramId}) {
    return MetaplexAuctioneerProgram(keys: [
      auctionHouseProgram.toReadOnly(),
      listingConfig.toWritable(),
      wallet.toWritable(),
      tokenAccount.toWritable(),
      metadata.toReadOnly(),
      authority.toReadOnly(),
      auctionHouse.toReadOnly(),
      auctionHouseFeeAccount.toWritable(),
      sellerTradeState.toWritable(),
      freeSellerTradeState.toWritable(),
      auctioneerAuthority.toReadOnly(),
      ahAuctioneerPda.toReadOnly(),
      programAsSigner.toReadOnly(),
      tokenProgramId.toReadOnly(),
      systemProgram.toReadOnly(),
      rent.toReadOnly(),
    ], programId: MetaplexAuctioneerProgramConst.programId, layout: layout);
  }

  /// Withdraw `amount` from the escrow payment account for your specific wallet.
  factory MetaplexAuctioneerProgram.withdraw(
      {
      /// Auction House Program
      required SolAddress auctionHouseProgram,

      /// User wallet account.
      required SolAddress wallet,

      /// SPL token account or native SOL account to transfer funds to. If the account is a native SOL account, this is the same as the wallet address.
      required SolAddress receiptAccount,

      /// Buyer escrow payment account PDA.
      required SolAddress escrowPaymentAccount,

      /// Auction House instance treasury mint account.
      required SolAddress treasuryMint,

      /// Auction House instance authority account.
      required SolAddress authority,

      /// Auction House instance PDA account.
      required SolAddress auctionHouse,

      /// Auction House instance fee account.
      required SolAddress auctionHouseFeeAccount,

      /// The auctioneer program PDA running this auction.
      required SolAddress auctioneerAuthority,

      /// The auctioneer PDA owned by Auction House storing scopes.
      required SolAddress ahAuctioneerPda,
      required MetaplexAuctioneerWithdrawLayout layout,
      SolAddress tokenProgramId = SPLTokenProgramConst.tokenProgramId,
      SolAddress systemProgram = SystemProgramConst.programId,
      SolAddress rent = SystemProgramConst.sysvarRentPubkey,
      SolAddress ata =
          AssociatedTokenAccountProgramConst.associatedTokenProgramId}) {
    return MetaplexAuctioneerProgram(keys: [
      auctionHouseProgram.toReadOnly(),
      wallet.toReadOnly(),
      receiptAccount.toWritable(),
      escrowPaymentAccount.toWritable(),
      treasuryMint.toReadOnly(),
      authority.toReadOnly(),
      auctionHouse.toReadOnly(),
      auctionHouseFeeAccount.toWritable(),
      auctioneerAuthority.toReadOnly(),
      ahAuctioneerPda.toReadOnly(),
      tokenProgramId.toReadOnly(),
      systemProgram.toReadOnly(),
      ata.toReadOnly(),
      rent.toReadOnly(),
    ], programId: MetaplexAuctioneerProgramConst.programId, layout: layout);
  }
}
