import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Validates address, returns either true or false.
/// [developers.tron.network](https://developers.tron.network/reference/validateaddress).
class TronRequestValidateAddress
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestValidateAddress({required this.address, this.visible = true});

  /// Address should be in base58checksum
  final String address;
  @override
  final bool visible;

  /// wallet/validateaddress
  @override
  TronHTTPMethods get method => TronHTTPMethods.validateaddress;

  @override
  Map<String, dynamic> toJson() {
    return {"address": address, "visible": visible};
  }

  @override
  String toString() {
    return "TronRequestValidateAddress{${toJson()}}";
  }
}
