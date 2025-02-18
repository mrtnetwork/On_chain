import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/graphql/queries/queries.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

class AptosGraphQLRequestGetFungibleAssetActivities extends AptosGraphQLRequest<
    List<AptosGraphQLFungibleAssetActivity>, Map<String, dynamic>> {
  AptosGraphQLRequestGetFungibleAssetActivities(
      {required this.variables, this.headers});
  @override
  final Map<String, String>? headers;
  final AptosGraphQLPaginatedVariablesParams variables;

  @override
  String get method => AptosGraphqlQueriesConst.getFungibleAssetActivities;
  @override
  Map<String, dynamic> get queryVariables => variables.toJson();

  @override
  List<AptosGraphQLFungibleAssetActivity> onResonse(
      Map<String, dynamic> result) {
    return result
        .asListOfMap("fungible_asset_activities")!
        .map((e) => AptosGraphQLFungibleAssetActivity.fromJson(e))
        .toList();
  }
}
