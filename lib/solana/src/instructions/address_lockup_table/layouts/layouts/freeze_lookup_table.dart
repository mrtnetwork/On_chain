import 'package:on_chain/solana/src/instructions/address_lockup_table/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// StructLayout for the AddressLookupFreezeLookupTable instruction.
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
    return const AddressLookupFreezeLookupTableLayout();
  }

  // StructLayout layout definition.
  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.u32(property: 'instruction')]);

  @override
  StructLayout get layout => _layout;

  @override
  AddressLookupTableProgramInstruction get instruction =>
      AddressLookupTableProgramInstruction.freezeLookupTable;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }

  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}
