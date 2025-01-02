/// A utility class for Solana RPC-related tasks.
class SolanaRequestUtils {
  /// Merges multiple configurations into a single map, filtering out null values.
  ///
  /// [configs]: A list of maps containing configurations.
  ///
  /// Returns a merged configuration map or null if no valid configuration is found.
  static Map<String, dynamic>? createConfig(
      List<Map<String, dynamic>?> configs) {
    final Map<String, dynamic> config = {};
    for (final i in configs) {
      if (i == null) continue;
      for (final k in i.keys) {
        if (i[k] != null) {
          config[k] = i[k];
        }
      }
    }
    if (config.isEmpty) return null;

    return config;
  }
}
