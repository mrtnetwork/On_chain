import 'package:blockchain_utils/utils/json/extension/json.dart';
import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';

/// Create a TRX transfer transaction. If to_address does not exist, then create the account on the blockchain.
class TransferContract extends TronBaseContract {
  /// Create a new [TransferContract] instance with specified parameters.
  TransferContract({
    required this.ownerAddress,
    required this.toAddress,
    required this.amount,
  });

  /// Create a new [TransferContract] instance by parsing a JSON map.
  factory TransferContract.fromJson(Map<String, dynamic> json) {
    return TransferContract(
      amount: json.valueAsBigInt("amount"),
      ownerAddress: TronAddress(json.valueAs("owner_address")),
      toAddress: TronAddress(json.valueAs("to_address")),
    );
  }
  factory TransferContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);

    return TransferContract(
      amount: decode.getField(3),
      toAddress: TronAddress.fromBytes(decode.getField(2)),
      ownerAddress: TronAddress.fromBytes(decode.getField(1)),
    );
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
  Map<String, dynamic> toJson({bool visible = true}) {
    return {
      'owner_address': ownerAddress.toAddress(visible),
      'to_address': toAddress.toAddress(visible),
      'amount': amount.toString(),
    }..removeWhere((key, value) => value == null);
  }

  /// Convert the [TransferContract] object to its string representation.
  @override
  String toString() {
    return 'TransferContract{${toJson()}}';
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.transferContract;

  @override
  BigInt get trxAmount => amount;
}
