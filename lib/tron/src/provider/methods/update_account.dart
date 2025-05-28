import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/account/account.dart';
import 'package:on_chain/tron/src/models/contract/transaction/transaction.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Modify account name
/// [developers.tron.network](https://developers.tron.network/reference/updateaccount).
class TronRequestUpdateAccount
    extends TronRequest<Transaction, Map<String, dynamic>> {
  factory TronRequestUpdateAccount.fromContract(AccountUpdateContract contract,
      {int? permissionId, bool visible = true}) {
    return TronRequestUpdateAccount(
        ownerAddress: contract.ownerAddress,
        accountName: StringUtils.decode(contract.accountName),
        pemissionId: permissionId,
        visible: visible);
  }
  TronRequestUpdateAccount(
      {required this.ownerAddress,
      required this.accountName,
      this.pemissionId,
      this.visible = true});

  /// Owner_address is the account address to be modified,
  final TronAddress ownerAddress;

  /// Account_name is the name of the account
  final String accountName;
  final int? pemissionId;
  @override
  final bool visible;

  /// wallet/updateaccount
  @override
  TronHTTPMethods get method => TronHTTPMethods.updateaccount;

  @override
  Map<String, dynamic> toJson() {
    return {
      'owner_address': ownerAddress.toAddress(visible),
      'account_name': accountName,
      'visible': visible,
      'Permission_id': pemissionId
    };
  }

  @override
  String toString() {
    return 'TronRequestUpdateAccount{${toJson()}}';
  }

  @override
  Transaction onResonse(result) {
    return Transaction.fromJson(result);
  }
}
