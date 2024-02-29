import 'package:blockchain_utils/exception/exception.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class SolanaTokenAccountType extends LayoutSerializable {
  const SolanaTokenAccountType._(this.name, this.value);
  final String name;
  final int value;
  static const SolanaTokenAccountType uninitialized =
      SolanaTokenAccountType._("Uninitialized", 0);
  static const SolanaTokenAccountType mint =
      SolanaTokenAccountType._("Mint", 1);
  static const SolanaTokenAccountType account =
      SolanaTokenAccountType._("Account", 2);
  static const List<SolanaTokenAccountType> values = [
    uninitialized,
    mint,
    account
  ];

  static Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.rustEnum(
        values.map((e) => LayoutUtils.none(e.name)).toList(), LayoutUtils.u8(),
        property: "solanaTokenAccountType")
  ]);
  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "solanaTokenAccountType": {name: null}
    };
  }

  factory SolanaTokenAccountType.fromJson(Map<String, dynamic> json) {
    return fromName(json["solanaTokenAccountType"]["key"]);
  }
  static SolanaTokenAccountType fromName(String? value) {
    return values.firstWhere(
      (element) => element.name == value,
      orElse: () => throw MessageException(
          "No SolanaTokenAccountType found matching the specified value",
          details: {"value": value}),
    );
  }

  static SolanaTokenAccountType fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw MessageException(
          "No SolanaTokenAccountType found matching the specified value",
          details: {"value": value}),
    );
  }
}
