import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';
import 'package:on_chain/tron/src/provider/models/block.dart';

/// Query the latest block information
/// [developers.tron.network](https://developers.tron.network/reference/wallet-getnowblock).
class TronRequestGetNowBlock
    extends TronRequest<TronBlock, Map<String, dynamic>> {
  TronRequestGetNowBlock();

  /// wallet/getnowblock
  @override
  TronHTTPMethods get method => TronHTTPMethods.getnowblock;

  @override
  Map<String, dynamic> toJson() {
    return {};
  }

  @override
  TronBlock onResonse(result) {
    return TronBlock.fromJson(result);
  }

  @override
  String toString() {
    return 'TronRequestGetNowBlock{${toJson()}}';
  }
}
