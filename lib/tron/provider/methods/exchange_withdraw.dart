import 'package:on_chain/tron/address/tron_address.dart';
import 'package:on_chain/tron/provider/core/request.dart';
import 'package:on_chain/tron/provider/methods/request_methods.dart';

/// Withdraws the transaction pair.
/// [developers.tron.network](https://developers.tron.network/reference/exchangewithdraw).
class TronRequestExchangeWithdraw
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestExchangeWithdraw(
      {required this.ownerAddress,
      required this.exchangeId,
      required this.tokenId,
      required this.quant,
      this.permissionId,
      this.visible = true});

  /// Address of the transaction to the creator
  final TronAddress ownerAddress;

  /// Transaction Pair ID
  final int exchangeId;

  /// Token ID
  final String tokenId;

  /// Number of tokens divested.
  final int quant;

  /// for multi-signature use
  final int? permissionId;
  @override
  final bool visible;

  /// wallet/exchangewithdraw
  @override
  TronHTTPMethods get method => TronHTTPMethods.exchangewithdraw;
  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress,
      "exchange_id": exchangeId,
      "token_id": tokenId,
      "quant": quant,
      "permission_id": permissionId,
      "visible": visible
    };
  }

  @override
  String toString() {
    return "TronRequestExchangeWithdraw{${toJson()}}";
  }
}
