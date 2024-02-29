import 'package:on_chain/solana/src/instructions/instructions.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Encapsulates all fee information and calculations for swap operations
class TokenSwapFees extends LayoutSerializable {
  /// Trade fees are extra token amounts that are held inside the token
  /// accounts during a trade, making the value of liquidity tokens rise.
  /// Trade fee numerator
  final BigInt tradeFeeNumerator;

  /// Trade fee denominator
  final BigInt tradeFeeDenominator;

  /// Owner trading fees are extra token amounts that are held inside the
  /// token accounts during a trade, with the equivalent in pool tokens
  /// minted to the owner of the program.
  /// Owner trade fee numerator
  final BigInt ownerTradeFeeNumerator;

  /// Owner trade fee denominator
  final BigInt ownerTradeFeeDenominator;

  /// Owner withdraw fees are extra liquidity pool token amounts that are
  /// sent to the owner on every withdrawal.
  /// Owner withdraw fee numerator
  final BigInt ownerWithdrawFeeNumerator;

  /// The owner withdraw fee denominator.
  final BigInt ownerWithdrawFeeDenominator;

  /// Host fees are a proportion of the owner trading fees, sent to an
  /// extra account provided during the trade.
  /// Host trading fee numerator
  final BigInt hostFeeNumerator;

  /// Host trading fee denominator
  final BigInt hostFeeDenominator;

  TokenSwapFees({
    required this.tradeFeeNumerator,
    required this.tradeFeeDenominator,
    required this.ownerTradeFeeNumerator,
    required this.ownerTradeFeeDenominator,
    required this.ownerWithdrawFeeNumerator,
    required this.ownerWithdrawFeeDenominator,
    required this.hostFeeNumerator,
    required this.hostFeeDenominator,
  });

  /// Constructs a [SPLTokenSwapInitSwapLayout] instance from the given byte array.
  factory TokenSwapFees.fromJson(Map<String, dynamic> json) {
    return TokenSwapFees(
      tradeFeeNumerator: json["tradeFeeNumerator"],
      tradeFeeDenominator: json["tradeFeeDenominator"],
      ownerTradeFeeNumerator: json["ownerTradeFeeNumerator"],
      ownerTradeFeeDenominator: json["ownerTradeFeeDenominator"],
      ownerWithdrawFeeNumerator: json["ownerWithdrawFeeNumerator"],
      ownerWithdrawFeeDenominator: json["ownerWithdrawFeeDenominator"],
      hostFeeNumerator: json["hostFeeNumerator"],
      hostFeeDenominator: json["hostFeeDenominator"],
    );
  }

  /// The layout structure for creating a token swap.
  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.u64('tradeFeeNumerator'),
    LayoutUtils.u64('tradeFeeDenominator'),
    LayoutUtils.u64('ownerTradeFeeNumerator'),
    LayoutUtils.u64('ownerTradeFeeDenominator'),
    LayoutUtils.u64('ownerWithdrawFeeNumerator'),
    LayoutUtils.u64('ownerWithdrawFeeDenominator'),
    LayoutUtils.u64('hostFeeNumerator'),
    LayoutUtils.u64('hostFeeDenominator'),
  ], "fees");
  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "tradeFeeNumerator": tradeFeeNumerator,
      "tradeFeeDenominator": tradeFeeDenominator,
      "ownerTradeFeeNumerator": ownerTradeFeeNumerator,
      "ownerTradeFeeDenominator": ownerTradeFeeDenominator,
      "ownerWithdrawFeeNumerator": ownerWithdrawFeeNumerator,
      "ownerWithdrawFeeDenominator": ownerWithdrawFeeDenominator,
      "hostFeeNumerator": hostFeeNumerator,
      "hostFeeDenominator": hostFeeDenominator
    };
  }

  @override
  String toString() {
    return "TokenSwapFees${serialize()}";
  }
}
