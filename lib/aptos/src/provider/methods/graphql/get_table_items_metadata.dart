import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/graphql/queries/queries.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

class AptosGraphQLRequestGetTableItemsMetadata extends AptosGraphQLRequest<
    List<AptosGraphQLTableMetadata>, Map<String, dynamic>> {
  AptosGraphQLRequestGetTableItemsMetadata(
      {required this.variables, this.headers});
  @override
  final Map<String, String>? headers;
  final AptosGraphQLPaginatedWithOrderVariablesParams variables;

  @override
  String get method => AptosGraphqlQueriesConst.getTableItemsMetadata;
  @override
  Map<String, dynamic> get queryVariables => variables.toJson();

  @override
  List<AptosGraphQLTableMetadata> onResonse(Map<String, dynamic> result) {
    return result
        .asListOfMap("table_metadatas")!
        .map((e) => AptosGraphQLTableMetadata.fromJson(e))
        .toList();
  }
}
