import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Note:To ensure security, Trongrid has disabled this interface service, please use the service provided by the local node.
/// [developers.tron.network](https://developers.tron.network/reference/getspendingkey).
class TronRequestGetSpendingKey
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  /// wallet/getspendingkey
  @override
  TronHTTPMethods get method => TronHTTPMethods.getspendingkey;

  @override
  Map<String, dynamic> toJson() {
    return {};
  }

  @override
  String toString() {
    return "TronRequestGetSpendingKey{${toJson()}}";
  }
}
