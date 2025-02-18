import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/graphql/queries/queries.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

class AptosGraphQLRequestGetNames extends AptosGraphQLRequest<
    List<AptosGraphQLAptosName>, Map<String, dynamic>> {
  AptosGraphQLRequestGetNames({required this.variables, this.headers});
  @override
  final Map<String, String>? headers;
  final AptosGraphQLPaginatedWithOrderVariablesParams variables;

  @override
  String get method => AptosGraphqlQueriesConst.getNames;
  @override
  Map<String, dynamic> get queryVariables => variables.toJson();

  @override
  List<AptosGraphQLAptosName> onResonse(Map<String, dynamic> result) {
    return result
        .asListOfMap("current_aptos_names")!
        .map((e) => AptosGraphQLAptosName.fromJson(e))
        .toList();
  }
}
