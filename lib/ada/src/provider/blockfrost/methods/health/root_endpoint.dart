import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Root endpoint has no other function than to point end users to documentation.
/// https://blockfrost.dev/api/root-endpoint
class BlockfrostRequestRootEndpoint
    extends BlockFrostRequest<ADARootResponse, Map<String, dynamic>> {
  BlockfrostRequestRootEndpoint();

  /// Root ENDPOINT
  @override
  String get method => BlockfrostMethods.rootEndpoint.url;

  @override
  List<String> get pathParameters => [];

  @override
  ADARootResponse onResponse(Map<String, dynamic> result) {
    return ADARootResponse.fromJson(result);
  }
}
