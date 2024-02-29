import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Returns a list of block objects.
/// [developers.tron.network](https://developers.tron.network/reference/wallet-getblockbylatestnum).
class TronRequestGetBlockByLatestNum
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetBlockByLatestNum({required this.num});
  final int num;

  /// wallet/getblockbylatestnum
  @override
  TronHTTPMethods get method => TronHTTPMethods.getblockbylatestnum;

  @override
  Map<String, dynamic> toJson() {
    return {"num": num};
  }

  @override
  String toString() {
    return "TronRequestGetBlockByLatestNum{${toJson()}}";
  }
}
