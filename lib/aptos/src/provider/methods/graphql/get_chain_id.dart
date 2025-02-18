import 'package:blockchain_utils/utils/numbers/utils/int_utils.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/graphql/queries/queries.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

class AptosGraphQLRequestChainId
    extends AptosGraphQLRequest<int?, Map<String, dynamic>> {
  AptosGraphQLRequestChainId({this.headers});
  @override
  final Map<String, String>? headers;

  @override
  String get method => AptosGraphqlQueriesConst.chainId;
  @override
  Map<String, dynamic> get queryVariables => {};
  @override
  int? onResonse(Map<String, dynamic> result) {
    final ledgerInfo = result.asListOfMap("ledger_infos", throwOnNull: false);
    if (ledgerInfo == null || ledgerInfo.isEmpty) return null;
    return IntUtils.tryParse(result["ledger_infos"][0]["chain_id"]);
  }
}
