import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Query the list of nodes connected to the API node
/// [developers.tron.network](https://developers.tron.network/reference/wallet-listnodes).
class TronRequestListNodes
    extends TronRequest<Map<String, dynamic>, Map<String, dynamic>> {
  /// wallet/listnodes
  @override
  TronHTTPMethods get method => TronHTTPMethods.listnodes;

  @override
  Map<String, dynamic> toJson() {
    return {};
  }

  @override
  String toString() {
    return 'TronRequestListNodes{${toJson()}}';
  }
}
