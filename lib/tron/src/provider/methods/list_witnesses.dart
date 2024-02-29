import 'package:on_chain/tron/src/models/wintnesses/witness_account.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// List all Super Representatives.
/// [developers.tron.network](https://developers.tron.network/reference/listwitnesses).
class TronRequestListWitnesses
    extends TVMRequestParam<List<WitnessesAccount>, Map<String, dynamic>> {
  /// wallet/listwitnesses
  @override
  TronHTTPMethods get method => TronHTTPMethods.listwitnesses;

  @override
  Map<String, dynamic> toJson() {
    return {};
  }

  @override
  String toString() {
    return "TronRequestListWitnesses{${toJson()}}";
  }

  @override
  List<WitnessesAccount> onResonse(Map<String, dynamic> result) {
    final witnesses = (result["witnesses"] as List)
        .map((e) => WitnessesAccount.fromJson(e))
        .toList();
    return witnesses;
  }
}
