import 'package:on_chain/tron/provider/core/request.dart';
import 'package:on_chain/tron/provider/methods/request_methods.dart';

/// GetIncomingViewingKey
/// [developers.tron.network](https://developers.tron.network/reference/getincomingviewingkey).
class TronRequestGetIncomingViewingKey
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetIncomingViewingKey({required this.ak, required this.nk});
  final String ak;
  final String nk;

  /// wallet/getincomingviewingkey
  @override
  TronHTTPMethods get method => TronHTTPMethods.getincomingviewingkey;

  @override
  Map<String, dynamic> toJson() {
    return {"ak": ak, "nk": nk};
  }

  @override
  String toString() {
    return "TronRequestGetIncomingViewingKey{${toJson()}}";
  }
}
