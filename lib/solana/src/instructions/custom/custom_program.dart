import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/program_layouts/program_layout.dart';
import 'package:on_chain/solana/src/models/models.dart';

class CustomProgram extends TransactionInstruction {
  CustomProgram({
    required List<AccountMeta> keys,
    required SolAddress programId,
    required ProgramLayout layout,
  }) : super(keys: keys, layout: layout, programId: programId);
}
