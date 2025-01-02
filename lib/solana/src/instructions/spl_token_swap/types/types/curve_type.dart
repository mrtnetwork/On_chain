import 'package:on_chain/solana/src/exception/exception.dart';

/// Curve types supported by the token-swap program.
class SPLTokenSwapCurveType {
  final String name;
  final int value;
  const SPLTokenSwapCurveType._(this.name, this.value);

  /// Uniswap-style constant product curve, invariant = token_a_amount *
  /// token_b_amount
  static const SPLTokenSwapCurveType constantProduct =
      SPLTokenSwapCurveType._('ConstantProduct', 0);

  /// Flat line, always providing 1:1 from one token to another
  static const SPLTokenSwapCurveType constantPrice =
      SPLTokenSwapCurveType._('ConstantPrice', 1);

  /// Offset curve, like Uniswap, but the token B side has a faked offset
  static const SPLTokenSwapCurveType offset =
      SPLTokenSwapCurveType._('Offset', 2);

  static const List<SPLTokenSwapCurveType> values = [
    constantProduct,
    constantPrice,
    offset
  ];

  static SPLTokenSwapCurveType fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw SolanaPluginException(
          'No SPLTokenSwapCurveType found matching the specified value',
          details: {'value': value}),
    );
  }
}
