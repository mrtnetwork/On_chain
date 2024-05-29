import 'package:on_chain/solana/src/instructions/address_lockup_table/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// StructLayout for the AddressLookupCloseLookupTable instruction.
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
    return const AddressLookupCloseLookupTableLayout();
  }

  /// StructLayout layout definition.
  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.u32(property: "instruction")]);

  @override
  StructLayout get layout => _layout;

  @override
  int get instruction =>
      AddressLookupTableProgramInstruction.closeLookupTable.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
