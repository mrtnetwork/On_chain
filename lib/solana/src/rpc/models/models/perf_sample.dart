/// A performance sample
class PerfSample {
  /// Slot number of sample
  final int slot;

  /// Number of transactions in a sample window
  final int numTransactions;

  /// Number of slots in a sample window
  final int numSlots;

  /// Sample window in seconds
  final int samplePeriodSecs;

  const PerfSample(
      {required this.slot,
      required this.numTransactions,
      required this.numSlots,
      required this.samplePeriodSecs});
  factory PerfSample.fromJson(Map<String, dynamic> json) {
    return PerfSample(
        slot: json["slot"],
        numTransactions: json["numTransactions"],
        numSlots: json["numSlots"],
        samplePeriodSecs: json["samplePeriodSecs"]);
  }
}
