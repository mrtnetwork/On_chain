import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/graphql/queries/queries.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

class AptosGraphQLRequestGetAccountOwnedTokens extends AptosGraphQLRequest<
    List<AptosGraphQLTokenOwnershipV2>, Map<String, dynamic>> {
  AptosGraphQLRequestGetAccountOwnedTokens(
      {required this.variables, this.headers});
  final AptosGraphQLPaginatedWithOrderVariablesParams variables;
  @override
  final Map<String, String>? headers;

  @override
  String get method => AptosGraphqlQueriesConst.getAccountOwnedTokens;
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
