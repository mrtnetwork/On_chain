import 'package:on_chain/tron/provider/core/request.dart';
import 'package:on_chain/tron/provider/methods/request_methods.dart';

/// GetNkFromNsk
/// [developers.tron.network](https://developers.tron.network/reference/getnkfromnsk).
class TronRequestGetNkFromNsk
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetNkFromNsk({required this.value});
  final String value;

  /// wallet/getnkfromnsk
  @override
  TronHTTPMethods get method => TronHTTPMethods.getnkfromnsk;

  @override
  Map<String, dynamic> toJson() {
    return {"value": value};
  }
}
