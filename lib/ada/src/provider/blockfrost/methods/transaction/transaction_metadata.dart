import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';

/// Obtain the transaction metadata.
/// https://blockfrost.dev/api/transaction-metadata
class BlockfrostRequestTransactionMetadata extends BlockforestRequestParam<
    List<Map<String, dynamic>>, List<Map<String, dynamic>>> {
  BlockfrostRequestTransactionMetadata(this.hash);

  /// Hash of the requested transaction
  final String hash;

  /// Transaction metadata
  @override
  String get method => BlockfrostMethods.transactionMetadata.url;

  @override
  List<String> get pathParameters => [hash];
}
