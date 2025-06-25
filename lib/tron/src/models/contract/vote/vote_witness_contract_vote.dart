import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';
import 'package:on_chain/utils/utils.dart';

class VoteWitnessContractVote extends TronProtocolBufferImpl {
  /// Create a new [VoteWitnessContractVote] instance by parsing a JSON map.
  factory VoteWitnessContractVote.fromJson(Map<String, dynamic> json) {
    return VoteWitnessContractVote(
      voteAddress: OnChainUtils.parseTronAddress(
          value: json['vote_address'], name: 'vote_address'),
      voteCount: OnChainUtils.parseBigInt(
          value: json['vote_count'], name: 'vote_count'),
    );
  }
  factory VoteWitnessContractVote.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return VoteWitnessContractVote(
      voteAddress: TronAddress.fromBytes(decode.getField(1)),
      voteCount: decode.getField(2),
    );
  }

  /// Create a new [VoteWitnessContractVote] instance with specified parameters.
  VoteWitnessContractVote({required this.voteAddress, required this.voteCount});

  final TronAddress voteAddress;
  final BigInt voteCount;

  @override
  List<int> get fieldIds => [1, 2];

  @override
  List get values => [voteAddress, voteCount];

  /// Convert the [VoteWitnessContractVote] object to a JSON representation.
  @override
  Map<String, dynamic> toJson({bool visible = true}) {
    return {
      'vote_address': voteAddress.toAddress(visible),
      'vote_count': voteCount.toString(),
    };
  }

  /// Convert the [VoteWitnessContractVote] object to its string representation.
  @override
  String toString() {
    return 'VoteWitnessContractVote{${toJson()}}';
  }
}
