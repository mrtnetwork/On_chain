import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/exception/exception.dart';

class SolanaTokenAccountType extends BorshLayoutSerializable {
  const SolanaTokenAccountType._(this.name, this.value);
  final String name;
  final int value;
  static const SolanaTokenAccountType uninitialized =
      SolanaTokenAccountType._('Uninitialized', 0);
  static const SolanaTokenAccountType mint =
      SolanaTokenAccountType._('Mint', 1);
  static const SolanaTokenAccountType account =
      SolanaTokenAccountType._('Account', 2);
  static const List<SolanaTokenAccountType> values = [
    uninitialized,
    mint,
    account
  ];

  static StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.rustEnum(
        values.map((e) => LayoutConst.none(property: e.name)).toList(),
        property: 'solanaTokenAccountType')
  ]);
  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'solanaTokenAccountType': {name: null}
    };
  }

  factory SolanaTokenAccountType.fromJson(Map<String, dynamic> json) {
    return fromName(json['solanaTokenAccountType']['key']);
  }
  static SolanaTokenAccountType fromName(String? value) {
    return values.firstWhere(
      (element) => element.name == value,
      orElse: () => throw SolanaPluginException(
          'No SolanaTokenAccountType found matching the specified value',
          details: {'value': value}),
    );
  }

  static SolanaTokenAccountType fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw SolanaPluginException(
          'No SolanaTokenAccountType found matching the specified value',
          details: {'value': value}),
    );
  }
}
