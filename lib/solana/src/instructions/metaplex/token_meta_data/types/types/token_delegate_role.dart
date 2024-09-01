import 'package:on_chain/solana/src/exception/exception.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

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
      orElse: () => throw SolanaPluginException(
          "No TokenDelegateRole found matching the specified value",
          details: {"value": value}),
    );
  }

  static final StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.rustEnum(
        values.map((e) => LayoutConst.none(property: e.name)).toList(),
        property: "tokenDelegateRole")
  ]);
  @override
  String toString() {
    return "TokenDelegateRole.$name";
  }

  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "tokenDelegateRole": {name: null}
    };
  }
}
