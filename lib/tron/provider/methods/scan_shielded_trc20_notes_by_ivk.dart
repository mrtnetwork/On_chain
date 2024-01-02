import 'package:on_chain/tron/provider/core/request.dart';
import 'package:on_chain/tron/provider/methods/request_methods.dart';

/// Scan outgoing notes.
/// [developers.tron.network](https://developers.tron.network/reference/scanshieldedtrc20notesbyivk).
class TronRequestScanShieldedTrc20NotesByIvk
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestScanShieldedTrc20NotesByIvk(
      {required this.startBlockIndex,
      required this.endBlockIndex,
      required this.shieldedTRC20ContractAddress,
      required this.ivk,
      required this.ak,
      required this.nk});
  final int startBlockIndex;
  final int endBlockIndex;
  final String shieldedTRC20ContractAddress;
  final String ivk;
  final String ak;
  final String nk;

  /// wallet/scanshieldedtrc20notesbyivk
  @override
  TronHTTPMethods get method => TronHTTPMethods.scanshieldedtrc20notesbyivk;

  @override
  Map<String, dynamic> toJson() {
    return {
      "start_block_index": startBlockIndex,
      "end_block_index": endBlockIndex,
      "shielded_TRC20_contract_address": shieldedTRC20ContractAddress,
      "ivk": ivk,
      "ak": ak,
      "nk": nk,
      "visible": visible
    };
  }

  @override
  String toString() {
    return "TronRequestScanShieldedTrc20NotesByIvk{${toJson()}}";
  }
}
