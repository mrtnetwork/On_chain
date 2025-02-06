import 'package:on_chain/aptos/src/provider/methods/methods/methods.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/models/types.dart';

/// Look up a transaction by its hash. This is the same hash that is returnedby
/// the API when submitting a transaction (see PendingTransaction).
/// When given a transaction hash, the server first looks for the transactionin storage (on-chain, committed).
/// If no on-chain transaction is found, itlooks the transaction up by hash in the mempool
/// (pending, not yet committed).To create a transaction hash by yourself, do the following:
/// 1. Hash message bytes: \"RawTransaction\" bytes + BCS bytes of [Transaction](https://aptos-labs.github.io/aptos-core/aptos_types/transaction/enum.Transaction.html).
/// 2. Apply hash algorithm `SHA3-256` to the hash message bytes.3. Hex-encode the hash bytes with `0x` prefix.
/// [aptos documation](https://aptos.dev/en/build/apis/fullnode-rest-api-reference)
class AptosRequestGetTransactionByHash
    extends AptosRequest<AptosApiTransaction, Map<String, dynamic>> {
  AptosRequestGetTransactionByHash(this.txnHash);

  /// Hash of transaction to retrieve
  final String txnHash;
  @override
  String get method => AptosApiMethod.getTransactionByHash.url;

  @override
  List<String> get pathParameters => [txnHash];

  @override
  AptosApiTransaction onResonse(Map<String, dynamic> result) {
    return AptosApiTransaction.fromJson(result);
  }
}
