import 'package:on_chain/tron/address/tron_address.dart';
import 'package:on_chain/tron/provider/core/request.dart';
import 'package:on_chain/tron/provider/methods/request_methods.dart';

/// Remaining times of executing unstake operation in Stake2.0
/// [developers.tron.network](https://developers.tron.network/reference/getassetissuelist).
class TronRequestGetAvailableUnfreezeCount
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetAvailableUnfreezeCount(
      {required this.ownerAddress, this.visible = true});

  /// Owner address
  final TronAddress ownerAddress;
  @override
  final bool visible;

  /// wallet/getavailableunfreezecount
  @override
  TronHTTPMethods get method => TronHTTPMethods.getavailableunfreezecount;

  @override
  Map<String, dynamic> toJson() {
    return {"owner_address": ownerAddress, "visible": visible};
  }

  @override
  String toString() {
    return "TronRequestGetAvailableUnfreezeCount{${toJson()}}";
  }
}
