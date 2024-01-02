import 'package:on_chain/tron/provider/core/request.dart';
import 'package:on_chain/tron/provider/methods/request_methods.dart';

/// Query the account address list which signed the transaction.
/// [developers.tron.network](https://developers.tron.network/reference/http-getapprovedlist).
class TronRequestGetApprovedList
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetApprovedList({
    required this.signature,
    required this.rawData,
    this.visible = true,
  });

  /// The signature list of transaction
  final List<String> signature;

  /// The transaction raw data
  final Map<String, dynamic> rawData;
  @override
  final bool visible;
  @override
  TronHTTPMethods get method => TronHTTPMethods.getapprovedlist;

  @override
  Map<String, dynamic> toJson() {
    return {"signature": signature, "raw_data": rawData};
  }

  @override
  String toString() {
    return "TronRequestGetApprovedList{${toJson()}}";
  }
}
