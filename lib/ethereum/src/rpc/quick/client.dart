import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';

import 'api.dart';

/// Quick client: high-level Ethereum calls with unified result types.
///
abstract class EthereumQuickClient extends EthereumQuickClientApi {}

class DefaultEthereumQuickClient extends EthereumQuickClient {
  @override
  final IProvider<IServiceProvider, EthereumRequestDetails> provider;

  DefaultEthereumQuickClient({required this.provider});
}
