import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/graphql/queries/queries.dart';

class AptosGraphQLRequestGetTopDelegationPools
    extends
        AptosGraphQLRequest<
          List<AptosGraphQLDelegationPoolBalance>,
          Map<String, dynamic>
        > {
  AptosGraphQLRequestGetTopDelegationPools({
    required this.variables,
    this.headers,
  });
  @override
  final Map<String, String>? headers;
  final AptosGraphQLPaginatedWithOrderVariablesParams variables;

  @override
  String get method => AptosGraphqlQueriesConst.getTopDelegationPools;
  @override
  Map<String, dynamic> get queryVariables => variables.toJson();

  @override
  List<AptosGraphQLDelegationPoolBalance> onResponse(
    Map<String, dynamic> result,
  ) {
    return result
        .valueEnsureAsList<Map<String, dynamic>>(
          "current_delegated_staking_pool_balances",
        )
        .map((e) => AptosGraphQLDelegationPoolBalance.fromJson(e))
        .toList();
  }
}
