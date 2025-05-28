import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/balance/delegate_resource_contract.dart';
import 'package:on_chain/tron/src/models/contract/transaction/transaction.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Delegate bandwidth or energy resources to other accounts in Stake2.0.
/// [developers.tron.network](https://developers.tron.network/reference/delegateresource-1).
class TronRequestDelegateResource
    extends TronRequest<Transaction, Map<String, dynamic>> {
  factory TronRequestDelegateResource.fromContract(
      DelegateResourceContract contract,
      {int? permissionId}) {
    return TronRequestDelegateResource(
        ownerAddress: contract.ownerAddress,
        receiverAddress: contract.receiverAddress,
        balance: contract.balance,
        resource: contract.resource?.name,
        visible: true,
        lock: contract.lock,
        lockPeriod: contract.lockPeriod,
        permissionId: permissionId);
  }
  TronRequestDelegateResource(
      {required this.ownerAddress,
      required this.receiverAddress,
      required this.balance,
      required this.resource,
      this.lock = false,
      this.lockPeriod,
      this.permissionId,
      this.visible = true});

  /// Account address
  final TronAddress ownerAddress;

  /// 	Resource receiver address
  final TronAddress receiverAddress;

  /// Resource delegate amount, the unit is sun
  final BigInt balance;

  /// Resource type
  final String? resource;

  /// Whether to lock the resource delegation, true means locked the delegation,
  /// the delegating cannot be canceled within the period specified by lock_period,
  /// false means non-locked, the resource delegating can be canceled at any time
  final bool? lock;

  /// Lock period, the unit is block interval(3 seconds).
  /// Only when lock is true, this field is valid.
  /// If the delegate lock period is 1 day, the lock_period is 28800.
  final BigInt? lockPeriod;

  /// for multi-signature use
  final int? permissionId;
  @override
  final bool visible;

  /// wallet/delegateresource
  @override
  TronHTTPMethods get method => TronHTTPMethods.delegateresource;

  @override
  Map<String, dynamic> toJson() {
    return {
      'owner_address': ownerAddress.toAddress(visible),
      'receiver_address': receiverAddress.toAddress(visible),
      'balance': balance,
      'resource': resource,
      'lock': lock,
      'lock_period': lockPeriod,
      'visible': visible,
      'Permission_id': permissionId
    };
  }

  @override
  Transaction onResonse(result) {
    return Transaction.fromJson(result);
  }

  @override
  String toString() {
    return 'TronRequestDelegateResource{${toJson()}}';
  }
}
