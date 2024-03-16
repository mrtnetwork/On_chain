import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Obtain information about stake pool retirements within a specific transaction.
/// https://blockfrost.dev/api/transaction-stake-pool-retirement-certificates
class BlockfrostRequestTransactionStakePoolRetirementCertificates
    extends BlockforestRequestParam<
        List<ADATransactionPoolRetirementCertificateResponse>,
        List<Map<String, dynamic>>> {
  BlockfrostRequestTransactionStakePoolRetirementCertificates(this.hash);

  /// Hash of the requested transaction
  final String hash;

  /// Transaction stake pool retirement certificates
  @override
  String get method =>
      BlockfrostMethods.transactionStakePoolRetirementCertificates.url;

  @override
  List<String> get pathParameters => [hash];

  @override
  List<ADATransactionPoolRetirementCertificateResponse> onResonse(
      List<Map<String, dynamic>> result) {
    return result
        .map((e) => ADATransactionPoolRetirementCertificateResponse.fromJson(e))
        .toList();
  }
}
