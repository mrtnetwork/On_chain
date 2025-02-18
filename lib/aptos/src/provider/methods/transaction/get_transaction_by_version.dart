import 'package:on_chain/aptos/src/provider/methods/methods/methods.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/fullnode/types.dart';

/// Retrieves a transaction by a given version.
/// If the version has beenpruned, a 410 will be returned.
/// [aptos documation](https://aptos.dev/en/build/apis/fullnode-rest-api-reference)
class AptosRequestGetTransactionByVersion
    extends AptosRequest<AptosApiTransaction, Map<String, dynamic>> {
  AptosRequestGetTransactionByVersion(this.txnVersion);

  /// Version of transaction to retrieve
  final BigInt txnVersion;
  @override
  String get method => AptosApiMethod.getTransactionByVersion.url;

  @override
  List<String> get pathParameters => [txnVersion.toString()];

  @override
  AptosApiTransaction onResonse(Map<String, dynamic> result) {
    return AptosApiTransaction.fromJson(result);
  }
}
