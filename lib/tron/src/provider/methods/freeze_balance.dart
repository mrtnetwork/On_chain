import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// FreezeBalance
/// This interface has been deprecated, please use FreezeBalanceV2 to stake TRX to obtain resources.
/// [developers.tron.network](https://developers.tron.network/reference/account-resources-freezebalance).
class TronRequestFreezeBalance
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestFreezeBalance(
      {required this.ownerAddress,
      required this.frozenBalance,
      required this.frozenDuration,
      required this.resource,
      this.receiverAddress,
      this.permissionId,
      this.visible = true});

  /// Owner address
  final TronAddress ownerAddress;

  /// TRX stake amount, the unit is sun
  final BigInt frozenBalance;

  /// Lock-up duration for this stake, now the value can only be 3 days.
  /// It is not allowed to unstake within 3 days after the stake. You can unstake TRX after the 3 lock-up days
  final int frozenDuration;

  /// TRX stake type, 'BANDWIDTH' or 'ENERGY'
  final String resource;

  /// the address that will receive the resource
  final TronAddress? receiverAddress;

  /// for multi-signature use
  final int? permissionId;
  @override
  final bool visible;

  /// wallet/freezebalance
  @override
  TronHTTPMethods get method => TronHTTPMethods.freezebalance;

  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress,
      "frozen_balance": frozenBalance,
      "frozen_duration": frozenDuration,
      "resource": resource,
      "receiver_address": receiverAddress,
      "Permission_id": permissionId,
      "visible": visible
    };
  }

  @override
  String toString() {
    return "TronRequestFreezeBalance{${toJson()}}";
  }
}
