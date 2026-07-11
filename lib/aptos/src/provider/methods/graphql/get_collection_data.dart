import 'package:blockchain_utils/utils/json/extension/json.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/graphql/queries/queries.dart';

class AptosGraphQLRequestGetCollectionData
    extends
        AptosGraphQLRequest<
          List<AptosGraphQLCollectionV2>,
          Map<String, dynamic>
        > {
  AptosGraphQLRequestGetCollectionData({required this.variables, this.headers});
  @override
  final Map<String, String>? headers;
  final AptosGraphQLWhereConditionVariablesParams variables;

  @override
  String get method => AptosGraphqlQueriesConst.getCollectionData;
  @override
  Map<String, dynamic> get queryVariables => variables.toJson();

  @override
  List<AptosGraphQLCollectionV2> onResonse(Map<String, dynamic> result) {
    return result
        .valueEnsureAsList<Map<String, dynamic>>("current_collections_v2")
        .map((e) => AptosGraphQLCollectionV2.fromJson(e))
        .toList();
  }
}
