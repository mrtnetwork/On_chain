import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/models/account/account_meta.dart';
import 'package:on_chain/solana/src/instructions/spl_token_meta_data/layouts/layouts.dart';
import 'package:on_chain/solana/src/models/transaction/instruction.dart';

/// Represents transaction instructions related to the SPL token metadata program.
class SPLTokenMetaDataProgram extends TransactionInstruction {
  SPLTokenMetaDataProgram({
    required super.keys,
    required super.programId,
    required ProgramLayout layout,
  }) : super(data: layout.toBytes());

  factory SPLTokenMetaDataProgram.fromBytes({
    required List<AccountMeta> keys,
    required List<int> instructionBytes,
    required SolAddress programId,
  }) {
    return SPLTokenMetaDataProgram(
        layout: SPLTokenMetaDataProgramLayout.fromBytes(instructionBytes),
        keys: keys,
        programId: programId);
  }

  /// Initializes a TLV.
  factory SPLTokenMetaDataProgram.initialize({
    required SPLTokenMetaDataInitializeLayout layout,

    /// Metadata
    required SolAddress metadata,

    /// Update authority
    required SolAddress updateAuthority,

    /// Mint
    required SolAddress mint,

    /// Mint authority
    required SolAddress mintAuthority,
    required SolAddress programId,
  }) {
    return SPLTokenMetaDataProgram(
        layout: layout,
        keys: [
          metadata.toWritable(),
          updateAuthority.toReadOnly(),
          mint.toReadOnly(),
          mintAuthority.toSigner()
        ],
        programId: programId);
  }

  /// Updates a field in a token-metadata account.
  factory SPLTokenMetaDataProgram.update({
    required SPLTokenMetaDataUpdateLayout layout,
    required SolAddress programId,

    /// Metadata account
    required SolAddress metadata,

    /// Update authority
    required SolAddress updateAuthority,
  }) {
    return SPLTokenMetaDataProgram(
        layout: layout,
        keys: [
          metadata.toWritable(),
          updateAuthority.toSigner(),
        ],
        programId: programId);
  }

  /// Removes a key-value pair in a token-metadata account.
  factory SPLTokenMetaDataProgram.removeField({
    required SPLTokenMetaDataRemoveFieldLayout layout,
    required SolAddress programId,

    /// Metadata account
    required SolAddress metadata,

    /// Update authority
    required SolAddress updateAuthority,
  }) {
    return SPLTokenMetaDataProgram(
        layout: layout,
        keys: [
          metadata.toWritable(),
          updateAuthority.toSigner(),
        ],
        programId: programId);
  }

  /// Updates the token-metadata authority.
  factory SPLTokenMetaDataProgram.updateAuthority({
    required SPLTokenMetaDataUpdateAuthorityLayout layout,
    required SolAddress programId,

    /// Metadata account
    required SolAddress metadata,

    /// Current update authority
    required SolAddress oldAuthority,
  }) {
    return SPLTokenMetaDataProgram(
        layout: layout,
        keys: [
          metadata.toWritable(),
          oldAuthority.toSigner(),
        ],
        programId: programId);
  }

  /// Emits the token-metadata as return data
  factory SPLTokenMetaDataProgram.emit({
    required SPLTokenMetaDataEmitLayout layout,
    required SolAddress programId,

    /// Metadata account
    required SolAddress metadata,
  }) {
    return SPLTokenMetaDataProgram(
        layout: layout, keys: [metadata.toReadOnly()], programId: programId);
  }
}
