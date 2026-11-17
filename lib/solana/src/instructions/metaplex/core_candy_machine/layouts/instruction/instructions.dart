import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/metaplex/core_candy_machine/constant.dart';

/// Core Candy Machine instructions. Anchor discriminants are
/// `sha256("global:<name>")[0..8]` (verified against the IDL).
class CoreCandyMachineProgramInstruction implements ProgramLayoutInstruction {
  @override
  final List<int> instruction;
  @override
  final String name;
  const CoreCandyMachineProgramInstruction(this.instruction, this.name);

  static const CoreCandyMachineProgramInstruction addConfigLines =
      CoreCandyMachineProgramInstruction([
        15,
        91,
        190,
        225,
        244,
        166,
        6,
        12,
      ], 'AddConfigLines');
  static const CoreCandyMachineProgramInstruction initialize =
      CoreCandyMachineProgramInstruction([
        175,
        175,
        109,
        31,
        13,
        152,
        155,
        237,
      ], 'Initialize');
  static const CoreCandyMachineProgramInstruction mintAsset =
      CoreCandyMachineProgramInstruction([
        188,
        203,
        46,
        38,
        138,
        198,
        93,
        197,
      ], 'MintAsset');
  static const CoreCandyMachineProgramInstruction setAuthority =
      CoreCandyMachineProgramInstruction([
        207,
        53,
        66,
        186,
        130,
        168,
        204,
        201,
      ], 'SetAuthority');
  static const CoreCandyMachineProgramInstruction setCollection =
      CoreCandyMachineProgramInstruction([
        245,
        226,
        231,
        189,
        82,
        190,
        247,
        175,
      ], 'SetCollection');
  static const CoreCandyMachineProgramInstruction setMintAuthority =
      CoreCandyMachineProgramInstruction([
        80,
        91,
        168,
        238,
        14,
        189,
        41,
        96,
      ], 'SetMintAuthority');
  static const CoreCandyMachineProgramInstruction update =
      CoreCandyMachineProgramInstruction([
        219,
        200,
        88,
        176,
        158,
        63,
        253,
        127,
      ], 'Update');
  static const CoreCandyMachineProgramInstruction withdraw =
      CoreCandyMachineProgramInstruction([
        183,
        18,
        70,
        156,
        148,
        109,
        161,
        34,
      ], 'Withdraw');

  static const List<CoreCandyMachineProgramInstruction> values = [
    addConfigLines,
    initialize,
    mintAsset,
    setAuthority,
    setCollection,
    setMintAuthority,
    update,
    withdraw,
  ];

  static CoreCandyMachineProgramInstruction? getInstruction(dynamic value) {
    for (final e in values) {
      if (value is! List || value.length < e.instruction.length) continue;
      bool same = true;
      for (var i = 0; i < e.instruction.length; i++) {
        if (value[i] != e.instruction[i]) {
          same = false;
          break;
        }
      }
      if (same) return e;
    }
    return null;
  }

  @override
  String get programName => 'CoreCandyMachine';

  @override
  SolAddress get programAddress =>
      CoreCandyMachineProgramConst.candyMachineProgramId;
}

/// Core Candy Guard instructions. The guard program shares
/// Anchor names (initialize/update/withdraw/setAuthority/wrap/unwrap) with
/// the machine program, so it gets its own enum + dispatch: decode must use
/// the transaction's programId to pick machine vs guard.
class CoreCandyGuardProgramInstruction implements ProgramLayoutInstruction {
  @override
  final List<int> instruction;
  @override
  final String name;
  const CoreCandyGuardProgramInstruction(this.instruction, this.name);

  static const CoreCandyGuardProgramInstruction initialize =
      CoreCandyGuardProgramInstruction([
        175,
        175,
        109,
        31,
        13,
        152,
        155,
        237,
      ], 'Initialize');
  static const CoreCandyGuardProgramInstruction mintV1 =
      CoreCandyGuardProgramInstruction([
        254,
        205,
        116,
        98,
        27,
        196,
        147,
        59,
      ], 'MintV1');
  static const CoreCandyGuardProgramInstruction route =
      CoreCandyGuardProgramInstruction([
        229,
        23,
        203,
        151,
        122,
        227,
        173,
        42,
      ], 'Route');
  static const CoreCandyGuardProgramInstruction setAuthority =
      CoreCandyGuardProgramInstruction([
        207,
        53,
        66,
        186,
        130,
        168,
        204,
        201,
      ], 'SetAuthority');
  static const CoreCandyGuardProgramInstruction unwrap =
      CoreCandyGuardProgramInstruction([
        126,
        175,
        198,
        14,
        212,
        69,
        50,
        44,
      ], 'Unwrap');
  static const CoreCandyGuardProgramInstruction update =
      CoreCandyGuardProgramInstruction([
        219,
        200,
        88,
        176,
        158,
        63,
        253,
        127,
      ], 'Update');
  static const CoreCandyGuardProgramInstruction withdraw =
      CoreCandyGuardProgramInstruction([
        183,
        18,
        70,
        156,
        148,
        109,
        161,
        34,
      ], 'Withdraw');
  static const CoreCandyGuardProgramInstruction wrap =
      CoreCandyGuardProgramInstruction([
        178,
        40,
        10,
        189,
        228,
        129,
        186,
        140,
      ], 'Wrap');

  static const List<CoreCandyGuardProgramInstruction> values = [
    initialize,
    mintV1,
    route,
    setAuthority,
    unwrap,
    update,
    withdraw,
    wrap,
  ];

  static CoreCandyGuardProgramInstruction? getInstruction(dynamic value) {
    for (final e in values) {
      if (value is! List || value.length < e.instruction.length) continue;
      bool same = true;
      for (var i = 0; i < e.instruction.length; i++) {
        if (value[i] != e.instruction[i]) {
          same = false;
          break;
        }
      }
      if (same) return e;
    }
    return null;
  }

  @override
  String get programName => 'CoreCandyGuard';

  @override
  SolAddress get programAddress =>
      CoreCandyMachineProgramConst.candyGuardProgramId;
}
