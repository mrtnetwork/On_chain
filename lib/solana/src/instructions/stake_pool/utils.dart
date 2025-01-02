import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token/constant.dart';
import 'package:on_chain/solana/src/instructions/stake_pool/constant.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/models/pda/pda.dart';

class StakePoolProgramUtils {
  /// Generates the withdraw authority program address for the stake pool
  static ProgramDerivedAddress findWithdrawAuthorityProgramAddress(
      {required SolAddress stakePoolAddress,
      SolAddress programId = StakePoolProgramConst.programId}) {
    return ProgramDerivedAddress.find(seedBytes: [
      stakePoolAddress.toBytes(),
      'withdraw'.codeUnits,
    ], programId: programId);
  }

  /// Generates the stake program address for a validator's vote account
  static ProgramDerivedAddress findStakeProgramAddress(
      {required SolAddress stakePoolAddress,
      required SolAddress voteAccountAddress,
      SolAddress programId = StakePoolProgramConst.programId}) {
    return ProgramDerivedAddress.find(seedBytes: [
      voteAccountAddress.toBytes(),
      stakePoolAddress.toBytes(),
    ], programId: programId);
  }

  /// Generates the stake program address for a validator's vote account
  static ProgramDerivedAddress findTransientStakeProgramAddress(
      {required SolAddress voteAccountAddress,
      required SolAddress stakePoolAddress,
      required BigInt seed,
      SolAddress programId = StakePoolProgramConst.programId}) {
    return ProgramDerivedAddress.find(seedBytes: [
      'transient'.codeUnits,
      voteAccountAddress.toBytes(),
      stakePoolAddress.toBytes(),
      LayoutConst.i64().serialize(seed)
    ], programId: programId);
  }

  ///  Generates the ephemeral program address for stake pool redelegation
  static ProgramDerivedAddress findEphemeralStakeProgramAddress(
      {required SolAddress stakePoolAddress,
      required BigInt seed,
      SolAddress programId = StakePoolProgramConst.programId}) {
    return ProgramDerivedAddress.find(seedBytes: [
      'ephemeral'.codeUnits,
      stakePoolAddress.toBytes(),
      LayoutConst.i64().serialize(seed)
    ], programId: programId);
  }

  /// Generates the metadata program address for the stake pool
  static ProgramDerivedAddress findMetadataAddress(
      {required SolAddress stakePoolMintAddress}) {
    return ProgramDerivedAddress.find(seedBytes: [
      'metadata'.codeUnits,
      SPLTokenProgramConst.metaDataProgramId.toBytes(),
      stakePoolMintAddress.toBytes(),
    ], programId: SPLTokenProgramConst.metaDataProgramId);
  }
}
