import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/graphql/queries/queries.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

class AptosGraphQLRequestGetAccountCollectionsWithOwnedTokens
    extends AptosGraphQLRequest<List<AptosGraphQLCollectionOwnershipV2View>,
        Map<String, dynamic>> {
  AptosGraphQLRequestGetAccountCollectionsWithOwnedTokens({
    required this.variables,
    this.headers,
  });
  final AptosGraphQLPaginatedWithOrderVariablesParams variables;
  @override
  final Map<String, String>? headers;

  @override
  String get method =>
      AptosGraphqlQueriesConst.getAccountCollectionWithOwnedTokens;
  @override
  Map<String, dynamic> get queryVariables => variables.toJson();
  @override
  List<AptosGraphQLCollectionOwnershipV2View> onResonse(
      Map<String, dynamic> result) {
    return result
        .asListOfMap("current_collection_ownership_v2_view")!
        .map((e) => AptosGraphQLCollectionOwnershipV2View.fromJson(e))
        .toList();
  }
}
