import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Return the protocol parameters for the epoch specified.
/// https://blockfrost.dev/api/protocol-parameters
class BlockfrostRequestProtocolParameters
    extends BlockforestRequestParam<ADAEpochParametersResponse, Map<String, dynamic>> {
  BlockfrostRequestProtocolParameters(this.epoch);

  /// Number of the epoch
  final int epoch;

  /// Protocol parameters
  @override
  String get method => BlockfrostMethods.protocolParameters.url;

  @override
  List<String> get pathParameters => [epoch.toString()];

  @override
  ADAEpochParametersResponse onResonse(Map<String, dynamic> result) {
    return ADAEpochParametersResponse.fromJson(result);
  }
}
