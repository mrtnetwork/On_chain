import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';

import '../api/api.dart';

/// Quick client: high-level Aptos calls with unified result types.
///
/// Two providers (fullnode + indexer GraphQL), each method pinned to its
/// backend(s) — see [AptosQuickClientApi]. Aptos backends are complementary,
/// not alternatives.
abstract class AptosQuickClient with AptosQuickClientApi {
  const AptosQuickClient();
}

class DefaultAptosQuickClient extends AptosQuickClient {
  @override
  final IProvider<IServiceProvider, AptosRequestDetails> fullNodeProvider;

  @override
  final IProvider<IServiceProvider, AptosRequestDetails> graphQlProvider;

  const DefaultAptosQuickClient({
    required this.fullNodeProvider,
    required this.graphQlProvider,
  });
}
