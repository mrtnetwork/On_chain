import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/assets_issue_contract/asset.dart';
import 'package:on_chain/tron/src/models/parsed_request/parsed_contract_request.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Participate in an asset issue..
/// [developers.tron.network](https://developers.tron.network/reference/participateassetissue).
class TronRequestParticipateAssetIssue
    extends TVMRequestParam<ParsedContractRequest, Map<String, dynamic>> {
  factory TronRequestParticipateAssetIssue.fromContract(
      ParticipateAssetIssueContract contract,
      {bool visible = true}) {
    return TronRequestParticipateAssetIssue(
        toAddress: contract.toAddress,
        ownerAddress: contract.ownerAddress,
        amount: contract.amount,
        assetName: StringUtils.decode(contract.assetName),
        visible: visible);
  }
  TronRequestParticipateAssetIssue(
      {required this.toAddress,
      required this.ownerAddress,
      required this.amount,
      required this.assetName,
      this.visible = true});

  final TronAddress toAddress;

  /// The number of trx participating in token issuance
  final TronAddress ownerAddress;

  /// The number of trx participating in token issuance
  final BigInt amount;

  /// Token id
  final String assetName;

  @override
  final bool visible;

  /// wallet/participateassetissue
  @override
  TronHTTPMethods get method => TronHTTPMethods.participateassetissue;

  @override
  Map<String, dynamic> toJson() {
    return {
      "to_address": toAddress,
      "owner_address": ownerAddress,
      "amount": amount,
      "asset_name": assetName,
      "visible": visible
    };
  }

  @override
  ParsedContractRequest onResonse(result) {
    return ParsedContractRequest.fromJson(result);
  }

  @override
  String toString() {
    return "TronRequestParticipateAssetIssue{${toJson()}}";
  }
}
