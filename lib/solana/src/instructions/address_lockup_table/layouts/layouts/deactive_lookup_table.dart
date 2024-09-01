import 'package:on_chain/solana/src/instructions/address_lockup_table/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// StructLayout for the AddressLookupDeactiveLookupTable instruction.
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
    return const AddressLookupDeactiveLookupTableLayout();
  }

  // StructLayout layout definition.
  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.u32(property: "instruction")]);

  @override
  StructLayout get layout => _layout;

  @override
  AddressLookupTableProgramInstruction get instruction =>
      AddressLookupTableProgramInstruction.deactivateLookupTable;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
