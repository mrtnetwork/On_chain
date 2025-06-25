import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';
import 'package:on_chain/utils/utils.dart';

/// Approves proposed transaction.
class ProposalApproveContract extends TronBaseContract {
  /// Create a new [ProposalApproveContract] instance by parsing a JSON map.
  factory ProposalApproveContract.fromJson(Map<String, dynamic> json) {
    return ProposalApproveContract(
      ownerAddress: OnChainUtils.parseTronAddress(
          value: json['owner_address'], name: 'owner_address'),
      proposalId: OnChainUtils.parseBigInt(
          value: json['proposal_id'], name: 'proposal_id'),
      isAddApproval: OnChainUtils.parseBoolean(
          value: json['is_add_approval'], name: 'is_add_approval'),
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
  @override
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
  Map<String, dynamic> toJson({bool visible = true}) {
    return {
      'owner_address': ownerAddress.toAddress(visible),
      'proposal_id': proposalId?.toString(),
      'is_add_approval': isAddApproval,
    }..removeWhere((k, v) => v == null);
  }

  /// Convert the [ProposalApproveContract] object to its string representation.
  @override
  String toString() {
    return 'ProposalApproveContract{${toJson()}}';
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.proposalApproveContract;
}
