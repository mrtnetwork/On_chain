import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/src/models/contract/transaction/transaction_raw.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';

class Transaction extends TronProtocolBufferImpl {
  /// Create a new [Transaction] instance by parsing a JSON map.
  factory Transaction.fromJson(Map<String, dynamic> json) {
    final rawData = TransactionRaw.fromJson(json['raw_data']);
    final signature = (json['signature'] as List?)
            ?.map((s) => BytesUtils.fromHexString(s))
            .toList() ??
        [];

    return Transaction(rawData: rawData, signature: signature);
  }

  /// Create a new [Transaction] instance with specified parameters.
  Transaction({required this.rawData, required List<List<int>> signature})
      : signature = signature
            .map((e) => BytesUtils.toBytes(e, unmodifiable: true))
            .toList();

  factory Transaction.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return Transaction(
        rawData: TransactionRaw.deserialize(decode.getField(1)),
        signature: decode.getField<List<List<int>>?>(2) ?? const []);
  }

  /// The raw data of the transaction.
  final TransactionRaw rawData;

  /// List of cryptographic signatures associated with the transaction.
  final List<List<int>> signature;

  @override
  List<int> get fieldIds => [1, 2];

  @override
  List get values => [rawData, signature];

  late final int length = toBuffer().length;

  /// Convert the [Transaction] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "raw_data": rawData.toJson(),
      "signature": signature.map((s) => BytesUtils.toHexString(s)).toList()
    };
  }

  /// Convert the [Transaction] object to its string representation.
  @override
  String toString() {
    return 'Transaction{${toJson()}}';
  }
}
