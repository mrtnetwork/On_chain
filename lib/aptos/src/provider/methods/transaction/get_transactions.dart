import 'package:on_chain/aptos/src/provider/methods/methods/methods.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/fullnode/types.dart';

/// Retrieve on-chain committed transactions. The page size and start ledger version can be provided
/// to get a specific sequence of transactions.
/// If the version has been pruned, then a 410 will be returned.
/// To retrieve a pending transaction, use /transactions/by_hash.
/// [aptos documation](https://aptos.dev/en/build/apis/fullnode-rest-api-reference)
class AptosRequestGetTransactions extends AptosRequest<
    List<AptosApiTransaction>, List<Map<String, dynamic>>> {
  AptosRequestGetTransactions({this.start, this.limit});

  /// Ledger version to start list of transactions
  /// If not provided, defaults to showing the latest transactions
  final BigInt? start;

  /// Max number of transactions to retrieve., defaults to default page size.
  final int? limit;
  @override
  String get method => AptosApiMethod.getTransactions.url;

  @override
  Map<String, String?> get queryParameters =>
      {"start": start?.toString(), "limit": limit?.toString()};

  @override
  List<AptosApiTransaction> onResonse(List<Map<String, dynamic>> result) {
    return result.map((e) => AptosApiTransaction.fromJson(e)).toList();
  }
}
