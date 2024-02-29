import 'package:on_chain/solana/src/instructions/name_service/layouts/layouts.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

abstract class NameServiceProgramLayout extends ProgramLayout {
  const NameServiceProgramLayout();
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u8("instruction")]);
  static ProgramLayout fromBytes(List<int> data) {
    try {
      final decode =
          ProgramLayout.decodeAndValidateStruct(layout: _layout, bytes: data);
      final instruction =
          NameServiceProgramInstruction.getInstruction(decode["instruction"]);
      switch (instruction) {
        case NameServiceProgramInstruction.create:
          return NameServiceCreateLayout.fromBuffer(data);
        case NameServiceProgramInstruction.delete:
          return NameServiceDeleteLayout.fromBuffer(data);
        case NameServiceProgramInstruction.update:
          return NameServiceUpdateLayout.fromBuffer(data);
        case NameServiceProgramInstruction.realloc:
          return NameServiceReallocLayout.fromBuffer(data);
        case NameServiceProgramInstruction.transfer:
          return NameServiceTransferLayout.fromBuffer(data);
        default:
          return UnknownProgramLayout(data);
      }
    } catch (e) {
      return UnknownProgramLayout(data);
    }
  }
}
