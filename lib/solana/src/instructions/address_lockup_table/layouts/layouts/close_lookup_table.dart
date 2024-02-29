import 'package:on_chain/solana/src/instructions/address_lockup_table/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Structure for the AddressLookupCloseLookupTable instruction.
class AddressLookupCloseLookupTableLayout
    extends AddressLookupTableProgramLayout {
  const AddressLookupCloseLookupTableLayout();

  /// Constructs the layout from raw bytes.
  factory AddressLookupCloseLookupTableLayout.fromBuffer(List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            AddressLookupTableProgramInstruction.closeLookupTable.insturction);
    return AddressLookupCloseLookupTableLayout();
  }

  /// Structure layout definition.
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u32("instruction")]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      AddressLookupTableProgramInstruction.closeLookupTable.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
