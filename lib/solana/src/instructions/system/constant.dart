import 'package:on_chain/solana/src/address/sol_address.dart';

class SystemProgramConst {
  static const SolAddress programId =
      SolAddress.unchecked('11111111111111111111111111111111');

  static const sysvarClockPubkey =
      SolAddress.unchecked('SysvarC1ock11111111111111111111111111111111');
  static const sysvarEpochSchedulePubkey =
      SolAddress.unchecked('SysvarEpochSchedu1e111111111111111111111111');
  static const sysvarInstructionsPubkey =
      SolAddress.unchecked('Sysvar1nstructions1111111111111111111111111');
  static const sysvarRecentBlockhashesPubkey =
      SolAddress.unchecked('SysvarRecentB1ockHashes11111111111111111111');
  static const sysvarRentPubkey =
      SolAddress.unchecked('SysvarRent111111111111111111111111111111111');
  static const sysvarRewardsPubkey =
      SolAddress.unchecked('SysvarRewards111111111111111111111111111111');
  static const sysvarSlotHashesPubkey =
      SolAddress.unchecked('SysvarS1otHashes111111111111111111111111111');
  static const sysvarSlotHistoryPubkey =
      SolAddress.unchecked('SysvarS1otHistory11111111111111111111111111');
  static const sysvarStakeHistoryPubkey =
      SolAddress.unchecked('SysvarStakeHistory1111111111111111111111111');
  static BigInt get nonceAccountSpace => BigInt.from(80);
}
