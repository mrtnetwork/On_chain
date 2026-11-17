import 'package:blockchain_utils/encoding/encoding.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/mpl_core/layouts/instruction/instructions.dart';
import 'package:on_chain/solana/src/instructions/mpl_core/layouts/layouts/mpl_core_layouts.dart';

/// Full MPL Core decode dispatch (0-41).
abstract class MplCoreProgramLayout extends ProgramLayout {
  const MplCoreProgramLayout();

  static StructLayout get _layout =>
      LayoutConst.struct([LayoutConst.u8(property: 'instruction')]);

  static ProgramLayout fromBytes(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: data,
    );
    final MplCoreProgramInstruction? instruction =
        MplCoreProgramInstruction.getInstruction(decode['instruction']);
    switch (instruction) {
      case MplCoreProgramInstruction.createV1:
        return MplCoreCreateV1Layout.fromBuffer(data);
      case MplCoreProgramInstruction.createCollectionV1:
        return MplCoreCreateCollectionV1Layout.fromBuffer(data);
      case MplCoreProgramInstruction.addPluginV1:
      case MplCoreProgramInstruction.addCollectionPluginV1:
      case MplCoreProgramInstruction.updatePluginV1:
      case MplCoreProgramInstruction.updateCollectionPluginV1:
      case MplCoreProgramInstruction.addExternalPluginAdapterV1:
      case MplCoreProgramInstruction.addCollectionExternalPluginAdapterV1:
      case MplCoreProgramInstruction.updateExternalPluginAdapterV1:
      case MplCoreProgramInstruction.updateCollectionExternalPluginAdapterV1:
      case MplCoreProgramInstruction.removeExternalPluginAdapterV1:
      case MplCoreProgramInstruction.removeCollectionExternalPluginAdapterV1:
      case MplCoreProgramInstruction.writeExternalPluginAdapterDataV1:
      case MplCoreProgramInstruction.writeCollectionExternalPluginAdapterDataV1:
      case MplCoreProgramInstruction.decompressV1:
        if (instruction == null) return UnknownProgramLayout(data);
        return MplCoreRawArgsLayout.fromBuffer(data, instruction);
      case MplCoreProgramInstruction.removePluginV1:
      case MplCoreProgramInstruction.removeCollectionPluginV1:
        return MplCoreRemovePluginLayout.fromBuffer(data, instruction!);
      case MplCoreProgramInstruction.approvePluginAuthorityV1:
      case MplCoreProgramInstruction.approveCollectionPluginAuthorityV1:
        return MplCoreApprovePluginAuthorityLayout.fromBuffer(
          data,
          instruction!,
        );
      case MplCoreProgramInstruction.revokePluginAuthorityV1:
      case MplCoreProgramInstruction.revokeCollectionPluginAuthorityV1:
        return MplCoreRevokePluginAuthorityLayout.fromBuffer(
          data,
          instruction!,
        );
      case MplCoreProgramInstruction.burnV1:
      case MplCoreProgramInstruction.burnCollectionV1:
      case MplCoreProgramInstruction.transferV1:
        return MplCoreCompressionProofLayout.fromBuffer(data, instruction!);
      case MplCoreProgramInstruction.updateV1:
      case MplCoreProgramInstruction.updateV2:
        return MplCoreUpdateLayout.fromBuffer(data, instruction!);
      case MplCoreProgramInstruction.updateCollectionV1:
      case MplCoreProgramInstruction.updateGroupV1:
        return MplCoreUpdateNameUriLayout.fromBuffer(data, instruction!);
      case MplCoreProgramInstruction.compressV1:
      case MplCoreProgramInstruction.collect:
      case MplCoreProgramInstruction.addCollectionsToGroupV1:
      case MplCoreProgramInstruction.addAssetsToGroupV1:
      case MplCoreProgramInstruction.closeGroupV1:
        return MplCoreEmptyLayout.fromBuffer(data, instruction!);
      case MplCoreProgramInstruction.createV2:
        return MplCoreCreateV2Layout.fromBuffer(data);
      case MplCoreProgramInstruction.createCollectionV2:
        return MplCoreCreateCollectionV2Layout.fromBuffer(data);
      case MplCoreProgramInstruction.executeV1:
        return MplCoreExecuteV1Layout.fromBuffer(data);
      case MplCoreProgramInstruction.updateCollectionInfoV1:
        return MplCoreUpdateCollectionInfoV1Layout.fromBuffer(data);
      case MplCoreProgramInstruction.removeCollectionsFromGroupV1:
      case MplCoreProgramInstruction.removeAssetsFromGroupV1:
      case MplCoreProgramInstruction.addGroupsToGroupV1:
      case MplCoreProgramInstruction.removeGroupsFromGroupV1:
        return MplCorePubkeyVecLayout.fromBuffer(data, instruction!);
      case MplCoreProgramInstruction.createGroupV1:
        return MplCoreCreateGroupV1Layout.fromBuffer(data);
      default:
        return UnknownProgramLayout(data);
    }
  }
}
