import 'package:blockchain_utils/utils/binary/utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_entangler/constant.dart';

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
      return values.firstWhere(
          (element) => BytesUtils.bytesEqual(element.insturction, value));
    } catch (_) {
      return null;
    }
  }

  @override
  String get programName => "MetaplexTokenEntangler";

  @override
  SolAddress get programAddress => MetaplexTokenEntanglerProgramConst.programId;
}
