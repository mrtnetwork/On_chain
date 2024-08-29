import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';
import 'package:on_chain/utils/utils.dart';

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
        amount: OnChainUtils.parseBigInt(value: json['amount'], name: "amount"),
        ownerAddress: OnChainUtils.parseTronAddress(
            value: json['owner_address'], name: "owner_address"),
        toAddress: OnChainUtils.parseTronAddress(
            value: json['to_address'], name: "to_address"));
  }
  factory TransferContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return TransferContract(
        amount: decode.getField(3),
        toAddress: TronAddress.fromBytes(decode.getField(2)),
        ownerAddress: TronAddress.fromBytes(decode.getField(1)));
  }

  /// Transaction initiator address
  @override
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

  @override
  BigInt get trxAmount => amount;
}
