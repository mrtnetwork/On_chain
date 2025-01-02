import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';

import 'package:on_chain/tron/src/models/contract/vote/vote_witness_contract_vote.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';
import 'package:on_chain/utils/utils.dart';

class VoteWitnessContract extends TronBaseContract {
  /// Create a new [VoteWitnessContract] instance by parsing a JSON map.
  factory VoteWitnessContract.fromJson(Map<String, dynamic> json) {
    return VoteWitnessContract(
      ownerAddress: OnChainUtils.parseTronAddress(
          value: json['owner_address'], name: 'owner_address'),
      votes:
          OnChainUtils.parseList<dynamic>(value: json['votes'], name: 'votes')
              ?.map((vote) => VoteWitnessContractVote.fromJson(
                  OnChainUtils.parseMap(
                      value: vote, name: 'vote', throwOnNull: true)!))
              .toList(),
      support:
          OnChainUtils.parseBoolean(value: json['support'], name: 'support'),
    );
  }

  /// Create a new [VoteWitnessContract] instance with specified parameters.
  VoteWitnessContract(
      {required this.ownerAddress,
      List<VoteWitnessContractVote>? votes,
      this.support})
      : votes = votes == null
            ? null
            : List<VoteWitnessContractVote>.unmodifiable(votes);
  factory VoteWitnessContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return VoteWitnessContract(
        ownerAddress: TronAddress.fromBytes(decode.getField(1)),
        votes: decode
            .getFields(2)
            .map((e) => VoteWitnessContractVote.deserialize(e))
            .toList(),
        support: decode.getField(3));
  }
  @override
  final TronAddress ownerAddress;
  final List<VoteWitnessContractVote>? votes;
  final bool? support;

  @override
  List<int> get fieldIds => [1, 2, 3];

  @override
  List get values => [ownerAddress, votes, support];

  /// Convert the [VoteWitnessContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      'owner_address': ownerAddress.toString(),
      'votes': votes?.map((vote) => vote.toJson()).toList(),
      'support': support,
    }..removeWhere((key, value) => value == null);
  }

  /// Convert the [VoteWitnessContract] object to its string representation.
  @override
  String toString() {
    return 'VoteWitnessContract{${toJson()}}';
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.voteWitnessContract;
}
