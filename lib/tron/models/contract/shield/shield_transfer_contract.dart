import 'package:on_chain/tron/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/models/contract/shield/receive_description.dart';
import 'package:on_chain/tron/models/contract/shield/spend_description.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

class ShieldedTransferContract extends TronBaseContract {
  /// Create a new [ShieldedTransferContract] instance by parsing a JSON map.
  factory ShieldedTransferContract.fromJson(Map<String, dynamic> json) {
    return ShieldedTransferContract(
      transparentFromAddress:
          BytesUtils.tryFromHexString(json["transparent_from_address"]),
      fromAmount: BigintUtils.tryParse(json["from_amount"]),
      spendDescription: (json["spend_description"] as List?)
          ?.map((desc) => SpendDescription.fromJson(desc))
          .toList(),
      receiveDescription: (json["receive_description"] as List?)
          ?.map((desc) => ReceiveDescription.fromJson(desc))
          .toList(),
      bindingSignature: BytesUtils.tryFromHexString(json["binding_signature"]),
      transparentToAddress:
          BytesUtils.tryFromHexString(json["transparent_to_address"]),
      toAmount: BigintUtils.tryParse(json["to_amount"]),
    );
  }

  /// Create a new [ShieldedTransferContract] instance with specified parameters.
  ShieldedTransferContract(
      {List<int>? transparentFromAddress,
      this.fromAmount,
      List<SpendDescription>? spendDescription,
      List<ReceiveDescription>? receiveDescription,
      List<int>? bindingSignature,
      List<int>? transparentToAddress,
      this.toAmount})
      : transparentFromAddress =
            BytesUtils.tryToBytes(transparentFromAddress, unmodifiable: true),
        bindingSignature =
            BytesUtils.tryToBytes(bindingSignature, unmodifiable: true),
        transparentToAddress =
            BytesUtils.tryToBytes(transparentToAddress, unmodifiable: true),
        spendDescription = spendDescription == null
            ? null
            : List<SpendDescription>.unmodifiable(spendDescription),
        receiveDescription = receiveDescription == null
            ? null
            : List<ReceiveDescription>.unmodifiable(receiveDescription);
  final List<int>? transparentFromAddress;
  final BigInt? fromAmount;
  final List<SpendDescription>? spendDescription;
  final List<ReceiveDescription>? receiveDescription;
  final List<int>? bindingSignature;
  final List<int>? transparentToAddress;
  final BigInt? toAmount;

  @override
  List<int> get fieldIds => [1, 2, 3, 4, 5, 6, 7];

  @override
  List get values => [
        transparentFromAddress,
        fromAmount,
        spendDescription,
        receiveDescription,
        bindingSignature,
        transparentToAddress,
        toAmount
      ];

  /// Convert the [ShieldedTransferContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "transparent_from_address":
          BytesUtils.tryToHexString(transparentFromAddress),
      "from_amount": fromAmount?.toString(),
      "spend_description":
          spendDescription?.map((desc) => desc.toJson()).toList(),
      "receive_description":
          receiveDescription?.map((desc) => desc.toJson()).toList(),
      "binding_signature": BytesUtils.tryToHexString(bindingSignature),
      "transparent_to_address": BytesUtils.tryToHexString(transparentToAddress),
      "to_amount": toAmount?.toString(),
    }..removeWhere((key, value) => value == null);
  }

  /// Convert the [ShieldedTransferContract] object to its string representation.
  @override
  String toString() {
    return "ShieldedTransferContract{${toJson()}}";
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.shieldedTransferContract;
}
