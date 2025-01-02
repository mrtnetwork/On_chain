import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Cancel unstakings, all unstaked funds still in the waiting period will
/// be re-staked, all unstaked funds that exceeded the 14-day waiting period will be automatically
/// withdrawn to the owner’s account
/// [developers.tron.network](https://developers.tron.network/reference/cancelallunfreezev2).
class TronRequestCancelAllUnfreezeV2
    extends TronRequest<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestCancelAllUnfreezeV2(
      {required this.ownerAddress, this.permissionId, this.visible = true});

  /// Owner addres
  final TronAddress ownerAddress;

  /// for multi-signature use
  final int? permissionId;
  @override
  final bool visible;

  /// wallet/cancelallunfreezev2
  @override
  TronHTTPMethods get method => TronHTTPMethods.cancelallunfreezev2;

  @override
  Map<String, dynamic> toJson() {
    return {
      'owner_address': ownerAddress.toAddress(visible),
      'Permission_id': permissionId,
      'visible': visible
    };
  }

  @override
  String toString() {
    return 'TronRequestCancelAllUnfreezeV2{${toJson()}}';
  }
}
