import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/account/accout.dart';
import 'package:on_chain/tron/src/models/parsed_request/parsed_contract_request.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

// Activate an account. Uses an already activated account to activate a new account.
/// Activate an account. [developers.tron.network](https://developers.tron.network/reference/account-createaccount).
class TronRequestCreateAccount
    extends TVMRequestParam<ParsedContractRequest, Map<String, dynamic>> {
  TronRequestCreateAccount(
      {required this.ownerAddress,
      required this.accountAddress,
      this.type,
      this.permissionId,
      this.visible = true});
  factory TronRequestCreateAccount.fromContract(
    AccountCreateContract contract, {
    int? permissionId,
    bool visible = true,
  }) {
    return TronRequestCreateAccount(
        ownerAddress: contract.ownerAddress,
        accountAddress: contract.accountAddress,
        type: contract.type?.name,
        permissionId: permissionId,
        visible: visible);
  }

  /// Transaction initiator address
  final TronAddress ownerAddress;

  /// Account address to be activated
  final TronAddress accountAddress;

  /// Account type. The external account type is 0, and this field will not be displayed in the return value
  final String? type;
  final int? permissionId;
  @override
  final bool visible;

  /// wallet/createaccount
  @override
  TronHTTPMethods get method => TronHTTPMethods.createaccount;

  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress,
      "account_address": accountAddress,
      "permission_id": permissionId,
      "type": type,
      "visible": visible
    };
  }

  @override
  String toString() {
    return "TronRequestCreateAccount{$toJson()}";
  }

  @override
  ParsedContractRequest onResonse(result) {
    return ParsedContractRequest.fromJson(result);
  }
}
