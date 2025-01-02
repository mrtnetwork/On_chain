import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Return the content of the requested epoch.
/// https://blockfrost.dev/api/specific-epoch
class BlockfrostRequestSpecificEpoch
    extends BlockFrostRequest<ADAEpochInfoResponse, Map<String, dynamic>> {
  BlockfrostRequestSpecificEpoch(this.epoch);

  /// Number of the epoch
  final int epoch;

  /// Specific epoch
  @override
  String get method => BlockfrostMethods.specificEpoch.url;

  @override
  List<String> get pathParameters => [epoch.toString()];

  @override
  ADAEpochInfoResponse onResonse(Map<String, dynamic> result) {
    return ADAEpochInfoResponse.fromJson(result);
  }
}
