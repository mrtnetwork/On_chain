import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/graphql/queries/queries.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

class AptosGraphQLRequestGetAccountCoinsData extends AptosGraphQLRequest<
    List<AptosGraphQLFungibleAssetBalance>, Map<String, dynamic>> {
  AptosGraphQLRequestGetAccountCoinsData({
    required this.variables,
    this.headers,
  });
  final AptosGraphQLPaginatedWithOrderVariablesParams variables;
  @override
  final Map<String, String>? headers;

  @override
  String get method => AptosGraphqlQueriesConst.getAccountCoinsData;
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
