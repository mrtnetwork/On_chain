import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/graphql/queries/queries.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

class AptosGraphQLRequestGetCurrentFungibleAssetBalances
    extends AptosGraphQLRequest<List<AptosGraphQLFungibleAssetBalance>,
        Map<String, dynamic>> {
  AptosGraphQLRequestGetCurrentFungibleAssetBalances(
      {required this.variables, this.headers});
  @override
  final Map<String, String>? headers;
  final AptosGraphQLPaginatedVariablesParams variables;

  @override
  String get method => AptosGraphqlQueriesConst.getCurrentFungibleAssetBalances;
  @override
  Map<String, dynamic> get queryVariables => variables.toJson();

  @override
  List<AptosGraphQLFungibleAssetBalance> onResonse(
      Map<String, dynamic> result) {
    return result
        .asListOfMap("current_fungible_asset_balances")!
        .map((e) => AptosGraphQLFungibleAssetBalance.fromJson(e))
        .toList();
  }
}
