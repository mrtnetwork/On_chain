import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';
import 'package:on_chain/tron/src/provider/models/chain_parameters.dart';

/// All parameters that the blockchain committee can set
/// [developers.tron.network](https://developers.tron.network/reference/wallet-getchainparameters).
class TronRequestGetChainParameters
    extends TVMRequestParam<TronChainParameters, Map<String, dynamic>> {
  TronRequestGetChainParameters();

  /// wallet/getchainparameters
  @override
  TronHTTPMethods get method => TronHTTPMethods.getchainparameters;

  @override
  Map<String, dynamic> toJson() {
    return {};
  }

  @override
  TronChainParameters onResonse(result) {
    final List<Map<String, dynamic>> chainParams =
        List.from(result["chainParameter"]);
    final Map<String, dynamic> params = {
      for (final i in chainParams) i["key"]: i["value"]
    };
    return TronChainParameters.fromJson(params);
  }

  @override
  String toString() {
    return "TronRequestGetChainParameters{${toJson()}}";
  }
}
