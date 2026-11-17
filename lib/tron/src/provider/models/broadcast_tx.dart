import 'package:on_chain/tron/src/models/contracts/transaction/tron.dart';

class TronBroadcastTxResult {
  final bool? result;
  final String? code;
  final String? message;
  final String txid;
  final TronTransaction transaction;
  const TronBroadcastTxResult({
    this.result,
    this.code,
    this.message,
    required this.txid,
    required this.transaction,
  });

  Map<String, dynamic> toJson() {
    return {
      "result": result,
      "code": code,
      "message": message,
      "txId": txid,
      "transaction": transaction.toJson(),
    };
  }
}
