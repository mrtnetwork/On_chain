import 'package:on_chain/tron/src/provider/api/api/api.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/provider/provider.dart';

abstract class TronQuickClient with TronQuickClientApi {
  const TronQuickClient();
}

class DefaultTronQuickClient extends TronQuickClient {
  @override
  final TronProvider provider;
  @override
  final List<TronProviderApi> availableProviders;
  const DefaultTronQuickClient({
    required this.provider,
    required this.availableProviders,
  });
}
