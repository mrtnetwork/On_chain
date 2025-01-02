import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';

/// This endpoint provides the current UNIX time. Your application might use this
/// to verify if the client clock is not out of sync.
/// https://blockfrost.dev/api/current-backend-time
class BlockfrostRequestBackendCurrentBackendTime
    extends BlockFrostRequest<int, Map<String, dynamic>> {
  BlockfrostRequestBackendCurrentBackendTime();

  /// Current backend time
  @override
  String get method => BlockfrostMethods.currentBackendTime.url;

  @override
  List<String> get pathParameters => [];

  @override
  int onResonse(Map<String, dynamic> result) {
    return result['server_time'];
  }
}
