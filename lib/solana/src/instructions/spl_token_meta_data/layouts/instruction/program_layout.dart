import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/instructions/spl_token_meta_data/layouts/layouts.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

abstract class SPLTokenMetaDataProgramLayout extends ProgramLayout {
  /// Getter for instruction (to be implemented by subclasses)
  @override
  abstract final List<int> instruction;

  const SPLTokenMetaDataProgramLayout();
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.blob(8, property: "instruction")]);
  static ProgramLayout fromBytes(List<int> data) {
    try {
      final decode =
          ProgramLayout.decodeAndValidateStruct(layout: _layout, bytes: data);
      final instruction = SPLTokenMetaDataProgramSplDiscriminate.getInstruction(
          decode["instruction"]);
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
    } catch (e) {
      return UnknownProgramLayout(data);
    }
  }

  /// Static method to decode and validate the structure
  static Map<String, dynamic> decodeAndValidateStruct({
    required Structure layout,
    required List<int> bytes,
    required List<int> instructionBytes,
  }) {
    final decode = layout.decode(bytes);
    final instcutionData = decode["instruction"];
    if (!bytesEqual(instcutionData, instructionBytes)) {
      throw MessageException("invalid instruction bytes", details: {
        "expected": BytesUtils.toHexString(instructionBytes),
        "instruction": BytesUtils.toBinary(instcutionData)
      });
    }

    return decode;
  }
}
