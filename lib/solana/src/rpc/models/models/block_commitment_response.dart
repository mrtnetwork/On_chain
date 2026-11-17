import 'package:blockchain_utils/blockchain_utils.dart';

/// Commitment for a particular block (getBlockCommitment).
class BlockCommitmentResponse {
  const BlockCommitmentResponse({
    required this.commitment,
    required this.totalStake,
  });
  factory BlockCommitmentResponse.fromJson(Map<String, dynamic> json) {
    final commitment = json['commitment'];
    return BlockCommitmentResponse(
      commitment:
          commitment == null
              ? null
              : (commitment as List).map((e) => BigintUtils.parse(e)).toList(),
      totalStake: BigintUtils.parse(json['totalStake']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'commitment': commitment?.map((e) => e.toString()).toList(),
      'totalStake': totalStake.toString(),
    };
  }

  /// Array of u64 integers logging the amount of cluster stake in lamports
  /// that has voted on the block at each depth. Null for very recent blocks.
  final List<BigInt>? commitment;

  /// Total active stake in lamports.
  final BigInt totalStake;
}
