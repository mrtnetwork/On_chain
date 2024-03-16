import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// List of registered stake pools.
/// https://blockfrost.dev/api/list-of-stake-pools
class BlockfrostRequestListOfStakePools
    extends BlockforestRequestParam<List<String>, List<dynamic>> {
  BlockfrostRequestListOfStakePools({BlockforestRequestFilterParams? filter})
      : super(filter: filter);

  /// List of stake pools
  @override
  String get method => BlockfrostMethods.listOfStakePools.url;

  @override
  List<String> get pathParameters => [];

  @override
  List<String> onResonse(List result) {
    return result.cast();
  }
}
