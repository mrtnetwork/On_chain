import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/src/models/contract/assets_issue_contract/frozensupply.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';
import 'package:on_chain/utils/utils/utils.dart';

class AssetIssueContract extends TronBaseContract {
  /// Create a new [AssetIssueContract] instance by parsing a JSON map.
  factory AssetIssueContract.fromJson(Map<String, dynamic> json) {
    return AssetIssueContract(
      ownerAddress: OnChainUtils.parseTronAddress(
          value: json['owner_address'], name: "owner_address"),
      name: OnChainUtils.parseBytes(value: json['name'], name: "name"),
      abbr: OnChainUtils.parseBytes(value: json['abbr'], name: "abbr"),
      totalSupply: OnChainUtils.parseBigInt(
          value: json['total_supply'], name: "total_supply"),
      frozenSupply: OnChainUtils.parseList(
              value: json['frozen_supply'], name: "frozen_supply")
          ?.map((frozenSupplyJson) =>
              AssetIssueContractFrozenSupply.fromJson(frozenSupplyJson))
          .toList(),
      trxNum: OnChainUtils.parseInt(value: json['trx_num'], name: "trx_num"),
      precision:
          OnChainUtils.parseInt(value: json['precision'], name: "precision"),
      num: OnChainUtils.parseInt(value: json["num"], name: "num"),
      startTime: OnChainUtils.parseBigInt(
          value: json['start_time'], name: "start_time"),
      endTime:
          OnChainUtils.parseBigInt(value: json['end_time'], name: "end_time"),
      order: OnChainUtils.parseBigInt(value: json['order'], name: "order"),
      voteScore:
          OnChainUtils.parseInt(value: json["vote_score"], name: "vote_score"),
      description: OnChainUtils.parseBytes(
          value: json['description'], name: "description"),
      url: OnChainUtils.parseBytes(value: json['url'], name: "url"),
      freeAssetNetLimit: OnChainUtils.parseBigInt(
          value: json['free_asset_netimit'], name: "name"),
      publicFreeAssetNetLimit: OnChainUtils.parseBigInt(
          value: json['public_free_asset_netimit'],
          name: "public_free_asset_netimit"),
      publicFreeAssetNetUsage: OnChainUtils.parseBigInt(
          value: json['public_free_asset_net_usage'],
          name: "public_free_asset_net_usage"),
      publicLatestFreeNetTime: OnChainUtils.parseBigInt(
          value: json["publicatest_free_net_time"],
          name: "publicatest_free_net_time"),
      id: OnChainUtils.parseString(value: json['id'], name: "id"),
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
        frozenSupply = (frozenSupply?.isNotEmpty ?? false)
            ? List.unmodifiable(frozenSupply!)
            : null,
        description = BytesUtils.tryToBytes(description, unmodifiable: true),
        url = BytesUtils.tryToBytes(url, unmodifiable: true);

  factory AssetIssueContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return AssetIssueContract(
        ownerAddress: TronAddress.fromBytes(decode.getField(1)),
        name: decode.getField(2),
        abbr: decode.getField(3),
        totalSupply: decode.getField(4),
        frozenSupply: decode
            .getFields<List<int>>(5)
            .map((e) => AssetIssueContractFrozenSupply.deserialize(e))
            .toList(),
        trxNum: decode.getField(6),
        precision: decode.getField(7),
        num: decode.getField(8),
        startTime: decode.getField(9),
        endTime: decode.getField(10),
        order: decode.getField(11),
        voteScore: decode.getField(16),
        description: decode.getField(20),
        url: decode.getField(21),
        freeAssetNetLimit: decode.getField(22),
        publicFreeAssetNetLimit: decode.getField(23),
        publicFreeAssetNetUsage: decode.getField(24),
        publicLatestFreeNetTime: decode.getField(25),
        id: decode.getField(41));
  }

  /// issuer address
  @override
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
