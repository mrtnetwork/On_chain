import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/src/models/contract/assets_issue_contract/frozensupply.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';

class AssetIssueContract extends TronBaseContract {
  /// Create a new [AssetIssueContract] instance by parsing a JSON map.
  factory AssetIssueContract.fromJson(Map<String, dynamic> json) {
    return AssetIssueContract(
      ownerAddress: TronAddress(json.valueAs("owner_address")),
      name: json.valueAsBytes("name", encoding: StringEncoding.utf8),
      abbr: json.valueAsBytes("abbr", encoding: StringEncoding.utf8),
      totalSupply: json.valueAsBigInt("total_supply"),
      frozenSupply:
          json
              .valueAsList<List<Map<String, dynamic>>?>("frozen_supply")
              ?.map(
                (frozenSupplyJson) =>
                    AssetIssueContractFrozenSupply.fromJson(frozenSupplyJson),
              )
              .toList(),
      trxNum: json.valueAsInt("trx_num"),
      precision: json.valueAsInt("precision"),
      num: json.valueAsInt("num"),
      startTime: json.valueAsBigInt("start_time"),
      endTime: json.valueAsBigInt("end_time"),
      order: json.valueAsBigInt("order"),
      voteScore: json.valueAsInt("vote_score"),
      description: json.valueAsBytes(
        "description",
        encoding: StringEncoding.utf8,
      ),
      url: json.valueAsBytes("url", encoding: StringEncoding.utf8),
      freeAssetNetLimit: json.valueAsBigInt("free_asset_netimit"),
      publicFreeAssetNetLimit: json.valueAsBigInt("public_free_asset_netimit"),
      publicFreeAssetNetUsage: json.valueAsBigInt(
        "public_free_asset_net_usage",
      ),
      publicLatestFreeNetTime: json.valueAsBigInt("publicatest_free_net_time"),
      id: json.valueAs("id"),
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
  }) : name = name.asImmutableBytes,
       abbr = abbr.asImmutableBytes,
       frozenSupply =
           (frozenSupply?.isNotEmpty ?? false)
               ? frozenSupply?.toImutableList
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
      frozenSupply:
          decode
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
      id: decode.getField(41),
    );
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
    id,
  ];
  @override
  List<int> get fieldIds => [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    16,
    20,
    21,
    22,
    23,
    24,
    25,
    41,
  ];

  /// Convert the [AssetIssueContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson({bool visible = true}) {
    return {
      'owner_address': ownerAddress.toAddress(visible),
      'name': StringUtils.decode(name),
      'abbr': StringUtils.decode(abbr),
      'total_supply': totalSupply.toString(),
      'trx_num': trxNum,
      'num': num,
      'start_time': startTime.toString(),
      'end_time': endTime.toString(),
      'description': StringUtils.tryDecode(description),
      'url': StringUtils.tryDecode(url),
      'free_asset_netimit': freeAssetNetLimit?.toString(),
      'public_free_asset_netimit': publicFreeAssetNetLimit?.toString(),
      'frozen_supply': frozenSupply?.map((e) => e.toJson()).toList(),
      'precision': precision,
    }..removeWhere((key, value) => value == null);
  }

  /// Convert the [AssetIssueContract] object to its string representation.
  @override
  String toString() {
    return 'AssetIssueContract{${toJson()}}';
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.assetIssueContract;
}
