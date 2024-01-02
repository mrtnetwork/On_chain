import 'package:on_chain/tron/provider/core/request.dart';
import 'package:on_chain/tron/provider/methods/request_methods.dart';

/// GetZenPaymentAddress
/// [developers.tron.network](https://developers.tron.network/reference/getzenpaymentaddress).
class TronRequestGetZenPaymentAddress
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetZenPaymentAddress({required this.ivk, required this.d});
  final String ivk;
  final String d;

  /// wallet/getzenpaymentaddress
  @override
  TronHTTPMethods get method => TronHTTPMethods.getzenpaymentaddress;

  @override
  Map<String, dynamic> toJson() {
    return {"ivk": ivk, "d": d};
  }

  @override
  String toString() {
    return "TronRequestGetZenPaymentAddress{${toJson()}}";
  }
}
