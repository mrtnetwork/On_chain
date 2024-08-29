import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';
import 'package:on_chain/utils/utils.dart';

/// To clear the ABI info of a smart contract.
class ClearABIContract extends TronBaseContract {
  /// Create a new [ClearABIContract] instance by parsing a JSON map.
  factory ClearABIContract.fromJson(Map<String, dynamic> json) {
    return ClearABIContract(
      ownerAddress: OnChainUtils.parseTronAddress(
          value: json["owner_address"], name: "owner_address"),
      contractAddress: OnChainUtils.parseTronAddress(
          value: json["contract_address"], name: "contract_address"),
    );
  }

  /// Create a new [ClearABIContract] instance with specified parameters.
  ClearABIContract({required this.ownerAddress, required this.contractAddress});
  factory ClearABIContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return ClearABIContract(
        ownerAddress: TronAddress.fromBytes(decode.getField(1)),
        contractAddress: TronAddress.fromBytes(decode.getField(2)));
  }

  /// Owner address of the smart contract
  @override
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
