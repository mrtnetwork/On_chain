import 'package:on_chain/tron/src/models/parsed_request/parsed_contract_request.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Broadcast the protobuf encoded transaction hex string after sign (developers.tron.network)[https://developers.tron.network/reference/broadcasthex].
class TronRequestBroadcastHex extends TronRequest<
    ParsedBroadcastTransactionResult, Map<String, dynamic>> {
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
  ParsedBroadcastTransactionResult onResonse(Map<String, dynamic> result) {
    return ParsedBroadcastTransactionResult.fromJson(result);
  }
}
