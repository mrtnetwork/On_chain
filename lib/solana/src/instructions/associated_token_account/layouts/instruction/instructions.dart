import 'package:blockchain_utils/helper/extensions/extensions.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/associated_token_account/constant.dart';

class AssociatedTokenAccountProgramInstruction
    implements ProgramLayoutInstruction {
  @override
  final int? insturction;
  @override
  final String name;
  const AssociatedTokenAccountProgramInstruction(this.insturction, this.name);
  static const AssociatedTokenAccountProgramInstruction initialize =
      AssociatedTokenAccountProgramInstruction(null, 'Initialize');
  static const AssociatedTokenAccountProgramInstruction idempotent =
      AssociatedTokenAccountProgramInstruction(1, 'Idempotent');
  static const AssociatedTokenAccountProgramInstruction recoverNested =
      AssociatedTokenAccountProgramInstruction(2, 'RcoverNested');
  static const List<AssociatedTokenAccountProgramInstruction> values = [
    initialize,
    idempotent,
    recoverNested,
  ];
  static AssociatedTokenAccountProgramInstruction? getInstruction(
    dynamic value,
  ) {
    return values.firstWhereNullable((element) => element.insturction == value);
  }

  @override
  String get programName => 'AssociatedTokenAccount';
  @override
  SolAddress get programAddress =>
      AssociatedTokenAccountProgramConst.associatedTokenProgramId;
}
