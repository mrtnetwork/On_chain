import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Transaction metadata per label.
/// https://blockfrost.dev/api/transaction-metadata-content-in-json
class BlockfrostRequestTransactionMetadataContentInJson
    extends BlockforestRequestParam<List<Map<String, dynamic>>,
        List<Map<String, dynamic>>> {
  BlockfrostRequestTransactionMetadataContentInJson(this.label,
      {BlockforestRequestFilterParams? filter})
      : super(filter: filter);

  /// Metadata label
  final int label;

  /// Transaction metadata content in JSON
  @override
  String get method => BlockfrostMethods.transactionMetadataContentInJson.url;

  @override
  List<String> get pathParameters => [label.toString()];
}
