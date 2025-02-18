import 'package:on_chain/aptos/src/provider/methods/methods/methods.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/fullnode/types.dart';

/// This endpoint allows you to get the transactions in a blockand the corresponding
/// block information.Transactions are limited by max default transactions size.
/// If not all transactionsare present, the user will need to query for the rest
/// of the transactions via theget transactions API.If the block is pruned, it will return a 410
/// [aptos documation](https://aptos.dev/en/build/apis/fullnode-rest-api-reference)
class AptosRequestGetBlocksByHeight
    extends AptosRequest<AptosApiBlock, Map<String, dynamic>> {
  AptosRequestGetBlocksByHeight(
      {required this.blockHeight, this.withTransaction});

  /// Block height to lookup.  Starts at 0
  final BigInt blockHeight;

  /// If set to true, include all transactions in the blockIf not provided, no transactions will be retrieved
  final bool? withTransaction;
  @override
  String get method => AptosApiMethod.getBlocksByHeight.url;

  @override
  List<String> get pathParameters => [blockHeight.toString()];
  @override
  Map<String, String?> get queryParameters =>
      {"with_transactions": withTransaction?.toString()};

  @override
  AptosApiBlock onResonse(Map<String, dynamic> result) {
    return AptosApiBlock.fromJson(result);
  }
}
