import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/assets_issue_contract/asset.dart';
import 'package:on_chain/tron/src/models/parsed_request/parsed_contract_request.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Update basic TRC10 token information.
/// [developers.tron.network](https://developers.tron.network/reference/wallet-updateasset).
class TronRequestUpdateAsset
    extends TVMRequestParam<ParsedContractRequest, Map<String, dynamic>> {
  factory TronRequestUpdateAsset.fromContract(
    UpdateAssetContract contract, {
    int? permissionId,
    bool visible = true,
  }) {
    return TronRequestUpdateAsset(
      ownerAddress: contract.ownerAddress,
      description: StringUtils.tryDecode(contract.description),
      url: StringUtils.tryDecode(contract.url),
      newLimit: contract.newLimit,
      newPublicLimit: contract.newPublicLimit,
      permissionId: permissionId,
      visible: visible,
    );
  }
  TronRequestUpdateAsset(
      {required this.ownerAddress,
      this.description,
      this.url,
      this.newLimit,
      this.newPublicLimit,
      this.permissionId,
      this.visible = true});

  /// The issuers address of the token
  final TronAddress ownerAddress;

  /// The description of token
  final String? description;

  /// The token's website url
  final String? url;

  /// Each token holder's free bandwidth
  final BigInt? newLimit;

  /// The total free bandwidth of the token
  final BigInt? newPublicLimit;

  /// for multi-signature use
  final int? permissionId;
  @override
  final bool visible;

  /// wallet/updateasset
  @override
  TronHTTPMethods get method => TronHTTPMethods.updateasset;

  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress,
      "description": description,
      "url": url,
      "newimit": newLimit,
      "new_publicimit": newPublicLimit,
      "permission_id": permissionId,
      "visible": visible
    };
  }

  @override
  String toString() {
    return "TronRequestUpdateAsset{${toJson()}}";
  }

  @override
  ParsedContractRequest onResonse(result) {
    return ParsedContractRequest.fromJson(result);
  }
}
