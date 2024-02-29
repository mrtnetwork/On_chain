import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Query the amount of TRX burned due to on-chain transaction fees since No. 54 Committee Proposal took effect
/// [developers.tron.network](https://developers.tron.network/reference/getburntrx).
class TronRequestGetBurnTrx
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetBurnTrx();

  /// wallet/getburntrx
  @override
  TronHTTPMethods get method => TronHTTPMethods.getburntrx;

  @override
  Map<String, dynamic> toJson() {
    return {};
  }

  @override
  String toString() {
    return "TronRequestGetBurnTrx{${toJson()}}";
  }
}
