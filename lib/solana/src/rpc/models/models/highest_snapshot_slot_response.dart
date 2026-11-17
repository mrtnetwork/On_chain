/// Highest slot information that the node has snapshots for
/// (getHighestSnapshotSlot).
class HighestSnapshotSlotResponse {
  const HighestSnapshotSlotResponse({required this.full, this.incremental});
  factory HighestSnapshotSlotResponse.fromJson(Map<String, dynamic> json) {
    return HighestSnapshotSlotResponse(
      full: json['full'],
      incremental: json['incremental'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'full': full, 'incremental': incremental};
  }

  /// Highest full snapshot slot.
  final int full;

  /// Highest incremental snapshot slot based on the full snapshot slot,
  /// if there is one.
  final int? incremental;
}
