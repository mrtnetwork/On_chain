import 'package:on_chain/tron/address/tron_address.dart';
import 'package:on_chain/tron/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

/// Update the consume_user_resource_percent parameter of a smart contract
class UpdateSettingContract extends TronBaseContract {
  /// Create a new [UpdateSettingContract] instance by parsing a JSON map.
  factory UpdateSettingContract.fromJson(Map<String, dynamic> json) {
    return UpdateSettingContract(
      ownerAddress: TronAddress(json["owner_address"]),
      contractAddress: TronAddress(json["contract_address"]),
      consumeUserResourcePercent:
          BigintUtils.tryParse(json["consume_user_resource_percent"]),
    );
  }

  /// Create a new [UpdateSettingContract] instance with specified parameters.
  UpdateSettingContract(
      {required this.ownerAddress,
      required this.contractAddress,
      this.consumeUserResourcePercent});

  /// Account address
  final TronAddress ownerAddress;

  /// Contract address
  final TronAddress contractAddress;

  /// User Energy Proportion
  final BigInt? consumeUserResourcePercent;

  @override
  List<int> get fieldIds => [1, 2, 3];

  /// Convert the [UpdateSettingContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress.toString(),
      "contract_address": contractAddress.toString(),
      "consume_user_resource_percent": consumeUserResourcePercent?.toString(),
    }..removeWhere((key, value) => value == null);
  }

  @override
  List get values =>
      [ownerAddress, contractAddress, consumeUserResourcePercent];

  /// Convert the [UpdateSettingContract] object to its string representation.
  @override
  String toString() {
    return "UpdateSettingContract{${toJson()}}";
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.updateSettingContract;
}
