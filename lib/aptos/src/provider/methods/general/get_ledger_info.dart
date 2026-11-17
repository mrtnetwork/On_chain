import 'package:on_chain/aptos/src/provider/methods/methods/methods.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/fullnode/types.dart';

/// Get the latest ledger information, including data such as chain ID,role type, ledger versions, epoch, etc.
/// [aptos documentation](https://aptos.dev/en/build/apis/fullnode-rest-api-reference)
class AptosRequestGetLedgerInfo
    extends AptosRequest<AptosApiLedgerInfo, Map<String, dynamic>> {
  @override
  String get method => AptosApiMethod.getLedgerInfo.url;

  @override
  AptosApiLedgerInfo onResponse(Map<String, dynamic> result) {
    return AptosApiLedgerInfo.fromJson(result);
  }
}
