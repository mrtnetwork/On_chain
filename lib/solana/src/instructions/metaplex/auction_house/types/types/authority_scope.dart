import 'package:on_chain/solana/src/exception/exception.dart';

class AuthorityScope {
  final String name;
  final int value;
  const AuthorityScope({required this.name, required this.value});
  static const AuthorityScope deposit =
      AuthorityScope(name: 'Deposit', value: 0);
  static const AuthorityScope buy = AuthorityScope(name: 'Buy', value: 1);
  static const AuthorityScope publicBuy =
      AuthorityScope(name: 'PublicBuy', value: 2);
  static const AuthorityScope executeSale =
      AuthorityScope(name: 'ExecuteSale', value: 3);
  static const AuthorityScope sell = AuthorityScope(name: 'Sell', value: 4);
  static const AuthorityScope cancel = AuthorityScope(name: 'Cancel', value: 5);
  static const AuthorityScope withdraw =
      AuthorityScope(name: 'Withdraw', value: 6);
  static const List<AuthorityScope> values = [
    deposit,
    buy,
    publicBuy,
    executeSale,
    sell,
    cancel,
    withdraw
  ];
  static AuthorityScope fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw SolanaPluginException(
          'No AuthorityScope found matching the specified value',
          details: {'value': value}),
    );
  }

  @override
  String toString() {
    return 'AuthorityScope.$name';
  }
}
