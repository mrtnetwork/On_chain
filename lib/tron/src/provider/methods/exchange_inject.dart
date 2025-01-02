import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Injects capital into the transaction. The purpose of injecting capital into
/// the trading pair is to prevent price fluctuation from affecting the transaction.
/// [developers.tron.network](https://developers.tron.network/reference/exchangeinject).
class TronRequestExchangeInject
    extends TronRequest<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestExchangeInject(
      {required this.ownerAddress,
      required this.exchangeId,
      required this.tokenId,
      required this.quant,
      this.permissionId,
      this.visible = true});

  /// Transaction to the creator's address
  final TronAddress ownerAddress;

  /// Transaction Pair ID
  final int exchangeId;

  /// Token ID; usually is the token name
  final String tokenId;

  /// Number of capital injection tokens.
  final int quant;

  /// for multi-signature use
  final int? permissionId;
  @override
  final bool visible;

  /// wallet/exchangeinject
  @override
  TronHTTPMethods get method => TronHTTPMethods.exchangeinject;
  @override
  Map<String, dynamic> toJson() {
    return {
      'owner_address': ownerAddress.toAddress(visible),
      'exchange_id': exchangeId,
      'token_id': tokenId,
      'quant': quant,
      'permission_id': permissionId,
      'visible': visible
    };
  }

  @override
  String toString() {
    return 'TronRequestExchangeInject{${toJson()}}';
  }
}
