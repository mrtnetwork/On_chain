import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

/// Deletes Proposal Transaction.
class ProposalDeleteContract extends TronBaseContract {
  /// Create a new [ProposalDeleteContract] instance by parsing a JSON map.
  factory ProposalDeleteContract.fromJson(Map<String, dynamic> json) {
    return ProposalDeleteContract(
      ownerAddress: TronAddress(json["owner_address"]),
      proposalId: BigintUtils.tryParse(json["proposal_id"]),
    );
  }

  /// Create a new [ProposalDeleteContract] instance with specified parameters.
  ProposalDeleteContract({required this.ownerAddress, this.proposalId});

  /// Account address
  final TronAddress ownerAddress;

  /// 	Proposal id
  final BigInt? proposalId;

  @override
  List<int> get fieldIds => [1, 2];

  @override
  List get values => [ownerAddress, proposalId];

  /// Convert the [ProposalDeleteContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress.toString(),
      "proposal_id": proposalId?.toString()
    };
  }

  /// Convert the [ProposalDeleteContract] object to its string representation.
  @override
  String toString() {
    return "ProposalDeleteContract{${toJson()}}";
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.proposalDeleteContract;
}
