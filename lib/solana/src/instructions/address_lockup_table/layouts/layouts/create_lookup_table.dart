import 'package:on_chain/solana/src/instructions/address_lockup_table/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/core/core.dart';
import 'package:on_chain/solana/src/layout/program_layouts/core/program_layout.dart';
import 'package:on_chain/solana/src/layout/utils/layout_utils.dart';

/// Structure for the AddressLookupCreateLookupTable instruction.
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

  // Structure layout definition.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u32("instruction"),
    LayoutUtils.u64("recentSlot"),
    LayoutUtils.u8("bumpSeed")
  ]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      AddressLookupTableProgramInstruction.createLookupTable.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"recentSlot": recentSlot, "bumpSeed": bumpSeed};
  }
}
