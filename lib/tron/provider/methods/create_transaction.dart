import 'package:on_chain/tron/address/tron_address.dart';
import 'package:on_chain/tron/models/contract/balance/transfer_contract.dart';
import 'package:on_chain/tron/models/parsed_request/parsed_contract_request.dart';
import 'package:on_chain/tron/provider/core/request.dart';
import 'package:on_chain/tron/provider/methods/request_methods.dart';

/// Create a TRX transfer transaction. If to_address does not exist, then create the account on the blockchain.
/// [developers.tron.network](https://developers.tron.network/reference/createtransaction).
class TronRequestCreateTransaction
    extends TVMRequestParam<ParsedContractRequest, Map<String, dynamic>> {
  TronRequestCreateTransaction(
      {required this.ownerAddress,
      required this.toAddress,
      required this.amount,
      this.permissionId,
      this.extraData,
      this.visible = true});
  factory TronRequestCreateTransaction.fromContract(TransferContract contract,
      {int? permissionId, bool visible = false}) {
    return TronRequestCreateTransaction(
        ownerAddress: contract.ownerAddress,
        toAddress: contract.toAddress,
        amount: contract.amount,
        permissionId: permissionId,
        visible: visible);
  }

  /// Transaction initiator address
  final TronAddress ownerAddress;

  /// Destination address
  final TronAddress toAddress;

  /// Transfer TRX amount, in sun
  final BigInt amount;

  /// for multi-signature use
  final int? permissionId;

  /// notes on the transaction,
  final String? extraData;
  @override
  final bool visible;

  @override
  TronHTTPMethods get method => TronHTTPMethods.createtransaction;

  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress,
      "to_address": toAddress,
      "amount": amount,
      "Permission_id": permissionId,
      "visible": visible,
      "extra_data": extraData,
    };
  }

  @override
  ParsedContractRequest onResonse(result) {
    return ParsedContractRequest.fromJson(result);
  }
}
