import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/memo/layouts/memo.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/models/account/account_meta.dart';
import 'package:on_chain/solana/src/instructions/memo/constant.dart';
import 'package:on_chain/solana/src/models/transaction/instruction.dart';

/// Represents an instruction for the Memo program.
class MemoProgram extends TransactionInstruction {
  MemoProgram._({
    required List<AccountMeta> keys,
    required SolAddress programId,
    required ProgramLayout layout,
  }) : super(keys: keys, data: layout.toBytes(), programId: programId);
  factory MemoProgram.fromBytes({
    required List<AccountMeta> keys,
    required List<int> instructionBytes,
    SolAddress programId = MemoProgramConst.programId,
  }) {
    return MemoProgram._(
        layout: MemoLayout.fromBuffer(instructionBytes),
        keys: keys,
        programId: programId);
  }

  /// Constructs a MemoProgram instruction.
  factory MemoProgram({
    required MemoLayout layout,
    List<SolAddress> pubKeys = const [],
  }) {
    return MemoProgram._(
      layout: layout,
      keys: pubKeys.map((e) => e.toSigner()).toList(),
      programId: MemoProgramConst.programId,
    );
  }
}
