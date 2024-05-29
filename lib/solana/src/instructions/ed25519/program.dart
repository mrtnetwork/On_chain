import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/models/account/account_meta.dart';
import 'package:on_chain/solana/src/instructions/ed25519/constant.dart';
import 'package:on_chain/solana/src/instructions/ed25519/layouts/ed25519.dart';
import 'package:on_chain/solana/src/models/transaction/instruction.dart';

/// Represents an instruction for the Ed25519 program.
class Ed25519Program extends TransactionInstruction {
  Ed25519Program._({
    required List<AccountMeta> keys,
    required SolAddress programId,
    required ProgramLayout layout,
  }) : super(keys: keys, layout: layout, programId: programId);
  factory Ed25519Program.fromBytes({
    required List<AccountMeta> keys,
    required List<int> instructionBytes,
    SolAddress programId = Ed25519ProgramConst.programId,
  }) {
    return Ed25519Program._(
        layout: Ed25519ProgramLayout.fromBuffer(instructionBytes),
        keys: keys,
        programId: programId);
  }

  /// Constructs an Ed25519Program instruction from a layout.
  factory Ed25519Program({required Ed25519ProgramLayout layout}) {
    return Ed25519Program._(
      layout: layout,
      keys: [],
      programId: Ed25519ProgramConst.programId,
    );
  }
}
