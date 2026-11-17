import 'package:on_chain/tezos/src/address/address.dart';

class TezosAccountState {
  final TezosAddress address;
  final BigInt balance;
  final BigInt counter;
  final String? managerKey;
  final bool needsReveal;

  const TezosAccountState({
    required this.address,
    required this.balance,
    required this.counter,
    required this.managerKey,
    required this.needsReveal,
  });
}
