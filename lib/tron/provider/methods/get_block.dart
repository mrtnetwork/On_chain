import 'package:on_chain/tron/provider/core/request.dart';
import 'package:on_chain/tron/provider/methods/request_methods.dart';

/// Query block header information or entire block information according to block height or block hash
/// [developers.tron.network](https://developers.tron.network/reference/getblock-1).
class TronRequestGetBlock
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetBlock({required this.idOrNum, this.detail = false});

  /// id_or_num can be the block height or the block hash. No value entered means to query the latest block.
  final String idOrNum;

  /// true means query the entire block information include the header and body. false means only query the block header information.
  final bool detail;

  /// wallet/getblock
  @override
  TronHTTPMethods get method => TronHTTPMethods.getblock;

  @override
  Map<String, dynamic> toJson() {
    return {"id_or_num": idOrNum, "detail": detail};
  }

  @override
  String toString() {
    return "TronRequestGetBlock{${toJson()}}";
  }
}
