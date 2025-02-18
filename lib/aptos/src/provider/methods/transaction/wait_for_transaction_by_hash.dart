import 'package:on_chain/aptos/src/provider/methods/methods/methods.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/fullnode/types.dart';

/// Same as /transactions/by_hash, but will wait for a pending transaction to be committed.
/// To be used as a longpoll optimization by clients, to reduce latency caused by polling.
/// The \"long\" poll is generally a second orless but dictated by the server;
/// the client must deal with the result as if the request was a normal/transactions/by_hash request, e.g.,
/// by retrying if the transaction is pending.
/// [aptos documation](https://aptos.dev/en/build/apis/fullnode-rest-api-reference)
class AptosRequestWaitForTransactionByHash
    extends AptosRequest<AptosApiTransaction, Map<String, dynamic>> {
  AptosRequestWaitForTransactionByHash(this.txnHash);

  /// Hash of transaction to retrieve
  final String txnHash;
  @override
  String get method => AptosApiMethod.waitForTransactionByHash.url;

  @override
  List<String> get pathParameters => [txnHash];

  @override
  AptosApiTransaction onResonse(Map<String, dynamic> result) {
    return AptosApiTransaction.fromJson(result);
  }
}
