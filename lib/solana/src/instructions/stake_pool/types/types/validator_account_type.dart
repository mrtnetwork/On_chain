import 'package:blockchain_utils/exception/exception.dart';

class ValidatorAccountType {
  final String name;
  final int value;
  const ValidatorAccountType._(this.name, this.value);
  static const ValidatorAccountType preferred =
      ValidatorAccountType._("Preferred", 0);
  static const ValidatorAccountType active =
      ValidatorAccountType._("Active", 1);
  static const ValidatorAccountType transient =
      ValidatorAccountType._("Transient", 2);
  static const ValidatorAccountType reserve =
      ValidatorAccountType._("Reserve", 3);
  static const List<ValidatorAccountType> values = [
    preferred,
    active,
    transient,
    reserve
  ];

  factory ValidatorAccountType.fromName(String? value) {
    return values.firstWhere(
      (element) => element.name == value,
      orElse: () => throw MessageException(
          "No ValidatorAccountType found matching the specified value",
          details: {"value": value}),
    );
  }
  factory ValidatorAccountType.fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw MessageException(
          "No ValidatorAccountType found matching the specified value",
          details: {"value": value}),
    );
  }

  @override
  String toString() {
    return "ValidatorAccountType.$name";
  }
}
