import 'package:blockchain_utils/exception/exception.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class TokenDelegateRole extends LayoutSerializable {
  final String name;
  const TokenDelegateRole._(this.name);
  static const TokenDelegateRole sale = TokenDelegateRole._("Sale");
  static const TokenDelegateRole transfer = TokenDelegateRole._("Transfer");
  static const TokenDelegateRole utility = TokenDelegateRole._("Utility");
  static const TokenDelegateRole staking = TokenDelegateRole._("Staking");
  static const TokenDelegateRole standard = TokenDelegateRole._("Standard");
  static const TokenDelegateRole lockedTransfer =
      TokenDelegateRole._("LockedTransfer");
  static const TokenDelegateRole migration = TokenDelegateRole._("Migration");
  static const List<TokenDelegateRole> values = [
    sale,
    transfer,
    utility,
    staking,
    standard,
    lockedTransfer,
    migration
  ];

  factory TokenDelegateRole.fromJson(Map<String, dynamic> json) {
    return TokenDelegateRole.fromName(json["tokenDelegateRole"]["key"]);
  }

  factory TokenDelegateRole.fromName(String? value) {
    return values.firstWhere(
      (element) => element.name == value,
      orElse: () => throw MessageException(
          "No TokenDelegateRole found matching the specified value",
          details: {"value": value}),
    );
  }

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.rustEnum(
        values.map((e) => LayoutUtils.none(e.name)).toList(), LayoutUtils.u8(),
        property: "tokenDelegateRole")
  ]);
  @override
  String toString() {
    return "TokenDelegateRole.$name";
  }

  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "tokenDelegateRole": {name: null}
    };
  }
}
