import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/name_service/constant.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/models/account/account_meta.dart';
import 'package:on_chain/solana/src/instructions/system/constant.dart';
import 'package:on_chain/solana/src/models/transaction/instruction.dart';
import 'layouts/layouts.dart';

/// Instructions supported by the generic Name Registry program
class NameServiceProgram extends TransactionInstruction {
  NameServiceProgram({
    required List<AccountMeta> keys,
    required SolAddress programId,
    required ProgramLayout layout,
  }) : super(keys: keys, data: layout.toBytes(), programId: programId);
  factory NameServiceProgram.fromBytes({
    required List<AccountMeta> keys,
    required List<int> instructionBytes,
    SolAddress programId = NameServiceProgramConst.programId,
  }) {
    return NameServiceProgram(
        layout: NameServiceProgramLayout.fromBytes(instructionBytes),
        keys: keys,
        programId: programId);
  }

  /// Create an empty name record
  factory NameServiceProgram.create({
    required NameServiceCreateLayout layout,

    /// Name record to be created (program-derived address)
    required SolAddress nameKey,

    /// Account owner
    required SolAddress nameOwnerKey,

    /// Funding account (must be a system account)
    required SolAddress payerKey,
    SolAddress nameProgramId = NameServiceProgramConst.programId,

    /// System program
    SolAddress systemProgramId = SystemProgramConst.programId,

    /// Account class
    SolAddress? nameClassKey,

    /// Parent name record
    SolAddress? nameParent,

    /// Owner of the parent name record.
    SolAddress? nameParentOwner,
  }) {
    return NameServiceProgram(
      keys: [
        systemProgramId.toReadOnly(),
        payerKey.toSignerAndWritable(),
        nameKey.toWritable(),
        nameOwnerKey.toReadOnly(),
        nameClassKey?.toSigner() ?? SolAddress.defaultPubKey.toReadOnly(),
        nameParent?.toReadOnly() ?? SolAddress.defaultPubKey.toReadOnly(),
        if (nameParentOwner != null) nameParentOwner.toSigner(),
      ],
      programId: nameProgramId,
      layout: layout,
    );
  }

  /// Update the data in a name record.
  factory NameServiceProgram.update({
    required NameServiceUpdateLayout layout,

    /// Name record to be updated
    required SolAddress nameAccountKey,

    /// Account owner
    required SolAddress nameUpdateSigner,
    SolAddress nameProgramId = NameServiceProgramConst.programId,

    /// Parent name record
    SolAddress? parentNameKey,
  }) {
    return NameServiceProgram(
      layout: layout,
      keys: [
        nameAccountKey.toWritable(),
        nameUpdateSigner.toSigner(),
        if (parentNameKey != null) parentNameKey.toReadOnly(),
      ],
      programId: nameProgramId,
    );
  }

  /// Transfer ownership of a name record.
  factory NameServiceProgram.transfer({
    required NameServiceTransferLayout layout,

    /// Name record to be transferred
    required SolAddress nameAccountKey,

    /// Account owner
    required SolAddress currentNameOwnerKey,
    SolAddress nameProgramId = NameServiceProgramConst.programId,

    /// Account class
    SolAddress? nameClassKey,

    /// Parent name record
    SolAddress? nameParent,
  }) {
    return NameServiceProgram(
      keys: [
        nameAccountKey.toWritable(),
        currentNameOwnerKey.toSigner(),
        if (nameClassKey != null) nameClassKey.toSigner(),
        if (nameParent != null) nameParent.toReadOnly(),
      ],
      programId: nameProgramId,
      layout: layout,
    );
  }

  /// Delete a name record.
  factory NameServiceProgram.delete({
    SolAddress nameProgramId = NameServiceProgramConst.programId,

    /// Name record to be deleted
    required SolAddress nameAccountKey,

    /// Account owner
    required SolAddress nameOwnerKey,

    /// Refund account
    required SolAddress refundTargetKey,
  }) {
    return NameServiceProgram(
      keys: [
        nameAccountKey.toWritable(),
        nameOwnerKey.toSigner(),
        refundTargetKey.toWritable(),
      ],
      programId: nameProgramId,
      layout: const NameServiceDeleteLayout(),
    );
  }

  /// Realloc the data of a name record.
  factory NameServiceProgram.realloc({
    /// Payer account (will be refunded if new space is less than current space)
    required SolAddress payerKey,

    /// Name record to be reallocated
    required SolAddress nameAccountKey,

    /// Account owner
    required SolAddress nameOwnerKey,
    required NameServiceReallocLayout layout,
    SolAddress nameProgramId = NameServiceProgramConst.programId,

    /// System program
    SolAddress systemProgramId = SystemProgramConst.programId,
  }) {
    return NameServiceProgram(
      keys: [
        systemProgramId.toReadOnly(),
        payerKey.toSignerAndWritable(),
        nameAccountKey.toWritable(),
        nameOwnerKey.toSigner(),
      ],
      programId: nameProgramId,
      layout: layout,
    );
  }
}
