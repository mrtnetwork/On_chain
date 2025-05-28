import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';
import 'package:on_chain/tron/src/provider/models/transaction.dart';

/// Broadcast the protobuf encoded transaction hex string after sign (developers.tron.network)[https://developers.tron.network/reference/broadcasthex].
class TronRequestBroadcastHex
    extends TronRequest<TronBroadcastHexResponse, Map<String, dynamic>> {
  TronRequestBroadcastHex({required this.transaction});

  /// Transaction hex after sign
  final String transaction;

  @override
  TronHTTPMethods get method => TronHTTPMethods.broadcasthex;

  @override
  Map<String, dynamic> toJson() {
    return {'transaction': transaction};
  }

  @override
  String toString() {
    return 'TronRequestBroadcastHex{${toJson()}}';
  }

  @override
  bool get visible => true;

  @override
  TronBroadcastHexResponse onResonse(Map<String, dynamic> result) {
    return TronBroadcastHexResponse.fromJson(result);
  }
}
