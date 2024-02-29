import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Query the transaction fee, block height by transaction id
/// [developers.tron.network](https://developers.tron.network/reference/gettransactioninfobyid).
class TronRequestGetTransactionById
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetTransactionById({required this.value});

  /// Transaction hash
  final String value;

  /// wallet/gettransactionbyid
  @override
  TronHTTPMethods get method => TronHTTPMethods.gettransactionbyid;

  @override
  Map<String, dynamic> toJson() {
    return {"value": value};
  }

  @override
  String toString() {
    return "TronRequestGetTransactionById{${toJson()}}";
  }
}
