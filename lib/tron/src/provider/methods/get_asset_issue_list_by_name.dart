import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Query the list of all the TRC10 tokens by a name.
/// [developers.tron.network](https://developers.tron.network/reference/getassetissuelistbyname-copy).
class TronRequestGetAssetIssueListByName
    extends TronRequest<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetAssetIssueListByName({required this.value});

  /// Name of the TRC 10 token
  final String value;

  /// wallet/getassetissuelistbyname
  @override
  TronHTTPMethods get method => TronHTTPMethods.getassetissuelistbyname;

  @override
  Map<String, dynamic> toJson() {
    return {'value': value};
  }

  @override
  bool get visible => true;

  @override
  String toString() {
    return 'TronRequestGetAssetIssueListByName{${toJson()}}';
  }
}
