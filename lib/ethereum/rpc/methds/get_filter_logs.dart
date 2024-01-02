import 'package:on_chain/ethereum/rpc/core/core.dart';
import 'package:on_chain/ethereum/rpc/core/methods.dart';

/// Returns an array of all logs matching filter with given id.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_getFilterLogs)
class RPCGetFilterLogs extends ETHRPCRequest<dynamic> {
  RPCGetFilterLogs({required this.filterIdentifier});

  /// eth_getFilterLogs
  @override
  EthereumMethods get method => EthereumMethods.getFilterLogs;

  /// The filter id.
  final BigInt filterIdentifier;
  @override
  List<dynamic> toJson() {
    return ["0x${filterIdentifier.toRadixString(16)}"];
  }

  @override
  String toString() {
    return "RPCGetFilterLogs{${toJson()}}";
  }
}
