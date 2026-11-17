import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/graphql/queries/queries.dart';

class AptosGraphQLRequestGetDelegatedStakingActivities
    extends
        AptosGraphQLRequest<
          List<AptosGraphQLDelegatedStakingActivity>,
          Map<String, dynamic>
        > {
  AptosGraphQLRequestGetDelegatedStakingActivities({
    required this.variables,
    this.headers,
  });
  @override
  final Map<String, String>? headers;
  final AptosGraphQLPaginatedWithOrderVariablesParams variables;

  @override
  String get method => AptosGraphqlQueriesConst.getDelegatedStakingActivities;
  @override
  Map<String, dynamic> get queryVariables => variables.toJson();

  @override
  List<AptosGraphQLDelegatedStakingActivity> onResponse(
    Map<String, dynamic> result,
  ) {
    return result
        .valueEnsureAsList<Map<String, dynamic>>("delegated_staking_activities")
        .map((e) => AptosGraphQLDelegatedStakingActivity.fromJson(e))
        .toList();
  }
}
