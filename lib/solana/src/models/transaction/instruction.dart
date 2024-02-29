import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/associated_token_account/constant.dart';
import 'package:on_chain/solana/src/instructions/instructions.dart';
import 'package:on_chain/solana/src/models/account/account_meta.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Transaction Instruction
abstract class TransactionInstruction {
  TransactionInstruction(
      {required List<AccountMeta> keys,
      required this.programId,
      required this.layout})
      : keys = List<AccountMeta>.unmodifiable(keys);

  /// Public keys to include in this transaction
  /// Boolean represents whether this pubkey needs to sign the transaction
  final List<AccountMeta> keys;

  /// Program Id to execute.
  final SolAddress programId;

  /// Program input.
  List<int> get data => layout.toBytes();

  /// Program layout.
  final ProgramLayout layout;

  factory TransactionInstruction.fromBytes({
    required SolAddress programId,
    required List<AccountMeta> keys,
    required List<int> instructionBytes,
  }) {
    try {
      if (programId == AddressLookupTableProgramConst.programId) {
        return AddressLookupTableProgram.fromBytes(
            programId: programId,
            keys: keys,
            instructionBytes: instructionBytes);
      } else if (programId == ComputeBudgetConst.programId) {
        return ComputeBudgetProgram.fromBytes(
            keys: keys, instructionBytes: instructionBytes);
      } else if (programId == Ed25519ProgramConst.programId) {
        return Ed25519Program.fromBytes(
            instructionBytes: instructionBytes, keys: keys);
      } else if (programId == MemoProgramConst.programId) {
        return MemoProgram.fromBytes(
            keys: keys, instructionBytes: instructionBytes);
      } else if (programId == NameServiceProgramConst.programId) {
        return NameServiceProgram.fromBytes(
            keys: keys, instructionBytes: instructionBytes);
      } else if (programId == Secp256k1ProgramConst.programId) {
        return Secp256k1Program.fromBytes(
            keys: keys, instructionBytes: instructionBytes);
      } else if (programId == SPLTokenProgramConst.tokenProgramId ||
          programId == SPLTokenProgramConst.token2022ProgramId) {
        return SPLTokenProgram.fromBytes(
            keys: keys,
            instructionBytes: instructionBytes,
            programId: programId);
      } else if (programId == SPLTokenSwapConst.oldTokenSwapProgramId ||
          programId == SPLTokenSwapConst.tokenSwapProgramId) {
        return SPLTokenSwapProgram.fromBytes(
            keys: keys,
            instructionBytes: instructionBytes,
            programId: programId);
      } else if (programId == StakeProgramConst.programId) {
        return StakeProgram.fromBytes(
            keys: keys, instructionBytes: instructionBytes);
      } else if (programId == StakePoolProgramConst.programId) {
        return StakePoolProgram.fromBytes(
            keys: keys, instructionBytes: instructionBytes);
      } else if (programId == SystemProgramConst.programId) {
        return SystemProgram.fromBytes(
            keys: keys, instructionBytes: instructionBytes);
      } else if (programId == VoteProgramConst.programId) {
        return VoteProgram.fromBytes(
            keys: keys, instructionBytes: instructionBytes);
      } else if (programId == TokenLendingProgramConst.lendingProgramId) {
        return TokenLendingProgram.fromBytes(
            keys: keys, instructionBytes: instructionBytes);
      } else if (programId ==
          AssociatedTokenAccountProgramConst.associatedTokenProgramId) {
        return AssociatedTokenAccountProgram.fromBytes(
            keys: keys, instructionBytes: instructionBytes);
      }
      return SPLTokenMetaDataProgram.fromBytes(
          keys: keys, instructionBytes: instructionBytes, programId: programId);
    } catch (e) {
      return CustomProgram(
          keys: keys,
          programId: programId,
          layout: UnknownProgramLayout(instructionBytes));
    }
  }

  @override
  String toString() {
    return "TransactionInstruction{keys: $keys, programID: $programId data: ${BytesUtils.toHexString(data)}}";
  }
}
