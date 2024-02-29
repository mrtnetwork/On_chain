import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/account/account_permission_update_contract.dart';
import 'package:on_chain/tron/src/models/parsed_request/parsed_contract_request.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Update the account's permission (developers.tron.network)[https://developers.tron.network/reference/accountpermissionupdate].
class TronRequestAccountPermissionUpdate
    extends TVMRequestParam<ParsedContractRequest, Map<String, dynamic>> {
  factory TronRequestAccountPermissionUpdate.fromContract(
      AccountPermissionUpdateContract contract,
      {int? permissionId}) {
    return TronRequestAccountPermissionUpdate(
        ownerAddress: contract.ownerAddress,
        actives: contract.actives.map((e) => e.toJson()).toList(),
        owner: contract.owner.toJson(),
        witness: contract.witness?.toJson(),
        permissionId: permissionId,
        visible: true);
  }
  TronRequestAccountPermissionUpdate({
    required this.ownerAddress,
    required this.actives,
    required this.owner,
    this.witness,
    this.permissionId,
    this.visible = true,
  });

  /// account address
  final TronAddress ownerAddress;

  /// The owner permission of the account.
  /// The fields contained in Permission are as follows:
  /// type - int: permission type; permission_name - string:
  /// permission name; threshold - int64: threshold; parent_id -
  /// int32: currently only 0; operations - string: permission; keys - Key[]:
  ///  the addresses and weights that jointly own the permission, up to 5 keys are allowed
  final Map<String, dynamic> owner;

  /// List of active permissions for the account
  final List<Map<String, dynamic>> actives;

  /// Account witness permissions
  final Map<String, dynamic>? witness;
  final int? permissionId;
  @override
  final bool visible;

  @override
  TronHTTPMethods get method => TronHTTPMethods.accountpermissionupdate;

  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress,
      "owner": owner,
      "witness": witness,
      "actives": actives,
      "visible": visible,
      "Permission_id": permissionId,
    };
  }

  @override
  String toString() {
    return "TronRequestAccountPermissionUpdate{${toJson()}}";
  }

  @override
  ParsedContractRequest onResonse(result) {
    return ParsedContractRequest.fromJson(result);
  }
}
