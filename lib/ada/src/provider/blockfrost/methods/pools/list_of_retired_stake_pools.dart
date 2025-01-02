import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// List of already retired pools.
/// https://blockfrost.dev/api/list-of-retired-stake-pools
class BlockfrostRequestListOfRetiredStakePools extends BlockFrostRequest<
    List<ADAPoolRetirementResponse>, List<Map<String, dynamic>>> {
  BlockfrostRequestListOfRetiredStakePools(
      {BlockFrostRequestFilterParams? filter})
      : super(filter: filter);

  /// List of retired stake pools
  @override
  String get method => BlockfrostMethods.listOfRetiredStakePools.url;

  @override
  List<String> get pathParameters => [];

  @override
  List<ADAPoolRetirementResponse> onResonse(List<Map<String, dynamic>> result) {
    return result.map((e) => ADAPoolRetirementResponse.fromJson(e)).toList();
  }
}
