// Factories for every MPL Core instruction (discriminants 0-41).
// Account order/flags match the official mpl_core IDL. Optional accounts
// that are omitted are substituted with the program ID, per the IDL.
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/mpl_core/constant.dart';
import 'package:on_chain/solana/src/instructions/mpl_core/layouts/instruction/instructions.dart';
import 'package:on_chain/solana/src/instructions/mpl_core/layouts/instruction/program_layout.dart';
import 'package:on_chain/solana/src/instructions/mpl_core/layouts/layouts/mpl_core_layouts.dart';
import 'package:on_chain/solana/src/instructions/mpl_core/layouts/layouts/mpl_core_types.dart';
import 'package:on_chain/solana/src/models/account/account_meta.dart';
import 'package:on_chain/solana/src/models/transaction/instruction.dart';

/// Full MPL Core program (was 5 stub factories).
class MplCoreProgram extends TransactionInstruction {
  MplCoreProgram._({
    required super.keys,
    required super.programId,
    required super.data,
  });

  /// Decode any MPL Core instruction (0-41).
  factory MplCoreProgram.fromBytes({
    required List<AccountMeta> keys,
    required List<int> instructionBytes,
    SolAddress? programId,
  }) {
    return MplCoreProgram._(
      keys: keys,
      programId: programId ?? MplCoreProgramConst.programId,
      data: MplCoreProgramLayout.fromBytes(instructionBytes).toBytes(),
    );
  }

  static AccountMeta _optional(
    SolAddress? address,
    AccountMeta Function() present,
    SolAddress programId,
  ) {
    if (address != null) return present();
    return programId.toReadOnly();
  }

  /// Accounts shared by asset-level instructions.
  static List<AccountMeta> _assetKeys({
    required SolAddress asset,
    required SolAddress payer,
    required bool payerSigner,
    SolAddress? collection,
    SolAddress? authority,
    SolAddress? systemProgram,
    SolAddress? logWrapper,
    SolAddress? programId,
    bool collectionWritable = true,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return [
      asset.toWritable(),
      _optional(
        collection,
        collectionWritable
            ? () => collection!.toWritable()
            : () => collection!.toReadOnly(),
        pid,
      ),
      if (payerSigner) payer.toSignerAndWritable() else payer.toWritable(),
      _optional(authority, () => authority!.toSigner(), pid),
      (systemProgram ?? MplCoreProgramConst.systemProgram).toReadOnly(),
      _optional(logWrapper, () => logWrapper!.toReadOnly(), pid),
    ];
  }

  /// Accounts shared by collection-level instructions.
  static List<AccountMeta> _collectionKeys({
    required SolAddress collection,
    required SolAddress payer,
    SolAddress? authority,
    SolAddress? systemProgram,
    SolAddress? logWrapper,
    SolAddress? programId,
    bool withLogWrapper = true,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return [
      collection.toWritable(),
      payer.toSignerAndWritable(),
      _optional(authority, () => authority!.toSigner(), pid),
      (systemProgram ?? MplCoreProgramConst.systemProgram).toReadOnly(),
      if (withLogWrapper)
        _optional(logWrapper, () => logWrapper!.toReadOnly(), pid),
    ];
  }

  /// CreateV1 (0).
  factory MplCoreProgram.createV1({
    required SolAddress asset,
    required SolAddress payer,
    required MplCoreCreateV1Layout layout,
    SolAddress? collection,
    SolAddress? authority,
    SolAddress? owner,
    SolAddress? updateAuthority,
    SolAddress? systemProgram,
    SolAddress? logWrapper,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: [
        asset.toSignerAndWritable(),
        _optional(collection, () => collection!.toWritable(), pid),
        _optional(authority, () => authority!.toSigner(), pid),
        payer.toSignerAndWritable(),
        _optional(owner, () => owner!.toReadOnly(), pid),
        _optional(updateAuthority, () => updateAuthority!.toReadOnly(), pid),
        (systemProgram ?? MplCoreProgramConst.systemProgram).toReadOnly(),
        _optional(logWrapper, () => logWrapper!.toReadOnly(), pid),
      ],
      programId: pid,
      data: layout.toBytes(),
    );
  }

  /// CreateCollectionV1 (1).
  factory MplCoreProgram.createCollectionV1({
    required SolAddress collection,
    required SolAddress payer,
    required MplCoreCreateCollectionV1Layout layout,
    SolAddress? updateAuthority,
    SolAddress? systemProgram,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: [
        collection.toSignerAndWritable(),
        _optional(updateAuthority, () => updateAuthority!.toReadOnly(), pid),
        payer.toSignerAndWritable(),
        (systemProgram ?? MplCoreProgramConst.systemProgram).toReadOnly(),
      ],
      programId: pid,
      data: layout.toBytes(),
    );
  }

  /// AddPluginV1 (2). `pluginArgs` = Borsh `AddPluginV1Args`.
  factory MplCoreProgram.addPluginV1({
    required SolAddress asset,
    required SolAddress payer,
    required List<int> pluginArgs,
    SolAddress? collection,
    SolAddress? authority,
    SolAddress? systemProgram,
    SolAddress? logWrapper,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: _assetKeys(
        asset: asset,
        payer: payer,
        payerSigner: true,
        collection: collection,
        authority: authority,
        systemProgram: systemProgram,
        logWrapper: logWrapper,
        programId: pid,
      ),
      programId: pid,
      data:
          MplCoreRawArgsLayout(
            instruction: MplCoreProgramInstruction.addPluginV1,
            argsBytes: pluginArgs,
          ).toBytes(),
    );
  }

  /// AddCollectionPluginV1 (3).
  factory MplCoreProgram.addCollectionPluginV1({
    required SolAddress collection,
    required SolAddress payer,
    required List<int> pluginArgs,
    SolAddress? authority,
    SolAddress? systemProgram,
    SolAddress? logWrapper,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: _collectionKeys(
        collection: collection,
        payer: payer,
        authority: authority,
        systemProgram: systemProgram,
        logWrapper: logWrapper,
        programId: pid,
      ),
      programId: pid,
      data:
          MplCoreRawArgsLayout(
            instruction: MplCoreProgramInstruction.addCollectionPluginV1,
            argsBytes: pluginArgs,
          ).toBytes(),
    );
  }

  /// RemovePluginV1 (4).
  factory MplCoreProgram.removePluginV1({
    required SolAddress asset,
    required SolAddress payer,
    required MplCorePluginType pluginType,
    SolAddress? collection,
    SolAddress? authority,
    SolAddress? systemProgram,
    SolAddress? logWrapper,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: _assetKeys(
        asset: asset,
        payer: payer,
        payerSigner: true,
        collection: collection,
        authority: authority,
        systemProgram: systemProgram,
        logWrapper: logWrapper,
        programId: pid,
      ),
      programId: pid,
      data:
          MplCoreRemovePluginLayout(
            instruction: MplCoreProgramInstruction.removePluginV1,
            pluginType: pluginType,
          ).toBytes(),
    );
  }

  /// RemoveCollectionPluginV1 (5).
  factory MplCoreProgram.removeCollectionPluginV1({
    required SolAddress collection,
    required SolAddress payer,
    required MplCorePluginType pluginType,
    SolAddress? authority,
    SolAddress? systemProgram,
    SolAddress? logWrapper,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: _collectionKeys(
        collection: collection,
        payer: payer,
        authority: authority,
        systemProgram: systemProgram,
        logWrapper: logWrapper,
        programId: pid,
      ),
      programId: pid,
      data:
          MplCoreRemovePluginLayout(
            instruction: MplCoreProgramInstruction.removeCollectionPluginV1,
            pluginType: pluginType,
          ).toBytes(),
    );
  }

  /// UpdatePluginV1 (6). `pluginArgs` = Borsh `UpdatePluginV1Args`.
  factory MplCoreProgram.updatePluginV1({
    required SolAddress asset,
    required SolAddress payer,
    required List<int> pluginArgs,
    SolAddress? collection,
    SolAddress? authority,
    SolAddress? systemProgram,
    SolAddress? logWrapper,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: _assetKeys(
        asset: asset,
        payer: payer,
        payerSigner: true,
        collection: collection,
        authority: authority,
        systemProgram: systemProgram,
        logWrapper: logWrapper,
        programId: pid,
      ),
      programId: pid,
      data:
          MplCoreRawArgsLayout(
            instruction: MplCoreProgramInstruction.updatePluginV1,
            argsBytes: pluginArgs,
          ).toBytes(),
    );
  }

  /// UpdateCollectionPluginV1 (7).
  factory MplCoreProgram.updateCollectionPluginV1({
    required SolAddress collection,
    required SolAddress payer,
    required List<int> pluginArgs,
    SolAddress? authority,
    SolAddress? systemProgram,
    SolAddress? logWrapper,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: _collectionKeys(
        collection: collection,
        payer: payer,
        authority: authority,
        systemProgram: systemProgram,
        logWrapper: logWrapper,
        programId: pid,
      ),
      programId: pid,
      data:
          MplCoreRawArgsLayout(
            instruction: MplCoreProgramInstruction.updateCollectionPluginV1,
            argsBytes: pluginArgs,
          ).toBytes(),
    );
  }

  /// ApprovePluginAuthorityV1 (8).
  factory MplCoreProgram.approvePluginAuthorityV1({
    required SolAddress asset,
    required SolAddress payer,
    required MplCorePluginType pluginType,
    required MplCoreAuthority newAuthority,
    SolAddress? collection,
    SolAddress? authority,
    SolAddress? systemProgram,
    SolAddress? logWrapper,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: _assetKeys(
        asset: asset,
        payer: payer,
        payerSigner: true,
        collection: collection,
        authority: authority,
        systemProgram: systemProgram,
        logWrapper: logWrapper,
        programId: pid,
      ),
      programId: pid,
      data:
          MplCoreApprovePluginAuthorityLayout(
            instruction: MplCoreProgramInstruction.approvePluginAuthorityV1,
            pluginType: pluginType,
            newAuthority: newAuthority,
          ).toBytes(),
    );
  }

  /// ApproveCollectionPluginAuthorityV1 (9).
  factory MplCoreProgram.approveCollectionPluginAuthorityV1({
    required SolAddress collection,
    required SolAddress payer,
    required MplCorePluginType pluginType,
    required MplCoreAuthority newAuthority,
    SolAddress? authority,
    SolAddress? systemProgram,
    SolAddress? logWrapper,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: _collectionKeys(
        collection: collection,
        payer: payer,
        authority: authority,
        systemProgram: systemProgram,
        logWrapper: logWrapper,
        programId: pid,
      ),
      programId: pid,
      data:
          MplCoreApprovePluginAuthorityLayout(
            instruction:
                MplCoreProgramInstruction.approveCollectionPluginAuthorityV1,
            pluginType: pluginType,
            newAuthority: newAuthority,
          ).toBytes(),
    );
  }

  /// RevokePluginAuthorityV1 (10).
  factory MplCoreProgram.revokePluginAuthorityV1({
    required SolAddress asset,
    required SolAddress payer,
    required MplCorePluginType pluginType,
    SolAddress? collection,
    SolAddress? authority,
    SolAddress? systemProgram,
    SolAddress? logWrapper,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: _assetKeys(
        asset: asset,
        payer: payer,
        payerSigner: true,
        collection: collection,
        authority: authority,
        systemProgram: systemProgram,
        logWrapper: logWrapper,
        programId: pid,
      ),
      programId: pid,
      data:
          MplCoreRevokePluginAuthorityLayout(
            instruction: MplCoreProgramInstruction.revokePluginAuthorityV1,
            pluginType: pluginType,
          ).toBytes(),
    );
  }

  /// RevokeCollectionPluginAuthorityV1 (11).
  factory MplCoreProgram.revokeCollectionPluginAuthorityV1({
    required SolAddress collection,
    required SolAddress payer,
    required MplCorePluginType pluginType,
    SolAddress? authority,
    SolAddress? systemProgram,
    SolAddress? logWrapper,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: _collectionKeys(
        collection: collection,
        payer: payer,
        authority: authority,
        systemProgram: systemProgram,
        logWrapper: logWrapper,
        programId: pid,
      ),
      programId: pid,
      data:
          MplCoreRevokePluginAuthorityLayout(
            instruction:
                MplCoreProgramInstruction.revokeCollectionPluginAuthorityV1,
            pluginType: pluginType,
          ).toBytes(),
    );
  }

  /// BurnV1 (12). `compressionProof` = raw Borsh of
  /// `Option<CompressionProof>` (null = uncompressed asset).
  factory MplCoreProgram.burnV1({
    required SolAddress asset,
    required SolAddress payer,
    List<int>? compressionProof,
    SolAddress? collection,
    SolAddress? authority,
    SolAddress? systemProgram,
    SolAddress? logWrapper,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: _assetKeys(
        asset: asset,
        payer: payer,
        payerSigner: true,
        collection: collection,
        authority: authority,
        systemProgram: systemProgram,
        logWrapper: logWrapper,
        programId: pid,
      ),
      programId: pid,
      data:
          MplCoreCompressionProofLayout(
            instruction: MplCoreProgramInstruction.burnV1,
            compressionProof: compressionProof,
          ).toBytes(),
    );
  }

  /// BurnCollectionV1 (13).
  factory MplCoreProgram.burnCollectionV1({
    required SolAddress collection,
    required SolAddress payer,
    List<int>? compressionProof,
    SolAddress? authority,
    SolAddress? logWrapper,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: [
        collection.toWritable(),
        payer.toSignerAndWritable(),
        _optional(authority, () => authority!.toSignerAndWritable(), pid),
        _optional(logWrapper, () => logWrapper!.toReadOnly(), pid),
      ],
      programId: pid,
      data:
          MplCoreCompressionProofLayout(
            instruction: MplCoreProgramInstruction.burnCollectionV1,
            compressionProof: compressionProof,
          ).toBytes(),
    );
  }

  /// TransferV1 (14).
  factory MplCoreProgram.transferV1({
    required SolAddress asset,
    required SolAddress newOwner,
    required SolAddress payer,
    List<int>? compressionProof,
    SolAddress? collection,
    SolAddress? authority,
    SolAddress? systemProgram,
    SolAddress? logWrapper,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: [
        asset.toWritable(),
        _optional(collection, () => collection!.toReadOnly(), pid),
        payer.toSignerAndWritable(),
        _optional(authority, () => authority!.toSigner(), pid),
        newOwner.toReadOnly(),
        (systemProgram ?? MplCoreProgramConst.systemProgram).toReadOnly(),
        _optional(logWrapper, () => logWrapper!.toReadOnly(), pid),
      ],
      programId: pid,
      data:
          MplCoreCompressionProofLayout(
            instruction: MplCoreProgramInstruction.transferV1,
            compressionProof: compressionProof,
          ).toBytes(),
    );
  }

  /// UpdateV1 (15).
  factory MplCoreProgram.updateV1({
    required SolAddress asset,
    required SolAddress payer,
    String? newName,
    String? newUri,
    MplCoreUpdateAuthority? newUpdateAuthority,
    SolAddress? collection,
    SolAddress? authority,
    SolAddress? systemProgram,
    SolAddress? logWrapper,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: [
        asset.toWritable(),
        _optional(collection, () => collection!.toReadOnly(), pid),
        payer.toSignerAndWritable(),
        _optional(authority, () => authority!.toSigner(), pid),
        (systemProgram ?? MplCoreProgramConst.systemProgram).toReadOnly(),
        _optional(logWrapper, () => logWrapper!.toReadOnly(), pid),
      ],
      programId: pid,
      data:
          MplCoreUpdateLayout(
            instruction: MplCoreProgramInstruction.updateV1,
            newName: newName,
            newUri: newUri,
            newUpdateAuthority: newUpdateAuthority,
          ).toBytes(),
    );
  }

  /// UpdateCollectionV1 (16).
  factory MplCoreProgram.updateCollectionV1({
    required SolAddress collection,
    required SolAddress payer,
    String? newName,
    String? newUri,
    SolAddress? authority,
    SolAddress? newUpdateAuthority,
    SolAddress? systemProgram,
    SolAddress? logWrapper,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: [
        collection.toWritable(),
        payer.toSignerAndWritable(),
        _optional(authority, () => authority!.toSigner(), pid),
        _optional(
          newUpdateAuthority,
          () => newUpdateAuthority!.toReadOnly(),
          pid,
        ),
        (systemProgram ?? MplCoreProgramConst.systemProgram).toReadOnly(),
        _optional(logWrapper, () => logWrapper!.toReadOnly(), pid),
      ],
      programId: pid,
      data:
          MplCoreUpdateNameUriLayout(
            instruction: MplCoreProgramInstruction.updateCollectionV1,
            newName: newName,
            newUri: newUri,
          ).toBytes(),
    );
  }

  /// CompressV1 (17). No args.
  factory MplCoreProgram.compressV1({
    required SolAddress asset,
    required SolAddress payer,
    SolAddress? collection,
    SolAddress? authority,
    SolAddress? systemProgram,
    SolAddress? logWrapper,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: [
        asset.toWritable(),
        _optional(collection, () => collection!.toReadOnly(), pid),
        payer.toSignerAndWritable(),
        _optional(authority, () => authority!.toSigner(), pid),
        (systemProgram ?? MplCoreProgramConst.systemProgram).toReadOnly(),
        _optional(logWrapper, () => logWrapper!.toReadOnly(), pid),
      ],
      programId: pid,
      data:
          const MplCoreEmptyLayout(
            instruction: MplCoreProgramInstruction.compressV1,
          ).toBytes(),
    );
  }

  /// DecompressV1 (18). `compressionProof` = raw Borsh of the
  /// required `CompressionProof`.
  factory MplCoreProgram.decompressV1({
    required SolAddress asset,
    required SolAddress payer,
    required List<int> compressionProof,
    SolAddress? collection,
    SolAddress? authority,
    SolAddress? systemProgram,
    SolAddress? logWrapper,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: [
        asset.toWritable(),
        _optional(collection, () => collection!.toReadOnly(), pid),
        payer.toSignerAndWritable(),
        _optional(authority, () => authority!.toSigner(), pid),
        (systemProgram ?? MplCoreProgramConst.systemProgram).toReadOnly(),
        _optional(logWrapper, () => logWrapper!.toReadOnly(), pid),
      ],
      programId: pid,
      data:
          MplCoreRawArgsLayout(
            instruction: MplCoreProgramInstruction.decompressV1,
            argsBytes: compressionProof,
          ).toBytes(),
    );
  }

  /// Collect (19). No args; two recipients.
  factory MplCoreProgram.collect({
    required SolAddress recipient1,
    required SolAddress recipient2,
    SolAddress? programId,
  }) {
    return MplCoreProgram._(
      keys: [recipient1.toWritable(), recipient2.toWritable()],
      programId: programId ?? MplCoreProgramConst.programId,
      data:
          const MplCoreEmptyLayout(
            instruction: MplCoreProgramInstruction.collect,
          ).toBytes(),
    );
  }

  /// CreateV2 (20). `pluginArgs` = raw Borsh of
  /// `Option<Vec<PluginAuthorityPair>>` + `Option<Vec<ExternalPluginAdapterInitInfo>>`.
  factory MplCoreProgram.createV2({
    required SolAddress asset,
    required SolAddress payer,
    required MplCoreCreateV2Layout layout,
    SolAddress? collection,
    SolAddress? authority,
    SolAddress? owner,
    SolAddress? updateAuthority,
    SolAddress? systemProgram,
    SolAddress? logWrapper,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: [
        asset.toSignerAndWritable(),
        _optional(collection, () => collection!.toWritable(), pid),
        _optional(authority, () => authority!.toSigner(), pid),
        payer.toSignerAndWritable(),
        _optional(owner, () => owner!.toReadOnly(), pid),
        _optional(updateAuthority, () => updateAuthority!.toReadOnly(), pid),
        (systemProgram ?? MplCoreProgramConst.systemProgram).toReadOnly(),
        _optional(logWrapper, () => logWrapper!.toReadOnly(), pid),
      ],
      programId: pid,
      data: layout.toBytes(),
    );
  }

  /// CreateCollectionV2 (21).
  factory MplCoreProgram.createCollectionV2({
    required SolAddress collection,
    required SolAddress payer,
    required MplCoreCreateCollectionV2Layout layout,
    SolAddress? updateAuthority,
    SolAddress? systemProgram,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: [
        collection.toSignerAndWritable(),
        _optional(updateAuthority, () => updateAuthority!.toReadOnly(), pid),
        payer.toSignerAndWritable(),
        (systemProgram ?? MplCoreProgramConst.systemProgram).toReadOnly(),
      ],
      programId: pid,
      data: layout.toBytes(),
    );
  }

  /// AddExternalPluginAdapterV1 (22).
  factory MplCoreProgram.addExternalPluginAdapterV1({
    required SolAddress asset,
    required SolAddress payer,
    required List<int> adapterArgs,
    SolAddress? collection,
    SolAddress? authority,
    SolAddress? systemProgram,
    SolAddress? logWrapper,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: _assetKeys(
        asset: asset,
        payer: payer,
        payerSigner: true,
        collection: collection,
        authority: authority,
        systemProgram: systemProgram,
        logWrapper: logWrapper,
        programId: pid,
      ),
      programId: pid,
      data:
          MplCoreRawArgsLayout(
            instruction: MplCoreProgramInstruction.addExternalPluginAdapterV1,
            argsBytes: adapterArgs,
          ).toBytes(),
    );
  }

  /// AddCollectionExternalPluginAdapterV1 (23).
  factory MplCoreProgram.addCollectionExternalPluginAdapterV1({
    required SolAddress collection,
    required SolAddress payer,
    required List<int> adapterArgs,
    SolAddress? authority,
    SolAddress? systemProgram,
    SolAddress? logWrapper,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: _collectionKeys(
        collection: collection,
        payer: payer,
        authority: authority,
        systemProgram: systemProgram,
        logWrapper: logWrapper,
        programId: pid,
      ),
      programId: pid,
      data:
          MplCoreRawArgsLayout(
            instruction:
                MplCoreProgramInstruction.addCollectionExternalPluginAdapterV1,
            argsBytes: adapterArgs,
          ).toBytes(),
    );
  }

  /// RemoveExternalPluginAdapterV1 (24).
  factory MplCoreProgram.removeExternalPluginAdapterV1({
    required SolAddress asset,
    required SolAddress payer,
    required List<int> keyArgs,
    SolAddress? collection,
    SolAddress? authority,
    SolAddress? systemProgram,
    SolAddress? logWrapper,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: _assetKeys(
        asset: asset,
        payer: payer,
        payerSigner: true,
        collection: collection,
        authority: authority,
        systemProgram: systemProgram,
        logWrapper: logWrapper,
        programId: pid,
      ),
      programId: pid,
      data:
          MplCoreRawArgsLayout(
            instruction:
                MplCoreProgramInstruction.removeExternalPluginAdapterV1,
            argsBytes: keyArgs,
          ).toBytes(),
    );
  }

  /// RemoveCollectionExternalPluginAdapterV1 (25).
  factory MplCoreProgram.removeCollectionExternalPluginAdapterV1({
    required SolAddress collection,
    required SolAddress payer,
    required List<int> keyArgs,
    SolAddress? authority,
    SolAddress? systemProgram,
    SolAddress? logWrapper,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: _collectionKeys(
        collection: collection,
        payer: payer,
        authority: authority,
        systemProgram: systemProgram,
        logWrapper: logWrapper,
        programId: pid,
      ),
      programId: pid,
      data:
          MplCoreRawArgsLayout(
            instruction:
                MplCoreProgramInstruction
                    .removeCollectionExternalPluginAdapterV1,
            argsBytes: keyArgs,
          ).toBytes(),
    );
  }

  /// UpdateExternalPluginAdapterV1 (26).
  factory MplCoreProgram.updateExternalPluginAdapterV1({
    required SolAddress asset,
    required SolAddress payer,
    required List<int> adapterArgs,
    SolAddress? collection,
    SolAddress? authority,
    SolAddress? systemProgram,
    SolAddress? logWrapper,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: _assetKeys(
        asset: asset,
        payer: payer,
        payerSigner: true,
        collection: collection,
        authority: authority,
        systemProgram: systemProgram,
        logWrapper: logWrapper,
        programId: pid,
      ),
      programId: pid,
      data:
          MplCoreRawArgsLayout(
            instruction:
                MplCoreProgramInstruction.updateExternalPluginAdapterV1,
            argsBytes: adapterArgs,
          ).toBytes(),
    );
  }

  /// UpdateCollectionExternalPluginAdapterV1 (27).
  factory MplCoreProgram.updateCollectionExternalPluginAdapterV1({
    required SolAddress collection,
    required SolAddress payer,
    required List<int> adapterArgs,
    SolAddress? authority,
    SolAddress? systemProgram,
    SolAddress? logWrapper,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: _collectionKeys(
        collection: collection,
        payer: payer,
        authority: authority,
        systemProgram: systemProgram,
        logWrapper: logWrapper,
        programId: pid,
      ),
      programId: pid,
      data:
          MplCoreRawArgsLayout(
            instruction:
                MplCoreProgramInstruction
                    .updateCollectionExternalPluginAdapterV1,
            argsBytes: adapterArgs,
          ).toBytes(),
    );
  }

  /// WriteExternalPluginAdapterDataV1 (28).
  factory MplCoreProgram.writeExternalPluginAdapterDataV1({
    required SolAddress asset,
    required SolAddress payer,
    required List<int> dataArgs,
    SolAddress? collection,
    SolAddress? authority,
    SolAddress? buffer,
    SolAddress? systemProgram,
    SolAddress? logWrapper,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: [
        ..._assetKeys(
          asset: asset,
          payer: payer,
          payerSigner: true,
          collection: collection,
          authority: authority,
          systemProgram: systemProgram,
          logWrapper: logWrapper,
          programId: pid,
        ).sublist(0, 4),
        _optional(buffer, () => buffer!.toWritable(), pid),
        (systemProgram ?? MplCoreProgramConst.systemProgram).toReadOnly(),
        _optional(logWrapper, () => logWrapper!.toReadOnly(), pid),
      ],
      programId: pid,
      data:
          MplCoreRawArgsLayout(
            instruction:
                MplCoreProgramInstruction.writeExternalPluginAdapterDataV1,
            argsBytes: dataArgs,
          ).toBytes(),
    );
  }

  /// WriteCollectionExternalPluginAdapterDataV1 (29).
  factory MplCoreProgram.writeCollectionExternalPluginAdapterDataV1({
    required SolAddress collection,
    required SolAddress payer,
    required List<int> dataArgs,
    SolAddress? authority,
    SolAddress? buffer,
    SolAddress? systemProgram,
    SolAddress? logWrapper,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: [
        collection.toWritable(),
        payer.toSignerAndWritable(),
        _optional(authority, () => authority!.toSigner(), pid),
        _optional(buffer, () => buffer!.toWritable(), pid),
        (systemProgram ?? MplCoreProgramConst.systemProgram).toReadOnly(),
        _optional(logWrapper, () => logWrapper!.toReadOnly(), pid),
      ],
      programId: pid,
      data:
          MplCoreRawArgsLayout(
            instruction:
                MplCoreProgramInstruction
                    .writeCollectionExternalPluginAdapterDataV1,
            argsBytes: dataArgs,
          ).toBytes(),
    );
  }

  /// UpdateV2 (30). `newCollection` moves the asset.
  factory MplCoreProgram.updateV2({
    required SolAddress asset,
    required SolAddress payer,
    String? newName,
    String? newUri,
    MplCoreUpdateAuthority? newUpdateAuthority,
    SolAddress? collection,
    SolAddress? authority,
    SolAddress? newCollection,
    SolAddress? systemProgram,
    SolAddress? logWrapper,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: [
        asset.toWritable(),
        _optional(collection, () => collection!.toWritable(), pid),
        payer.toSignerAndWritable(),
        _optional(authority, () => authority!.toSigner(), pid),
        _optional(newCollection, () => newCollection!.toWritable(), pid),
        (systemProgram ?? MplCoreProgramConst.systemProgram).toReadOnly(),
        _optional(logWrapper, () => logWrapper!.toReadOnly(), pid),
      ],
      programId: pid,
      data:
          MplCoreUpdateLayout(
            instruction: MplCoreProgramInstruction.updateV2,
            newName: newName,
            newUri: newUri,
            newUpdateAuthority: newUpdateAuthority,
          ).toBytes(),
    );
  }

  /// ExecuteV1 (31). The asset signs via PDA; the inner
  /// instruction (`programId` + `instructionData`) runs with the asset as
  /// signer. Extra accounts for the inner ix go in `remainingAccounts`.
  factory MplCoreProgram.executeV1({
    required SolAddress asset,
    required SolAddress payer,
    required SolAddress programId,
    required MplCoreExecuteV1Layout layout,
    SolAddress? collection,
    SolAddress? assetSigner,
    SolAddress? authority,
    SolAddress? systemProgram,
    List<SolAddress> remainingAccounts = const [],
    SolAddress? coreProgramId,
  }) {
    final pid = coreProgramId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: [
        asset.toWritable(),
        _optional(collection, () => collection!.toWritable(), pid),
        (assetSigner ?? asset).toReadOnly(),
        payer.toWritable(),
        _optional(authority, () => authority!.toSigner(), pid),
        (systemProgram ?? MplCoreProgramConst.systemProgram).toReadOnly(),
        programId.toReadOnly(),
        ...remainingAccounts.map((e) => e.toReadOnly()),
      ],
      programId: pid,
      data: layout.toBytes(),
    );
  }

  /// UpdateCollectionInfoV1 (32). Only the Bubblegum signer
  /// (PDA) may call it.
  factory MplCoreProgram.updateCollectionInfoV1({
    required SolAddress collection,
    required SolAddress bubblegumSigner,
    required MplCoreUpdateCollectionInfoV1Layout layout,
    SolAddress? programId,
  }) {
    return MplCoreProgram._(
      keys: [collection.toWritable(), bubblegumSigner.toSigner()],
      programId: programId ?? MplCoreProgramConst.programId,
      data: layout.toBytes(),
    );
  }

  /// AddCollectionsToGroupV1 (33). Members travel as remaining
  /// accounts (readonly); no args.
  factory MplCoreProgram.addCollectionsToGroupV1({
    required SolAddress group,
    required SolAddress payer,
    List<SolAddress> members = const [],
    SolAddress? authority,
    SolAddress? systemProgram,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: [
        group.toWritable(),
        payer.toSignerAndWritable(),
        _optional(authority, () => authority!.toSigner(), pid),
        (systemProgram ?? MplCoreProgramConst.systemProgram).toReadOnly(),
        ...members.map((e) => e.toReadOnly()),
      ],
      programId: pid,
      data:
          const MplCoreEmptyLayout(
            instruction: MplCoreProgramInstruction.addCollectionsToGroupV1,
          ).toBytes(),
    );
  }

  /// RemoveCollectionsFromGroupV1 (34).
  factory MplCoreProgram.removeCollectionsFromGroupV1({
    required SolAddress group,
    required SolAddress payer,
    required List<SolAddress> collections,
    SolAddress? authority,
    SolAddress? systemProgram,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: [
        group.toWritable(),
        payer.toSignerAndWritable(),
        _optional(authority, () => authority!.toSigner(), pid),
        (systemProgram ?? MplCoreProgramConst.systemProgram).toReadOnly(),
      ],
      programId: pid,
      data:
          MplCorePubkeyVecLayout(
            instruction: MplCoreProgramInstruction.removeCollectionsFromGroupV1,
            pubkeys: collections,
          ).toBytes(),
    );
  }

  /// AddAssetsToGroupV1 (35).
  factory MplCoreProgram.addAssetsToGroupV1({
    required SolAddress group,
    required SolAddress payer,
    List<SolAddress> members = const [],
    SolAddress? authority,
    SolAddress? systemProgram,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: [
        group.toWritable(),
        payer.toSignerAndWritable(),
        _optional(authority, () => authority!.toSigner(), pid),
        (systemProgram ?? MplCoreProgramConst.systemProgram).toReadOnly(),
        ...members.map((e) => e.toReadOnly()),
      ],
      programId: pid,
      data:
          const MplCoreEmptyLayout(
            instruction: MplCoreProgramInstruction.addAssetsToGroupV1,
          ).toBytes(),
    );
  }

  /// RemoveAssetsFromGroupV1 (36).
  factory MplCoreProgram.removeAssetsFromGroupV1({
    required SolAddress group,
    required SolAddress payer,
    required List<SolAddress> assets,
    SolAddress? authority,
    SolAddress? systemProgram,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: [
        group.toWritable(),
        payer.toSignerAndWritable(),
        _optional(authority, () => authority!.toSigner(), pid),
        (systemProgram ?? MplCoreProgramConst.systemProgram).toReadOnly(),
      ],
      programId: pid,
      data:
          MplCorePubkeyVecLayout(
            instruction: MplCoreProgramInstruction.removeAssetsFromGroupV1,
            pubkeys: assets,
          ).toBytes(),
    );
  }

  /// AddGroupsToGroupV1 (37).
  factory MplCoreProgram.addGroupsToGroupV1({
    required SolAddress parentGroup,
    required SolAddress payer,
    required List<SolAddress> groups,
    SolAddress? authority,
    SolAddress? systemProgram,
    List<SolAddress> members = const [],
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: [
        parentGroup.toWritable(),
        payer.toSignerAndWritable(),
        _optional(authority, () => authority!.toSigner(), pid),
        (systemProgram ?? MplCoreProgramConst.systemProgram).toReadOnly(),
        ...members.map((e) => e.toReadOnly()),
      ],
      programId: pid,
      data:
          MplCorePubkeyVecLayout(
            instruction: MplCoreProgramInstruction.addGroupsToGroupV1,
            pubkeys: groups,
          ).toBytes(),
    );
  }

  /// RemoveGroupsFromGroupV1 (38).
  factory MplCoreProgram.removeGroupsFromGroupV1({
    required SolAddress parentGroup,
    required SolAddress payer,
    required List<SolAddress> groups,
    SolAddress? authority,
    SolAddress? systemProgram,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: [
        parentGroup.toWritable(),
        payer.toSignerAndWritable(),
        _optional(authority, () => authority!.toSigner(), pid),
        (systemProgram ?? MplCoreProgramConst.systemProgram).toReadOnly(),
      ],
      programId: pid,
      data:
          MplCorePubkeyVecLayout(
            instruction: MplCoreProgramInstruction.removeGroupsFromGroupV1,
            pubkeys: groups,
          ).toBytes(),
    );
  }

  /// CreateGroupV1 (39).
  factory MplCoreProgram.createGroupV1({
    required SolAddress group,
    required SolAddress payer,
    required MplCoreCreateGroupV1Layout layout,
    SolAddress? updateAuthority,
    SolAddress? systemProgram,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: [
        group.toSignerAndWritable(),
        _optional(updateAuthority, () => updateAuthority!.toSigner(), pid),
        payer.toSignerAndWritable(),
        (systemProgram ?? MplCoreProgramConst.systemProgram).toReadOnly(),
      ],
      programId: pid,
      data: layout.toBytes(),
    );
  }

  /// CloseGroupV1 (40). No args.
  factory MplCoreProgram.closeGroupV1({
    required SolAddress group,
    required SolAddress payer,
    SolAddress? authority,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: [
        group.toWritable(),
        payer.toSignerAndWritable(),
        _optional(authority, () => authority!.toSigner(), pid),
      ],
      programId: pid,
      data:
          const MplCoreEmptyLayout(
            instruction: MplCoreProgramInstruction.closeGroupV1,
          ).toBytes(),
    );
  }

  /// UpdateGroupV1 (41).
  factory MplCoreProgram.updateGroupV1({
    required SolAddress group,
    required SolAddress payer,
    String? newName,
    String? newUri,
    SolAddress? authority,
    SolAddress? newUpdateAuthority,
    SolAddress? systemProgram,
    SolAddress? programId,
  }) {
    final pid = programId ?? MplCoreProgramConst.programId;
    return MplCoreProgram._(
      keys: [
        group.toWritable(),
        payer.toSignerAndWritable(),
        _optional(authority, () => authority!.toSigner(), pid),
        _optional(
          newUpdateAuthority,
          () => newUpdateAuthority!.toReadOnly(),
          pid,
        ),
        (systemProgram ?? MplCoreProgramConst.systemProgram).toReadOnly(),
      ],
      programId: pid,
      data:
          MplCoreUpdateNameUriLayout(
            instruction: MplCoreProgramInstruction.updateGroupV1,
            newName: newName,
            newUri: newUri,
          ).toBytes(),
    );
  }
}
