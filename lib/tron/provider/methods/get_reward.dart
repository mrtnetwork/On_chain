import 'package:on_chain/tron/address/tron_address.dart';
import 'package:on_chain/tron/provider/core/request.dart';
import 'package:on_chain/tron/provider/methods/request_methods.dart';

/// Get the rewards that a witness or a user has not yet withdrawn.
/// [developers.tron.network](https://developers.tron.network/reference/wallet-getreward).
class TronRequestGetReward
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetReward({required this.address, this.visible = true});
  final TronAddress address;
  @override
  final bool visible;

  /// wallet/getReward
  @override
  TronHTTPMethods get method => TronHTTPMethods.getReward;

  @override
  Map<String, dynamic> toJson() {
    return {"address": address, "visible": visible};
  }

  @override
  String toString() {
    return "TronRequestGetReward{${toJson()}}";
  }
}
