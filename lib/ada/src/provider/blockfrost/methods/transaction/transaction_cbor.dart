import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';

/// Return content of the requested transaction.
/// https://blockfrost.dev/api/specific-transaction
class BlockfrostRequestTransactionCbor
    extends BlockFrostRequest<String, Map<String, dynamic>> {
  BlockfrostRequestTransactionCbor(this.hash);

  /// Hash of the requested transaction
  final String hash;

  /// Specific transaction
  @override
  String get method => BlockfrostMethods.transactionCbor.url;

  @override
  List<String> get pathParameters => [hash];

  @override
  String onResonse(Map<String, dynamic> result) {
    return result["cbor"];
  }
}
