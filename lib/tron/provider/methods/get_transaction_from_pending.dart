import 'package:on_chain/tron/provider/core/request.dart';
import 'package:on_chain/tron/provider/methods/request_methods.dart';

/// Get transaction details from the pending pool
/// [developers.tron.network](https://developers.tron.network/reference/gettransactionfrompending).
class TronRequestGetTransactionFromPending
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetTransactionFromPending({required this.value});
  final String value;

  /// wallet/gettransactionfrompending
  @override
  TronHTTPMethods get method => TronHTTPMethods.gettransactionfrompending;

  @override
  Map<String, dynamic> toJson() {
    return {"value": value};
  }

  @override
  String toString() {
    return "TronRequestGetTransactionFromPending{${toJson()}}";
  }
}
