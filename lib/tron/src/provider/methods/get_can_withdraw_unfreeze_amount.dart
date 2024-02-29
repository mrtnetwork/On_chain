import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Query the withdrawable balance at the specified timestamp In Stake2.0
/// [developers.tron.network](https://developers.tron.network/reference/getcanwithdrawunfreezeamount-1).
class TronRequestGetCanWithdrawUnfreezeAmount
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetCanWithdrawUnfreezeAmount(
      {required this.ownerAddress,
      required this.timestamp,
      this.visible = true});
  final TronAddress ownerAddress;

  /// query cutoff timestamp, in milliseconds.
  final BigInt timestamp;
  @override
  final bool visible;

  /// wallet/getcanwithdrawunfreezeamount
  @override
  TronHTTPMethods get method => TronHTTPMethods.getcanwithdrawunfreezeamount;

  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress,
      "timestamp": timestamp,
      "visible": visible
    };
  }

  @override
  String toString() {
    return "TronRequestGetCanWithdrawUnfreezeAmount{${toJson()}}";
  }
}
