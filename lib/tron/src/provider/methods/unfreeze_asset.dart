import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/transaction/transaction.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Unstake a token that has passed the minimum freeze duration.
/// [developers.tron.network](https://developers.tron.network/reference/unfreezeasset).
class TronRequestUnfreezeAsset
    extends TronRequest<Transaction, Map<String, dynamic>> {
  TronRequestUnfreezeAsset(
      {required this.ownerAddress, this.permissionId, this.visible = true});

  /// Owner address
  final TronAddress ownerAddress;

  /// for multi-signature use
  final int? permissionId;
  @override
  final bool visible;

  /// wallet/unfreezeasset
  @override
  TronHTTPMethods get method => TronHTTPMethods.unfreezeasset;

  @override
  Map<String, dynamic> toJson() {
    return {
      'owner_address': ownerAddress.toAddress(visible),
      'permission_id': permissionId,
      'visible': visible
    };
  }

  @override
  String toString() {
    return 'TronRequestUnfreezeAsset{${toJson()}}';
  }

  @override
  Transaction onResonse(result) {
    return Transaction.fromJson(result);
  }
}
