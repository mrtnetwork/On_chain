import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// List of stake pools retiring in the upcoming epochs.
/// https://blockfrost.dev/api/list-of-retiring-stake-pools
class BlockfrostRequestListOfRetiringStakePools extends BlockFrostRequest<
    List<ADAPoolRetirementResponse>, List<Map<String, dynamic>>> {
  BlockfrostRequestListOfRetiringStakePools(
      {BlockFrostRequestFilterParams? filter})
      : super(filter: filter);

  /// List of retiring stake pools
  @override
  String get method => BlockfrostMethods.listOfRetiringStakePools.url;

  @override
  List<String> get pathParameters => [];

  @override
  List<ADAPoolRetirementResponse> onResonse(List<Map<String, dynamic>> result) {
    return result.map((e) => ADAPoolRetirementResponse.fromJson(e)).toList();
  }
}
