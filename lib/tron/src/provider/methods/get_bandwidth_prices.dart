import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Query historical bandwidth unit price.
/// [developers.tron.network](https://developers.tron.network/reference/getbandwidthprices).
class TronRequestGetBandwidthPrices
    extends TronRequest<Map<String, dynamic>, Map<String, dynamic>> {
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
    return 'TronRequestGetBandwidthPrices{${toJson()}}';
  }
}
