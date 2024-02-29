/// For preflight checks and transaction processing, Solana nodes choose which bank state to query based on a commitment
/// requirement set by the client. The commitment describes how finalized a block is at that point in time.
/// When querying the ledger state, it's recommended to use lower levels of commitment to report progress and
/// higher levels to ensure the state will not be rolled back.
///
/// For processing many dependent transactions in series,
/// it's recommended to use confirmed commitment,
/// which balances speed with rollback safety. For total safety,
/// it's recommended to use finalized commitment.
/// https://solana.com/docs/rpc
class Commitment {
  const Commitment._(this.value);
  final String value;

  /// the node will query the most recent block confirmed by supermajority of the cluster as
  /// having reached maximum lockout, meaning the cluster has recognized this block as finalized
  static const Commitment processed = Commitment._("processed");

  /// the node will query the most recent block that has been voted on by supermajority of the cluster.
  static const Commitment confirmed = Commitment._("confirmed");

  /// the node will query its most recent block. Note that the block may still be skipped by the cluster.
  static const Commitment finalized = Commitment._("finalized");

  @override
  String toString() {
    return value;
  }

  Map<String, dynamic> toJson([bool preFlight = false]) {
    if (preFlight) {
      return {"preflightCommitment": value};
    }
    return {"commitment": value};
  }
}
