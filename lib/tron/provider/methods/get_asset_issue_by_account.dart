import 'package:on_chain/tron/address/tron_address.dart';
import 'package:on_chain/tron/provider/core/request.dart';
import 'package:on_chain/tron/provider/methods/request_methods.dart';

/// Query the TRC10 token information issued by an account.
/// [developers.tron.network](https://developers.tron.network/reference/getassetissuebyaccount).
class TronRequestGetAssetIssueByAccount
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetAssetIssueByAccount(
      {required this.address, this.visible = true});

  /// Address is the Token Issuer account address
  final TronAddress address;
  @override
  final bool visible;

  /// wallet/getassetissuebyaccount
  @override
  TronHTTPMethods get method => TronHTTPMethods.getassetissuebyaccount;

  @override
  Map<String, dynamic> toJson() {
    return {"address": address, "visible": visible};
  }

  @override
  String toString() {
    return "TronRequestGetAssetIssueByAccount{${toJson()}}";
  }
}
