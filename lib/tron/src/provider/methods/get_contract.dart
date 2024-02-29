import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Queries a contract's information from the blockchain, including the bytecode of the contract, ABI, configuration parameters, etc.
/// [developers.tron.network](https://developers.tron.network/reference/wallet-getcontract).
class TronRequestGetContract
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetContract({required this.value, this.visible = true});

  /// Contract address
  final TronAddress value;
  @override
  final bool visible;

  /// wallet/getcontract
  @override
  TronHTTPMethods get method => TronHTTPMethods.getcontract;

  @override
  Map<String, dynamic> toJson() {
    return {"value": value, "visible": visible};
  }

  @override
  String toString() {
    return "TronRequestGetContract{${toJson()}}";
  }
}
