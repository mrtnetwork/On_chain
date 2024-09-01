import 'package:on_chain/solana/src/exception/exception.dart';

class PackSetState {
  final String name;
  final int value;
  const PackSetState._(this.name, this.value);

  static const notActivated = PackSetState._("NotActivated", 0);
  static const activated = PackSetState._("Activated", 1);
  static const deactivated = PackSetState._("Deactivated", 2);
  static const ended = PackSetState._("Ended", 3);

  static const List<PackSetState> values = [
    notActivated,
    activated,
    deactivated,
    ended
  ];
  static PackSetState fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw SolanaPluginException(
          "No PackSetState found matching the specified value",
          details: {"value": value}),
    );
  }

  @override
  String toString() {
    return "PackSetState.$name";
  }
}
