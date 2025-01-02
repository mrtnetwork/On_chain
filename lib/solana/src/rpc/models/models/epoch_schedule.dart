/// [Epoch schedule](https://docs.solana.com/terminology#epoch)
class EpochSchedule {
  /// The maximum number of slots in each epoch
  final int slotsPerEpoch;

  /// The number of slots before beginning of an epoch to calculate a leader schedule for that epoch
  final int leaderScheduleSlotOffset;

  /// Indicates whether epochs start short and grow
  final bool warmup;

  /// The first epoch with [slotsPerEpoch] slots
  final int firstNormalEpoch;

  /// The first slot of [firstNormalEpoch]
  final int firstNormalSlot;

  const EpochSchedule(
      {required this.slotsPerEpoch,
      required this.leaderScheduleSlotOffset,
      required this.warmup,
      required this.firstNormalEpoch,
      required this.firstNormalSlot});
  factory EpochSchedule.fromJson(Map<String, dynamic> json) {
    return EpochSchedule(
        slotsPerEpoch: json['slotsPerEpoch'],
        leaderScheduleSlotOffset: json['leaderScheduleSlotOffset'],
        warmup: json['warmup'],
        firstNormalEpoch: json['firstNormalEpoch'],
        firstNormalSlot: json['firstNormalSlot']);
  }
}
