import 'package:on_chain/tron/address/tron_address.dart';
import 'package:on_chain/tron/provider/core/request.dart';
import 'package:on_chain/tron/provider/methods/request_methods.dart';

/// Returns all resources delegations during stake1.0 phase from an account to another account.
/// The fromAddress can be retrieved from the GetDelegatedResourceAccountIndex API.
/// [developers.tron.network](https://developers.tron.network/reference/getdelegatedresource).
class TronRequestGetDelegatedResource
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetDelegatedResource(
      {required this.fromAddress,
      required this.toAddress,
      this.visible = true});

  /// Energy from address
  final TronAddress fromAddress;

  /// Energy delegation information
  final TronAddress toAddress;
  @override
  final bool visible;

  /// wallet/getdelegatedresource
  @override
  TronHTTPMethods get method => TronHTTPMethods.getdelegatedresource;

  @override
  Map<String, dynamic> toJson() {
    return {
      "fromAddress": fromAddress,
      "toAddress": toAddress,
      "visible": visible
    };
  }

  @override
  String toString() {
    return "TronRequestGetDelegatedResource{${toJson()}}";
  }
}
