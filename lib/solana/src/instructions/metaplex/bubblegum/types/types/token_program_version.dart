import 'package:blockchain_utils/exception/exception.dart';

class TokenProgramVersion {
  final String name;
  final int value;
  const TokenProgramVersion._(this.name, this.value);

  static const TokenProgramVersion orginal =
      TokenProgramVersion._("Original", 0);
  static const TokenProgramVersion token2022 =
      TokenProgramVersion._("Token2022", 1);
  static const List<TokenProgramVersion> values = [orginal, token2022];
  static TokenProgramVersion fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw MessageException(
          "No TokenProgramVersion found matching the specified value",
          details: {"value": value}),
    );
  }

  @override
  String toString() {
    return "TokenProgramVersion.$name";
  }
}
