import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/hydra/constant.dart';
import 'package:on_chain/solana/src/models/pda/pda.dart';
import 'package:on_chain/solana/src/utils/utils.dart';

class MetaplexHydraProgramUtils {
  static ProgramDerivedAddress findFanoutMembershipMintVoucherPda({
    required SolAddress fanout,
    required SolAddress membership,
    required SolAddress mint,
  }) {
    final address = SolanaUtils.findProgramAddress(seeds: [
      'fanout-membership'.codeUnits,
      fanout.toBytes(),
      membership.toBytes(),
      mint.toBytes(),
    ], programId: MetaplexHydraProgramConst.programId);
    return ProgramDerivedAddress(address: address.item1, bump: address.item2);
  }

  static ProgramDerivedAddress findFanoutPda({required String name}) {
    final address = SolanaUtils.findProgramAddress(seeds: [
      'fanout-config'.codeUnits,
      StringUtils.encode(name),
    ], programId: MetaplexHydraProgramConst.programId);
    return ProgramDerivedAddress(address: address.item1, bump: address.item2);
  }

  static ProgramDerivedAddress findFanoutMembershipVoucherPda(
      {required SolAddress fanout, required SolAddress member}) {
    final address = SolanaUtils.findProgramAddress(seeds: [
      'fanout-membership'.codeUnits,
      fanout.toBytes(),
      member.toBytes()
    ], programId: MetaplexHydraProgramConst.programId);
    return ProgramDerivedAddress(address: address.item1, bump: address.item2);
  }

  static ProgramDerivedAddress findFanoutMintPda(
      {required SolAddress fanout, required SolAddress mint}) {
    final address = SolanaUtils.findProgramAddress(
        seeds: ['fanout-config'.codeUnits, fanout.toBytes(), mint.toBytes()],
        programId: MetaplexHydraProgramConst.programId);
    return ProgramDerivedAddress(address: address.item1, bump: address.item2);
  }
}
