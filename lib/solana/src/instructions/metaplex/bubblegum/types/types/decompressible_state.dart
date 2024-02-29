import 'package:blockchain_utils/exception/exception.dart';

class DecompressibleState {
  final String name;
  final int value;
  const DecompressibleState._(this.name, this.value);
  static const DecompressibleState enabled =
      DecompressibleState._("Enabled", 0);
  static const DecompressibleState disabled =
      DecompressibleState._("Disabled", 1);
  static const List<DecompressibleState> values = [enabled, disabled];
  static DecompressibleState fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw MessageException(
          "No DecompressibleState found matching the specified value",
          details: {"value": value}),
    );
  }

  @override
  String toString() {
    return "DecompressibleState.$name";
  }
}
