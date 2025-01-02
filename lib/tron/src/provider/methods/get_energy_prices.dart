import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Query historical energy unit price
/// [developers.tron.network](https://developers.tron.network/reference/getenergyprices).
class TronRequestGetEnergyPrices
    extends TronRequest<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetEnergyPrices();

  /// wallet/getenergyprices
  @override
  TronHTTPMethods get method => TronHTTPMethods.getenergyprices;

  @override
  Map<String, dynamic> toJson() {
    return {};
  }

  @override
  String toString() {
    return 'TronRequestGetEnergyPrices{${toJson()}}';
  }
}
