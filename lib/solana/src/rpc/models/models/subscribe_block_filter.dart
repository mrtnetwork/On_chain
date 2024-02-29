import 'package:on_chain/solana/src/address/sol_address.dart';

/// filter criteria for the logs to receive results by account type; currently supported:
class SubscribeBlockFilter {
  const SubscribeBlockFilter._(this.mentionsAccountOrProgram);
  final SolAddress? mentionsAccountOrProgram;

  /// include all transactions in block
  factory SubscribeBlockFilter.all() {
    return SubscribeBlockFilter._(null);
  }

  /// return only transactions that mention the provided public key (as base-58 encoded string).
  /// If no mentions in a given block, then no notification will be sent.
  factory SubscribeBlockFilter.mentionsAccountOrProgram(SolAddress account) {
    return SubscribeBlockFilter._(account);
  }

  dynamic toJson() {
    if (mentionsAccountOrProgram != null) {
      return {"mentionsAccountOrProgram": mentionsAccountOrProgram!.address};
    }
    return "all";
  }
}
