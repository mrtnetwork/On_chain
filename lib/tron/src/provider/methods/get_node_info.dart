import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// GetNodeInfo
/// [developers.tron.network](https://developers.tron.network/reference/wallet-getnodeinfo).
class TronRequestGetNodeInfo
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetNodeInfo();

  /// wallet/getnodeinfo
  @override
  TronHTTPMethods get method => TronHTTPMethods.getnodeinfo;

  @override
  Map<String, dynamic> toJson() {
    return {};
  }

  @override
  String toString() {
    return "TronRequestGetNodeInfo{${toJson()}}";
  }
}
