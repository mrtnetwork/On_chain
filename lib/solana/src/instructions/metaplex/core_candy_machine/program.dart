// Factories for the Core Candy Machine + Core Candy Guard programs.
// Account order/flags match the IDLs (mpl-core-candy-machine).
import 'dart:typed_data';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/metaplex/core_candy_machine/constant.dart';
import 'package:on_chain/solana/src/instructions/mpl_core/constant.dart';
import 'package:on_chain/solana/src/instructions/system/constant.dart';
import 'package:on_chain/solana/src/instructions/metaplex/core_candy_machine/layouts/instruction/instructions.dart';
import 'package:on_chain/solana/src/instructions/metaplex/core_candy_machine/layouts/instruction/program_layout.dart';
import 'package:on_chain/solana/src/instructions/metaplex/core_candy_machine/layouts/layouts/core_candy_machine_layouts.dart';
import 'package:on_chain/solana/src/models/account/account_meta.dart';
import 'package:on_chain/solana/src/models/transaction/instruction.dart';

class CoreCandyMachineProgram extends TransactionInstruction {
  CoreCandyMachineProgram._({
    required super.keys,
    required super.programId,
    required ProgramLayout layout,
  }) : super(data: layout.toBytes());

  factory CoreCandyMachineProgram.fromBytes({
    required List<AccountMeta> keys,
    required List<int> instructionBytes,
    SolAddress programId = CoreCandyMachineProgramConst.candyMachineProgramId,
  }) {
    return CoreCandyMachineProgram._(
      keys: keys,
      programId: programId,
      layout: CoreCandyMachineProgramLayoutDispatch.machineFromBytes(
        instructionBytes,
      ),
    );
  }

  factory CoreCandyMachineProgram.addConfigLines({
    required SolAddress candyMachine,
    required SolAddress authority,
    required CoreCandyMachineAddConfigLinesLayout layout,
    SolAddress? programId,
  }) {
    return CoreCandyMachineProgram._(
      keys: [candyMachine.toWritable(), authority.toSigner()],
      programId:
          programId ?? CoreCandyMachineProgramConst.candyMachineProgramId,
      layout: layout,
    );
  }

  factory CoreCandyMachineProgram.initialize({
    required SolAddress candyMachine,
    required SolAddress authorityPda,
    required SolAddress authority,
    required SolAddress payer,
    required SolAddress collection,
    required SolAddress collectionUpdateAuthority,
    required List<int> data,
    SolAddress? mplCoreProgram,
    SolAddress? systemProgram,
    SolAddress? sysvarInstructions,
    SolAddress? programId,
  }) {
    return CoreCandyMachineProgram._(
      keys: [
        candyMachine.toWritable(),
        authorityPda.toWritable(),
        authority.toReadOnly(),
        payer.toSignerAndWritable(),
        collection.toWritable(),
        collectionUpdateAuthority.toSignerAndWritable(),
        (mplCoreProgram ?? MplCoreProgramConstForCandy.coreProgram)
            .toReadOnly(),
        (systemProgram ?? MplCoreProgramConstForCandy.systemProgram)
            .toReadOnly(),
        (sysvarInstructions ?? MplCoreProgramConstForCandy.sysvarInstructions)
            .toReadOnly(),
      ],
      programId:
          programId ?? CoreCandyMachineProgramConst.candyMachineProgramId,
      layout: CoreCandyMachineRawArgsLayout(
        instruction: CoreCandyMachineProgramInstruction.initialize,
        discriminant: CoreCandyMachineProgramInstruction.initialize.instruction,
        argsBytes: data,
      ),
    );
  }

  factory CoreCandyMachineProgram.mintAsset({
    required SolAddress candyMachine,
    required SolAddress authorityPda,
    required SolAddress mintAuthority,
    required SolAddress payer,
    required SolAddress assetOwner,
    required SolAddress asset,
    required SolAddress collection,
    required List<int> args,
    SolAddress? mplCoreProgram,
    SolAddress? systemProgram,
    SolAddress? sysvarInstructions,
    SolAddress? recentSlothashes,
    SolAddress? programId,
  }) {
    return CoreCandyMachineProgram._(
      keys: [
        candyMachine.toWritable(),
        authorityPda.toWritable(),
        mintAuthority.toSigner(),
        payer.toSignerAndWritable(),
        assetOwner.toReadOnly(),
        asset.toSignerAndWritable(),
        collection.toWritable(),
        (mplCoreProgram ?? MplCoreProgramConstForCandy.coreProgram)
            .toReadOnly(),
        (systemProgram ?? MplCoreProgramConstForCandy.systemProgram)
            .toReadOnly(),
        (sysvarInstructions ?? MplCoreProgramConstForCandy.sysvarInstructions)
            .toReadOnly(),
        (recentSlothashes ?? MplCoreProgramConstForCandy.recentSlothashes)
            .toReadOnly(),
      ],
      programId:
          programId ?? CoreCandyMachineProgramConst.candyMachineProgramId,
      layout: CoreCandyMachineRawArgsLayout(
        instruction: CoreCandyMachineProgramInstruction.mintAsset,
        discriminant: CoreCandyMachineProgramInstruction.mintAsset.instruction,
        argsBytes: args,
      ),
    );
  }

  factory CoreCandyMachineProgram.setAuthority({
    required SolAddress candyMachine,
    required SolAddress authority,
    required SolAddress newAuthority,
    SolAddress? programId,
  }) {
    return CoreCandyMachineProgram._(
      keys: [candyMachine.toWritable(), authority.toSigner()],
      programId:
          programId ?? CoreCandyMachineProgramConst.candyMachineProgramId,
      layout: CoreCandyMachineSetAuthorityLayout(
        programInstruction: CoreCandyMachineProgramInstruction.setAuthority,
        newAuthority: newAuthority,
      ),
    );
  }

  factory CoreCandyMachineProgram.setCollection({
    required SolAddress candyMachine,
    required SolAddress authority,
    required SolAddress authorityPda,
    required SolAddress payer,
    required SolAddress collectionUpdateAuthority,
    required SolAddress collection,
    required SolAddress newCollectionUpdateAuthority,
    required SolAddress newCollection,
    SolAddress? mplCoreProgram,
    SolAddress? systemProgram,
    SolAddress? sysvarInstructions,
    SolAddress? programId,
  }) {
    return CoreCandyMachineProgram._(
      keys: [
        candyMachine.toWritable(),
        authority.toSigner(),
        authorityPda.toWritable(),
        payer.toSignerAndWritable(),
        collectionUpdateAuthority.toReadOnly(),
        collection.toWritable(),
        newCollectionUpdateAuthority.toSigner(),
        newCollection.toWritable(),
        (mplCoreProgram ?? MplCoreProgramConstForCandy.coreProgram)
            .toReadOnly(),
        (systemProgram ?? MplCoreProgramConstForCandy.systemProgram)
            .toReadOnly(),
        (sysvarInstructions ?? MplCoreProgramConstForCandy.sysvarInstructions)
            .toReadOnly(),
      ],
      programId:
          programId ?? CoreCandyMachineProgramConst.candyMachineProgramId,
      layout: const CoreCandyMachineEmptyLayout(
        programInstruction: CoreCandyMachineProgramInstruction.setCollection,
      ),
    );
  }

  factory CoreCandyMachineProgram.setMintAuthority({
    required SolAddress candyMachine,
    required SolAddress authority,
    required SolAddress mintAuthority,
    SolAddress? programId,
  }) {
    return CoreCandyMachineProgram._(
      keys: [
        candyMachine.toWritable(),
        authority.toSigner(),
        mintAuthority.toSigner(),
      ],
      programId:
          programId ?? CoreCandyMachineProgramConst.candyMachineProgramId,
      layout: const CoreCandyMachineEmptyLayout(
        programInstruction: CoreCandyMachineProgramInstruction.setMintAuthority,
      ),
    );
  }

  factory CoreCandyMachineProgram.update({
    required SolAddress candyMachine,
    required SolAddress authority,
    required List<int> data,
    SolAddress? programId,
  }) {
    return CoreCandyMachineProgram._(
      keys: [candyMachine.toWritable(), authority.toSigner()],
      programId:
          programId ?? CoreCandyMachineProgramConst.candyMachineProgramId,
      layout: CoreCandyMachineRawArgsLayout(
        instruction: CoreCandyMachineProgramInstruction.update,
        discriminant: CoreCandyMachineProgramInstruction.update.instruction,
        argsBytes: data,
      ),
    );
  }

  factory CoreCandyMachineProgram.withdraw({
    required SolAddress candyMachine,
    required SolAddress authority,
    SolAddress? programId,
  }) {
    return CoreCandyMachineProgram._(
      keys: [candyMachine.toWritable(), authority.toSignerAndWritable()],
      programId:
          programId ?? CoreCandyMachineProgramConst.candyMachineProgramId,
      layout: const CoreCandyMachineEmptyLayout(
        programInstruction: CoreCandyMachineProgramInstruction.withdraw,
      ),
    );
  }
}

class CoreCandyGuardProgram extends TransactionInstruction {
  CoreCandyGuardProgram._({
    required super.keys,
    required super.programId,
    required ProgramLayout layout,
  }) : super(data: layout.toBytes());

  factory CoreCandyGuardProgram.fromBytes({
    required List<AccountMeta> keys,
    required List<int> instructionBytes,
    SolAddress programId = CoreCandyMachineProgramConst.candyGuardProgramId,
  }) {
    return CoreCandyGuardProgram._(
      keys: keys,
      programId: programId,
      layout: CoreCandyMachineProgramLayoutDispatch.guardFromBytes(
        instructionBytes,
      ),
    );
  }

  factory CoreCandyGuardProgram.initialize({
    required SolAddress candyGuard,
    required SolAddress base,
    required SolAddress authority,
    required SolAddress payer,
    required List<int> data,
    SolAddress? systemProgram,
    SolAddress? programId,
  }) {
    return CoreCandyGuardProgram._(
      keys: [
        candyGuard.toWritable(),
        base.toSigner(),
        authority.toReadOnly(),
        payer.toSignerAndWritable(),
        (systemProgram ?? MplCoreProgramConstForCandy.systemProgram)
            .toReadOnly(),
      ],
      programId: programId ?? CoreCandyMachineProgramConst.candyGuardProgramId,
      layout: CoreCandyMachineRawArgsLayout(
        instruction: CoreCandyGuardProgramInstruction.initialize,
        discriminant: CoreCandyGuardProgramInstruction.initialize.instruction,
        argsBytes: data,
      ),
    );
  }

  factory CoreCandyGuardProgram.mintV1({
    required SolAddress candyGuard,
    required SolAddress candyMachineProgram,
    required SolAddress candyMachine,
    required SolAddress candyMachineAuthorityPda,
    required SolAddress payer,
    required SolAddress minter,
    required SolAddress owner,
    required SolAddress asset,
    required SolAddress collection,
    required CoreCandyGuardMintV1Layout layout,
    SolAddress? mplCoreProgram,
    SolAddress? systemProgram,
    SolAddress? sysvarInstructions,
    SolAddress? recentSlothashes,
    SolAddress? programId,
  }) {
    return CoreCandyGuardProgram._(
      keys: [
        candyGuard.toReadOnly(),
        candyMachineProgram.toReadOnly(),
        candyMachine.toWritable(),
        candyMachineAuthorityPda.toWritable(),
        payer.toSignerAndWritable(),
        minter.toSignerAndWritable(),
        owner.toReadOnly(),
        asset.toSignerAndWritable(),
        collection.toWritable(),
        (mplCoreProgram ?? MplCoreProgramConstForCandy.coreProgram)
            .toReadOnly(),
        (systemProgram ?? MplCoreProgramConstForCandy.systemProgram)
            .toReadOnly(),
        (sysvarInstructions ?? MplCoreProgramConstForCandy.sysvarInstructions)
            .toReadOnly(),
        (recentSlothashes ?? MplCoreProgramConstForCandy.recentSlothashes)
            .toReadOnly(),
      ],
      programId: programId ?? CoreCandyMachineProgramConst.candyGuardProgramId,
      layout: layout,
    );
  }

  factory CoreCandyGuardProgram.route({
    required SolAddress candyGuard,
    required SolAddress candyMachine,
    required SolAddress payer,
    required int guardType,
    required List<int> data,
    String? label,
    SolAddress? programId,
  }) {
    return CoreCandyGuardProgram._(
      keys: [
        candyGuard.toReadOnly(),
        candyMachine.toWritable(),
        payer.toSignerAndWritable(),
      ],
      programId: programId ?? CoreCandyMachineProgramConst.candyGuardProgramId,
      layout: CoreCandyMachineRawArgsLayout(
        instruction: CoreCandyGuardProgramInstruction.route,
        discriminant: CoreCandyGuardProgramInstruction.route.instruction,
        argsBytes: _routeArgs(guardType, data, label),
      ),
    );
  }

  factory CoreCandyGuardProgram.setAuthority({
    required SolAddress candyGuard,
    required SolAddress authority,
    required SolAddress newAuthority,
    SolAddress? programId,
  }) {
    return CoreCandyGuardProgram._(
      keys: [candyGuard.toWritable(), authority.toSigner()],
      programId: programId ?? CoreCandyMachineProgramConst.candyGuardProgramId,
      layout: CoreCandyMachineSetAuthorityLayout(
        programInstruction: CoreCandyGuardProgramInstruction.setAuthority,
        newAuthority: newAuthority,
      ),
    );
  }
  factory CoreCandyGuardProgram.unwrap({
    required SolAddress candyGuard,
    required SolAddress authority,
    required SolAddress candyMachine,
    required SolAddress candyMachineAuthority,
    required SolAddress candyMachineProgram,
    SolAddress? programId,
  }) {
    return CoreCandyGuardProgram._(
      keys: [
        candyGuard.toReadOnly(),
        authority.toSigner(),
        candyMachine.toWritable(),
        candyMachineAuthority.toSigner(),
        candyMachineProgram.toReadOnly(),
      ],
      programId: programId ?? CoreCandyMachineProgramConst.candyGuardProgramId,
      layout: const CoreCandyMachineEmptyLayout(
        programInstruction: CoreCandyGuardProgramInstruction.unwrap,
      ),
    );
  }
  factory CoreCandyGuardProgram.update({
    required SolAddress candyGuard,
    required SolAddress authority,
    required SolAddress payer,
    required List<int> data,
    SolAddress? systemProgram,
    SolAddress? programId,
  }) {
    return CoreCandyGuardProgram._(
      keys: [
        candyGuard.toWritable(),
        authority.toSigner(),
        payer.toSigner(),
        (systemProgram ?? MplCoreProgramConstForCandy.systemProgram)
            .toReadOnly(),
      ],
      programId: programId ?? CoreCandyMachineProgramConst.candyGuardProgramId,
      layout: CoreCandyMachineRawArgsLayout(
        instruction: CoreCandyGuardProgramInstruction.update,
        discriminant: CoreCandyGuardProgramInstruction.update.instruction,
        argsBytes: data,
      ),
    );
  }

  factory CoreCandyGuardProgram.withdraw({
    required SolAddress candyGuard,
    required SolAddress authority,
    SolAddress? programId,
  }) {
    return CoreCandyGuardProgram._(
      keys: [candyGuard.toWritable(), authority.toSignerAndWritable()],
      programId: programId ?? CoreCandyMachineProgramConst.candyGuardProgramId,
      layout: const CoreCandyMachineEmptyLayout(
        programInstruction: CoreCandyGuardProgramInstruction.withdraw,
      ),
    );
  }
  factory CoreCandyGuardProgram.wrap({
    required SolAddress candyGuard,
    required SolAddress authority,
    required SolAddress candyMachine,
    required SolAddress candyMachineProgram,
    required SolAddress candyMachineAuthority,
    SolAddress? programId,
  }) {
    return CoreCandyGuardProgram._(
      keys: [
        candyGuard.toReadOnly(),
        authority.toSigner(),
        candyMachine.toWritable(),
        candyMachineProgram.toReadOnly(),
        candyMachineAuthority.toSigner(),
      ],
      programId: programId ?? CoreCandyMachineProgramConst.candyGuardProgramId,
      layout: const CoreCandyMachineEmptyLayout(
        programInstruction: CoreCandyGuardProgramInstruction.wrap,
      ),
    );
  }

  static List<int> _routeArgs(int guardType, List<int> data, String? label) {
    final labelBytes =
        label == null
            ? IntUtils.toBytes(0, length: 1)
            : [
              ...IntUtils.toBytes(1, length: 1),
              ..._vecU8(StringUtils.encode(label)),
            ];
    return [
      ...IntUtils.toBytes(guardType, length: 1),
      ..._vecU8(data),
      ...labelBytes,
    ];
  }

  static List<int> _vecU8(List<int> bytes) {
    return [
      ...IntUtils.toBytes(bytes.length, length: 4, byteOrder: Endian.little),
      ...bytes,
    ];
  }
}

abstract class MplCoreProgramConstForCandy {
  static SolAddress get coreProgram => MplCoreProgramConst.programId;
  static SolAddress get systemProgram => SystemProgramConst.programId;
  static SolAddress get sysvarInstructions =>
      SystemProgramConst.sysvarInstructionsPubkey;
  static SolAddress get recentSlothashes =>
      SystemProgramConst.sysvarSlotHashesPubkey;
}
