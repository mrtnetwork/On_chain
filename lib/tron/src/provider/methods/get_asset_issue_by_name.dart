import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Query a token by name, returns token info...
/// [developers.tron.network](https://developers.tron.network/reference/getassetissuebyname-copy).
class TronRequestGetAssetIssueByName
    extends TronRequest<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetAssetIssueByName({required this.value});
  final String value;

  /// wallet/getassetissuebyname
  @override
  TronHTTPMethods get method => TronHTTPMethods.getassetissuebyname;

  @override
  Map<String, dynamic> toJson() {
    return {'value': value};
  }

  @override
  bool get visible => true;
}
