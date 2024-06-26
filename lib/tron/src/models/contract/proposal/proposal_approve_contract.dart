import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';

/// Approves proposed transaction.
class ProposalApproveContract extends TronBaseContract {
  /// Create a new [ProposalApproveContract] instance by parsing a JSON map.
  factory ProposalApproveContract.fromJson(Map<String, dynamic> json) {
    return ProposalApproveContract(
      ownerAddress: TronAddress(json["owner_address"]),
      proposalId: BigintUtils.tryParse(json["proposal_id"]),
      isAddApproval: json["is_add_approval"],
    );
  }
  factory ProposalApproveContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return ProposalApproveContract(
        ownerAddress: TronAddress.fromBytes(decode.getField(1)),
        proposalId: decode.getField(2),
        isAddApproval: decode.getField(3));
  }

  /// Create a new [ProposalApproveContract] instance with specified parameters.
  ProposalApproveContract(
      {required this.ownerAddress, this.proposalId, this.isAddApproval});

  /// Account address
  final TronAddress ownerAddress;

  /// Proposal id
  final BigInt? proposalId;

  /// Whether to agree with the proposal
  final bool? isAddApproval;

  @override
  List<int> get fieldIds => [1, 2, 3];

  @override
  List get values => [ownerAddress, proposalId, isAddApproval];

  /// Convert the [ProposalApproveContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress.toString(),
      "proposal_id": proposalId?.toString(),
      "is_add_approval": isAddApproval,
    };
  }

  /// Convert the [ProposalApproveContract] object to its string representation.
  @override
  String toString() {
    return "ProposalApproveContract{${toJson()}}";
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.proposalApproveContract;
}
