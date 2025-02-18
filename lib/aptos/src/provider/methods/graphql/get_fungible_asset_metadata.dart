import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/graphql/queries/queries.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

class AptosGraphQLRequestGetFungibleAssetMetadata extends AptosGraphQLRequest<
    List<AptosGraphQLFungibleAssetMetadata>, Map<String, dynamic>> {
  AptosGraphQLRequestGetFungibleAssetMetadata(
      {required this.variables, this.headers});
  @override
  final Map<String, String>? headers;
  final AptosGraphQLPaginatedVariablesParams variables;

  @override
  String get method => AptosGraphqlQueriesConst.getFungibleAssetMetadata;
  @override
  Map<String, dynamic> get queryVariables => variables.toJson();

  @override
  List<AptosGraphQLFungibleAssetMetadata> onResonse(
      Map<String, dynamic> result) {
    return result
        .asListOfMap("fungible_asset_metadata")!
        .map((e) => AptosGraphQLFungibleAssetMetadata.fromJson(e))
        .toList();
  }
}
