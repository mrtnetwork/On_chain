import 'package:on_chain/tron/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

class AssetIssueContractFrozenSupply extends TronProtocolBufferImpl {
  /// Create a new [AssetIssueContractFrozenSupply] instance with specified parameters.
  AssetIssueContractFrozenSupply(
      {required this.frozenAmount, required this.frozenDays});

  /// Create a new [AssetIssueContractFrozenSupply] instance by parsing a JSON map.
  factory AssetIssueContractFrozenSupply.fromJson(Map<String, dynamic> json) {
    return AssetIssueContractFrozenSupply(
        frozenAmount: BigintUtils.parse(json["frozen_amount"]),
        frozenDays: BigintUtils.parse(json["frozen_days"]));
  }
  final BigInt frozenAmount;
  final BigInt frozenDays;
  @override
  List<int> get fieldIds => [1, 2];

  @override
  List get values => [frozenAmount, frozenDays];

  /// Convert the [AssetIssueContractFrozenSupply] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "frozen_amount": frozenAmount.toString(),
      "frozen_days": frozenDays.toString()
    };
  }

  /// Convert the [AssetIssueContractFrozenSupply] object to its string representation.
  @override
  String toString() {
    return "AssetIssueContractFrozenSupply{${toJson()}}";
  }
}
