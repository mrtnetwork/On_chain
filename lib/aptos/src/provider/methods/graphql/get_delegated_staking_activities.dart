import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/graphql/queries/queries.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

class AptosGraphQLRequestGetDelegatedStakingActivities
    extends AptosGraphQLRequest<List<AptosGraphQLDelegatedStakingActivity>,
        Map<String, dynamic>> {
  AptosGraphQLRequestGetDelegatedStakingActivities(
      {required this.delegatorAddress, this.poolAddress, this.headers});
  @override
  final Map<String, String>? headers;
  final String? delegatorAddress;
  final String? poolAddress;

  @override
  String get method => AptosGraphqlQueriesConst.getDelegatedStakingActivities;
  @override
  Map<String, dynamic> get queryVariables =>
      {"delegatorAddress": delegatorAddress, "poolAddress": poolAddress};

  @override
  List<AptosGraphQLDelegatedStakingActivity> onResonse(
      Map<String, dynamic> result) {
    return result
        .asListOfMap("delegated_staking_activities")!
        .map((e) => AptosGraphQLDelegatedStakingActivity.fromJson(e))
        .toList();
  }
}
