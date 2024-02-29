import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/src/models/contract/smart_contract/smart_contract.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

/// Deploys a contract
class CreateSmartContract extends TronBaseContract {
  /// Create a new [CreateSmartContract] instance by parsing a JSON map.
  factory CreateSmartContract.fromJson(Map<String, dynamic> json) {
    return CreateSmartContract(
      ownerAddress: TronAddress(json["owner_address"]),
      newContract: SmartContract.fromJson(json["new_contract"]),
      callTokenValue: BigintUtils.tryParse(json["call_token_value"]),
      tokenId: BigintUtils.tryParse(json["token_id"]),
    );
  }

  /// Create a new [CreateSmartContract] instance with specified parameters.
  CreateSmartContract(
      {required this.ownerAddress,
      required this.newContract,
      this.callTokenValue,
      this.tokenId});

  /// Account address
  final TronAddress ownerAddress;

  /// Deployed contract data, the fields contained in it
  final SmartContract newContract;

  /// The amount of TRC-10 transferred into the contract
  final BigInt? callTokenValue;

  /// TRC-10 token id
  final BigInt? tokenId;

  /// Convert the [CreateSmartContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress.toString(),
      "new_contract": newContract.toJson(),
      "call_token_value": callTokenValue?.toString(),
      "token_id": tokenId?.toString()
    }..removeWhere((key, value) => value == null);
  }

  @override
  List<int> get fieldIds => [1, 2, 3, 4];

  @override
  List get values => [ownerAddress, newContract, callTokenValue, tokenId];

  /// Convert the [CreateSmartContract] object to its string representation.
  @override
  String toString() {
    return "CreateSmartContract{${toJson()}}";
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.createSmartContract;
}
