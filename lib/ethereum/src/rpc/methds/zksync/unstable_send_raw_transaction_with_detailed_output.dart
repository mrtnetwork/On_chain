import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/types/zks.dart';

/// Executes a transaction and returns its hash, storage logs, and events that would have been
/// generated if the transaction had already been included in the block.
/// The API has a similar behaviour to eth_sendRawTransaction but with some extra data returned from it.
/// [zksync.io](https://docs.zksync.io/zksync-protocol/api/zks-rpc#unstable_sendrawtransactionwithdetailedoutput)
class ZKSRequestUnstableSendRawTransactionWithDetailedOutput
    extends EthereumRequest<ZkSyncSendRawTransactionWithDetailedOutput,
        Map<String, dynamic>> {
  final String signedTx;
  const ZKSRequestUnstableSendRawTransactionWithDetailedOutput(this.signedTx);
  @override
  String get method => "unstable_sendrawtransactionwithdetailedoutput";
  @override
  List<dynamic> toJson() {
    return [signedTx];
  }

  @override
  ZkSyncSendRawTransactionWithDetailedOutput onResonse(
      Map<String, dynamic> result) {
    return ZkSyncSendRawTransactionWithDetailedOutput.fromJson(result);
  }
}
