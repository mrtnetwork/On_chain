import 'package:on_chain/tron/address/tron_address.dart';
import 'package:on_chain/tron/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/models/contract/assets_issue_contract/frozensupply.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

class AssetIssueContract extends TronBaseContract {
  /// Create a new [AssetIssueContract] instance by parsing a JSON map.
  factory AssetIssueContract.fromJson(Map<String, dynamic> json) {
    return AssetIssueContract(
      ownerAddress: TronAddress(json['owner_address']),
      name: StringUtils.encode(json['name']),
      abbr: StringUtils.encode(json['abbr']),
      totalSupply: BigInt.from(json['total_supply']),
      frozenSupply: (json['frozen_supply'] as List<dynamic>?)
          ?.map((frozenSupplyJson) =>
              AssetIssueContractFrozenSupply.fromJson(frozenSupplyJson))
          .toList(),
      trxNum: json['trx_num'],
      precision: json['precision'],
      num: json['num'],
      startTime: BigintUtils.parse(json['start_time']),
      endTime: BigintUtils.parse(json['end_time']),
      order: BigintUtils.tryParse(json['order']),
      voteScore: json['vote_score'],
      description: StringUtils.tryEncode(json['description']),
      url: StringUtils.tryEncode(json['url']),
      freeAssetNetLimit: BigintUtils.tryParse(json['free_asset_netimit']),
      publicFreeAssetNetLimit:
          BigintUtils.tryParse(json['public_free_asset_netimit']),
      publicFreeAssetNetUsage:
          BigintUtils.tryParse(json['public_free_asset_net_usage']),
      publicLatestFreeNetTime:
          BigintUtils.tryParse(json['publicatest_free_net_time']),
      id: json['id'],
    );
  }

  /// Private constructor for creating an instance of [AssetIssueContract].
  AssetIssueContract({
    required this.ownerAddress,
    required List<int> name,
    required List<int> abbr,
    required this.totalSupply,
    List<AssetIssueContractFrozenSupply>? frozenSupply,
    required this.trxNum,
    required this.num,
    this.precision,
    required this.startTime,
    required this.endTime,
    this.order,
    this.voteScore,
    List<int>? description,
    List<int>? url,
    this.freeAssetNetLimit,
    this.publicFreeAssetNetLimit,
    this.publicFreeAssetNetUsage,
    this.publicLatestFreeNetTime,
    this.id,
  })  : name = BytesUtils.toBytes(name, unmodifiable: true),
        abbr = BytesUtils.toBytes(abbr, unmodifiable: true),
        frozenSupply =
            frozenSupply != null ? List.unmodifiable(frozenSupply) : null,
        description = BytesUtils.tryToBytes(description, unmodifiable: true),
        url = BytesUtils.tryToBytes(url, unmodifiable: true);

  /// issuer address
  final TronAddress ownerAddress;

  /// token name
  final List<int> name;

  /// token abbr
  final List<int> abbr;

  /// total supply
  final BigInt totalSupply;

  /// The number of tokens to be frozen is specified by the issuer of the token when it is issued
  final List<AssetIssueContractFrozenSupply>? frozenSupply;

  /// Define the price by the ratio of trx_num/num(The unit of 'trx_num' is SUN)
  final int trxNum;

  /// precision
  final int? precision;

  /// Define the price by the ratio of trx_num/num(The unit of 'trx_num' is SUN)
  final int num;

  /// ICO start time
  final BigInt startTime;

  /// ICO end time
  final BigInt endTime;
  final BigInt? order;
  final int? voteScore;

  /// token description
  final List<int>? description;

  /// Token official website url, default hexString
  final List<int>? url;

  /// Token free asset net limit
  final BigInt? freeAssetNetLimit;

  /// Token public free asset net limit for a account
  final BigInt? publicFreeAssetNetLimit;

  /// The total number of token free bandwidth used by all token owne
  final BigInt? publicFreeAssetNetUsage;

  /// The timestamp of the last consumption of this token's free bandwidth
  final BigInt? publicLatestFreeNetTime;
  final String? id;

  @override
  List get values => [
        ownerAddress,
        name,
        abbr,
        totalSupply,
        frozenSupply,
        trxNum,
        precision,
        num,
        startTime,
        endTime,
        order,
        voteScore,
        description,
        url,
        freeAssetNetLimit,
        publicFreeAssetNetLimit,
        publicFreeAssetNetUsage,
        publicLatestFreeNetTime,
        id
      ];
  @override
  List<int> get fieldIds =>
      [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 16, 20, 21, 22, 23, 24, 25, 41];

  /// Convert the [AssetIssueContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress.toString(),
      "name": StringUtils.decode(name),
      "abbr": StringUtils.decode(abbr),
      "total_supply": totalSupply.toString(),
      "trx_num": trxNum,
      "num": num,
      "start_time": startTime.toString(),
      "end_time": endTime.toString(),
      "description": StringUtils.tryDecode(description),
      "url": StringUtils.tryDecode(url),
      "free_asset_netimit": freeAssetNetLimit?.toString(),
      "public_free_asset_netimit": publicFreeAssetNetLimit?.toString(),
      "frozen_supply": frozenSupply?.map((e) => e.toJson()).toList(),
      "precision": precision,
    }..removeWhere((key, value) => value == null);
  }

  /// Convert the [AssetIssueContract] object to its string representation.
  @override
  String toString() {
    return "AssetIssueContract{${toJson()}}";
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.assetIssueContract;
}
