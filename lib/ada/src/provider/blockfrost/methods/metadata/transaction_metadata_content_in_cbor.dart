import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Transaction metadata per label.
/// https://blockfrost.dev/api/transaction-metadata-content-in-cbor
class BlockfrostRequestTransactionMetadataContentInCbor
    extends BlockforestRequestParam<List<ADAMetadataCBORResponse>,
        List<Map<String, dynamic>>> {
  BlockfrostRequestTransactionMetadataContentInCbor(this.label,
      {BlockforestRequestFilterParams? filter})
      : super(filter: filter);

  /// Metadata label
  final int label;

  /// Transaction metadata content in CBOR
  @override
  String get method => BlockfrostMethods.transactionMetadataContentInCbor.url;

  @override
  List<String> get pathParameters => [label.toString()];

  @override
  List<ADAMetadataCBORResponse> onResonse(List<Map<String, dynamic>> result) {
    return result.map((e) => ADAMetadataCBORResponse.fromJson(e)).toList();
  }
}
