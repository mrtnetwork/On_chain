import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// List of registered stake pools with additional information.
/// https://blockfrost.dev/api/list-of-stake-pools-with-additional-information
class BlockfrostRequestListOfStakePoolsWithAdditionalInformation
    extends BlockforestRequestParam<List<ADAPoolInfoResponse>,
        List<Map<String, dynamic>>> {
  BlockfrostRequestListOfStakePoolsWithAdditionalInformation(
      {BlockforestRequestFilterParams? filter})
      : super(filter: filter);

  /// List of stake pools with additional information
  @override
  String get method =>
      BlockfrostMethods.listOfStakePoolsWithAdditionalInformation.url;

  @override
  List<String> get pathParameters => [];

  @override
  List<ADAPoolInfoResponse> onResonse(List<Map<String, dynamic>> result) {
    return result.map((e) => ADAPoolInfoResponse.fromJson(e)).toList();
  }
}
