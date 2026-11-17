import 'package:blockchain_utils/helper/helper.dart';
import 'package:on_chain/ethereum/src/models/log_entry.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Returns an array of all logs matching filter with given id.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_getFilterLogs)
class EthereumRequestGetFilterLogs
    extends EthereumRequest<List<LogEntry>, List> {
  EthereumRequestGetFilterLogs({required this.filterIdentifier});

  /// eth_getFilterLogs
  @override
  String get method => EthereumMethods.getFilterLogs.value;

  /// The filter id.
  final BigInt filterIdentifier;
  @override
  List<dynamic> toJson() {
    return [filterIdentifier.toHexaDecimal];
  }

  @override
  List<LogEntry> onResponse(result) {
    return result.map((e) => LogEntry.fromJson(e)).toList();
  }

  @override
  String toString() {
    return 'EthereumRequestGetFilterLogs{${toJson()}}';
  }
}
