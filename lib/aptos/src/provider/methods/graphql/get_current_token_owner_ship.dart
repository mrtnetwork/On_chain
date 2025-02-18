import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/graphql/queries/queries.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

class AptosGraphQLRequestGetCurrentTokenOwnership extends AptosGraphQLRequest<
    List<AptosGraphQLTokenOwnershipV2>, Map<String, dynamic>> {
  AptosGraphQLRequestGetCurrentTokenOwnership(
      {required this.variables, this.headers});
  @override
  final Map<String, String>? headers;
  final AptosGraphQLPaginatedWithOrderVariablesParams variables;

  @override
  String get method => AptosGraphqlQueriesConst.getCurrentTokenOwnership;
  @override
  Map<String, dynamic> get queryVariables => variables.toJson();

  @override
  List<AptosGraphQLTokenOwnershipV2> onResonse(Map<String, dynamic> result) {
    return result
        .asListOfMap("current_token_ownerships_v2")!
        .map((e) => AptosGraphQLTokenOwnershipV2.fromJson(e))
        .toList();
  }
}
