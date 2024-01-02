import 'package:on_chain/tron/provider/core/request.dart';
import 'package:on_chain/tron/provider/methods/request_methods.dart';

/// Query historical bandwidth unit price.
/// [developers.tron.network](https://developers.tron.network/reference/getbandwidthprices).
class TronRequestGetBandwidthPrices
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetBandwidthPrices();

  /// wallet/getbandwidthprices
  @override
  TronHTTPMethods get method => TronHTTPMethods.getbandwidthprices;

  @override
  Map<String, dynamic> toJson() {
    return {};
  }

  @override
  String toString() {
    return "TronRequestGetBandwidthPrices{${toJson()}}";
  }
}
