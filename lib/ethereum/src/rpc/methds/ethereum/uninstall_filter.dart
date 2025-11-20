import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Uninstalls a filter with given id. Should always be called when watch is no longer needed.
/// Additionally Filters timeout when they aren't requested with eth_getFilterChanges for a period of time.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_uninstallFilter)
class EthereumRequestUninstallFilter extends EthereumRequest<Object?, Object?> {
  EthereumRequestUninstallFilter({required this.filterIdentifier});

  /// eth_uninstallFilter
  @override
  String get method => EthereumMethods.uninstallFilter.value;

  /// The filter id.
  final BigInt filterIdentifier;
  @override
  List<dynamic> toJson() {
    return ['0x${filterIdentifier.toRadixString(16)}'];
  }

  @override
  String toString() {
    return 'EthereumRequestUninstallFilter{${toJson()}}';
  }
}
