import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// In Stake2.0, query the amount of delegatable resources share of the specified resource type for an address, unit is sun.
/// [developers.tron.network](https://developers.tron.network/reference/getcandelegatedmaxsize).
class TronRequestGetCanDelegatedMaxSize
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetCanDelegatedMaxSize(
      {required this.ownerAddress, required this.type, this.visible = true});
  final TronAddress ownerAddress;

  /// resource type, 0 is bandwidth, 1 is energy
  final int type;
  @override
  final bool visible;

  /// wallet/getcandelegatedmaxsize
  @override
  TronHTTPMethods get method => TronHTTPMethods.getcandelegatedmaxsize;

  @override
  Map<String, dynamic> toJson() {
    return {"owner_address": ownerAddress, "type": type, "visible": visible};
  }

  @override
  String toString() {
    return "TronRequestGetCanDelegatedMaxSize{${toJson()}}";
  }
}
