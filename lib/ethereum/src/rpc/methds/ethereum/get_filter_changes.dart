import 'package:blockchain_utils/helper/helper.dart';
import 'package:on_chain/ethereum/src/models/log_entry.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Polling method for a filter, which returns an array of logs which occurred since last poll.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_getFilterChanges)
class EthereumRequestGetFilterChanges
    extends EthereumRequest<List<LogEntry>, List> {
  EthereumRequestGetFilterChanges({required this.filterIdentifier});

  /// eth_getFilterChanges
  @override
  String get method => EthereumMethods.getFilterChanges.value;

  /// the filter id.
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
    return 'EthereumRequestGetFilterChanges{${toJson()}}';
  }
}
