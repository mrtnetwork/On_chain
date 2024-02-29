import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';

class BlockProduction {
  /// a dictionary of validator identities, as base-58 encoded strings.
  /// Value is a two element array containing the number of leader slots and the number of blocks produced
  final Map<String, List<int>> byIdentity;

  /// Block production slot range
  final RPCBlockRangeConfig range;
  const BlockProduction({required this.byIdentity, required this.range});

  factory BlockProduction.fromJson(Map<String, dynamic> json) {
    final byIdentity = Map<String, dynamic>.from(json["byIdentity"]);
    return BlockProduction(byIdentity: {
      for (final i in byIdentity.entries) i.key: (i.value as List).cast()
    }, range: RPCBlockRangeConfig.fromJson(json["range"]));
  }
}
