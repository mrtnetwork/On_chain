import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/address_lockup_table/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

/// StructLayout for the AddressExtendLookupTable instruction.
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
        addresses: (decode['addresses'] as List).cast<SolAddress>());
  }

  // StructLayout layout definition.
  static StructLayout get _layout => LayoutConst.struct([
        LayoutConst.u32(property: 'instruction'),
        LayoutConst.padding(LayoutConst.u64(), propery: 'paddingLength'),
        LayoutConst.seq(
          SolanaLayoutUtils.publicKey('publicKey'),
          LayoutConst.rustVecOffset(),
          property: 'addresses',
        )
      ]);

  @override
  StructLayout get layout => _layout;

  @override
  AddressLookupTableProgramInstruction get instruction =>
      AddressLookupTableProgramInstruction.extendLookupTable;

  @override
  Map<String, dynamic> serialize() {
    return {'addresses': addresses};
  }

  @override
  Map<String, dynamic> toJson() {
    return {'addresses': addresses.map((e) => e.address).toList()};
  }
}
