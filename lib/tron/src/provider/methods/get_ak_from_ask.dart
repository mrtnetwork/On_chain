import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// GetAkFromAsk.
/// [developers.tron.network](https://developers.tron.network/reference/getakfromask).
class TronRequestGetAkFromAsk
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetAkFromAsk({required this.value});
  final String value;

  /// wallet/getakfromask
  @override
  TronHTTPMethods get method => TronHTTPMethods.getakfromask;

  @override
  Map<String, dynamic> toJson() {
    return {"value": value};
  }

  @override
  bool get visible => false;
  @override
  String toString() {
    return "TronRequestGetAkFromAsk{${toJson()}}";
  }
}
