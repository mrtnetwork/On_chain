import 'package:on_chain/tron/address/tron_address.dart';
import 'package:on_chain/tron/provider/core/request.dart';
import 'package:on_chain/tron/provider/methods/request_methods.dart';

/// Query the resource delegation by an account during stake1.0 phase. i.e. list all addresses that have delegated resources to an account.
/// [developers.tron.network](https://developers.tron.network/reference/getdelegatedresourceaccountindex).
class TronRequestGetDelegatedResourceAccountIndex
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetDelegatedResourceAccountIndex(
      {required this.value, this.visible = true});

  /// Address
  final TronAddress value;
  @override
  final bool visible;

  /// wallet/getdelegatedresourceaccountindex
  @override
  TronHTTPMethods get method =>
      TronHTTPMethods.getdelegatedresourceaccountindex;

  @override
  Map<String, dynamic> toJson() {
    return {"value": value, "visible": visible};
  }

  @override
  String toString() {
    return "TronRequestGetDelegatedResourceAccountIndex{${toJson()}}";
  }
}
