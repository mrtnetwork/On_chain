import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';
import 'package:on_chain/utils/utils.dart';

/// Deletes Proposal Transaction.
class ProposalDeleteContract extends TronBaseContract {
  /// Create a new [ProposalDeleteContract] instance by parsing a JSON map.
  factory ProposalDeleteContract.fromJson(Map<String, dynamic> json) {
    return ProposalDeleteContract(
      ownerAddress: OnChainUtils.parseTronAddress(
          value: json['owner_address'], name: 'owner_address'),
      proposalId: OnChainUtils.parseBigInt(
          value: json['proposal_id'], name: 'proposal_id'),
    );
  }

  /// Create a new [ProposalDeleteContract] instance with specified parameters.
  ProposalDeleteContract({required this.ownerAddress, this.proposalId});
  factory ProposalDeleteContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return ProposalDeleteContract(
        ownerAddress: TronAddress.fromBytes(decode.getField(1)),
        proposalId: decode.getField(2));
  }

  /// Account address
  @override
  final TronAddress ownerAddress;

  /// 	Proposal id
  final BigInt? proposalId;

  @override
  List<int> get fieldIds => [1, 2];

  @override
  List get values => [ownerAddress, proposalId];

  /// Convert the [ProposalDeleteContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson({bool visible = true}) {
    return {
      'owner_address': ownerAddress.toAddress(visible),
      'proposal_id': proposalId?.toString()
    };
  }

  /// Convert the [ProposalDeleteContract] object to its string representation.
  @override
  String toString() {
    return 'ProposalDeleteContract{${toJson()}}';
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.proposalDeleteContract;
}
