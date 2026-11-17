import 'package:on_chain/sui/src/rpc/core/core.dart';

/// Return the total number of transaction blocks known to the server.
/// [sui documation](https://docs.sui.io/sui-api-ref#sui_getlatestcheckpointsequencenumber)
class SuiRequestGetTotalTransactionBlocks extends SuiRequest<String, String> {
  const SuiRequestGetTotalTransactionBlocks();

  @override
  String get method => 'sui_getTotalTransactionBlocks';

  @override
  List<dynamic> toJson() {
    return [];
  }
}
