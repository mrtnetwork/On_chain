import 'package:on_chain/solana/src/instructions/address_lockup_table/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Structure for the AddressLookupFreezeLookupTable instruction.
class AddressLookupFreezeLookupTableLayout
    extends AddressLookupTableProgramLayout {
  const AddressLookupFreezeLookupTableLayout();

  /// Constructs the layout from raw bytes.
  factory AddressLookupFreezeLookupTableLayout.fromBuffer(List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            AddressLookupTableProgramInstruction.freezeLookupTable.insturction);
    return AddressLookupFreezeLookupTableLayout();
  }

  // Structure layout definition.
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u32("instruction")]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      AddressLookupTableProgramInstruction.freezeLookupTable.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
