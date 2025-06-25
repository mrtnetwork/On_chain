import 'package:on_chain/aptos/src/address/address/address.dart';
import 'package:on_chain/aptos/src/provider/methods/methods/methods.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/fullnode/types.dart';

/// Retrieves on-chain committed transactions from an account.
/// If the start version is too far in the past, a 410 will be returned.
/// If no start version is given, it will start at version 0.To retrieve a pending transaction, use /transactions/by_hash.
/// [aptos documation](https://aptos.dev/en/build/apis/fullnode-rest-api-reference)
class AptosRequestGetAccountTransactions extends AptosRequest<
    List<AptosApiTransaction>, List<Map<String, dynamic>>> {
  AptosRequestGetAccountTransactions(
      {required this.address, this.start, this.limit});

  /// Address of account with or without a `0x` prefix
  final AptosAddress address;

  /// Account sequence number to start list of transactionsIf not provided,
  /// defaults to showing the latest transactions
  final BigInt? start;

  /// Max number of transactions to retrieve. If not provided, defaults to default page size
  final int? limit;
  @override
  String get method => AptosApiMethod.getAccountTransactions.url;

  @override
  List<String> get pathParameters => [address.address];
  @override
  Map<String, String?> get queryParameters =>
      {"start": start?.toString(), "limit": limit?.toString()};

  @override
  List<AptosApiTransaction> onResonse(List<Map<String, dynamic>> result) {
    return result.map((e) => AptosApiTransaction.fromJson(e)).toList();
  }
}
