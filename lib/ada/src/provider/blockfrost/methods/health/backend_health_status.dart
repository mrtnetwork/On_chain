import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';

/// Return backend status as a boolean.
/// Your application should handle situations when backend for the given chain is unavailable.
/// https://blockfrost.dev/api/backend-health-status
class BlockfrostRequestBackendHealthStatus
    extends BlockFrostRequest<bool, Map<String, dynamic>> {
  BlockfrostRequestBackendHealthStatus();

  /// Backend health status
  @override
  String get method => BlockfrostMethods.backendHealthStatus.url;

  @override
  List<String> get pathParameters => [];

  @override
  bool onResonse(Map<String, dynamic> result) {
    return result['is_healthy'];
  }
}
