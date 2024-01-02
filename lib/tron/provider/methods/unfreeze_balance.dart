import 'package:on_chain/tron/address/tron_address.dart';
import 'package:on_chain/tron/provider/core/request.dart';
import 'package:on_chain/tron/provider/methods/request_methods.dart';

/// Unstake the TRX staked during Stake1.0, release the obtained bandwidth or energy and TP. This operation will cause automatically cancel all votes.
/// [developers.tron.network](https://developers.tron.network/reference/account-resources-unfreezebalance).
class TronRequestUnfreezeBalance
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestUnfreezeBalance(
      {required this.ownerAddress,
      required this.resource,
      this.receiverAddress,
      this.permissionId,
      this.visible = true});

  /// Owner address
  final TronAddress ownerAddress;

  /// Stake TRX for 'BANDWIDTH' or 'ENERGY'
  final String resource;

  /// Optional,the address that will lose the resource
  final TronAddress? receiverAddress;

  /// for multi-signature use
  final int? permissionId;

  @override
  final bool visible;

  /// wallet/unfreezebalance
  @override
  TronHTTPMethods get method => TronHTTPMethods.unfreezebalance;

  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress,
      "resource": resource,
      "receiver_address": receiverAddress,
      "Permission_id": permissionId,
      "visible": visible
    };
  }

  @override
  String toString() {
    return "TronRequestUnfreezeBalance{${toJson()}}";
  }
}
