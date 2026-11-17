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

  final List<String> signatures;
  const VersionedBlockResponse({
    required this.blockhash,
    required this.previousBlockhash,
    required this.parentSlot,
    required this.transactions,
    required this.rewards,
    required this.blockTime,
    this.signatures = const [],
  });
  factory VersionedBlockResponse.fromJson(Map<String, dynamic> json) {
    final List<VersionedTransactionResponse> transactions = [];
    final List<String> signatures = [];
    for (final e in (json['transactions'] as List? ?? [])) {
      if (e is String) {
        signatures.add(e);
      } else {
        transactions.add(
          VersionedTransactionResponse.fromJson(
            (e as Map).cast<String, dynamic>(),
          ),
        );
      }
    }
    final rawSignatures = json['signatures'];
    if (rawSignatures is List) {
      signatures.addAll(rawSignatures.cast<String>());
    }
    return VersionedBlockResponse(
      blockhash: SolAddress.uncheckCurve(json['blockhash']),
      previousBlockhash: SolAddress.uncheckCurve(json['previousBlockhash']),
      parentSlot: json['parentSlot'],
      transactions: transactions,
      rewards:
          (json['rewards'] as List?)
              ?.map((e) => RewardResponse.fromJson(e))
              .toList(),
      blockTime: BigintUtils.tryParse(json['blockTime']),
      signatures: signatures,
    );
  }
}
