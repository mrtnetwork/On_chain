/// RPC Slot range to return block production for. If parameter not provided, defaults to current epoch.
class RPCBlockRangeConfig {
  const RPCBlockRangeConfig({required this.firstSlot, this.lastSlot});
  factory RPCBlockRangeConfig.fromJson(Map<String, dynamic> json) {
    return RPCBlockRangeConfig(
        firstSlot: json['firstSlot'], lastSlot: json['lastSlot']);
  }

  /// first slot to return block production information for (inclusive)
  final int firstSlot;

  /// last slot to return block production information for (inclusive). If parameter not provided, defaults to the highest slot
  final int? lastSlot;
  Map<String, dynamic> toJson() {
    return {
      'range': {
        'firstSlot': firstSlot,
        if (lastSlot != null) 'lastSlot': lastSlot
      }
    };
  }
}
