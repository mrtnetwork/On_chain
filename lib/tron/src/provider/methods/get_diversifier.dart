import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// GetDiversifier
/// [developers.tron.network](https://developers.tron.network/reference/getdiversifier).
class TronRequestGetDiversifier
    extends TronRequest<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetDiversifier();

  /// wallet/getdiversifier
  @override
  TronHTTPMethods get method => TronHTTPMethods.getdiversifier;

  @override
  Map<String, dynamic> toJson() {
    return {};
  }

  @override
  String toString() {
    return 'TronRequestGetDiversifier{${toJson()}}';
  }
}
