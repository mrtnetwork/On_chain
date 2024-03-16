import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Return the protocol parameters for the latest epoch..
/// https://blockfrost.dev/api/latest-epoch-protocol-parameters
class BlockfrostRequestLatestEpochProtocolParameters
    extends BlockforestRequestParam<ADAEpochParametersResponse, Map<String, dynamic>> {
  BlockfrostRequestLatestEpochProtocolParameters();

  /// Latest epoch protocol parameters
  @override
  String get method => BlockfrostMethods.latestEpochProtocolParameters.url;

  @override
  List<String> get pathParameters => [];

  @override
  ADAEpochParametersResponse onResonse(Map<String, dynamic> result) {
    return ADAEpochParametersResponse.fromJson(result);
  }
}
