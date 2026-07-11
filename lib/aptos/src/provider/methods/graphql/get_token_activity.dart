import 'package:blockchain_utils/utils/json/extension/json.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/graphql/queries/queries.dart';

class AptosGraphQLRequestGetTokenActivity
    extends
        AptosGraphQLRequest<
          List<AptosGraphQLTokenActivity>,
          Map<String, dynamic>
        > {
  AptosGraphQLRequestGetTokenActivity({required this.variables, this.headers});
  @override
  final Map<String, String>? headers;
  final AptosGraphQLPaginatedWithOrderVariablesParams variables;

  @override
  String get method => AptosGraphqlQueriesConst.getTokenActivity;
  @override
  Map<String, dynamic> get queryVariables => variables.toJson();

  @override
  List<AptosGraphQLTokenActivity> onResonse(Map<String, dynamic> result) {
    return result
        .valueEnsureAsList<Map<String, dynamic>>("token_activities_v2")
        .map((e) => AptosGraphQLTokenActivity.fromJson(e))
        .toList();
  }
}
