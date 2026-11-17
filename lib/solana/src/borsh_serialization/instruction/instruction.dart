import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/solana.dart';

abstract class ProgramLayoutInstruction {
  abstract final dynamic instruction;
  abstract final String name;
  abstract final String programName;
  abstract final SolAddress programAddress;
}

class UnknownProgramInstruction implements ProgramLayoutInstruction {
  @override
  final dynamic instruction;
  @override
  final String name;
  const UnknownProgramInstruction(this.instruction, this.name);
  static const UnknownProgramInstruction unknown = UnknownProgramInstruction(
    null,
    'Unknown',
  );

  static const List<UnknownProgramInstruction> values = [unknown];

  @override
  String get programName => 'Unknown';
  @override
  SolAddress get programAddress => throw BuError(DefaultErrorType.unsupported, 'programAddress is not available for this instruction.',
  );
}
