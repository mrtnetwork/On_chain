import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// List of all used transaction metadata labels.
/// https://blockfrost.dev/api/transaction-metadata-labels
class BlockfrostRequestTransactionMetadataLabels extends BlockFrostRequest<
    List<ADAMetadataLabelResponse>, List<Map<String, dynamic>>> {
  BlockfrostRequestTransactionMetadataLabels(
      {BlockFrostRequestFilterParams? filter})
      : super(filter: filter);

  /// Transaction metadata labels
  @override
  String get method => BlockfrostMethods.transactionMetadataLabels.url;

  @override
  List<String> get pathParameters => [];

  @override
  List<ADAMetadataLabelResponse> onResonse(List<Map<String, dynamic>> result) {
    return result.map((e) => ADAMetadataLabelResponse.fromJson(e)).toList();
  }
}
