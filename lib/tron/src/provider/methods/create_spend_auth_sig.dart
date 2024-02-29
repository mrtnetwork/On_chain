import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// CreateSpendAuthSig. [developers.tron.network](https://developers.tron.network/reference/createspendauthsig).
class TronRequestCreateSpendAuthSig
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestCreateSpendAuthSig(
      {required this.ask, required this.txHash, required this.alpha});
  final String ask;
  final String txHash;
  final String alpha;

  @override
  TronHTTPMethods get method => TronHTTPMethods.createspendauthsig;

  @override
  Map<String, dynamic> toJson() {
    return {"ask": ask, "tx_hash": txHash, "alpha": alpha};
  }

  @override
  bool get visible => true;
}
