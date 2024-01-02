import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/address/tron_address.dart';
import 'package:on_chain/tron/models/contract/assets_issue_contract/asset.dart';
import 'package:on_chain/tron/models/parsed_request/parsed_contract_request.dart';
import 'package:on_chain/tron/provider/core/request.dart';
import 'package:on_chain/tron/provider/methods/request_methods.dart';

/// Issue a TRC10 token. [developers.tron.network](https://developers.tron.network/reference/createassetissue).
class TronRequestCreateAssetIssue
    extends TVMRequestParam<ParsedContractRequest, Map<String, dynamic>> {
  factory TronRequestCreateAssetIssue.fromContract(AssetIssueContract contract,
      {bool visible = true}) {
    return TronRequestCreateAssetIssue(
        ownerAddress: contract.ownerAddress,
        name: StringUtils.decode(contract.name),
        abbr: StringUtils.decode(contract.abbr),
        totalSupply: contract.totalSupply,
        trxNum: contract.trxNum,
        num: contract.num,
        startTime: contract.startTime,
        endTime: contract.endTime,
        description: StringUtils.tryDecode(contract.description),
        url: StringUtils.tryDecode(contract.url),
        freeAssetNetLimit: contract.freeAssetNetLimit,
        publicFreeAssetNetLimit: contract.publicFreeAssetNetLimit,
        frozenSupply: (contract.frozenSupply)
            ?.map((e) => Map<String, BigInt>.from(
                {"frozen_amount": e.frozenAmount, "frozen_days": e.frozenDays}))
            .toList(),
        precision: contract.precision,
        visible: visible,
        publicFreeAssetNetUsage: contract.publicFreeAssetNetUsage,
        publicLatestFreeNetTime: contract.publicLatestFreeNetTime);
  }
  TronRequestCreateAssetIssue(
      {required this.ownerAddress,
      required this.name,
      required this.abbr,
      this.totalSupply,
      this.num,
      this.startTime,
      this.endTime,
      this.description,
      this.url,
      this.freeAssetNetLimit,
      this.publicFreeAssetNetLimit,
      this.frozenSupply,
      this.precision,
      required this.trxNum,
      this.publicFreeAssetNetUsage,
      this.publicLatestFreeNetTime,
      this.visible = true});

  /// issuer address
  final TronAddress ownerAddress;

  /// token name
  final String name;

  /// token abbr
  final String abbr;

  /// total supply
  final BigInt? totalSupply;

  /// Define the price by the ratio of trx_num/num(The unit of 'trx_num' is SUN)
  final int trxNum;

  /// Define the price by the ratio of trx_num/num(The unit of 'trx_num' is SUN)
  final int? num;

  /// ICO start time
  final BigInt? startTime;

  /// ICO end time
  final BigInt? endTime;

  /// token description
  final String? description;

  /// Token official website url
  final String? url;

  /// Token free asset net limit
  final BigInt? freeAssetNetLimit;

  /// Token public free asset net limit for a account
  final BigInt? publicFreeAssetNetLimit;

  /// The total number of token free bandwidth used by all token owner
  final BigInt? publicFreeAssetNetUsage;

  /// The timestamp of the last consumption of this token's free bandwidth
  final BigInt? publicLatestFreeNetTime;

  /// The number of tokens to be frozen is specified by the issuer of the token when it is issued
  final List<Map<String, BigInt>>? frozenSupply;

  /// precision
  final int? precision;
  @override
  final bool visible;

  @override
  TronHTTPMethods get method => TronHTTPMethods.createassetissue;

  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress,
      "name": name,
      "abbr": abbr,
      "total_supply": totalSupply,
      "trx_num": trxNum,
      "num": num,
      "start_time": startTime,
      "end_time": endTime,
      "description": description,
      "url": url,
      "free_asset_netimit": freeAssetNetLimit,
      "public_free_asset_netimit": publicFreeAssetNetLimit,
      "frozen_supply": frozenSupply,
      "precision": precision,
      "visible": visible
    };
  }

  @override
  ParsedContractRequest onResonse(result) {
    return ParsedContractRequest.fromJson(result);
  }

  @override
  String toString() {
    return "TronRequestCreateAssetIssue{${toJson()}}";
  }
}
