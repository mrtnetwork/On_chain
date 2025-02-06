import 'package:on_chain/aptos/src/address/address/address.dart';
import 'package:on_chain/aptos/src/provider/methods/methods/methods.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';
import 'package:on_chain/aptos/src/provider/models/models/types.dart';

/// Return the authentication key and the sequence number for an account\naddress.
/// Optionally, a ledger version can be specified. If the ledger\nversion is not
/// specified in the request, the latest ledger version is used
/// [aptos documation](https://aptos.dev/en/build/apis/fullnode-rest-api-reference)
class AptosRequestGetAccount
    extends AptosRequest<AptosApiAccountData, Map<String, dynamic>> {
  /// Address of account with or without a `0x` prefix
  final AptosAddress address;

  /// Ledger version to get state of account If not provided, it will be the latest version
  final BigInt? ledgerVersion;
  AptosRequestGetAccount({required this.address, this.ledgerVersion});
  @override
  String get method => AptosApiMethod.getAccount.url;

  @override
  List<String> get pathParameters => [address.toString()];
  @override
  Map<String, String?> get queryParameters =>
      {"ledger_version": ledgerVersion?.toString()};

  @override
  AptosApiAccountData onResonse(Map<String, dynamic> result) {
    return AptosApiAccountData.fromJson(result);
  }
}
