import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/rpc/models/models/versioned_transaction_response.dart';

import 'reward_response.dart';

class VersionedBlockResponse {
  final SolAddress blockhash;
  final SolAddress previousBlockhash;
  final int parentSlot;
  final List<VersionedTransactionResponse> transactions;
  final List<RewardResponse>? rewards;
  final BigInt? blockTime;
  const VersionedBlockResponse(
      {required this.blockhash,
      required this.previousBlockhash,
      required this.parentSlot,
      required this.transactions,
      required this.rewards,
      required this.blockTime});
  factory VersionedBlockResponse.fromJson(Map<String, dynamic> json) {
    return VersionedBlockResponse(
        blockhash: SolAddress.uncheckCurve(json["blockhash"]),
        previousBlockhash: SolAddress.uncheckCurve(json["previousBlockhash"]),
        parentSlot: json["parentSlot"],
        transactions: (json["transactions"] as List).map((e) {
          return VersionedTransactionResponse.fromJson(e);
        }).toList(),
        rewards: (json["rewards"] as List?)
            ?.map((e) => RewardResponse.fromJson(e))
            .toList(),
        blockTime: BigintUtils.tryParse(json["blockTime"]));
  }
}
