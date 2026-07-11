import 'package:blockchain_utils/utils/json/extension/json.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/graphql/queries/queries.dart';

class AptosGraphQLRequestGetProcessorStatus
    extends
        AptosGraphQLRequest<
          List<AptosGraphQLProcessorStatus>,
          Map<String, dynamic>
        > {
  AptosGraphQLRequestGetProcessorStatus({
    required this.variables,
    this.headers,
  });
  @override
  final Map<String, String>? headers;
  final AptosGraphQLWhereConditionVariablesParams variables;

  @override
  String get method => AptosGraphqlQueriesConst.getProcessorStatus;
  @override
  Map<String, dynamic> get queryVariables => variables.toJson();

  @override
  List<AptosGraphQLProcessorStatus> onResonse(Map<String, dynamic> result) {
    return result
        .valueEnsureAsList<Map<String, dynamic>>("processor_status")
        .map((e) => AptosGraphQLProcessorStatus.fromJson(e))
        .toList();
  }
}
