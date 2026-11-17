import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tezos/src/rpc/api/api/baker_api.dart';
import 'package:on_chain/tezos/src/rpc/api/api/confirmation.dart';
import 'package:on_chain/tezos/src/rpc/api/api/contract_api.dart';
import 'package:on_chain/tezos/src/rpc/api/api/operations_api.dart';
import 'package:on_chain/tezos/src/rpc/api/api/pipeline_api.dart';
import 'package:on_chain/tezos/src/rpc/api/api/rollup_api.dart';
import 'package:on_chain/tezos/src/rpc/api/api/ticket_api.dart';
import 'package:on_chain/tezos/src/rpc/api/api/wallet_api.dart';
import 'package:on_chain/tezos/src/rpc/api/api/quick_api.dart';
import 'package:on_chain/tezos/src/rpc/api/api/token_api.dart';
import 'package:on_chain/tezos/src/rpc/api/types/client_config.dart';
import 'package:on_chain/tezos/src/rpc/core/core.dart';

/// Default Tezos client.
///
/// Public flow:
/// 1. `build*` → operation objects
/// 2. [estimate] → ops with fee/gas/storage
/// 3. [fill] → counters + reveal if needed
/// 4. [injectOperations] / [injectContents] → [TezosInjectResult]
class DefaultTezosClient
    with
        TezosQuickApi,
        TezosConfirmation,
        TezosPipelineApi,
        TezosContractApi,
        TezosTokenQuickApi,
        TezosOperationsApi,
        TezosWalletApi,
        TezosTicketApi,
        TezosBakerApi,
        TezosRollupApi {
  @override
  final IProvider<IServiceProvider, OctezRequestDetails> provider;

  @override
  final TezosClientConfig config;

  const DefaultTezosClient({
    required this.provider,
    this.config = TezosClientConfig.defaults,
  });
}
