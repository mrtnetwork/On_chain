import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/rpc/core/core.dart';

import 'api.dart';
import 'quick_confidential_api.dart';

/// Quick client: high-level Solana calls with unified result types.
///
abstract class SolanaQuickClient
    with SolanaQuickClientApi, SolanaQuickConfidentialApi {
  const SolanaQuickClient();
}

class DefaultSolanaQuickClient extends SolanaQuickClient {
  @override
  final IProvider<IServiceProvider, SolanaRequestDetails> provider;

  const DefaultSolanaQuickClient({required this.provider});
}
