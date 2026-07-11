import 'package:blockchain_utils/utils/json/json.dart';
import 'package:blockchain_utils/utils/numbers/utils/int_utils.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/graphql/queries/queries.dart';

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
    final ledgerInfo = result.valueAsList<List<Map<String, dynamic>>?>(
      "ledger_infos",
    );
    if (ledgerInfo == null || ledgerInfo.isEmpty) return null;
    return IntUtils.tryParse(result["ledger_infos"][0]["chain_id"]);
  }
}
