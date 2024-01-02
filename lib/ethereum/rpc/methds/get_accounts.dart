import 'package:on_chain/ethereum/rpc/core/core.dart';
import 'package:on_chain/ethereum/rpc/core/methods.dart';

/// Returns a list of addresses owned by client.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_accounts)
class RPCGetAccounts extends ETHRPCRequest<List<dynamic>> {
  RPCGetAccounts();
  @override
  EthereumMethods get method => EthereumMethods.getAccounts;

  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  String toString() {
    return "RPCGetAccounts{$toJson()}";
  }
}
