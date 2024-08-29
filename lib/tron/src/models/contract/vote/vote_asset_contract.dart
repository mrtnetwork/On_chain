import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';
import 'package:on_chain/utils/utils.dart';

class VoteAssetContract extends TronBaseContract {
  /// Create a new [VoteAssetContract] instance by parsing a JSON map.
  factory VoteAssetContract.fromJson(Map<String, dynamic> json) {
    return VoteAssetContract(
      ownerAddress: OnChainUtils.parseTronAddress(
          value: json["owner_address"], name: "owner_address"),
      voteAddress: OnChainUtils.parseList<String>(
              value: json["vote_address"],
              name: "vote_address",
              throwOnNull: true)!
          .map((address) => TronAddress(address))
          .toList(),
      support:
          OnChainUtils.parseBoolean(value: json['support'], name: "support"),
      count: OnChainUtils.parseInt(value: json['count'], name: "count"),
    );
  }

  /// Create a new [VoteAssetContract] instance with specified parameters.
  VoteAssetContract(
      {required this.ownerAddress,
      required List<TronAddress> voteAddress,
      this.support,
      this.count})
      : voteAddress = List<TronAddress>.unmodifiable(voteAddress);

  factory VoteAssetContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return VoteAssetContract(
        ownerAddress: TronAddress.fromBytes(decode.getField(1)),
        voteAddress:
            decode.getFields(2).map((e) => TronAddress.fromBytes(e)).toList(),
        support: decode.getField(3),
        count: decode.getField(5));
  }

  @override
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
