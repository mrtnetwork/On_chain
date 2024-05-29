import 'package:on_chain/solana/src/instructions/address_lockup_table/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// StructLayout for the AddressLookupCreateLookupTable instruction.
class AddressLookupCreateLookupTableLayout
    extends AddressLookupTableProgramLayout {
  /// A recent slot must be used in the derivation path for each initialized table.
  final BigInt recentSlot;

  /// The bump seed.
  final int bumpSeed;

  /// Constructs the layout with required parameters.
  const AddressLookupCreateLookupTableLayout({
    required this.recentSlot,
    required this.bumpSeed,
  });

  /// Constructs the layout from raw bytes.
  factory AddressLookupCreateLookupTableLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            AddressLookupTableProgramInstruction.createLookupTable.insturction);
    return AddressLookupCreateLookupTableLayout(
        recentSlot: decode["recentSlot"], bumpSeed: decode["bumpSeed"]);
  }

  // StructLayout layout definition.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u32(property: "instruction"),
    LayoutConst.u64(property: "recentSlot"),
    LayoutConst.u8(property: "bumpSeed")
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  int get instruction =>
      AddressLookupTableProgramInstruction.createLookupTable.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"recentSlot": recentSlot, "bumpSeed": bumpSeed};
  }
}
