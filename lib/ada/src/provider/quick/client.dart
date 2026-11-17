import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/provider/blockfrost/blockfrost.dart';

import 'api.dart';

/// Quick client: high-level Cardano calls with unified result types.
///
/// There is exactly one [provider]; see [AdaQuickClientApi].
abstract class AdaQuickClient with AdaQuickClientApi {
  const AdaQuickClient();
}

class DefaultAdaQuickClient extends AdaQuickClient {
  @override
  final IProvider<IServiceProvider, BlockFrostRequestDetails> provider;

  const DefaultAdaQuickClient({required this.provider});
}
