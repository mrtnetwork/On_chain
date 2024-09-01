import 'package:on_chain/solana/src/exception/exception.dart';

class TokenStandard {
  final String name;
  final int value;
  const TokenStandard._(this.name, this.value);
  static const TokenStandard nonFungible = TokenStandard._("NonFungible", 0);
  static const TokenStandard fungibleAsset =
      TokenStandard._("FungibleAsset", 1);
  static const TokenStandard fungible = TokenStandard._("Fungible", 2);
  static const TokenStandard nonFungibleEdition =
      TokenStandard._("NonFungibleEdition", 3);
  static const List<TokenStandard> values = [
    nonFungible,
    fungibleAsset,
    fungible,
    nonFungibleEdition
  ];
  static TokenStandard fromValue(int? value) {
    try {
      return values.firstWhere((element) => element.value == value);
    } on StateError {
      throw SolanaPluginException(
          "No TokenStandard found matching the specified value",
          details: {"value": value});
    }
  }

  @override
  String toString() {
    return "TokenStandard.$name";
  }
}
