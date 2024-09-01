import 'package:on_chain/solana/src/exception/exception.dart';

class TransferFeeInstructionInstruction {
  const TransferFeeInstructionInstruction._(this.name, this.value);
  final String name;
  final int value;
  static const TransferFeeInstructionInstruction initializeTransferFeeConfig =
      TransferFeeInstructionInstruction._("InitializeTransferFeeConfig", 0);
  static const TransferFeeInstructionInstruction transferCheckedWithFee =
      TransferFeeInstructionInstruction._("TransferCheckedWithFee", 1);
  static const TransferFeeInstructionInstruction
      withdrawWithheldTokensFromMint =
      TransferFeeInstructionInstruction._("WithdrawWithheldTokensFromMint", 2);
  static const TransferFeeInstructionInstruction
      withdrawWithheldTokensFromAccounts = TransferFeeInstructionInstruction._(
          "WithdrawWithheldTokensFromAccounts", 3);
  static const TransferFeeInstructionInstruction harvestWithheldTokensToMint =
      TransferFeeInstructionInstruction._("HarvestWithheldTokensToMint", 4);
  static const TransferFeeInstructionInstruction setTransferFee =
      TransferFeeInstructionInstruction._("SetTransferFee", 5);
  static const List<TransferFeeInstructionInstruction> values = [
    initializeTransferFeeConfig,
    transferCheckedWithFee,
    withdrawWithheldTokensFromMint,
    withdrawWithheldTokensFromAccounts,
    harvestWithheldTokensToMint,
    setTransferFee
  ];

  static TransferFeeInstructionInstruction fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw SolanaPluginException(
          "No TransferFeeInstructionInstruction found matching the specified value",
          details: {"value": value}),
    );
  }
}
