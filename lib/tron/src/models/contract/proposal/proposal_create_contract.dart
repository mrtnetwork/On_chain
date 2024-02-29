import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

/// Creates a proposal transaction.
class ProposalCreateContract extends TronBaseContract {
  /// Create a new [ProposalCreateContract] instance by parsing a JSON map.
  factory ProposalCreateContract.fromJson(Map<String, dynamic> json) {
    return ProposalCreateContract(
      ownerAddress: TronAddress(json["owner_address"]),
      parameters: json["parameters"] == null
          ? null
          : (json["parameters"] as Map).map(
              (key, value) =>
                  MapEntry(BigintUtils.parse(key), BigintUtils.parse(value)),
            ),
    );
  }

  /// Create a new [ProposalCreateContract] instance with specified parameters.
  ProposalCreateContract(
      {required this.ownerAddress, Map<BigInt, BigInt>? parameters})
      : parameters = parameters == null
            ? null
            : Map<BigInt, BigInt>.unmodifiable(parameters);

  /// Account address
  final TronAddress ownerAddress;

  /// Parameters proposed to be modified and their values
  final Map<BigInt, BigInt>? parameters;

  @override
  List<int> get fieldIds => [1, 2];

  @override
  List get values => [ownerAddress, parameters];

  /// Convert the [ProposalCreateContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress.toString(),
      "parameters": parameters
          ?.map((key, value) => MapEntry(key.toString(), value.toString())),
    };
  }

  /// Convert the [ProposalCreateContract] object to its string representation.
  @override
  String toString() {
    return "ProposalCreateContract{${toJson()}}";
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.proposalCreateContract;
}
