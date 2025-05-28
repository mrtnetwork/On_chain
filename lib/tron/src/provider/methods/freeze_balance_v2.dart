import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/balance/balance.dart';
import 'package:on_chain/tron/src/models/contract/transaction/transaction.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// In Stake2.0, stake an amount of TRX to obtain bandwidth or energy,
/// and obtain equivalent TRON Power(TP) according to the staked amount.
/// [developers.tron.network](https://developers.tron.network/reference/freezebalancev2-1).
class TronRequestFreezeBalanceV2
    extends TronRequest<Transaction, Map<String, dynamic>> {
  factory TronRequestFreezeBalanceV2.fromContract(
      FreezeBalanceV2Contract contract,
      {int? permissionId,
      bool visible = true}) {
    return TronRequestFreezeBalanceV2(
        ownerAddress: contract.ownerAddress,
        frozenBalance: contract.frozenBalance,
        resource: contract.resource?.name,
        permissionId: permissionId,
        visible: visible);
  }
  TronRequestFreezeBalanceV2(
      {required this.ownerAddress,
      required this.frozenBalance,
      this.resource,
      this.permissionId,
      this.visible = true});

  /// Owner address
  final TronAddress ownerAddress;

  /// TRX stake amount, the unit is sun
  final BigInt frozenBalance;

  /// TRX stake type, 'BANDWIDTH' or 'ENERGY'
  final String? resource;

  /// for multi-signature use
  final int? permissionId;
  @override
  final bool visible;

  @override
  TronHTTPMethods get method => TronHTTPMethods.freezebalancev2;

  @override
  Map<String, dynamic> toJson() {
    return {
      'owner_address': ownerAddress.toAddress(visible),
      'frozen_balance': frozenBalance,
      'resource': resource,
      'Permission_id': permissionId,
      'visible': visible
    };
  }

  @override
  Transaction onResonse(result) {
    return Transaction.fromJson(result);
  }

  @override
  String toString() {
    return 'TronRequestFreezeBalanceV2{${toJson()}}';
  }
}
