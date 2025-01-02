import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// GetTriggerInputForShieldedTrc20Contract
/// [developers.tron.network](https://developers.tron.network/reference/gettriggerinputforshieldedtrc20contract).
class TronRequestGetTriggerInputForShieldedTrc20Contract
    extends TronRequest<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetTriggerInputForShieldedTrc20Contract();

  /// wallet/gettriggerinputforshieldedtrc20contract
  @override
  TronHTTPMethods get method =>
      TronHTTPMethods.gettriggerinputforshieldedtrc20contract;

  @override
  Map<String, dynamic> toJson() {
    return {};
  }

  @override
  String toString() {
    return 'TronRequestGetTriggerInputForShieldedTrc20Contract{${toJson()}}';
  }
}
