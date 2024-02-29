import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// To clear the ABI info of a smart contract. [developers.tron.network](https://api.shasta.trongrid.io/wallet/clearabi).
class TronRequestClearAbi
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestClearAbi(
      {required this.ownerAddress,
      required this.contractAddress,
      this.visible = true});

  /// Account address
  final TronAddress ownerAddress;

  /// Contract address
  final TronAddress contractAddress;
  @override
  final bool visible;

  /// wallet/clearabi
  @override
  TronHTTPMethods get method => TronHTTPMethods.clearabi;

  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress,
      "contract_address": contractAddress,
      "visible": visible
    };
  }
}
