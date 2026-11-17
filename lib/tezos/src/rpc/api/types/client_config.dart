/// Configuration shared by high-level Tezos API mixins.
///
/// Methods accept optional overrides (`chain`, `chainId`, `version`,
/// `timeout`, `interval`). When an argument is `null`, the value is taken
/// from this config.
class TezosClientConfig {
  /// Shell path alias, e.g. `main` / `test` (mempool, inject, confirmation).
  final String chain;

  /// Protocol path chain id when needed (often same as [chain] for aliases).
  final String? chainId;

  /// Default RPC `version` query (e.g. operations list version `"1"` / `"2"`).
  final String version;

  /// Default poll timeout for [waitForOperation].
  final Duration confirmationTimeout;

  /// Default poll interval for [waitForOperation].
  final Duration confirmationInterval;

  const TezosClientConfig({
    this.chain = 'main',
    this.chainId,
    this.version = '1',
    this.confirmationTimeout = const Duration(minutes: 3),
    this.confirmationInterval = const Duration(seconds: 4),
  });

  static const defaults = TezosClientConfig();

  TezosClientConfig copyWith({
    String? chain,
    String? chainId,
    String? version,
    Duration? confirmationTimeout,
    Duration? confirmationInterval,
  }) {
    return TezosClientConfig(
      chain: chain ?? this.chain,
      chainId: chainId ?? this.chainId,
      version: version ?? this.version,
      confirmationTimeout: confirmationTimeout ?? this.confirmationTimeout,
      confirmationInterval: confirmationInterval ?? this.confirmationInterval,
    );
  }

  String resolveChain([String? override]) => override ?? chain;
  String? resolveChainId([String? override]) => override ?? chainId;
  String resolveVersion([String? override]) => override ?? version;
  Duration resolveTimeout([Duration? override]) =>
      override ?? confirmationTimeout;
  Duration resolveInterval([Duration? override]) =>
      override ?? confirmationInterval;
}
