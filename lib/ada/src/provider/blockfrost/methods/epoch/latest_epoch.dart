import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Return the information about the latest, therefore current, epoch..
/// https://blockfrost.dev/api/latest-epoch
class BlockfrostRequestLatestEpoch
    extends BlockFrostRequest<ADAEpochInfoResponse, Map<String, dynamic>> {
  BlockfrostRequestLatestEpoch();

  /// Latest epoch
  @override
  String get method => BlockfrostMethods.latestEpoch.url;

  @override
  List<String> get pathParameters => [];

  @override
  ADAEpochInfoResponse onResonse(Map<String, dynamic> result) {
    return ADAEpochInfoResponse.fromJson(result);
  }
}
