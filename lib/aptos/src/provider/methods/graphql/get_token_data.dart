import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/graphql/queries/queries.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

class AptosGraphQLRequestGetCurrentTokenData extends AptosGraphQLRequest<
    List<AptosGraphQLTokenCollection>, Map<String, dynamic>> {
  AptosGraphQLRequestGetCurrentTokenData(
      {required this.variables, this.headers});
  @override
  final Map<String, String>? headers;
  final AptosGraphQLPaginatedWithOrderVariablesParams variables;

  @override
  String get method => AptosGraphqlQueriesConst.getTokenData;
  @override
  Map<String, dynamic> get queryVariables => variables.toJson();

  @override
  List<AptosGraphQLTokenCollection> onResonse(Map<String, dynamic> result) {
    return result
        .asListOfMap("current_token_datas_v2")!
        .map((e) => AptosGraphQLTokenCollection.fromJson(e))
        .toList();
  }
}
