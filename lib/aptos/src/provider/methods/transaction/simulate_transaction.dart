import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/aptos/src/provider/methods/methods/methods.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';

/// The output of the transaction will have the exact transaction outputs and events that runningan actual signed
/// transaction would have.  However, it will not have the associated statehashes,
/// as they are not updated in storage.  This can be used to estimate
/// the maximum gasunits for a submitted transaction.To use this, you must:
/// - Create a SignedTransaction with a zero-padded signature.
/// - Submit a SubmitTransactionRequest containing a UserTransactionRequest containing that signature.
/// To use this endpoint with BCS, you must submit a SignedTransactionencoded as BCS.
/// See SignedTransaction in types/src/transaction/mod.rs.
/// [aptos documation](https://aptos.dev/en/build/apis/fullnode-rest-api-reference)
class AptosRequestSimulateTransaction
    extends AptosPostRequest<Map<String, dynamic>, Map<String, dynamic>> {
  final List<int> signedTransactionData;
  final bool? estimateMaxGasAmount;
  final bool? estimateGasUnitPrice;
  final bool? estimatePrioritizedGasUnitPrice;

  AptosRequestSimulateTransaction(
      {required List<int> signedTransactionData,
      this.estimateGasUnitPrice,
      this.estimateMaxGasAmount,
      this.estimatePrioritizedGasUnitPrice})
      : signedTransactionData = signedTransactionData.asImmutableBytes;

  @override
  String get method => AptosApiMethod.simulateTransaction.url;

  @override
  Map<String, String?> get queryParameters => {
        "estimate_max_gas_amount": estimateMaxGasAmount?.toString(),
        "estimate_gas_unit_price": estimateGasUnitPrice?.toString(),
        "estimate_prioritized_gas_unit_price":
            estimatePrioritizedGasUnitPrice?.toString()
      };
  @override
  Map<String, String>? get headers =>
      {"content-Type": "application/x.aptos.signed_transaction+bcs"};

  @override
  List<int> get body => signedTransactionData;
}
