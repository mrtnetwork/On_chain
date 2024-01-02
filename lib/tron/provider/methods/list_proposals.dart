import 'package:on_chain/tron/provider/core/request.dart';
import 'package:on_chain/tron/provider/methods/request_methods.dart';

/// List all proposals.
/// [developers.tron.network](https://developers.tron.network/reference/wallet-listproposals).
class TronRequestListProposals
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  /// wallet/listproposals
  @override
  TronHTTPMethods get method => TronHTTPMethods.listproposals;

  @override
  Map<String, dynamic> toJson() {
    return {};
  }

  @override
  String toString() {
    return "TronRequestListProposals{${toJson()}}";
  }
}
