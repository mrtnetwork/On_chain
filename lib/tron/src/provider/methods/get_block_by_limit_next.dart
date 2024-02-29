import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Returns the list of Block Objects included in the 'Block Height' range specified.
/// [developers.tron.network](https://developers.tron.network/reference/getblockbylimitnext).
class TronRequestGetBlockByLimitNext
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetBlockByLimitNext(
      {required this.startNum, required this.endNum});

  /// Starting block height, including this block.
  final int startNum;

  /// Ending block height, excluding that block.
  final int endNum;

  /// wallet/getblockbylimitnext
  @override
  TronHTTPMethods get method => TronHTTPMethods.getblockbylimitnext;

  @override
  Map<String, dynamic> toJson() {
    return {"startNum": startNum, "endNum": endNum};
  }
}
