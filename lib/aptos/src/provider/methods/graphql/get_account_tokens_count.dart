import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/graphql/queries/queries.dart';

class AptosGraphQLRequestGetAccountTokensCount extends AptosGraphQLRequest<
    AptosGraphQLApiAggregate, Map<String, dynamic>> {
  AptosGraphQLRequestGetAccountTokensCount(
      {required this.variables, this.headers});
  final AptosGraphQLPaginatedVariablesParams variables;
  @override
  final Map<String, String>? headers;

  @override
  String get method => AptosGraphqlQueriesConst.getAccountTokensCount;
  @override
  Map<String, dynamic> get queryVariables => variables.toJson();
  @override
  AptosGraphQLApiAggregate onResonse(Map<String, dynamic> result) {
    return AptosGraphQLApiAggregate.fromJson(
        result["current_token_ownerships_v2_aggregate"]["aggregate"]);
  }
}
