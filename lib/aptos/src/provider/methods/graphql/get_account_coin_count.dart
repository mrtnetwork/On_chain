import 'package:on_chain/aptos/src/address/address/address.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/graphql/queries/queries.dart';

class AptosGraphQLRequestGetAccountCoinsCount extends AptosGraphQLRequest<
    AptosGraphQLApiAggregate, Map<String, dynamic>> {
  AptosGraphQLRequestGetAccountCoinsCount(
      {required this.address, this.headers});
  final AptosAddress address;
  @override
  final Map<String, String>? headers;

  @override
  String get method => AptosGraphqlQueriesConst.getAccountCoinsCount;
  @override
  Map<String, dynamic> get queryVariables => {'address': address.address};
  @override
  AptosGraphQLApiAggregate onResonse(Map<String, dynamic> result) {
    return AptosGraphQLApiAggregate.fromJson(
        result["current_fungible_asset_balances_aggregate"]["aggregate"]);
  }
}
