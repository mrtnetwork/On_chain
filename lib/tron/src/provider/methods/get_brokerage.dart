import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Get SR brokerage ratio
/// [developers.tron.network](https://developers.tron.network/reference/wallet-getbrokerage).
class TronRequestGetBrokerage
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetBrokerage({required this.address, this.visible = true});

  /// Super representative's account address
  final TronAddress address;
  @override
  final bool visible;

  /// wallet/getBrokerage
  @override
  TronHTTPMethods get method => TronHTTPMethods.getBrokerage;
  @override
  Map<String, dynamic> toJson() {
    return {"address": address, "visible": visible};
  }

  @override
  String toString() {
    return "TronRequestGetBrokerage{${toJson()}}";
  }
}
