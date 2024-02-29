class RecentPrioritizationFees {
  /// slot in which the fee was observed
  final int slot;

  /// the per-compute-unit fee paid by at least one successfully
  /// landed transaction, specified in increments of 0.000001 lamports
  final int prioritizationFee;
  const RecentPrioritizationFees(
      {required this.slot, required this.prioritizationFee});
  factory RecentPrioritizationFees.fromJson(Map<String, dynamic> json) {
    return RecentPrioritizationFees(
        slot: json["slot"], prioritizationFee: json["prioritizationFee"]);
  }
}
