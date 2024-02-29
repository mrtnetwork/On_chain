import 'package:on_chain/solana/src/instructions/address_lockup_table/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Structure for the AddressLookupDeactiveLookupTable instruction.
class AddressLookupDeactiveLookupTableLayout
    extends AddressLookupTableProgramLayout {
  const AddressLookupDeactiveLookupTableLayout();

  /// Constructs the layout from raw bytes.
  factory AddressLookupDeactiveLookupTableLayout.fromBuffer(List<int> data) {
    // Decode and validate the structure.
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: AddressLookupTableProgramInstruction
            .deactivateLookupTable.insturction);
    return AddressLookupDeactiveLookupTableLayout();
  }

  // Structure layout definition.
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u32("instruction")]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      AddressLookupTableProgramInstruction.deactivateLookupTable.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
