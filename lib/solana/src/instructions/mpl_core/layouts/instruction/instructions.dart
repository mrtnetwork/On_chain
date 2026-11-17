import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/mpl_core/constant.dart';

/// Full MPL Core instruction set (discriminants 0-41).
/// Order and accounts match the official `mpl_core` IDL
/// (`CoREENxT6tW1HoK8ypY1SxRMZTcVPm7R94rH4PZNhX7d`).
class MplCoreProgramInstruction implements ProgramLayoutInstruction {
  @override
  final int instruction;
  @override
  final String name;
  const MplCoreProgramInstruction(this.instruction, this.name);

  static const MplCoreProgramInstruction createV1 = MplCoreProgramInstruction(
    0,
    'CreateV1',
  );
  static const MplCoreProgramInstruction createCollectionV1 =
      MplCoreProgramInstruction(1, 'CreateCollectionV1');
  static const MplCoreProgramInstruction addPluginV1 =
      MplCoreProgramInstruction(2, 'AddPluginV1');
  static const MplCoreProgramInstruction addCollectionPluginV1 =
      MplCoreProgramInstruction(3, 'AddCollectionPluginV1');
  static const MplCoreProgramInstruction removePluginV1 =
      MplCoreProgramInstruction(4, 'RemovePluginV1');
  static const MplCoreProgramInstruction removeCollectionPluginV1 =
      MplCoreProgramInstruction(5, 'RemoveCollectionPluginV1');
  static const MplCoreProgramInstruction updatePluginV1 =
      MplCoreProgramInstruction(6, 'UpdatePluginV1');
  static const MplCoreProgramInstruction updateCollectionPluginV1 =
      MplCoreProgramInstruction(7, 'UpdateCollectionPluginV1');
  static const MplCoreProgramInstruction approvePluginAuthorityV1 =
      MplCoreProgramInstruction(8, 'ApprovePluginAuthorityV1');
  static const MplCoreProgramInstruction approveCollectionPluginAuthorityV1 =
      MplCoreProgramInstruction(9, 'ApproveCollectionPluginAuthorityV1');
  static const MplCoreProgramInstruction revokePluginAuthorityV1 =
      MplCoreProgramInstruction(10, 'RevokePluginAuthorityV1');
  static const MplCoreProgramInstruction revokeCollectionPluginAuthorityV1 =
      MplCoreProgramInstruction(11, 'RevokeCollectionPluginAuthorityV1');
  static const MplCoreProgramInstruction burnV1 = MplCoreProgramInstruction(
    12,
    'BurnV1',
  );
  static const MplCoreProgramInstruction burnCollectionV1 =
      MplCoreProgramInstruction(13, 'BurnCollectionV1');
  static const MplCoreProgramInstruction transferV1 = MplCoreProgramInstruction(
    14,
    'TransferV1',
  );
  static const MplCoreProgramInstruction updateV1 = MplCoreProgramInstruction(
    15,
    'UpdateV1',
  );
  static const MplCoreProgramInstruction updateCollectionV1 =
      MplCoreProgramInstruction(16, 'UpdateCollectionV1');
  static const MplCoreProgramInstruction compressV1 = MplCoreProgramInstruction(
    17,
    'CompressV1',
  );
  static const MplCoreProgramInstruction decompressV1 =
      MplCoreProgramInstruction(18, 'DecompressV1');
  static const MplCoreProgramInstruction collect = MplCoreProgramInstruction(
    19,
    'Collect',
  );
  static const MplCoreProgramInstruction createV2 = MplCoreProgramInstruction(
    20,
    'CreateV2',
  );
  static const MplCoreProgramInstruction createCollectionV2 =
      MplCoreProgramInstruction(21, 'CreateCollectionV2');
  static const MplCoreProgramInstruction addExternalPluginAdapterV1 =
      MplCoreProgramInstruction(22, 'AddExternalPluginAdapterV1');
  static const MplCoreProgramInstruction addCollectionExternalPluginAdapterV1 =
      MplCoreProgramInstruction(23, 'AddCollectionExternalPluginAdapterV1');
  static const MplCoreProgramInstruction removeExternalPluginAdapterV1 =
      MplCoreProgramInstruction(24, 'RemoveExternalPluginAdapterV1');
  static const MplCoreProgramInstruction
  removeCollectionExternalPluginAdapterV1 = MplCoreProgramInstruction(
    25,
    'RemoveCollectionExternalPluginAdapterV1',
  );
  static const MplCoreProgramInstruction updateExternalPluginAdapterV1 =
      MplCoreProgramInstruction(26, 'UpdateExternalPluginAdapterV1');
  static const MplCoreProgramInstruction
  updateCollectionExternalPluginAdapterV1 = MplCoreProgramInstruction(
    27,
    'UpdateCollectionExternalPluginAdapterV1',
  );
  static const MplCoreProgramInstruction writeExternalPluginAdapterDataV1 =
      MplCoreProgramInstruction(28, 'WriteExternalPluginAdapterDataV1');
  static const MplCoreProgramInstruction
  writeCollectionExternalPluginAdapterDataV1 = MplCoreProgramInstruction(
    29,
    'WriteCollectionExternalPluginAdapterDataV1',
  );
  static const MplCoreProgramInstruction updateV2 = MplCoreProgramInstruction(
    30,
    'UpdateV2',
  );
  static const MplCoreProgramInstruction executeV1 = MplCoreProgramInstruction(
    31,
    'ExecuteV1',
  );
  static const MplCoreProgramInstruction updateCollectionInfoV1 =
      MplCoreProgramInstruction(32, 'UpdateCollectionInfoV1');
  static const MplCoreProgramInstruction addCollectionsToGroupV1 =
      MplCoreProgramInstruction(33, 'AddCollectionsToGroupV1');
  static const MplCoreProgramInstruction removeCollectionsFromGroupV1 =
      MplCoreProgramInstruction(34, 'RemoveCollectionsFromGroupV1');
  static const MplCoreProgramInstruction addAssetsToGroupV1 =
      MplCoreProgramInstruction(35, 'AddAssetsToGroupV1');
  static const MplCoreProgramInstruction removeAssetsFromGroupV1 =
      MplCoreProgramInstruction(36, 'RemoveAssetsFromGroupV1');
  static const MplCoreProgramInstruction addGroupsToGroupV1 =
      MplCoreProgramInstruction(37, 'AddGroupsToGroupV1');
  static const MplCoreProgramInstruction removeGroupsFromGroupV1 =
      MplCoreProgramInstruction(38, 'RemoveGroupsFromGroupV1');
  static const MplCoreProgramInstruction createGroupV1 =
      MplCoreProgramInstruction(39, 'CreateGroupV1');
  static const MplCoreProgramInstruction closeGroupV1 =
      MplCoreProgramInstruction(40, 'CloseGroupV1');
  static const MplCoreProgramInstruction updateGroupV1 =
      MplCoreProgramInstruction(41, 'UpdateGroupV1');

  static const List<MplCoreProgramInstruction> values = [
    createV1,
    createCollectionV1,
    addPluginV1,
    addCollectionPluginV1,
    removePluginV1,
    removeCollectionPluginV1,
    updatePluginV1,
    updateCollectionPluginV1,
    approvePluginAuthorityV1,
    approveCollectionPluginAuthorityV1,
    revokePluginAuthorityV1,
    revokeCollectionPluginAuthorityV1,
    burnV1,
    burnCollectionV1,
    transferV1,
    updateV1,
    updateCollectionV1,
    compressV1,
    decompressV1,
    collect,
    createV2,
    createCollectionV2,
    addExternalPluginAdapterV1,
    addCollectionExternalPluginAdapterV1,
    removeExternalPluginAdapterV1,
    removeCollectionExternalPluginAdapterV1,
    updateExternalPluginAdapterV1,
    updateCollectionExternalPluginAdapterV1,
    writeExternalPluginAdapterDataV1,
    writeCollectionExternalPluginAdapterDataV1,
    updateV2,
    executeV1,
    updateCollectionInfoV1,
    addCollectionsToGroupV1,
    removeCollectionsFromGroupV1,
    addAssetsToGroupV1,
    removeAssetsFromGroupV1,
    addGroupsToGroupV1,
    removeGroupsFromGroupV1,
    createGroupV1,
    closeGroupV1,
    updateGroupV1,
  ];

  static MplCoreProgramInstruction? getInstruction(dynamic value) {
    for (final e in values) {
      if (e.instruction == value) return e;
    }
    return null;
  }

  @override
  String get programName => 'MplCore';

  @override
  SolAddress get programAddress => MplCoreProgramConst.programId;
}
