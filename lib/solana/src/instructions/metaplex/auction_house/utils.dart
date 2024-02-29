import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/constant.dart';
import 'package:on_chain/solana/src/models/pda/pda.dart';

class MetaplexAuctionHouseProgramUtils {
  /// Finds the Auction House PDA for a creator and treasury
  static ProgramDerivedAddress auctionHousePDA(
      {required SolAddress creator, required SolAddress treasuryMint}) {
    return ProgramDerivedAddress.find(seedBytes: [
      MetaplexAuctionHouseProgramConst.auctionHouseSeed.codeUnits,
      creator.toBytes(),
      treasuryMint.toBytes()
    ], programId: MetaplexAuctionHouseProgramConst.programId);
  }

  /// Finds the Auctioneer PDA of an Auction House
  static ProgramDerivedAddress auctioneerPDA(
      {required SolAddress auctionHouse,
      required SolAddress auctioneerAuthority}) {
    return ProgramDerivedAddress.find(seedBytes: [
      MetaplexAuctionHouseProgramConst.auctioneerSeed.codeUnits,
      auctionHouse.toBytes(),
      auctioneerAuthority.toBytes()
    ], programId: MetaplexAuctionHouseProgramConst.programId);
  }

  /// Finds the PDA of an Auction House's fee account.
  static ProgramDerivedAddress feeAcountPDA(
      {required SolAddress auctionHouse}) {
    return ProgramDerivedAddress.find(seedBytes: [
      MetaplexAuctionHouseProgramConst.auctionHouseSeed.codeUnits,
      auctionHouse.toBytes(),
      MetaplexAuctionHouseProgramConst.feePayerSeed.codeUnits,
    ], programId: MetaplexAuctionHouseProgramConst.programId);
  }

  /// Finds the PDA of an Auction House's treasury account.
  static ProgramDerivedAddress treasury({required SolAddress auctionHouse}) {
    return ProgramDerivedAddress.find(seedBytes: [
      MetaplexAuctionHouseProgramConst.auctionHouseSeed.codeUnits,
      auctionHouse.toBytes(),
      MetaplexAuctionHouseProgramConst.treasurySeed.codeUnits,
    ], programId: MetaplexAuctionHouseProgramConst.programId);
  }
}
