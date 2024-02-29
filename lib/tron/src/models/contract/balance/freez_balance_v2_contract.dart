import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

/// In Stake2.0, stake an amount of TRX to obtain bandwidth or energy,
/// and obtain equivalent TRON Power(TP) according to the staked amount
class FreezeBalanceV2Contract extends TronBaseContract {
  /// Create a new [FreezeBalanceV2Contract] instance by parsing a JSON map.
  factory FreezeBalanceV2Contract.fromJson(Map<String, dynamic> json) {
    return FreezeBalanceV2Contract(
        ownerAddress: TronAddress(json["owner_address"]),
        frozenBalance: BigintUtils.parse(json["frozen_balance"]),
        resource: ResourceCode.fromName(json["resource"]));
  }

  /// Create a new [FreezeBalanceV2Contract] instance with specified parameters.
  FreezeBalanceV2Contract(
      {required this.ownerAddress, required this.frozenBalance, this.resource});

  /// Account address
  final TronAddress ownerAddress;

  /// TRX stake amount, the unit is sun
  final BigInt frozenBalance;

  /// TRX stake type, 'BANDWIDTH' or 'ENERGY'
  final ResourceCode? resource;

  @override
  List<int> get fieldIds => [1, 2, 3];

  @override
  List get values => [
        ownerAddress,
        frozenBalance,
        resource == ResourceCode.bandWidth ? null : resource
      ];

  /// Convert the [FreezeBalanceV2Contract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress.toString(),
      "frozen_balance": frozenBalance.toString(),
      "resource": resource?.name
    };
  }

  /// Convert the [FreezeBalanceV2Contract] object to its string representation.
  @override
  String toString() {
    return "FreezeBalanceV2Contract{${toJson()}}";
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.freezeBalanceV2Contract;
}
