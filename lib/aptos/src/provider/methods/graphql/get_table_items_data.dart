import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/graphql/queries/queries.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

class AptosGraphQLRequestGetTableItemsData extends AptosGraphQLRequest<
    List<AptosGraphQLTableItem>, Map<String, dynamic>> {
  AptosGraphQLRequestGetTableItemsData({required this.variables, this.headers});
  @override
  final Map<String, String>? headers;
  final AptosGraphQLPaginatedWithOrderVariablesParams variables;

  @override
  String get method => AptosGraphqlQueriesConst.getTableItemsData;
  @override
  Map<String, dynamic> get queryVariables => variables.toJson();

  @override
  List<AptosGraphQLTableItem> onResonse(Map<String, dynamic> result) {
    return result
        .asListOfMap("table_items")!
        .map((e) => AptosGraphQLTableItem.fromJson(e))
        .toList();
  }
}
