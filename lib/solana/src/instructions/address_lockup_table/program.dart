import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/models/account/account_meta.dart';
import 'package:on_chain/solana/src/instructions/address_lockup_table/constant.dart';
import 'package:on_chain/solana/src/instructions/system/constant.dart';
import 'package:on_chain/solana/src/models/transaction/instruction.dart';

import 'layouts/layouts.dart';

/// Represents instructions for the AddressLookupTable program.
class AddressLookupTableProgram extends TransactionInstruction {
  AddressLookupTableProgram({
    required List<AccountMeta> keys,
    required ProgramLayout layout,
    SolAddress programId = AddressLookupTableProgramConst.programId,
  }) : super(keys: keys, layout: layout, programId: programId);
  factory AddressLookupTableProgram.fromBytes({
    required SolAddress programId,
    required List<AccountMeta> keys,
    required List<int> instructionBytes,
  }) {
    return AddressLookupTableProgram(
        layout: AddressLookupTableProgramLayout.fromBytes(instructionBytes),
        keys: keys,
        programId: programId);
  }

  /// Creates an instruction to create a lookup table.
  factory AddressLookupTableProgram.createLookupTable({
    /// Account used to derive and control the new address lookup table.
    required SolAddress authority,

    /// Account that will fund the new address lookup table.
    required SolAddress payer,

    /// lookupTableAddress derived from recent slot [findAddressLookupTableProgram]
    required SolAddress lookupTableAddress,
    required AddressLookupCreateLookupTableLayout layout,
  }) {
    return AddressLookupTableProgram(
      layout: layout,
      keys: [
        lookupTableAddress.toWritable(),
        authority.toSigner(),
        payer.toSignerAndWritable(),
        SystemProgramConst.programId.toReadOnly(),
      ],
      programId: AddressLookupTableProgramConst.programId,
    );
  }

  /// Creates an instruction to freeze a lookup table.
  factory AddressLookupTableProgram.freezeLookupTable({
    /// Account which is the current authority.
    required SolAddress authority,

    /// Address lookup table account to freeze.
    required SolAddress lookupTable,
  }) {
    return AddressLookupTableProgram(
      layout: const AddressLookupFreezeLookupTableLayout(),
      keys: [
        lookupTable.toWritable(),
        authority.toSigner(),
      ],
      programId: AddressLookupTableProgramConst.programId,
    );
  }

  /// Creates an instruction to extend a lookup table.
  factory AddressLookupTableProgram.extendLookupTable({
    /// Account which is the current authority.
    required SolAddress authority,

    /// Address lookup table account to extend.
    required SolAddress lookupTable,
    required AddressExtendLookupTableLayout layout,

    /// Account that will fund the table reallocation.
    /// Not required if the reallocation has already been funded.
    SolAddress? payer,
  }) {
    final keys = [
      lookupTable.toWritable(),
      authority.toSigner(),
    ];
    if (payer != null) {
      keys.addAll([
        payer.toSignerAndWritable(),
        SystemProgramConst.programId.toReadOnly(),
      ]);
    }
    return AddressLookupTableProgram(
      layout: layout,
      keys: keys,
      programId: AddressLookupTableProgramConst.programId,
    );
  }

  /// Creates an instruction to deactivate a lookup table.
  factory AddressLookupTableProgram.deactivateLookupTable({
    /// Account which is the current authority.
    required SolAddress authority,

    /// Address lookup table account to deactivate.
    required SolAddress lookupTable,
  }) {
    return AddressLookupTableProgram(
      layout: const AddressLookupDeactiveLookupTableLayout(),
      keys: [
        lookupTable.toWritable(),
        authority.toSigner(),
      ],
      programId: AddressLookupTableProgramConst.programId,
    );
  }

  /// Creates an instruction to close a lookup table.
  factory AddressLookupTableProgram.closeLookupTable({
    /// Account which is the current authority.
    required SolAddress authority,

    /// Address lookup table account to close.
    required SolAddress lookupTable,

    /// Recipient of closed account lamports.
    required SolAddress recipient,
  }) {
    return AddressLookupTableProgram(
      layout: const AddressLookupCloseLookupTableLayout(),
      keys: [
        lookupTable.toWritable(),
        authority.toSigner(),
        recipient.toWritable(),
      ],
      programId: AddressLookupTableProgramConst.programId,
    );
  }
}
