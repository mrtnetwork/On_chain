import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Returns an array of all logs matching filter with given id.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_getFilterLogs)
class EthereumRequestGetFilterLogs extends EthereumRequest<Object?, Object?> {
  EthereumRequestGetFilterLogs({required this.filterIdentifier});

  /// eth_getFilterLogs
  @override
  String get method => EthereumMethods.getFilterLogs.value;

  /// The filter id.
  final BigInt filterIdentifier;
  @override
  List<dynamic> toJson() {
    return ['0x${filterIdentifier.toRadixString(16)}'];
  }

  @override
  String toString() {
    return 'EthereumRequestGetFilterLogs{${toJson()}}';
  }
}
