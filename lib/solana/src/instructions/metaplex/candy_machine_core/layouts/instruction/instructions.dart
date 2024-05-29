import 'package:blockchain_utils/compare/compare.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaplexCandyMachineProgramInstruction
    implements ProgramLayoutInstruction {
  @override
  final List<int> insturction;
  @override
  final String name;
  const MetaplexCandyMachineProgramInstruction(this.insturction, this.name);
  static const MetaplexCandyMachineProgramInstruction addConfigLines =
      MetaplexCandyMachineProgramInstruction(
          [223, 50, 224, 227, 151, 8, 115, 106], "AddConfigLines");
  static const MetaplexCandyMachineProgramInstruction createCandyGuard =
      MetaplexCandyMachineProgramInstruction(
          [175, 175, 109, 31, 13, 152, 155, 237], "CreateCandyGuard");
  static const MetaplexCandyMachineProgramInstruction deleteCandyGuard =
      MetaplexCandyMachineProgramInstruction(
          [183, 18, 70, 156, 148, 109, 161, 34], "DeleteCandyGuard");
  static const MetaplexCandyMachineProgramInstruction deleteCandyMachine =
      MetaplexCandyMachineProgramInstruction(
          [183, 18, 70, 156, 148, 109, 161, 34], "DeleteCandyMachine");
  static const MetaplexCandyMachineProgramInstruction initializeCandyMachine =
      MetaplexCandyMachineProgramInstruction(
          [175, 175, 109, 31, 13, 152, 155, 237], "InitializeCandyMachine");
  static const MetaplexCandyMachineProgramInstruction initializeCandyMachineV2 =
      MetaplexCandyMachineProgramInstruction(
          [67, 153, 175, 39, 218, 16, 38, 32], "InitializeCandyMachineV2");
  static const MetaplexCandyMachineProgramInstruction mint =
      MetaplexCandyMachineProgramInstruction(
          [51, 57, 225, 47, 182, 146, 137, 166], "Mint");
  static const MetaplexCandyMachineProgramInstruction mintFromCandyMachine =
      MetaplexCandyMachineProgramInstruction(
          [51, 57, 225, 47, 182, 146, 137, 166], "MintFromCandyMachine");

  static const MetaplexCandyMachineProgramInstruction mintFromCandyMachineV2 =
      MetaplexCandyMachineProgramInstruction(
          [120, 121, 23, 146, 173, 110, 199, 205], "MintFromCandyMachineV2");
  static const MetaplexCandyMachineProgramInstruction mintV2 =
      MetaplexCandyMachineProgramInstruction(
          [120, 121, 23, 146, 173, 110, 199, 205], "MintFromCandyMachineV2");
  static const MetaplexCandyMachineProgramInstruction route =
      MetaplexCandyMachineProgramInstruction(
          [229, 23, 203, 151, 122, 227, 173, 42], "Route");
  static const MetaplexCandyMachineProgramInstruction setCandyGuardAuthority =
      MetaplexCandyMachineProgramInstruction(
          [133, 250, 37, 21, 110, 163, 26, 121], "SetCandyGuardAuthority");
  static const MetaplexCandyMachineProgramInstruction setCandyMachineAuthority =
      MetaplexCandyMachineProgramInstruction(
          [133, 250, 37, 21, 110, 163, 26, 121], "SetCandyMachineAuthority");
  static const MetaplexCandyMachineProgramInstruction setCollection =
      MetaplexCandyMachineProgramInstruction(
          [192, 254, 206, 76, 168, 182, 59, 223], "SetCollection");
  static const MetaplexCandyMachineProgramInstruction setCollectionV2 =
      MetaplexCandyMachineProgramInstruction(
          [229, 35, 61, 91, 15, 14, 99, 160], "SetCollectionV2");
  static const MetaplexCandyMachineProgramInstruction setMintAuthority =
      MetaplexCandyMachineProgramInstruction(
          [67, 127, 155, 187, 100, 174, 103, 121], "SetMintAuthority");
  static const MetaplexCandyMachineProgramInstruction setTokenStandard =
      MetaplexCandyMachineProgramInstruction(
          [147, 212, 106, 195, 30, 170, 209, 128], "SetTokenStandard");
  static const MetaplexCandyMachineProgramInstruction unwrap =
      MetaplexCandyMachineProgramInstruction(
          [126, 175, 198, 14, 212, 69, 50, 44], "Unwrap");
  static const MetaplexCandyMachineProgramInstruction updateCandyGuard =
      MetaplexCandyMachineProgramInstruction(
          [219, 200, 88, 176, 158, 63, 253, 127], "UpdateCandyGuard");
  static const MetaplexCandyMachineProgramInstruction updateCandyMachine =
      MetaplexCandyMachineProgramInstruction(
          [219, 200, 88, 176, 158, 63, 253, 127], "UpdateCandyMachine");
  static const MetaplexCandyMachineProgramInstruction wrap =
      MetaplexCandyMachineProgramInstruction(
          [178, 40, 10, 189, 228, 129, 186, 140], "Unwrap");
  //

  static const List<MetaplexCandyMachineProgramInstruction> values = [
    addConfigLines,
  ];
  static MetaplexCandyMachineProgramInstruction? getInstruction(dynamic value) {
    try {
      return values
          .firstWhere((element) => bytesEqual(element.insturction, value));
    } on StateError {
      return null;
    }
  }
}
