// Represents an instruction for the Secp256k1 program.
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/models/account/account_meta.dart';
import 'package:on_chain/solana/src/instructions/secp256k1/constant.dart';
import 'package:on_chain/solana/src/instructions/secp256k1/layouts/secp256k1.dart';
import 'package:on_chain/solana/src/models/transaction/instruction.dart';

/// Represents an instruction for the Secp256k1 program.
class Secp256k1Program extends TransactionInstruction {
  Secp256k1Program._({
    required List<AccountMeta> keys,
    required SolAddress programId,
    required ProgramLayout layout,
  }) : super(keys: keys, data: layout.toBytes(), programId: programId);
  factory Secp256k1Program.fromBytes({
    required List<AccountMeta> keys,
    required List<int> instructionBytes,
    SolAddress programId = Secp256k1ProgramConst.programId,
  }) {
    return Secp256k1Program._(
        layout: Secp256k1Layout.fromBuffer(instructionBytes),
        keys: keys,
        programId: programId);
  }

  /// Constructs a Secp256k1Program instruction from a layout.
  factory Secp256k1Program({required Secp256k1Layout layout}) {
    return Secp256k1Program._(
        layout: layout, keys: [], programId: Secp256k1ProgramConst.programId);
  }
}
