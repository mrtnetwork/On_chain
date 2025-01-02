/// A class containing constants representing various Solana Webosocket subscribe methods.
class SolanaSubscribeRpcMethods {
  final String value;

  /// Constructs a [SolanaSubscribeRpcMethods] instance with a specific value.
  const SolanaSubscribeRpcMethods._(this.value);
  static const SolanaSubscribeRpcMethods accountSubscribe =
      SolanaSubscribeRpcMethods._('accountSubscribe');
  static const SolanaSubscribeRpcMethods blockSubscribe =
      SolanaSubscribeRpcMethods._('blockSubscribe');
  static const SolanaSubscribeRpcMethods logsSubscribe =
      SolanaSubscribeRpcMethods._('logsSubscribe');
  static const SolanaSubscribeRpcMethods programSubscribe =
      SolanaSubscribeRpcMethods._('programSubscribe');
  static const SolanaSubscribeRpcMethods rootSubscribe =
      SolanaSubscribeRpcMethods._('rootSubscribe');
  static const SolanaSubscribeRpcMethods signatureSubscribe =
      SolanaSubscribeRpcMethods._('signatureSubscribe');
  static const SolanaSubscribeRpcMethods slotSubscribe =
      SolanaSubscribeRpcMethods._('slotSubscribe');
  static const SolanaSubscribeRpcMethods slotsUpdatesSubscribe =
      SolanaSubscribeRpcMethods._('slotsUpdatesSubscribe');
  static const SolanaSubscribeRpcMethods voteSubscribe =
      SolanaSubscribeRpcMethods._('voteSubscribe');
}

/// A class containing constants representing various Solana Webosocket subscribe methods.
class SolanaUnSubscribeRpcMethods {
  final String value;

  /// Constructs a [SolanaUnSubscribeRpcMethods] instance with a specific value.
  const SolanaUnSubscribeRpcMethods._(this.value);

  static const SolanaUnSubscribeRpcMethods accountUnsubscribe =
      SolanaUnSubscribeRpcMethods._('accountUnsubscribe');

  static const SolanaUnSubscribeRpcMethods blockUnsubscribe =
      SolanaUnSubscribeRpcMethods._('blockUnsubscribe');

  static const SolanaUnSubscribeRpcMethods logsUnsubscribe =
      SolanaUnSubscribeRpcMethods._('logsUnsubscribe');

  static const SolanaUnSubscribeRpcMethods programUnsubscribe =
      SolanaUnSubscribeRpcMethods._('programUnsubscribe');

  static const SolanaUnSubscribeRpcMethods rootUnsubscribe =
      SolanaUnSubscribeRpcMethods._('rootUnsubscribe');

  static const SolanaUnSubscribeRpcMethods signatureUnsubscribe =
      SolanaUnSubscribeRpcMethods._('signatureUnsubscribe');

  static const SolanaUnSubscribeRpcMethods slotUnsubscribe =
      SolanaUnSubscribeRpcMethods._('slotUnsubscribe');

  static const SolanaUnSubscribeRpcMethods slotsUpdatesUnsubscribe =
      SolanaUnSubscribeRpcMethods._('slotsUpdatesUnsubscribe');

  static const SolanaUnSubscribeRpcMethods voteUnsubscribe =
      SolanaUnSubscribeRpcMethods._('voteUnsubscribe');
}
