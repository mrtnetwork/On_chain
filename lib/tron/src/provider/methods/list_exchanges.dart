import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// List all exchange pairs.
/// [developers.tron.network](https://developers.tron.network/reference/wallet-listexchanges).
class TronRequestListExchanges
    extends TronRequest<Map<String, dynamic>, Map<String, dynamic>> {
  /// wallet/listexchanges
  @override
  TronHTTPMethods get method => TronHTTPMethods.listexchanges;

  @override
  Map<String, dynamic> toJson() {
    return {};
  }

  @override
  String toString() {
    return 'TronRequestListExchanges{${toJson()}}';
  }
}
