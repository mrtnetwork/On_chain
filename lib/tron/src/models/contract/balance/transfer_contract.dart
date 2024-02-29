import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

/// Create a TRX transfer transaction. If to_address does not exist, then create the account on the blockchain.
class TransferContract extends TronBaseContract {
  /// Create a new [TransferContract] instance with specified parameters.
  TransferContract(
      {required this.ownerAddress,
      required this.toAddress,
      required this.amount});

  /// Create a new [TransferContract] instance by parsing a JSON map.
  factory TransferContract.fromJson(Map<String, dynamic> json) {
    return TransferContract(
      amount: BigintUtils.parse(json['amount']),
      ownerAddress: TronAddress(json['owner_address']),
      toAddress: TronAddress(json['to_address']),
    );
  }

  /// Transaction initiator address
  final TronAddress ownerAddress;

  /// Destination address
  final TronAddress toAddress;

  /// Transfer TRX amount, in sun
  final BigInt amount;

  @override
  List<int> get fieldIds => [1, 2, 3];

  @override
  List get values => [ownerAddress, toAddress, amount];

  /// Convert the [TransferContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress.toString(),
      "to_address": toAddress.toString(),
      "amount": amount.toString(),
    }..removeWhere((key, value) => value == null);
  }

  /// Convert the [TransferContract] object to its string representation.
  @override
  String toString() {
    return "TransferContract{${toJson()}}";
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.transferContract;
}
