import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/balance/undelegate_resource_contract.dart';
import 'package:on_chain/tron/src/models/parsed_request/parsed_contract_request.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Cancel the delegation of bandwidth or energy resources to other accounts in Stake2.0
/// [developers.tron.network](https://developers.tron.network/reference/undelegateresource-1).
class TronRequestUndelegateResource
    extends TVMRequestParam<ParsedContractRequest, Map<String, dynamic>> {
  factory TronRequestUndelegateResource.fromContract(
      UnDelegateResourceContract contract,
      {int? permissionId}) {
    return TronRequestUndelegateResource(
        ownerAddress: contract.ownerAddress,
        receiverAddress: contract.receiverAddress,
        balance: contract.balance,
        resource: contract.resource?.name,
        permissionId: permissionId);
  }
  TronRequestUndelegateResource(
      {required this.ownerAddress,
      required this.receiverAddress,
      required this.balance,
      this.resource,
      this.permissionId,
      this.visible = true});

  /// Owner address
  final TronAddress ownerAddress;

  /// Resource receiver address
  final TronAddress receiverAddress;

  /// Amount of TRX staked for resources to be delegated, unit is sun
  final BigInt balance;

  /// Resource type: 'BANDWIDTH' or 'ENERGY'
  final String? resource;

  /// for multi-signature use
  final int? permissionId;
  @override
  final bool visible;

  /// wallet/undelegateresource
  @override
  TronHTTPMethods get method => TronHTTPMethods.undelegateresource;

  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress,
      "receiver_address": receiverAddress,
      "balance": balance,
      "resource": resource,
      "visible": visible,
      "Permission_id": permissionId
    };
  }

  @override
  ParsedContractRequest onResonse(result) {
    return ParsedContractRequest.fromJson(result);
  }

  @override
  String toString() {
    return "TronRequestUndelegateResource{${toJson()}}";
  }
}
