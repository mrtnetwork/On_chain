import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// List of records of a specific ticker
/// https://blockfrost.dev/api/specific-ticker-for-an-address
class BlockfrostRequestSpecificTickerForAnAddress
    extends BlockforestRequestParam<List<Map<String, dynamic>>,
        List<Map<String, dynamic>>> {
  BlockfrostRequestSpecificTickerForAnAddress(
      {required this.address,
      required this.ticker,
      BlockforestRequestFilterParams? filter})
      : super(filter: filter);
  final String address;
  final String ticker;

  /// Specific ticker for an address
  @override
  String get method => BlockfrostMethods.specificTickerForAnAddress.url;

  @override
  List<String> get pathParameters => [address, ticker];
}
