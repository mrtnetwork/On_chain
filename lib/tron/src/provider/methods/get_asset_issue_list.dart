import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Query the list of all the TRC10 tokens.
/// [developers.tron.network](https://developers.tron.network/reference/getassetissuelist).
class TronRequestGetAssetIssueList
    extends TronRequest<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetAssetIssueList();

  /// wallet/getassetissuelist
  @override
  TronHTTPMethods get method => TronHTTPMethods.getassetissuelist;

  @override
  Map<String, dynamic> toJson() {
    return {};
  }

  @override
  String toString() {
    return 'TronRequestGetAssetIssueList{${toJson()}}';
  }
}
