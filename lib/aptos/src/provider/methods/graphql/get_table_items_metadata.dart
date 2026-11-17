import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/graphql/queries/queries.dart';

class AptosGraphQLRequestGetTableItemsMetadata
    extends
        AptosGraphQLRequest<
          List<AptosGraphQLTableMetadata>,
          Map<String, dynamic>
        > {
  AptosGraphQLRequestGetTableItemsMetadata({
    required this.variables,
    this.headers,
  });
  @override
  final Map<String, String>? headers;
  final AptosGraphQLPaginatedWithOrderVariablesParams variables;

  @override
  String get method => AptosGraphqlQueriesConst.getTableItemsMetadata;
  @override
  Map<String, dynamic> get queryVariables => variables.toJson();

  @override
  List<AptosGraphQLTableMetadata> onResponse(Map<String, dynamic> result) {
    return result
        .valueEnsureAsList<Map<String, dynamic>>("table_metadatas")
        .map((e) => AptosGraphQLTableMetadata.fromJson(e))
        .toList();
  }
}
