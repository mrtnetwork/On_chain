import 'package:on_chain/solana/src/exception/exception.dart';

class FreezeInstruction {
  final String name;
  final int value;

  const FreezeInstruction._(this.name, this.value);

  static const FreezeInstruction initialize =
      FreezeInstruction._("Initialize", 0);
  static const FreezeInstruction thaw = FreezeInstruction._("Thaw", 1);
  static const FreezeInstruction unlockFunds =
      FreezeInstruction._("UnlockFunds", 2);

  static const List<FreezeInstruction> values = [initialize, thaw, unlockFunds];

  static FreezeInstruction fromValue(int value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw SolanaPluginException(
          "No FreezeInstruction found matching the specified value",
          details: {"value": value}),
    );
  }
}
