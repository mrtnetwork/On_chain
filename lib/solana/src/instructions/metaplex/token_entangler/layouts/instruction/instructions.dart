import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexTokenEntanglerProgramInstruction
    implements ProgramLayoutInstruction {
  @override
  final List<int> insturction;
  @override
  final String name;
  const MetaplexTokenEntanglerProgramInstruction(this.insturction, this.name);
  static const MetaplexTokenEntanglerProgramInstruction createEntangledPair =
      MetaplexTokenEntanglerProgramInstruction(
          [166, 106, 32, 45, 156, 210, 209, 240], "CreateEntangledPair");
  static const MetaplexTokenEntanglerProgramInstruction swap =
      MetaplexTokenEntanglerProgramInstruction(
          [248, 198, 158, 145, 225, 117, 135, 200], "Swap");
  static const MetaplexTokenEntanglerProgramInstruction updateEntangledPair =
      MetaplexTokenEntanglerProgramInstruction(
          [41, 97, 247, 218, 98, 162, 75, 244], "UpdateEntangledPair");

  static const List<MetaplexTokenEntanglerProgramInstruction> values = [
    createEntangledPair,
    swap,
    updateEntangledPair
  ];
  static MetaplexTokenEntanglerProgramInstruction? getInstruction(
      dynamic value) {
    try {
      return values
          .firstWhere((element) => bytesEqual(element.insturction, value));
    } on StateError {
      return null;
    }
  }
}
