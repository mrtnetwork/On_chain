import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// [developers.tron.network](https://developers.tron.network/reference/gettransactioninfobyblocknum).
class TronRequestGetTransactionInfoByBlockNum
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetTransactionInfoByBlockNum({required this.num});

  /// Block height
  final int num;

  /// wallet/gettransactioninfobyblocknum
  @override
  TronHTTPMethods get method => TronHTTPMethods.gettransactioninfobyblocknum;

  @override
  Map<String, dynamic> toJson() {
    return {"num": num};
  }

  @override
  String toString() {
    return "TronRequestGetTransactionInfoByBlockNum{${toJson()}}";
  }
}
