import 'package:on_chain/tron/address/tron_address.dart';
import 'package:on_chain/tron/provider/core/request.dart';
import 'package:on_chain/tron/provider/methods/request_methods.dart';
import 'package:on_chain/tron/provider/models/account_resource.dart';

/// Query the resource information of an account(bandwidth,energy,etc).
/// [developers.tron.network](https://developers.tron.network/reference/getaccountresource).
class TronRequestGetAccountResource
    extends TVMRequestParam<AccountResourceModel, Map<String, dynamic>> {
  TronRequestGetAccountResource({required this.address, this.visible = true});

  /// Address
  final TronAddress address;
  @override
  final bool visible;

  @override
  TronHTTPMethods get method => TronHTTPMethods.getaccountresource;

  /// wallet/getaccountresource
  @override
  Map<String, dynamic> toJson() {
    return {"address": address, "visible": visible};
  }

  @override
  AccountResourceModel onResonse(result) {
    return AccountResourceModel.fromJson(result);
  }

  @override
  String toString() {
    return "TronRequestGetAccountResource{${toJson()}}";
  }
}
