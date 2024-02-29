import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';

/// Cancel unstakings, all unstaked funds still in the waiting period will be re-staked,
/// all unstaked funds that exceeded the 14-day waiting period will be automatically
/// withdrawn to the owner’s account
class CancelAllUnfreezeV2Contract extends TronBaseContract {
  /// Create a new [CancelAllUnfreezeV2Contract] instance by parsing a JSON map.
  factory CancelAllUnfreezeV2Contract.fromJson(Map<String, dynamic> json) {
    return CancelAllUnfreezeV2Contract(
        ownerAddress: TronAddress(json["owner_address"]));
  }

  /// Create a new [CancelAllUnfreezeV2Contract] instance with specified parameters.
  CancelAllUnfreezeV2Contract({required this.ownerAddress});

  /// Account address
  final TronAddress ownerAddress;

  @override
  List<int> get fieldIds => [1];

  @override
  List get values => [ownerAddress];

  /// Convert the [CancelAllUnfreezeV2Contract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {"owner_address": ownerAddress.toString()};
  }

  /// Convert the [CancelAllUnfreezeV2Contract] object to its string representation.
  @override
  String toString() {
    return "CancelAllUnfreezeV2Contract{${toJson()}}";
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.cancelAllUnfreezeV2Contract;
}
