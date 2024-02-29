import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Polling method for a filter, which returns an array of logs which occurred since last poll.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_getFilterChanges)
class RPCGetFilterChanges extends ETHRPCRequest<dynamic> {
  RPCGetFilterChanges({required this.filterIdentifier});

  /// eth_getFilterChanges
  @override
  EthereumMethods get method => EthereumMethods.getFilterChanges;

  /// the filter id.
  final BigInt filterIdentifier;
  @override
  List<dynamic> toJson() {
    return ["0x${filterIdentifier.toRadixString(16)}"];
  }

  @override
  String toString() {
    return "RPCGetFilterChanges{${toJson()}}";
  }
}
