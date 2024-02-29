import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';

/// To clear the ABI info of a smart contract.
class ClearABIContract extends TronBaseContract {
  /// Create a new [ClearABIContract] instance by parsing a JSON map.
  factory ClearABIContract.fromJson(Map<String, dynamic> json) {
    return ClearABIContract(
      ownerAddress: TronAddress(json["owner_address"]),
      contractAddress: TronAddress(json["contract_address"]),
    );
  }

  /// Create a new [ClearABIContract] instance with specified parameters.
  ClearABIContract({required this.ownerAddress, required this.contractAddress});

  /// Owner address of the smart contract
  final TronAddress ownerAddress;

  /// Smart contract address
  final TronAddress contractAddress;

  @override
  List<int> get fieldIds => [1, 2];

  @override
  List get values => [ownerAddress, contractAddress];

  /// Convert the [ClearABIContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress.toString(),
      "contract_address": contractAddress.toString(),
    };
  }

  /// Convert the [ClearABIContract] object to its string representation.
  @override
  String toString() {
    return "ClearABIContract{${toJson()}}";
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.clearABIContract;
}
