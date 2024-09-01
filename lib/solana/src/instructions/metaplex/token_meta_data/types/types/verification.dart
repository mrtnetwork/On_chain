import 'package:on_chain/solana/src/exception/exception.dart';

class Verification {
  final String name;
  final int value;
  const Verification._(this.name, this.value);
  static const Verification creatorV1 = Verification._("CreatorV1", 0);
  static const Verification collectionV1 = Verification._("CollectionV1", 1);

  static const List<Verification> values = [creatorV1, collectionV1];

  static Verification fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw SolanaPluginException(
          "No MetaDataTokenStandard found matching the specified value",
          details: {"value": value}),
    );
  }

  static Verification fromName(String? value) {
    return values.firstWhere(
      (element) => element.name == value,
      orElse: () => throw SolanaPluginException(
          "No Verification found matching the specified value",
          details: {"value": value}),
    );
  }

  @override
  String toString() {
    return "Verification.$name";
  }
}
