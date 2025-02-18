import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/graphql/queries/queries.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

class AptosGraphQLRequestGetNumberOfDelegators extends AptosGraphQLRequest<
    List<AptosGraphQLNumActiveDelegatorPerPool>, Map<String, dynamic>> {
  AptosGraphQLRequestGetNumberOfDelegators(
      {required this.variables, this.headers});
  @override
  final Map<String, String>? headers;
  final AptosGraphQLWhereConditionWithOrderVariablesParams variables;

  @override
  String get method => AptosGraphqlQueriesConst.getNumberOfDelegators;
  @override
  Map<String, dynamic> get queryVariables => variables.toJson();

  @override
  List<AptosGraphQLNumActiveDelegatorPerPool> onResonse(
      Map<String, dynamic> result) {
    return result
        .asListOfMap("num_active_delegator_per_pool")!
        .map((e) => AptosGraphQLNumActiveDelegatorPerPool.fromJson(e))
        .toList();
  }
}
