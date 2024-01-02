import 'package:on_chain/tron/address/tron_address.dart';
import 'package:on_chain/tron/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

/// Unstake some TRX staked in Stake2.0,
/// release the corresponding amount of bandwidth or energy,
/// and voting rights (TP)
class UnfreezeBalanceV2Contract extends TronBaseContract {
  /// Create a new [UnfreezeBalanceV2Contract] instance by parsing a JSON map.
  factory UnfreezeBalanceV2Contract.fromJson(Map<String, dynamic> json) {
    return UnfreezeBalanceV2Contract(
        ownerAddress: TronAddress(json["owner_address"]),
        unfreezeBalance: BigintUtils.parse(json["unfreeze_balance"]),
        resource: ResourceCode.fromName(json["resource"]));
  }

  /// Create a new [UnfreezeBalanceV2Contract] instance with specified parameters.
  UnfreezeBalanceV2Contract(
      {required this.ownerAddress,
      required this.unfreezeBalance,
      this.resource});

  /// Account address
  final TronAddress ownerAddress;

  /// Unstake amount, unit is sun
  final BigInt unfreezeBalance;

  /// Resource type
  final ResourceCode? resource;

  @override
  List<int> get fieldIds => [1, 2, 3];

  @override
  List get values =>
      [ownerAddress, unfreezeBalance, resource?.value == 0 ? null : resource];

  /// Convert the [UnfreezeBalanceV2Contract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress.toString(),
      "unfreeze_balance": unfreezeBalance.toString(),
      "resource": resource?.name
    };
  }

  /// Convert the [UnfreezeBalanceV2Contract] object to its string representation.
  @override
  String toString() {
    return "UnfreezeBalanceV2Contract{${toJson()}}";
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.unfreezeBalanceV2Contract;
}
