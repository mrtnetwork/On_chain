import 'package:on_chain/aptos/src/address/address/address.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/graphql/queries/queries.dart';

class AptosGraphQLRequestGetAccountTransactionsCount
    extends AptosGraphQLRequest<AptosGraphQLApiAggregate,
        Map<String, dynamic>> {
  AptosGraphQLRequestGetAccountTransactionsCount(
      {required this.address, this.headers});
  final AptosAddress address;
  @override
  final Map<String, String>? headers;

  @override
  String get method => AptosGraphqlQueriesConst.getAccountTransactionsCount;
  @override
  Map<String, dynamic> get queryVariables => {"address": address.toString()};
  @override
  AptosGraphQLApiAggregate onResonse(Map<String, dynamic> result) {
    return AptosGraphQLApiAggregate.fromJson(
        result["account_transactions_aggregate"]["aggregate"]);
  }
}
