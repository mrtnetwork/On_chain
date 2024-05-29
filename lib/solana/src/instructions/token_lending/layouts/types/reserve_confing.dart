import 'package:on_chain/solana/src/instructions/token_lending/layouts/types/reserve_fee_config.dart';
import 'package:blockchain_utils/layout/layout.dart';

/// Reserve configuration
class ReserveConfig {
  /// Optimal utilization rate, as a percentage
  final int optimalUtilizationRate;

  /// Target ratio of the value of borrows to deposits, as a percentage
  /// 0 if use as collateral is disabled
  final int loanToValueRatio;

  /// Bonus a liquidator gets when repaying part of an unhealthy obligation,
  /// as a percentage
  final int liquidationBonus;

  /// Loan to value ratio at which an obligation can be liquidated, as a
  /// percentage
  final int liquidationThreshold;

  /// Min borrow APY
  final int minBorrowRate;

  /// Optimal (utilization) borrow APY
  final int optimalBorrowRate;

  /// Max borrow APY
  final int maxBorrowRate;

  /// Program owner fees assessed, separate from gains due to interest accrual
  final ReserveFeesConfig feesConfig;
  const ReserveConfig(
      {required this.optimalUtilizationRate,
      required this.loanToValueRatio,
      required this.liquidationBonus,
      required this.liquidationThreshold,
      required this.minBorrowRate,
      required this.optimalBorrowRate,
      required this.maxBorrowRate,
      required this.feesConfig});
  factory ReserveConfig.fromJson(Map<String, dynamic> json) {
    return ReserveConfig(
        optimalUtilizationRate: json["optimalUtilizationRate"],
        loanToValueRatio: json["loanToValueRatio"],
        liquidationBonus: json["liquidationBonus"],
        liquidationThreshold: json["liquidationThreshold"],
        minBorrowRate: json["minBorrowRate"],
        optimalBorrowRate: json["optimalBorrowRate"],
        maxBorrowRate: json["maxBorrowRate"],
        feesConfig: ReserveFeesConfig.fromJson(json["fees"]));
  }
  static StructLayout layout = LayoutConst.struct([
    LayoutConst.u8(property: 'optimalUtilizationRate'),
    LayoutConst.u8(property: 'loanToValueRatio'),
    LayoutConst.u8(property: 'liquidationBonus'),
    LayoutConst.u8(property: 'liquidationThreshold'),
    LayoutConst.u8(property: 'minBorrowRate'),
    LayoutConst.u8(property: 'optimalBorrowRate'),
    LayoutConst.u8(property: 'maxBorrowRate'),
    ReserveFeesConfig.layout
  ], property: "config");

  Map<String, dynamic> serialize() {
    return {
      "optimalUtilizationRate": optimalUtilizationRate,
      "loanToValueRatio": loanToValueRatio,
      "liquidationBonus": liquidationBonus,
      "liquidationThreshold": liquidationThreshold,
      "minBorrowRate": minBorrowRate,
      "optimalBorrowRate": optimalBorrowRate,
      "maxBorrowRate": maxBorrowRate,
      "fees": feesConfig.serialize()
    };
  }

  @override
  String toString() {
    return "ReserveConfig${serialize()}";
  }
}
