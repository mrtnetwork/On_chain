import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/models/pda/pda.dart';
import 'constant.dart';

class MetaplexAuctioneerProgramUtils {
  static ProgramDerivedAddress findListingConfigAddress({
    required SolAddress wallet,
    required SolAddress auctionHouse,
    required SolAddress tokenAccount,
    required SolAddress treasuryMint,
    required SolAddress tokenMint,
    required BigInt tokenSize,
  }) {
    return ProgramDerivedAddress.find(seedBytes: [
      'listing_config'.codeUnits,
      wallet.toBytes(),
      auctionHouse.toBytes(),
      tokenAccount.toBytes(),
      treasuryMint.toBytes(),
      tokenMint.toBytes(),
      LayoutConst.u64().serialize(tokenSize)
    ], programId: MetaplexAuctioneerProgramConst.programId);
  }

  static ProgramDerivedAddress findAuctioneerAuthoriSeeds({
    required SolAddress auctionHouse,
  }) {
    return ProgramDerivedAddress.find(seedBytes: [
      'auctioneer'.codeUnits,
      auctionHouse.toBytes(),
    ], programId: MetaplexAuctioneerProgramConst.programId);
  }
}
