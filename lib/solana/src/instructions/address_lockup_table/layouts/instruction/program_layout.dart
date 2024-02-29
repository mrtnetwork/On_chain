import 'package:on_chain/solana/src/instructions/address_lockup_table/layouts/layouts.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

abstract class AddressLookupTableProgramLayout extends ProgramLayout {
  const AddressLookupTableProgramLayout();
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u32("instruction")]);
  static ProgramLayout fromBytes(List<int> data) {
    try {
      final decode =
          ProgramLayout.decodeAndValidateStruct(layout: _layout, bytes: data);
      final instruction = AddressLookupTableProgramInstruction.getInstruction(
          decode["instruction"]);
      switch (instruction) {
        case AddressLookupTableProgramInstruction.closeLookupTable:
          return AddressLookupCloseLookupTableLayout.fromBuffer(data);
        case AddressLookupTableProgramInstruction.freezeLookupTable:
          return AddressLookupFreezeLookupTableLayout.fromBuffer(data);
        case AddressLookupTableProgramInstruction.createLookupTable:
          return AddressLookupCreateLookupTableLayout.fromBuffer(data);
        case AddressLookupTableProgramInstruction.extendLookupTable:
          return AddressExtendLookupTableLayout.fromBuffer(data);
        case AddressLookupTableProgramInstruction.deactivateLookupTable:
          return AddressLookupDeactiveLookupTableLayout.fromBuffer(data);
        default:
          return UnknownProgramLayout(data);
      }
    } catch (e) {
      return UnknownProgramLayout(data);
    }
  }
}
