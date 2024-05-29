import 'package:on_chain/solana/src/instructions/address_lockup_table/layouts/layouts.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

abstract class AddressLookupTableProgramLayout extends ProgramLayout {
  const AddressLookupTableProgramLayout();
  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.u32(property: "instruction")]);
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
