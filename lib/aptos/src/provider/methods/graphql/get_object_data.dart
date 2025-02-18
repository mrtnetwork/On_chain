import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/graphql/queries/queries.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

class AptosGraphQLRequestGetObjectData extends AptosGraphQLRequest<
    List<AptosGraphQLObject>, Map<String, dynamic>> {
  AptosGraphQLRequestGetObjectData({required this.variables, this.headers});
  @override
  final Map<String, String>? headers;
  final AptosGraphQLPaginatedWithOrderVariablesParams variables;

  @override
  String get method => AptosGraphqlQueriesConst.getObjectData;
  @override
  Map<String, dynamic> get queryVariables => variables.toJson();

  @override
  List<AptosGraphQLObject> onResonse(Map<String, dynamic> result) {
    return result
        .asListOfMap("current_objects")!
        .map((e) => AptosGraphQLObject.fromJson(e))
        .toList();
  }
}
