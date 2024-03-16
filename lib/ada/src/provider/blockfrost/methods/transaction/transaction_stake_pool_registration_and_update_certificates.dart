import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Obtain information about stake pool registration and update certificates of a specific transaction.
/// https://blockfrost.dev/api/transaction-stake-pool-registration-and-update-certificates
class BlockfrostRequestTransactionStakePoolRegistrationAndUpdateCertificates
    extends BlockforestRequestParam<
        List<ADAPoolRegistrationCertificateResponse>,
        List<Map<String, dynamic>>> {
  BlockfrostRequestTransactionStakePoolRegistrationAndUpdateCertificates(
      this.hash);

  /// Hash of the requested transaction
  final String hash;

  /// Transaction stake pool registration and update certificates
  @override
  String get method => BlockfrostMethods
      .transactionStakePoolRegistrationAndUpdateCertificates.url;

  @override
  List<String> get pathParameters => [hash];

  @override
  List<ADAPoolRegistrationCertificateResponse> onResonse(
      List<Map<String, dynamic>> result) {
    return result
        .map((e) => ADAPoolRegistrationCertificateResponse.fromJson(e))
        .toList();
  }
}
