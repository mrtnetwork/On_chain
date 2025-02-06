import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/aptos/src/provider/methods/methods/methods.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/models/types.dart';

/// This endpoint accepts transaction submissions in two formats.To submit a transaction as JSON,
/// you must submit a SubmitTransactionRequest.
/// To build this request, do the following:
/// 1. Encode the transaction as BCS. If you are using a language that hasnative BCS support,
/// make sure of that library. If not, you may takeadvantage of /transactions/encode_submission.
/// When using thisendpoint, make sure you trust the node you're talking to, as it ispossible
/// they could manipulate your request.2. Sign the encoded transaction and use it to create a TransactionSignature.
/// 3. Submit the request. Make sure to use the \"application/json\" Content-Type.To submit a transaction as BCS,
/// you must submit a SignedTransactionencoded as BCS. See SignedTransaction in types/src/transaction/mod.rs.Make
/// sure to use the `application/x.aptos.signed_transaction+bcs` Content-Type.
/// [aptos documation](https://aptos.dev/en/build/apis/fullnode-rest-api-reference)
class AptosRequestSubmitTransaction
    extends AptosPostRequest<AptosApiPendingTransaction, Map<String, dynamic>> {
  final List<int> signedTransactionData;

  AptosRequestSubmitTransaction({required List<int> signedTransactionData})
      : signedTransactionData = signedTransactionData.asImmutableBytes;

  @override
  String get method => AptosApiMethod.submitTransaction.url;

  @override
  Map<String, String>? get headers =>
      {"content-Type": "application/x.aptos.signed_transaction+bcs"};

  @override
  List<int> get body => signedTransactionData;

  @override
  AptosApiPendingTransaction onResonse(Map<String, dynamic> result) {
    return AptosApiPendingTransaction.fromJson(result);
  }
}
