import 'package:on_chain/solana/src/borsh_serialization/core/program_layout.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/models/models.dart';

class CustomProgram extends TransactionInstruction {
  CustomProgram({
    required List<AccountMeta> keys,
    required SolAddress programId,
    required ProgramLayout layout,
  }) : super(keys: keys, data: layout.toBytes(), programId: programId);
}
