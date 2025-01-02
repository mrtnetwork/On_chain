import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Returns the Block Object corresponding to the 'Block Height' specified (number of blocks preceding it).
/// [developers.tron.network](https://developers.tron.network/reference/wallet-getblockbynum).
class TronRequestGetBlockByNum
    extends TronRequest<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetBlockByNum({required this.num});

  /// num is the block height
  final int num;

  /// wallet/getblockbynum
  @override
  TronHTTPMethods get method => TronHTTPMethods.getblockbynum;

  @override
  Map<String, dynamic> toJson() {
    return {'num': num};
  }

  @override
  String toString() {
    return 'TronRequestGetBlockByNum{${toJson()}}';
  }
}
