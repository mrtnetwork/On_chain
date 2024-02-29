/// Information about the current epoch
class EpochInfo {
  final int epoch;
  final int slotIndex;
  final int slotsInEpoch;
  final int absoluteSlot;
  final int? blockHeight;
  final int? transactionCount;
  const EpochInfo(
      {required this.epoch,
      required this.slotIndex,
      required this.slotsInEpoch,
      required this.absoluteSlot,
      required this.blockHeight,
      required this.transactionCount});
  factory EpochInfo.fromJson(Map<String, dynamic> json) {
    return EpochInfo(
        epoch: json["epoch"],
        slotIndex: json["slotIndex"],
        slotsInEpoch: json["slotsInEpoch"],
        absoluteSlot: json["absoluteSlot"],
        blockHeight: json["blockHeight"],
        transactionCount: json["transactionCount"]);
  }
}
