import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Get the account balance in a specific block
/// [developers.tron.network](https://developers.tron.network/reference/getaccountbalance).
class TronRequestGetAccountBalance
    extends TronRequest<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetAccountBalance(
      {required this.accountIdentifier,
      required this.blockIdentifier,
      this.visible = true});

  /// account_identifier
  final Map<String, TronAddress> accountIdentifier;

  /// block_identifier
  final Map<String, String> blockIdentifier;
  @override
  final bool visible;

  @override
  TronHTTPMethods get method => TronHTTPMethods.getaccountbalance;

  @override
  Map<String, dynamic> toJson() {
    return {
      'account_identifier': accountIdentifier.map(
        (key, value) => MapEntry(key, value.toAddress(visible)),
      ),
      'block_identifier': blockIdentifier,
      'visible': visible
    };
  }

  @override
  String toString() {
    return 'TronRequestGetAccountBalance{${toJson()}}';
  }
}
