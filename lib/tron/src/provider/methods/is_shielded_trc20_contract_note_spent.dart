import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// IsShieldedTrc20ContractNoteSpent
/// [developers.tron.network](https://developers.tron.network/reference/isshieldedtrc20contractnotespent).
class TronRequestIsShieldedTrc20ContractNoteSpent
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestIsShieldedTrc20ContractNoteSpent(
      {required this.ak,
      required this.nk,
      required this.position,
      required this.shieldedTRC20ContractAddress});
  final String ak;
  final String nk;
  final int position;
  final String shieldedTRC20ContractAddress;

  /// wallet/isshieldedtrc20contractnotespent
  @override
  TronHTTPMethods get method =>
      TronHTTPMethods.isshieldedtrc20contractnotespent;

  @override
  Map<String, dynamic> toJson() {
    return {
      "ak": ak,
      "nk": nk,
      "position": position,
      "shielded_TRC20_contract_address": shieldedTRC20ContractAddress
    };
  }

  @override
  String toString() {
    return "TronRequestIsShieldedTrc20ContractNoteSpent{${toJson()}}";
  }
}
