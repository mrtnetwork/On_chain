import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';

/// Submit an already serialized transaction to the network.
/// https://blockfrost.dev/api/specific-account-address
class BlockfrostRequestSubmitTransaction
    extends BlockFrostPostRequest<String, String> {
  BlockfrostRequestSubmitTransaction({required List<int> transactionCborBytes})
    : transactionCborBytes = transactionCborBytes.asImmutableBytes;

  /// Submit a transaction
  @override
  String get method => BlockfrostMethods.submitTransaction.url;

  @override
  List<String> get pathParameters => [];

  @override
  Map<String, String> get headers => {'Content-Type': 'application/cbor'};

  final BuBytes transactionCborBytes;

  /// The transaction to submit, serialized in CBOR.
  @override
  BuBytes get body => transactionCborBytes;
  @override
  String onResponse(String result) {
    if (result.startsWith('"')) {
      return StringUtils.toJson(result);
    }
    return result;
  }
}
