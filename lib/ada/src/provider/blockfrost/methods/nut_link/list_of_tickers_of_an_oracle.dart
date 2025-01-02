import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// List of records of a specific oracle.
/// https://blockfrost.dev/api/list-of-tickers-of-an-oracle
class BlockfrostRequestListOfTickersOfAnOracle extends BlockFrostRequest<
    List<Map<String, dynamic>>, List<Map<String, dynamic>>> {
  BlockfrostRequestListOfTickersOfAnOracle(this.address,
      {BlockFrostRequestFilterParams? filter})
      : super(filter: filter);
  final String address;

  /// List of tickers of an oracle
  @override
  String get method => BlockfrostMethods.listOfTickersOfAnOracle.url;

  @override
  List<String> get pathParameters => [address];
}
