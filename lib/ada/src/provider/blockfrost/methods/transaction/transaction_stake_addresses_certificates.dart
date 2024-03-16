import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Obtain information about (de)registration of stake addresses within a transaction.
/// https://blockfrost.dev/api/transaction-stake-addresses-certificates
class BlockfrostRequestTransactionStakeAddressesCertificates
    extends BlockforestRequestParam<List<ADATransactionStakeAddressCertificateResponse>,
        List<Map<String, dynamic>>> {
  BlockfrostRequestTransactionStakeAddressesCertificates(this.hash);

  /// Hash of the requested transaction
  final String hash;

  /// Transaction stake addresses certificates
  @override
  String get method =>
      BlockfrostMethods.transactionStakeAddressesCertificates.url;

  @override
  List<String> get pathParameters => [hash];

  @override
  List<ADATransactionStakeAddressCertificateResponse> onResonse(
      List<Map<String, dynamic>> result) {
    return result
        .map((e) => ADATransactionStakeAddressCertificateResponse.fromJson(e))
        .toList();
  }
}
