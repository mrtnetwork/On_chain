import 'package:on_chain/tron/provider/core/request.dart';
import 'package:on_chain/tron/provider/methods/request_methods.dart';

/// GetExpandedSpendingKey
/// [developers.tron.network](https://developers.tron.network/reference/getexpandedspendingkey).
class TronRequestGetExpandedSpendingKey
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetExpandedSpendingKey({required this.value});

  /// HEX of Spending Key
  final String value;

  /// wallet/getexpandedspendingkey
  @override
  TronHTTPMethods get method => TronHTTPMethods.getexpandedspendingkey;

  @override
  Map<String, dynamic> toJson() {
    return {"value": value};
  }

  @override
  String toString() {
    return "TronRequestGetExpandedSpendingKey{${toJson()}}";
  }
}
