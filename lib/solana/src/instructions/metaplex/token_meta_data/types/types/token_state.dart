import 'package:blockchain_utils/exception/exception.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class TokenState extends LayoutSerializable {
  final String name;
  const TokenState._(this.name);
  static const TokenState unlocked = TokenState._("Unlocked");
  static const TokenState locked = TokenState._("Locked");
  static const TokenState listed = TokenState._("Listed");

  static const List<TokenState> values = [unlocked, locked, listed];

  factory TokenState.fromJson(Map<String, dynamic> json) {
    return TokenState.fromName(json["tokenState"]["key"]);
  }

  factory TokenState.fromName(String? value) {
    return values.firstWhere(
      (element) => element.name == value,
      orElse: () => throw MessageException(
          "No TokenState found matching the specified value",
          details: {"value": value}),
    );
  }

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.rustEnum(
        values.map((e) => LayoutUtils.none(e.name)).toList(), LayoutUtils.u8(),
        property: "tokenState")
  ]);
  @override
  String toString() {
    return "TokenState.$name";
  }

  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "tokenState": {name: null}
    };
  }
}
