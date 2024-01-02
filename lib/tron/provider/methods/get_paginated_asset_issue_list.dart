import 'package:on_chain/tron/provider/core/request.dart';
import 'package:on_chain/tron/provider/methods/request_methods.dart';

/// Query the list of all the tokens by pagination.Returns a list of Tokens that succeed the Token located at offset.
/// [developers.tron.network](https://developers.tron.network/reference/getpaginatedassetissuelist).
class TronRequestGetPaginatedAssetIssueList
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetPaginatedAssetIssueList(
      {required this.offset, required this.limit});

  /// The index of the start token
  final int offset;

  /// The amount of tokens per page
  final int limit;

  /// wallet/getpaginatedassetissuelist
  @override
  TronHTTPMethods get method => TronHTTPMethods.getpaginatedassetissuelist;

  @override
  Map<String, dynamic> toJson() {
    return {"offset": offset, "limit": limit};
  }

  @override
  String toString() {
    return "TronRequestGetPaginatedAssetIssueList{${toJson()}}";
  }
}
