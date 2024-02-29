import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Query exchange pair based on id
/// [developers.tron.network](https://developers.tron.network/reference/wallet-getexchangebyid).
class TronRequestGetExchangeById
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetExchangeById({required this.id});

  /// Transaction Pair ID
  final int id;

  /// wallet/getexchangebyid
  @override
  TronHTTPMethods get method => TronHTTPMethods.getexchangebyid;

  @override
  Map<String, dynamic> toJson() {
    return {"id": id};
  }

  @override
  String toString() {
    return "TronRequestGetExchangeById{${toJson()}}";
  }
}
