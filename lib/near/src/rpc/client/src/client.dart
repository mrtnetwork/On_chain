import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/near/src/rpc/client/src/node_api.dart';
import 'package:on_chain/near/src/rpc/client/src/token_api.dart';
import 'package:on_chain/near/src/rpc/client/src/transaction_api.dart';

import 'api.dart';

/// Quick client: high-level NEAR calls with unified result types.
///
/// Mixes the node reads ([NearQuickNodeApi]), token reads
/// ([NearTokenQuickApi]), unified conveniences ([NearQuickClientApi]) and
/// transaction builders ([NearQuickTransactionApi]).
abstract class NearQuickClient
    with
        NearQuickNodeApi,
        NearTokenQuickApi,
        NearQuickClientApi,
        NearQuickTransactionApi {}

class DefaultNearQuickClient extends NearQuickClient {
  @override
  final IProvider<IServiceProvider, BaseServiceRequestParams> provider;

  DefaultNearQuickClient(this.provider);
}
