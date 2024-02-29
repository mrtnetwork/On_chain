import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/address_lockup_table/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/core/core.dart';
import 'package:on_chain/solana/src/layout/program_layouts/core/program_layout.dart';
import 'package:on_chain/solana/src/layout/utils/layout_utils.dart';

/// Structure for the AddressExtendLookupTable instruction.
class AddressExtendLookupTableLayout extends AddressLookupTableProgramLayout {
  /// List of Public Keys to be added to the lookup table.
  final List<SolAddress> addresses;

  /// Constructs the layout with required parameters.
  const AddressExtendLookupTableLayout({required this.addresses});

  /// Constructs the layout from raw bytes.
  factory AddressExtendLookupTableLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            AddressLookupTableProgramInstruction.extendLookupTable.insturction);
    return AddressExtendLookupTableLayout(
        addresses: (decode["addresses"] as List).cast<SolAddress>());
  }

  // Structure layout definition.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u32("instruction"),
    LayoutUtils.u64(),
    LayoutUtils.seq(
      LayoutUtils.publicKey("publicKey"),
      LayoutUtils.offset(LayoutUtils.u32(), -8),
      property: "addresses",
    )
  ]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      AddressLookupTableProgramInstruction.extendLookupTable.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"addresses": addresses};
  }
}
