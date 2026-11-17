import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/near/src/address/address.dart';
import 'package:on_chain/near/src/rpc/client/src/node_api.dart';
import 'package:on_chain/near/src/rpc/client/src/token_api.dart';
import 'package:on_chain/near/src/types/types.dart';

/// Base high-level NEAR calls with unified result types.
///
/// Composes the node ([NearQuickNodeApi]) and token ([NearTokenQuickApi])
/// read layers and adds the Solana/Ethereum-style conveniences
/// ([getBalance], [getBlockHeight], [trackTransaction]) on top, so one
/// client object covers every call.
mixin NearQuickClientApi on NearQuickNodeApi, NearTokenQuickApi {
  /// Alias of [getAccountBalance].
  Future<BigInt> getBalance(BaseNearAddress address) {
    return getAccountBalance(address);
  }

  /// Latest block height.
  Future<BigInt> getBlockHeight({
    NearBlockReference blockReference = NearBlockReference.optimistic,
    Duration? timeout,
  }) async {
    final response = await block(
      blockReference: blockReference,
      timeout: timeout,
    );
    return response.header.height;
  }

  /// Polls [getTransactionStatus] until ([txId], [accountId]) finalizes.
  /// Returns [NearTxStatus.block] once executed, throws when any outcome
  /// reports failure or [timeout] elapses.
  Future<NearTxStatus> trackTransaction({
    required String txId,
    required BaseNearAddress accountId,
    Duration timeout = const Duration(minutes: 1),
    Duration interval = const Duration(seconds: 2),
    Duration? requestTimeout,
  }) async {
    final deadline = DateTime.now().toUtc().add(timeout);
    while (DateTime.now().toUtc().isBefore(deadline)) {
      final status = await getTransactionStatus(
        txId: txId,
        accountId: accountId,
      );
      if (status == NearTxStatus.failed) {
        throw OnChainErrors.nearPlugin(
          'trackTransaction',
          reason: 'Transaction execution failed.',
          details: {'txId': txId},
        );
      }
      if (status == NearTxStatus.block) return status;
      await Future.delayed(interval);
    }
    throw OnChainErrors.nearPlugin(
      'trackTransaction',
      reason: 'Timed out while waiting for transaction result.',
      details: {'txId': txId, 'timeout': '$timeout'},
    );
  }
}
