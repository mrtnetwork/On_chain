import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/constant.dart';
import 'package:on_chain/solana/src/models/pda/pda.dart';

import 'types/types/meta_data_delegate_role.dart';

class MetaplexTokenMetaDataProgramUtils {
  static ProgramDerivedAddress findCollectionAuthorityRecordPda(

      /// The address of the mint account
      {required SolAddress mint,

      /// The address of the collection authority
      required SolAddress collectionAuthority}) {
    return ProgramDerivedAddress.find(seedBytes: [
      "metadata".codeUnits,
      MetaplexTokenMetaDataProgramConst.programId.toBytes(),
      mint.toBytes(),
      "collection_authority".codeUnits,
      collectionAuthority.toBytes()
    ], programId: MetaplexTokenMetaDataProgramConst.programId);
  }

  static ProgramDerivedAddress findDeprecatedMasterEditionV1Pda(

      /// The address of the mint account
      {required SolAddress mint}) {
    return ProgramDerivedAddress.find(seedBytes: [
      "metadata".codeUnits,
      MetaplexTokenMetaDataProgramConst.programId.toBytes(),
      mint.toBytes(),
      "edition".codeUnits,
    ], programId: MetaplexTokenMetaDataProgramConst.programId);
  }

  static ProgramDerivedAddress findEditionMarkerPda({
    /// The address of the mint account
    required SolAddress mint,

    /// The floor of the edition number divided by 248 as a string. I.e. ⌊edition/248⌋.
    required String editionMarker,
  }) {
    return ProgramDerivedAddress.find(seedBytes: [
      "metadata".codeUnits,
      MetaplexTokenMetaDataProgramConst.programId.toBytes(),
      mint.toBytes(),
      "edition".codeUnits,
      editionMarker.codeUnits,
    ], programId: MetaplexTokenMetaDataProgramConst.programId);
  }

  static ProgramDerivedAddress findEditionMarkerV2Pda(
      {
      /// The address of the mint account
      required SolAddress mint}) {
    return ProgramDerivedAddress.find(seedBytes: [
      "metadata".codeUnits,
      MetaplexTokenMetaDataProgramConst.programId.toBytes(),
      mint.toBytes(),
      "edition".codeUnits,
      "marker".codeUnits,
    ], programId: MetaplexTokenMetaDataProgramConst.programId);
  }

  static ProgramDerivedAddress findHolderDelegateRecordPda({
    /// The address of the mint account
    required SolAddress mint,

    /// The role of the holder delegate
    required String delegateRole,

    /// The address of the owner of the token
    required SolAddress owner,

    /// The address of the delegate authority
    required SolAddress delegate,
  }) {
    return ProgramDerivedAddress.find(seedBytes: [
      "metadata".codeUnits,
      MetaplexTokenMetaDataProgramConst.programId.toBytes(),
      mint.toBytes(),
      delegateRole.codeUnits,
      owner.toBytes(),
      delegate.toBytes()
    ], programId: MetaplexTokenMetaDataProgramConst.programId);
  }

  static ProgramDerivedAddress findMetadataPda({
    /// The address of the mint account
    required SolAddress mint,
  }) {
    return ProgramDerivedAddress.find(seedBytes: [
      "metadata".codeUnits,
      MetaplexTokenMetaDataProgramConst.programId.toBytes(),
      mint.toBytes()
    ], programId: MetaplexTokenMetaDataProgramConst.programId);
  }

  static ProgramDerivedAddress findTokenRecordPda(
      {
      /// The address of the mint account
      required SolAddress mint,

      /// The address of the token account (ata or not)
      required SolAddress token}) {
    return ProgramDerivedAddress.find(seedBytes: [
      "metadata".codeUnits,
      MetaplexTokenMetaDataProgramConst.programId.toBytes(),
      mint.toBytes(),
      "token_record".codeUnits,
      token.toBytes()
    ], programId: MetaplexTokenMetaDataProgramConst.programId);
  }

  static ProgramDerivedAddress findMasterEditionPda(
      {
      /// The address of the mint account
      required SolAddress mint}) {
    return ProgramDerivedAddress.find(seedBytes: [
      "metadata".codeUnits,
      MetaplexTokenMetaDataProgramConst.programId.toBytes(),
      mint.toBytes(),
      "edition".codeUnits,
    ], programId: MetaplexTokenMetaDataProgramConst.programId);
  }

  static ProgramDerivedAddress findUseAuthorityRecordPda(
      {
      /// The address of the mint account
      required SolAddress mint,

      /// The address of the use authority
      required SolAddress useAuthority}) {
    return ProgramDerivedAddress.find(seedBytes: [
      "metadata".codeUnits,
      MetaplexTokenMetaDataProgramConst.programId.toBytes(),
      mint.toBytes(),
      "user".codeUnits,
      useAuthority.toBytes()
    ], programId: MetaplexTokenMetaDataProgramConst.programId);
  }

  static ProgramDerivedAddress findMetadataDelegateRecordPda(
      {
      /// The address of the mint account
      required SolAddress mint,

      /// The role of the metadata delegate
      required SolAddress updateAuthority,

      /// The address of the metadata's update authority
      required SolAddress delegate,

      /// The address of the delegate authority
      required MetadataDelegateRole delegateRole}) {
    return ProgramDerivedAddress.find(seedBytes: [
      "metadata".codeUnits,
      MetaplexTokenMetaDataProgramConst.programId.toBytes(),
      mint.toBytes(),
      delegateRole.seed.codeUnits,
      updateAuthority.toBytes(),
      delegate.toBytes(),
    ], programId: MetaplexTokenMetaDataProgramConst.programId);
  }
}
