import 'package:blockchain_utils/helper/extensions/extensions.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/address_lockup_table/constant.dart';

class AddressLookupTableProgramInstruction implements ProgramLayoutInstruction {
  @override
  final int insturction;
  @override
  final String name;
  const AddressLookupTableProgramInstruction(this.insturction, this.name);
  static const AddressLookupTableProgramInstruction createLookupTable =
      AddressLookupTableProgramInstruction(0, 'CreateLookupTable');
  static const AddressLookupTableProgramInstruction freezeLookupTable =
      AddressLookupTableProgramInstruction(1, 'FreezeLookupTable');
  static const AddressLookupTableProgramInstruction extendLookupTable =
      AddressLookupTableProgramInstruction(2, 'ExtendLookupTable');
  static const AddressLookupTableProgramInstruction deactivateLookupTable =
      AddressLookupTableProgramInstruction(3, 'DeactivateLookupTable');
  static const AddressLookupTableProgramInstruction closeLookupTable =
      AddressLookupTableProgramInstruction(4, 'CloseLookupTable');
  static const List<AddressLookupTableProgramInstruction> values = [
    createLookupTable,
    freezeLookupTable,
    extendLookupTable,
    deactivateLookupTable,
    closeLookupTable,
  ];
  static AddressLookupTableProgramInstruction? getInstruction(dynamic value) {
    return values.firstWhereNullable((element) => element.insturction == value);
  }

  @override
  String get programName => 'AddressLookupTable';

  @override
  SolAddress get programAddress => AddressLookupTableProgramConst.programId;
}
