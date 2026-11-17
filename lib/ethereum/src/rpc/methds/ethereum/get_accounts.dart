import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Returns a list of addresses owned by client.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_accounts)
class EthereumRequestGetAccounts extends EthereumRequest<List<String>, List> {
  EthereumRequestGetAccounts();
  @override
  String get method => EthereumMethods.getAccounts.value;

  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  List<String> onResponse(result) {
    return result.map((e) => e as String).toList();
  }

  @override
  String toString() {
    return 'EthereumRequestGetAccounts{$toJson()}';
  }
}
