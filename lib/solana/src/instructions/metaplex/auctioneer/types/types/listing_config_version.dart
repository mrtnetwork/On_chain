import 'package:on_chain/solana/src/exception/exception.dart';

class ListingConfigVersion {
  final String name;
  final int value;
  const ListingConfigVersion({required this.name, required this.value});
  static const ListingConfigVersion v0 =
      ListingConfigVersion(name: "V0", value: 0);

  static const List<ListingConfigVersion> values = [v0];
  static ListingConfigVersion fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw SolanaPluginException(
          "No ListingConfigVersion found matching the specified value",
          details: {"value": value}),
    );
  }

  @override
  String toString() {
    return "ListingConfigVersion.$name";
  }
}
