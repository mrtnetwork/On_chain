import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';

/// Submit an already serialized transaction to the network.
/// https://blockfrost.dev/api/specific-account-address
class BlockfrostRequestSubmitTransaction
    extends BlockforestPostRequestParam<String, String> {
  BlockfrostRequestSubmitTransaction({required List<int> transactionCborBytes})
      : transactionCborBytes = BytesUtils.toBytes(transactionCborBytes);

  /// Submit a transaction
  @override
  String get method => BlockfrostMethods.submitTransaction.url;

  @override
  List<String> get pathParameters => [];

  @override
  Map<String, String>? get header => {"Content-Type": "application/cbor"};

  final List<int> transactionCborBytes;

  /// The transaction to submit, serialized in CBOR.
  @override
  Object get body => transactionCborBytes;
}
