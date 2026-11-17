// Represents an instruction for the Secp256r1 program.
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/models/account/account_meta.dart';
import 'package:on_chain/solana/src/instructions/secp256r1/constant.dart';
import 'package:on_chain/solana/src/instructions/secp256r1/layouts/secp256r1.dart';
import 'package:on_chain/solana/src/models/transaction/instruction.dart';

/// Represents an instruction for the Secp256r1 precompile.
class Secp256r1Program extends TransactionInstruction {
  Secp256r1Program._({
    required super.keys,
    required super.programId,
    required ProgramLayout layout,
  }) : super(data: layout.toBytes());
  factory Secp256r1Program.fromBytes({
    required List<AccountMeta> keys,
    required List<int> instructionBytes,
    SolAddress programId = Secp256r1ProgramConst.programId,
  }) {
    return Secp256r1Program._(
      layout: Secp256r1Layout.fromBuffer(instructionBytes),
      keys: keys,
      programId: programId,
    );
  }

  /// Constructs a Secp256r1Program instruction from a layout.
  factory Secp256r1Program({required Secp256r1Layout layout}) {
    return Secp256r1Program._(
      layout: layout,
      keys: [],
      programId: Secp256r1ProgramConst.programId,
    );
  }
}
