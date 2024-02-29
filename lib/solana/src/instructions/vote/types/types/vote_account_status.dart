import 'vote_account_info.dart';

/// A collection of cluster vote accounts
class VoteAccountStatus {
  const VoteAccountStatus({required this.current, required this.delinquent});
  factory VoteAccountStatus.fromJson(Map<String, dynamic> json) {
    return VoteAccountStatus(
        current: (json["current"] as List)
            .map((e) => VoteAccountInfo.fromJson(e))
            .toList(),
        delinquent: (json["delinquent"] as List)
            .map((e) => VoteAccountInfo.fromJson(e))
            .toList());
  }

  /// Active vote accounts
  final List<VoteAccountInfo> current;

  /// Inactive vote accounts
  final List<VoteAccountInfo> delinquent;
}
