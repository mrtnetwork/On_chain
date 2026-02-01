import 'package:blockchain_utils/utils/utils.dart';

import 'package:on_chain/solana/src/exception/exception.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/instructions/spl_token_meta_data/layouts/layouts.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

abstract class SPLTokenMetaDataProgramLayout extends ProgramLayout {
  /// Getter for instruction (to be implemented by subclasses)
  @override
  abstract final SPLTokenMetaDataProgramSplDiscriminate instruction;

  const SPLTokenMetaDataProgramLayout();
  static StructLayout get _layout =>
      LayoutConst.struct([LayoutConst.blob(8, property: 'instruction')]);
  static ProgramLayout fromBytes(List<int> data) {
    final decode =
        ProgramLayout.decodeAndValidateStruct(layout: _layout, bytes: data);
    final instruction = SPLTokenMetaDataProgramSplDiscriminate.getInstruction(
        decode['instruction']);
    switch (instruction) {
      case SPLTokenMetaDataProgramSplDiscriminate.emit:
        return SPLTokenMetaDataEmitLayout.fromBuffer(data);
      case SPLTokenMetaDataProgramSplDiscriminate.initialize:
        return SPLTokenMetaDataInitializeLayout.fromBuffer(data);
      case SPLTokenMetaDataProgramSplDiscriminate.update:
        return SPLTokenMetaDataUpdateLayout.fromBuffer(data);
      case SPLTokenMetaDataProgramSplDiscriminate.remove:
        return SPLTokenMetaDataRemoveFieldLayout.fromBuffer(data);
      case SPLTokenMetaDataProgramSplDiscriminate.updateAuthority:
        return SPLTokenMetaDataUpdateAuthorityLayout.fromBuffer(data);
      default:
        return UnknownProgramLayout(data);
    }
  }

  /// Static method to decode and validate the structure
  static Map<String, dynamic> decodeAndValidateStruct({
    required StructLayout layout,
    required List<int> bytes,
    required List<int> instructionBytes,
  }) {
    final decode = layout.deserialize(bytes).value;
    final instcutionData = decode['instruction'];
    if (!BytesUtils.bytesEqual(instcutionData, instructionBytes)) {
      throw SolanaPluginException('invalid instruction bytes', details: {
        'expected': BytesUtils.toHexString(instructionBytes),
        'instruction': BytesUtils.toBinary(instcutionData)
      });
    }

    return decode;
  }
}
