import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Obtain the transaction metadata in CBOR.
/// https://blockfrost.dev/api/transaction-metadata-in-cbor
class BlockfrostRequestTransactionMetadataInCBOR
    extends BlockforestRequestParam<List<ADATransactionMetadataCBORResponse>,
        List<Map<String, dynamic>>> {
  BlockfrostRequestTransactionMetadataInCBOR(this.hash);

  /// Hash of the requested transaction
  final String hash;

  /// Transaction metadata in CBOR
  @override
  String get method => BlockfrostMethods.transactionMetadataInCBOR.url;

  @override
  List<String> get pathParameters => [hash];

  @override
  List<ADATransactionMetadataCBORResponse> onResonse(
      List<Map<String, dynamic>> result) {
    return result.map((e) => ADATransactionMetadataCBORResponse.fromJson(e)).toList();
  }
}
