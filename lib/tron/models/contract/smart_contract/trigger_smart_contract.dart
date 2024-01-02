import 'package:on_chain/tron/address/tron_address.dart';
import 'package:on_chain/tron/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

class TriggerSmartContract extends TronBaseContract {
  /// Create a new [TriggerSmartContract] instance by parsing a JSON map.
  factory TriggerSmartContract.fromJson(Map<String, dynamic> json) {
    return TriggerSmartContract(
      ownerAddress: TronAddress(json["owner_address"]),
      contractAddress: TronAddress(json["contract_address"]),
      data: BytesUtils.tryFromHexString(json["data"]),
      callTokenValue: BigintUtils.tryParse(json["call_token_value"]),
      callValue: BigintUtils.tryParse(json["call_value"]),
      tokenId: BigintUtils.tryParse(json["token_id"]),
    );
  }

  /// Create a new [TriggerSmartContract] instance with specified parameters.
  TriggerSmartContract(
      {required this.ownerAddress,
      required this.contractAddress,
      this.callValue,
      List<int>? data,
      this.callTokenValue,
      this.tokenId})
      : data = BytesUtils.tryToBytes(data, unmodifiable: true);

  /// Account address
  final TronAddress ownerAddress;

  /// Contract address
  final TronAddress contractAddress;

  /// The amount of TRX passed into the contract
  final BigInt? callValue;

  /// Operating parameters
  final List<int>? data;

  /// The amount of TRC-10 transferred into the contract
  final BigInt? callTokenValue;

  /// TRC-10 token id
  final BigInt? tokenId;

  @override
  List<int> get fieldIds => [1, 2, 3, 4, 5, 6];

  @override
  List get values =>
      [ownerAddress, contractAddress, callValue, data, callTokenValue, tokenId];

  /// Convert the [TriggerSmartContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress.toString(),
      "contract_address": contractAddress.toString(),
      "data": BytesUtils.tryToHexString(data!),
      "call_value": callValue?.toString(),
      "call_token_value": callTokenValue?.toString(),
      "token_id": tokenId?.toString()
    }..removeWhere((key, value) => value == null);
  }

  /// Convert the [TriggerSmartContract] object to its string representation.
  @override
  String toString() {
    return "TriggerSmartContract{${toJson()}}";
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.triggerSmartContract;
}
