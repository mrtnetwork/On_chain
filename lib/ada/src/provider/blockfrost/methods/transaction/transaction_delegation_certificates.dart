import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Obtain information about delegation certificates of a specific transaction.
/// https://blockfrost.dev/api/transaction-delegation-certificates
class BlockfrostRequestTransactionDelegationCertificates
    extends BlockforestRequestParam<List<ADATransactionDelegationCertificateResponse>,
        List<Map<String, dynamic>>> {
  BlockfrostRequestTransactionDelegationCertificates(this.hash);

  /// Hash of the requested transaction
  final String hash;

  /// Transaction delegation certificates
  @override
  String get method => BlockfrostMethods.transactionDelegationCertificates.url;

  @override
  List<String> get pathParameters => [hash];

  @override
  List<ADATransactionDelegationCertificateResponse> onResonse(
      List<Map<String, dynamic>> result) {
    return result
        .map((e) => ADATransactionDelegationCertificateResponse.fromJson(e))
        .toList();
  }
}
