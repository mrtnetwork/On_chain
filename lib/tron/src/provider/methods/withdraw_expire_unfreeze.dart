import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Withdraw unfrozen balance in Stake2.0, the user can call this API to get back their funds after executing /wallet/unfreezebalancev2 transaction and waiting N days, N is a network parameter
/// [developers.tron.network](https://developers.tron.network/reference/withdrawexpireunfreeze).
class TronRequestWithdrawExpireUnfreeze
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestWithdrawExpireUnfreeze(
      {required this.ownerAddress, this.permissionId, this.visible = true});

  /// Owner address
  final TronAddress ownerAddress;

  /// for multi-signature use
  final int? permissionId;
  @override
  final bool visible;

  /// wallet/withdrawexpireunfreeze
  @override
  TronHTTPMethods get method => TronHTTPMethods.withdrawexpireunfreeze;

  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress,
      "visible": visible,
      "Permission_id": permissionId
    };
  }

  @override
  String toString() {
    return "TronRequestWithdrawExpireUnfreeze{${toJson()}}";
  }
}
