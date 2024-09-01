import 'package:on_chain/solana/src/exception/exception.dart';

class UseMethod {
  final String name;
  final int value;
  const UseMethod._(this.name, this.value);
  static const UseMethod burn = UseMethod._("Burn", 0);
  static const UseMethod multiple = UseMethod._("Multiple", 1);
  static const UseMethod single = UseMethod._("Single", 2);
  static const List<UseMethod> values = [burn, multiple, single];
  static UseMethod fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw SolanaPluginException(
          "No UsesMethod found matching the specified value",
          details: {"value": value}),
    );
  }

  @override
  String toString() {
    return "UseMethod.$name";
  }
}
