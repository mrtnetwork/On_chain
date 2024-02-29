import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

class VoteAssetContract extends TronBaseContract {
  /// Create a new [VoteAssetContract] instance by parsing a JSON map.
  factory VoteAssetContract.fromJson(Map<String, dynamic> json) {
    final ownerAddress = TronAddress(json['owner_address']);
    final voteAddress = (json['vote_address'] as List)
        .map((address) => TronAddress(address))
        .toList();

    return VoteAssetContract(
      ownerAddress: ownerAddress,
      voteAddress: voteAddress,
      support: json['support'],
      count: IntUtils.tryParse(json['count']),
    );
  }

  /// Create a new [VoteAssetContract] instance with specified parameters.
  VoteAssetContract(
      {required this.ownerAddress,
      required List<TronAddress> voteAddress,
      this.support,
      this.count})
      : voteAddress = List<TronAddress>.unmodifiable(voteAddress);
  final TronAddress ownerAddress;
  final List<TronAddress> voteAddress;
  final bool? support;
  final int? count;

  @override
  List<int> get fieldIds => [1, 2, 3, 5];

  @override
  List get values => [ownerAddress, voteAddress, support, count];

  /// Convert the [VoteAssetContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress.toString(),
      "vote_address": voteAddress.map((address) => address.toString()).toList(),
      "support": support,
      "count": count,
    }..removeWhere((key, value) => value == null);
  }

  /// Convert the [VoteAssetContract] object to its string representation.
  @override
  String toString() {
    return "VoteAssetContract{${toJson()}}";
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.voteAssetContract;
}
