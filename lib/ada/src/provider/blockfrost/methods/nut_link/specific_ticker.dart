import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// List of records of a specific ticker
/// https://blockfrost.dev/api/specific-ticker
class BlockfrostRequestSpecificTicker extends BlockforestRequestParam<
    List<Map<String, dynamic>>, List<Map<String, dynamic>>> {
  BlockfrostRequestSpecificTicker(this.ticker,
      {BlockforestRequestFilterParams? filter})
      : super(filter: filter);

  final String ticker;

  /// Specific ticker
  @override
  String get method => BlockfrostMethods.specificTicker.url;

  @override
  List<String> get pathParameters => [ticker];
}
