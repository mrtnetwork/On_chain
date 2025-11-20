import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Returns a list of addresses owned by client.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_accounts)
class EthereumRequestGetAccounts extends EthereumRequest<List<dynamic>, List> {
  EthereumRequestGetAccounts();
  @override
  String get method => EthereumMethods.getAccounts.value;

  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  String toString() {
    return 'EthereumRequestGetAccounts{$toJson()}';
  }
}
