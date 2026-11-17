import 'package:on_chain/solana/src/borsh_serialization/core/program_layout.dart';
import 'package:on_chain/solana/src/models/models.dart';

class CustomProgram extends TransactionInstruction {
  CustomProgram({
    required super.keys,
    required super.programId,
    required ProgramLayout layout,
  }) : super(data: layout.toBytes());
}
