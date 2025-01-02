import 'package:on_chain/solana/src/exception/exception.dart';

class MarketState {
  final String name;
  final int value;
  const MarketState._(this.name, this.value);
  static const MarketState uninitialized = MarketState._('Uninitialized', 0);
  static const MarketState created = MarketState._('Created', 1);
  static const MarketState suspended = MarketState._('Suspended', 2);
  static const MarketState active = MarketState._('Active', 3);
  static const MarketState ended = MarketState._('Ended', 4);
  static const List<MarketState> values = [
    uninitialized,
    created,
    suspended,
    active,
    ended
  ];
  static MarketState fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw SolanaPluginException(
          'No MarketState found matching the specified value',
          details: {'value': value}),
    );
  }

  @override
  String toString() {
    return 'MarketState.$name';
  }
}
