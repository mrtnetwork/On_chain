import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Broadcast the signed transaction [developers.tron.network](https://developers.tron.network/reference/broadcasttransaction).
class TronRequestBroadcastTransaction
    extends TronRequest<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestBroadcastTransaction({required this.rawData});

  /// raw body
  final String rawData;

  @override
  TronHTTPMethods get method => TronHTTPMethods.broadcasttransaction;

  @override
  Map<String, dynamic> toJson() {
    return {'raw_data': rawData};
  }

  @override
  String toString() {
    return 'TronRequestBroadcastTransaction{${toJson()}}';
  }

  @override
  bool get visible => false;
}
