import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Query the transaction fee, block height by transaction id
/// [developers.tron.network](https://developers.tron.network/reference/gettransactioninfobyid).
class TronRequestGetTransactionInfoById
    extends TronRequest<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetTransactionInfoById({required this.value});

  /// Transaction hash
  final String value;

  /// wallet/gettransactioninfobyid
  @override
  TronHTTPMethods get method => TronHTTPMethods.gettransactioninfobyid;

  @override
  Map<String, dynamic> toJson() {
    return {'value': value};
  }
}
