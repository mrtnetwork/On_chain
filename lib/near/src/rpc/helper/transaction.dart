import 'package:on_chain/near/src/rpc/models/types/types.dart';

extension ExtTxStatusExtractor on NearRpcRpcTransactionResponse {
  NearRpcFinalExecutionStatus? status() => switch (this) {
    NearRpcRpcTransactionResponseFinalExecutionOutcomeWithReceiptView(
      :final value,
    ) =>
      value.status,
    NearRpcRpcTransactionResponseFinalExecutionOutcomeView(:final value) =>
      value.status,
    NearRpcRpcTransactionResponseVariant2() => null,
  };
}
