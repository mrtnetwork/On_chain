import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/system/constant.dart';

class SystemProgramInstruction implements ProgramLayoutInstruction {
  @override
  final int insturction;
  @override
  final String name;
  const SystemProgramInstruction(this.insturction, this.name);
  static const SystemProgramInstruction create =
      SystemProgramInstruction(0, "Create");
  static const SystemProgramInstruction assign =
      SystemProgramInstruction(1, "Assign");
  static const SystemProgramInstruction transfer =
      SystemProgramInstruction(2, "Transfer");

  static const SystemProgramInstruction createWithSeed =
      SystemProgramInstruction(3, "CreateWithSeed");

  static const SystemProgramInstruction advanceNonceAccount =
      SystemProgramInstruction(4, "AdvanceNonceAccount");
  static const SystemProgramInstruction withdrawNonceAccount =
      SystemProgramInstruction(5, "WithdrawNonceAccount");
  static const SystemProgramInstruction initializeNonceAccount =
      SystemProgramInstruction(6, "InitializeNonceAccount");
  static const SystemProgramInstruction authorizeNonceAccount =
      SystemProgramInstruction(7, "AuthorizeNonceAccount");
  static const SystemProgramInstruction allocate =
      SystemProgramInstruction(8, "Allocate");
  static const SystemProgramInstruction allocateWithSeed =
      SystemProgramInstruction(9, "AllocateWithSeed");
  static const SystemProgramInstruction assignWithSeed =
      SystemProgramInstruction(10, "AssignWithSeed");
  static const SystemProgramInstruction transferWithSeed =
      SystemProgramInstruction(11, "TransferWithSeed");
  static const SystemProgramInstruction upgradeNonceAccount =
      SystemProgramInstruction(12, "UpgradeNonceAccount");

  static const List<SystemProgramInstruction> values = [
    create,
    assign,
    transfer,
    createWithSeed,
    advanceNonceAccount,
    withdrawNonceAccount,
    initializeNonceAccount,
    authorizeNonceAccount,
    allocate,
    allocateWithSeed,
    assignWithSeed,
    transferWithSeed,
    upgradeNonceAccount
  ];
  static SystemProgramInstruction? getInstruction(dynamic value) {
    try {
      return values.firstWhere((element) => element.insturction == value);
    } catch (e) {
      return null;
    }
  }

  @override
  String get programName => "System";
  @override
  SolAddress get programAddress => SystemProgramConst.programId;
}
