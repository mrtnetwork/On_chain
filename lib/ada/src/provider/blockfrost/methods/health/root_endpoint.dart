import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';

/// Root endpoint has no other function than to point end users to documentation.
/// https://blockfrost.dev/api/root-endpoint
class BlockfrostRequestRootEndpoint extends BlockforestRequestParam<
    Map<String, dynamic>, Map<String, dynamic>> {
  BlockfrostRequestRootEndpoint();

  /// Root ENDPOINT
  @override
  String get method => BlockfrostMethods.rootEndpoint.url;

  @override
  List<String> get pathParameters => [];
}
