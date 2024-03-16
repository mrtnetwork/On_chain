import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Return detailed network information.
/// https://blockfrost.dev/api/network-information
class BlockfrostRequestNetworkInformation extends BlockforestRequestParam<
    ADANetworkInfoResponse, Map<String, dynamic>> {
  BlockfrostRequestNetworkInformation();

  /// Network information
  @override
  String get method => BlockfrostMethods.networkInformation.url;

  @override
  List<String> get pathParameters => [];

  @override
  ADANetworkInfoResponse onResonse(Map<String, dynamic> result) {
    return ADANetworkInfoResponse.fromJson(result);
  }
}
