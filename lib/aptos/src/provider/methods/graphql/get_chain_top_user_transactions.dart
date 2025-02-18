import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/graphql/queries/queries.dart';

class AptosGraphQLRequestGetChainTopUserTransactions
    extends AptosGraphQLRequest<List<dynamic>, Map<String, dynamic>> {
  AptosGraphQLRequestGetChainTopUserTransactions({this.limit, this.headers});
  final int? limit;
  @override
  final Map<String, String>? headers;

  @override
  String get method => AptosGraphqlQueriesConst.getChainTopUserTransactions;
  @override
  Map<String, dynamic> get queryVariables => {"limit": limit};
  @override
  List onResonse(Map<String, dynamic> result) {
    return result["user_transactions"];
  }
}
