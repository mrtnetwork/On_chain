import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Participate the transaction of exchange pair
/// [developers.tron.network](https://developers.tron.network/reference/exchangetransaction).
class TronRequestExchangeTransaction
    extends TronRequest<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestExchangeTransaction(
      {required this.ownerAddress,
      required this.exchangeId,
      required this.tokenId,
      required this.quant,
      required this.expected,
      this.permissionId,
      this.visible = true});

  /// Trader's wallet address
  final TronAddress ownerAddress;

  /// Transaction Pair ID
  final int exchangeId;

  /// ID of the sold token
  final String tokenId;

  /// Quantity of the token being sold
  final int quant;

  /// Expected quantity of the token being purchase
  final int expected;

  /// for multi-signature use
  final int? permissionId;
  @override
  final bool visible;

  /// wallet/exchangetransaction
  @override
  TronHTTPMethods get method => TronHTTPMethods.exchangetransaction;

  @override
  Map<String, dynamic> toJson() {
    return {
      'owner_address': ownerAddress.toAddress(visible),
      'exchange_id': exchangeId,
      'token_id': tokenId,
      'quant': quant,
      'expected': expected,
      'permission_id': permissionId,
      'visible': visible
    };
  }

  @override
  String toString() {
    return 'TronRequestExchangeTransaction{${toJson()}}';
  }
}
