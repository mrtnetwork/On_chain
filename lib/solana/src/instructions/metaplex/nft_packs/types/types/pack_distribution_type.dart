import 'package:on_chain/solana/src/exception/exception.dart';

class PackDistributionType {
  final String name;
  final int value;
  const PackDistributionType._(this.name, this.value);

  static const maxSupply = PackDistributionType._("MaxSupply", 0);
  static const fixed = PackDistributionType._("Fixed", 1);
  static const unlimited = PackDistributionType._("Unlimited", 2);
  static const List<PackDistributionType> values = [
    maxSupply,
    fixed,
    unlimited
  ];
  static PackDistributionType fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw SolanaPluginException(
          "No PackDistributionType found matching the specified value",
          details: {"value": value}),
    );
  }

  @override
  String toString() {
    return "PackDistributionType.$name";
  }
}
