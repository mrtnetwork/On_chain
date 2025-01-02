import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Scan outgoing notes(spent).
/// [developers.tron.network](https://developers.tron.network/reference/scanshieldedtrc20notesbyovk).
class TronRequestScanShieldedTrc20NotesByOvk
    extends TronRequest<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestScanShieldedTrc20NotesByOvk({
    required this.startBlockIndex,
    required this.endBlockIndex,
    required this.shieldedTRC20ContractAddress,
    required this.ovk,
  });
  final int startBlockIndex;
  final int endBlockIndex;
  final String shieldedTRC20ContractAddress;
  final String ovk;

  /// wallet/scanshieldedtrc20notesbyovk
  @override
  TronHTTPMethods get method => TronHTTPMethods.scanshieldedtrc20notesbyovk;

  @override
  Map<String, dynamic> toJson() {
    return {
      'start_block_index': startBlockIndex,
      'end_block_index': endBlockIndex,
      'shielded_TRC20_contract_address': shieldedTRC20ContractAddress,
      'ovk': ovk,
      'visible': visible
    };
  }

  @override
  String toString() {
    return 'TronRequestScanShieldedTrc20NotesByOvk{${toJson()}}';
  }
}
