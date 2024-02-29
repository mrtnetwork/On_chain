import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Get transaction list information from pending pool
/// [developers.tron.network](https://developers.tron.network/reference/gettransactionlistfrompending).
class TronRequestGetTransactionListFromPending
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetTransactionListFromPending();

  /// wallet/gettransactionlistfrompending
  @override
  TronHTTPMethods get method => TronHTTPMethods.gettransactionlistfrompending;

  @override
  Map<String, dynamic> toJson() {
    return {};
  }

  @override
  String toString() {
    return "TronRequestGetTransactionListFromPending{${toJson()}}";
  }
}
