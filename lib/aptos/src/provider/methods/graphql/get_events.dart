import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/graphql/queries/queries.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

class AptosGraphQLRequestGetEvents
    extends AptosGraphQLRequest<List<AptosGraphQLEvent>, Map<String, dynamic>> {
  AptosGraphQLRequestGetEvents({required this.variables, this.headers});
  @override
  final Map<String, String>? headers;
  final AptosGraphQLPaginatedWithOrderVariablesParams variables;

  @override
  String get method => AptosGraphqlQueriesConst.getEvents;
  @override
  Map<String, dynamic> get queryVariables => variables.toJson();

  @override
  List<AptosGraphQLEvent> onResonse(Map<String, dynamic> result) {
    return result
        .asListOfMap("events")!
        .map((e) => AptosGraphQLEvent.fromJson(e))
        .toList();
  }
}
