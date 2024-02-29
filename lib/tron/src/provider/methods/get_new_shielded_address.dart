import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// GetNewShieldedAddress
/// [developers.tron.network](https://developers.tron.network/reference/getnewshieldedaddress).
class TronRequestGetNewShieldedAddress
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetNewShieldedAddress();

  /// wallet/getnewshieldedaddress
  @override
  TronHTTPMethods get method => TronHTTPMethods.getnewshieldedaddress;

  @override
  Map<String, dynamic> toJson() {
    return {};
  }

  @override
  String toString() {
    return "TronRequestGetNewShieldedAddress{${toJson()}}";
  }
}
