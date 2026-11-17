import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class TokenState extends BorshLayoutSerializable {
  final String name;
  const TokenState._(this.name);
  static const TokenState unlocked = TokenState._('Unlocked');
  static const TokenState locked = TokenState._('Locked');
  static const TokenState listed = TokenState._('Listed');

  static const List<TokenState> values = [unlocked, locked, listed];

  factory TokenState.fromJson(Map<String, dynamic> json) {
    return TokenState.fromName(json['tokenState']['key']);
  }

  factory TokenState.fromName(String? value) {
    return values.firstWhere(
      (element) => element.name == value,
      orElse:
          () =>
              throw BuError(
                OnChainErrorType.solanaPlugin,
                'No TokenState found matching the specified value',
                details: {'value': value?.toString()},
              ),
    );
  }

  static StructLayout get staticLayout => LayoutConst.struct([
    LayoutConst.rustEnum(
      values.map((e) => LayoutConst.none(property: e.name)).toList(),
      property: 'tokenState',
    ),
  ]);
  @override
  String toString() {
    return 'TokenState.$name';
  }

  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'tokenState': {name: null},
    };
  }
}
