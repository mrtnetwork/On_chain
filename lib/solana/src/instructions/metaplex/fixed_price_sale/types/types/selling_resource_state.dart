import 'package:blockchain_utils/exception/exception.dart';

class SellingResourceState {
  final String name;
  final int value;
  const SellingResourceState._(this.name, this.value);
  static const SellingResourceState uninitialized =
      SellingResourceState._("Uninitialized", 0);
  static const SellingResourceState created =
      SellingResourceState._("Created", 1);
  static const SellingResourceState inUse = SellingResourceState._("InUse", 2);
  static const SellingResourceState exhausted =
      SellingResourceState._("Exhausted", 3);
  static const SellingResourceState stopped =
      SellingResourceState._("Stopped", 4);
  static const List<SellingResourceState> values = [
    uninitialized,
    created,
    inUse,
    exhausted,
    stopped
  ];
  static SellingResourceState fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw MessageException(
          "No SellingResourceState found matching the specified value",
          details: {"value": value}),
    );
  }

  @override
  String toString() {
    return "SellingResourceState.$name";
  }
}
