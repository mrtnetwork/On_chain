import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Signs a transaction that can be submitted to the network at a later time using with eth_sendRawTransaction.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_signTransaction)
class RPCSignTransaction extends ETHRPCRequest<dynamic> {
  RPCSignTransaction({required this.transaction});

  /// eth_signTransaction
  @override
  EthereumMethods get method => EthereumMethods.signTransaction;

  final Map<String, dynamic> transaction;

  @override
  List<dynamic> toJson() {
    return [transaction];
  }
}
