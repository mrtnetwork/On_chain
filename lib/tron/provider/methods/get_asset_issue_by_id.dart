import 'package:on_chain/tron/provider/core/request.dart';
import 'package:on_chain/tron/provider/methods/request_methods.dart';

/// Query a token by token id. Returns the token object, which contains the token name..
/// [developers.tron.network](https://developers.tron.network/reference/getassetissuebyid).
class TronRequestGetAssetIssueById
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetAssetIssueById({required this.value});
  final int value;

  /// wallet/getassetissuebyid
  @override
  TronHTTPMethods get method => TronHTTPMethods.getassetissuebyid;

  @override
  Map<String, dynamic> toJson() {
    return {"value": value};
  }

  @override
  bool get visible => true;
}
