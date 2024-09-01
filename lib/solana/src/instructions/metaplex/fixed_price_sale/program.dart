import 'package:on_chain/solana/src/borsh_serialization/core/program_layout.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/constant.dart';
import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/layouts/layouts.dart';
import 'package:on_chain/solana/src/instructions/spl_token/constant.dart';
import 'package:on_chain/solana/src/instructions/system/constant.dart';
import 'package:on_chain/solana/src/models/models.dart';

class MetaplexFixedPriceSaleProgram extends TransactionInstruction {
  MetaplexFixedPriceSaleProgram({
    required List<AccountMeta> keys,
    required SolAddress programId,
    required ProgramLayout layout,
  }) : super(keys: keys, data: layout.toBytes(), programId: programId);

  factory MetaplexFixedPriceSaleProgram.buy({
    required SolAddress market,
    required SolAddress sellingResource,
    required SolAddress userTokenAccount,
    required SolAddress userWallet,
    required SolAddress tradeHistory,
    required SolAddress treasuryHolder,
    required SolAddress newMetadata,
    required SolAddress newEdition,
    required SolAddress masterEdition,
    required SolAddress newMint,
    required SolAddress editionMarker,
    required SolAddress vault,
    required SolAddress owner,
    required SolAddress newTokenAccount,
    required SolAddress masterEditionMetadata,
    required SolAddress clock,
    required SolAddress tokenMetadataProgram,
    required MetaplexFixedPriceSaleBuyLayout layout,
    List<AccountMeta> anchorRemainingAccounts = const [],
    SolAddress rent = SystemProgramConst.sysvarRentPubkey,
    SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
    SolAddress systemProgram = SystemProgramConst.programId,
  }) {
    return MetaplexFixedPriceSaleProgram(keys: [
      market.toWritable(),
      sellingResource.toWritable(),
      userTokenAccount.toWritable(),
      userWallet.toSignerAndWritable(),
      tradeHistory.toWritable(),
      treasuryHolder.toWritable(),
      newMetadata.toWritable(),
      newEdition.toWritable(),
      masterEdition.toWritable(),
      newMint.toWritable(),
      editionMarker.toWritable(),
      vault.toWritable(),
      owner.toReadOnly(),
      newTokenAccount.toWritable(),
      masterEditionMetadata.toWritable(),
      clock.toReadOnly(),
      rent.toReadOnly(),
      tokenMetadataProgram.toReadOnly(),
      tokenProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      ...anchorRemainingAccounts,
    ], programId: MetaplexFixedPriceSaleProgramConst.programId, layout: layout);
  }
  factory MetaplexFixedPriceSaleProgram.buyV2({
    required SolAddress market,
    required SolAddress sellingResource,
    required SolAddress userTokenAccount,
    required SolAddress userWallet,
    required SolAddress tradeHistory,
    required SolAddress treasuryHolder,
    required SolAddress newMetadata,
    required SolAddress newEdition,
    required SolAddress masterEdition,
    required SolAddress newMint,
    required SolAddress editionMarker,
    required SolAddress vault,
    required SolAddress owner,
    required SolAddress newTokenAccount,
    required SolAddress masterEditionMetadata,
    required SolAddress clock,
    required SolAddress tokenMetadataProgram,
    required MetaplexFixedPriceSaleBuyV2Layout layout,
    List<AccountMeta> anchorRemainingAccounts = const [],
    SolAddress rent = SystemProgramConst.sysvarRentPubkey,
    SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
    SolAddress systemProgram = SystemProgramConst.programId,
  }) {
    return MetaplexFixedPriceSaleProgram(keys: [
      market.toWritable(),
      sellingResource.toWritable(),
      userTokenAccount.toWritable(),
      userWallet.toSignerAndWritable(),
      tradeHistory.toWritable(),
      treasuryHolder.toWritable(),
      newMetadata.toWritable(),
      newEdition.toWritable(),
      masterEdition.toWritable(),
      newMint.toWritable(),
      editionMarker.toWritable(),
      vault.toWritable(),
      owner.toReadOnly(),
      newTokenAccount.toWritable(),
      masterEditionMetadata.toWritable(),
      clock.toReadOnly(),
      rent.toReadOnly(),
      tokenMetadataProgram.toReadOnly(),
      tokenProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      ...anchorRemainingAccounts
    ], programId: MetaplexFixedPriceSaleProgramConst.programId, layout: layout);
  }
  factory MetaplexFixedPriceSaleProgram.changeMarket({
    required SolAddress market,
    required SolAddress owner,
    required SolAddress clock,
    required MetaplexFixedPriceSaleChangeMarketLayout layout,
    List<AccountMeta> anchorRemainingAccounts = const [],
  }) {
    return MetaplexFixedPriceSaleProgram(keys: [
      market.toWritable(),
      owner.toSigner(),
      clock.toReadOnly(),
      ...anchorRemainingAccounts,
    ], programId: MetaplexFixedPriceSaleProgramConst.programId, layout: layout);
  }
  factory MetaplexFixedPriceSaleProgram.claimResource({
    required SolAddress market,
    required SolAddress treasuryHolder,
    required SolAddress sellingResource,
    required SolAddress sellingResourceOwner,
    required SolAddress vault,
    required SolAddress metadata,
    required SolAddress owner,
    required SolAddress destination,
    required SolAddress clock,
    required SolAddress tokenMetadataProgram,
    required MetaplexFixedPriceSaleClaimResourceLayout layout,
    List<AccountMeta> anchorRemainingAccounts = const [],
    SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
    SolAddress systemProgram = SystemProgramConst.programId,
  }) {
    return MetaplexFixedPriceSaleProgram(keys: [
      market.toReadOnly(),
      treasuryHolder.toReadOnly(),
      sellingResource.toReadOnly(),
      sellingResourceOwner.toSigner(),
      vault.toWritable(),
      metadata.toWritable(),
      owner.toReadOnly(),
      destination.toWritable(),
      clock.toReadOnly(),
      tokenProgram.toReadOnly(),
      tokenMetadataProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      ...anchorRemainingAccounts
    ], programId: MetaplexFixedPriceSaleProgramConst.programId, layout: layout);
  }
  factory MetaplexFixedPriceSaleProgram.closeMarket({
    required SolAddress market,
    required SolAddress owner,
    required SolAddress clock,
    List<AccountMeta> anchorRemainingAccounts = const [],
  }) {
    return MetaplexFixedPriceSaleProgram(
        keys: [
          market.toWritable(),
          owner.toSigner(),
          clock.toReadOnly(),
          ...anchorRemainingAccounts
        ],
        programId: MetaplexFixedPriceSaleProgramConst.programId,
        layout: MetaplexFixedPriceSaleCloseMarketLayout());
  }

  factory MetaplexFixedPriceSaleProgram.createMarket({
    required SolAddress market,
    required SolAddress store,
    required SolAddress sellingResourceOwner,
    required SolAddress sellingResource,
    required SolAddress mint,
    required SolAddress treasuryHolder,
    required SolAddress owner,
    required MetaplexFixedPriceSaleCreateMarketLayout layout,
    SolAddress systemProgram = SystemProgramConst.programId,
    List<AccountMeta> anchorRemainingAccounts = const [],
  }) {
    return MetaplexFixedPriceSaleProgram(keys: [
      market.toSignerAndWritable(),
      store.toReadOnly(),
      sellingResourceOwner.toSignerAndWritable(),
      sellingResource.toWritable(),
      mint.toReadOnly(),
      treasuryHolder.toWritable(),
      owner.toReadOnly(),
      systemProgram.toReadOnly(),
      ...anchorRemainingAccounts,
    ], programId: MetaplexFixedPriceSaleProgramConst.programId, layout: layout);
  }
  factory MetaplexFixedPriceSaleProgram.createStore({
    required SolAddress admin,
    required SolAddress store,
    required MetaplexFixedPriceSaleCreateStoreLayout layout,
    List<AccountMeta> anchorRemainingAccounts = const [],
    SolAddress systemProgram = SystemProgramConst.programId,
  }) {
    return MetaplexFixedPriceSaleProgram(keys: [
      admin.toSignerAndWritable(),
      store.toSignerAndWritable(),
      systemProgram.toReadOnly(),
      ...anchorRemainingAccounts
    ], programId: MetaplexFixedPriceSaleProgramConst.programId, layout: layout);
  }
  factory MetaplexFixedPriceSaleProgram.initSellingResource({
    required SolAddress store,
    required SolAddress admin,
    required SolAddress sellingResource,
    required SolAddress sellingResourceOwner,
    required SolAddress resourceMint,
    required SolAddress masterEdition,
    required SolAddress metadata,
    required SolAddress vault,
    required SolAddress owner,
    required SolAddress resourceToken,
    required MetaplexFixedPriceSaleInitSellingResourceLayout layout,
    List<AccountMeta> anchorRemainingAccounts = const [],
    SolAddress rent = SystemProgramConst.sysvarRentPubkey,
    SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
    SolAddress systemProgram = SystemProgramConst.programId,
  }) {
    return MetaplexFixedPriceSaleProgram(keys: [
      store.toReadOnly(),
      admin.toSignerAndWritable(),
      sellingResource.toSignerAndWritable(),
      sellingResourceOwner.toReadOnly(),
      resourceMint.toReadOnly(),
      masterEdition.toReadOnly(),
      metadata.toReadOnly(),
      vault.toWritable(),
      owner.toReadOnly(),
      resourceToken.toWritable(),
      rent.toReadOnly(),
      tokenProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      ...anchorRemainingAccounts,
    ], programId: MetaplexFixedPriceSaleProgramConst.programId, layout: layout);
  }
  factory MetaplexFixedPriceSaleProgram.resumeMarket({
    required SolAddress market,
    required SolAddress owner,
    required SolAddress clock,
    List<AccountMeta> anchorRemainingAccounts = const [],
  }) {
    return MetaplexFixedPriceSaleProgram(
        keys: [
          market.toWritable(),
          owner.toSigner(),
          clock.toReadOnly(),
          ...anchorRemainingAccounts
        ],
        programId: MetaplexFixedPriceSaleProgramConst.programId,
        layout: MetaplexFixedPriceSaleResumeMarketLayout());
  }
  factory MetaplexFixedPriceSaleProgram.savePrimaryMetadataCreators({
    required SolAddress admin,
    required SolAddress metadata,
    required SolAddress primaryMetadataCreators,
    required MetaplexFixedPriceSaleSavePrimaryMetadataCreatorsLayout layout,
    List<AccountMeta> anchorRemainingAccounts = const [],
    SolAddress systemProgram = SystemProgramConst.programId,
  }) {
    return MetaplexFixedPriceSaleProgram(keys: [
      admin.toSignerAndWritable(),
      metadata.toWritable(),
      primaryMetadataCreators.toWritable(),
      systemProgram.toReadOnly(),
      ...anchorRemainingAccounts
    ], programId: MetaplexFixedPriceSaleProgramConst.programId, layout: layout);
  }
  factory MetaplexFixedPriceSaleProgram.suspendMarket({
    required SolAddress market,
    required SolAddress owner,
    required SolAddress clock,
    List<AccountMeta> anchorRemainingAccounts = const [],
  }) {
    return MetaplexFixedPriceSaleProgram(
        keys: [
          market.toWritable(),
          owner.toSigner(),
          clock.toReadOnly(),
          ...anchorRemainingAccounts
        ],
        programId: MetaplexFixedPriceSaleProgramConst.programId,
        layout: MetaplexFixedPriceSaleSuspendMarketLayout());
  }
  factory MetaplexFixedPriceSaleProgram.withdraw({
    required SolAddress market,
    required SolAddress sellingResource,
    required SolAddress metadata,
    required SolAddress treasuryHolder,
    required SolAddress treasuryMint,
    required SolAddress owner,
    required SolAddress destination,
    required SolAddress funder,
    required SolAddress payer,
    required SolAddress payoutTicket,
    required SolAddress clock,
    required SolAddress associatedTokenProgram,
    required MetaplexFixedPriceSaleWithdrawLayout layout,
    List<AccountMeta> anchorRemainingAccounts = const [],
    SolAddress rent = SystemProgramConst.sysvarRentPubkey,
    SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
    SolAddress systemProgram = SystemProgramConst.programId,
  }) {
    return MetaplexFixedPriceSaleProgram(keys: [
      market.toReadOnly(),
      sellingResource.toReadOnly(),
      metadata.toReadOnly(),
      treasuryHolder.toWritable(),
      treasuryMint.toReadOnly(),
      owner.toReadOnly(),
      destination.toWritable(),
      funder.toReadOnly(),
      payer.toSignerAndWritable(),
      payoutTicket.toWritable(),
      rent.toReadOnly(),
      clock.toReadOnly(),
      tokenProgram.toReadOnly(),
      associatedTokenProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      ...anchorRemainingAccounts
    ], programId: MetaplexFixedPriceSaleProgramConst.programId, layout: layout);
  }
}
