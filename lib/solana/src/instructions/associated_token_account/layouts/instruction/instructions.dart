import 'package:on_chain/solana/src/layout/layout.dart';

class AssociatedTokenAccountProgramInstruction
    implements ProgramLayoutInstruction {
  @override
  final int? insturction;
  @override
  final String name;
  const AssociatedTokenAccountProgramInstruction(this.insturction, this.name);
  static const AssociatedTokenAccountProgramInstruction initialize =
      AssociatedTokenAccountProgramInstruction(null, "Initialize");
  static const AssociatedTokenAccountProgramInstruction idempotent =
      AssociatedTokenAccountProgramInstruction(1, "Idempotent");
  static const AssociatedTokenAccountProgramInstruction recoverNested =
      AssociatedTokenAccountProgramInstruction(2, "RcoverNested");
  static const List<AssociatedTokenAccountProgramInstruction> values = [
    initialize,
    idempotent,
    recoverNested
  ];
  static AssociatedTokenAccountProgramInstruction? getInstruction(
      dynamic value) {
    try {
      return values.firstWhere((element) => element.insturction == value);
    } on StateError {
      return null;
    }
  }
}
