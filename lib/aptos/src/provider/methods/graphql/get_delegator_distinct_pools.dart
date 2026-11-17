import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/graphql/queries/queries.dart';

class AptosGraphQLRequestGetDelegatorDistinctPools
    extends
        AptosGraphQLRequest<
          List<AptosGraphQLDelegatorDistinctPool>,
          Map<String, dynamic>
        > {
  AptosGraphQLRequestGetDelegatorDistinctPools({
    required this.variables,
    this.headers,
  });
  @override
  final Map<String, String>? headers;
  final AptosGraphQLWhereConditionVariablesParams variables;

  @override
  String get method => AptosGraphqlQueriesConst.getDelegatorDistinctPools;
  @override
  Map<String, dynamic> get queryVariables => variables.toJson();

  @override
  List<AptosGraphQLDelegatorDistinctPool> onResponse(
    Map<String, dynamic> result,
  ) {
    return result
        .valueEnsureAsList<Map<String, dynamic>>("delegator_distinct_pool")
        .map((e) => AptosGraphQLDelegatorDistinctPool.fromJson(e))
        .toList();
  }
}
