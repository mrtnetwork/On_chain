import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';
import 'package:on_chain/utils/utils.dart';

class AssetIssueContractFrozenSupply extends TronProtocolBufferImpl {
  /// Create a new [AssetIssueContractFrozenSupply] instance with specified parameters.
  AssetIssueContractFrozenSupply(
      {required this.frozenAmount, required this.frozenDays});

  /// Create a new [AssetIssueContractFrozenSupply] instance by parsing a JSON map.
  factory AssetIssueContractFrozenSupply.fromJson(Map<String, dynamic> json) {
    return AssetIssueContractFrozenSupply(
        frozenAmount: OnChainUtils.parseBigInt(
            value: json['frozen_amount'], name: 'frozen_amount'),
        frozenDays: OnChainUtils.parseBigInt(
            value: json['frozen_days'], name: 'frozen_days'));
  }
  factory AssetIssueContractFrozenSupply.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return AssetIssueContractFrozenSupply(
        frozenAmount: decode.getField(1), frozenDays: decode.getField(2));
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
      'frozen_amount': frozenAmount.toString(),
      'frozen_days': frozenDays.toString()
    };
  }

  /// Convert the [AssetIssueContractFrozenSupply] object to its string representation.
  @override
  String toString() {
    return 'AssetIssueContractFrozenSupply{${toJson()}}';
  }
}
