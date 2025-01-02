import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// CreateShieldedContractParameters. [developers.tron.network](https://developers.tron.network/reference/createshieldedcontractparameters).
class TronRequestCreateShieldedContractParameters
    extends TronRequest<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestCreateShieldedContractParameters(
      {this.ovk,
      this.fromAccount,
      this.toAmount,
      this.transparentToAddress,
      required this.shieldedTRC20ContractAddress,
      this.ask,
      this.nsk});
  final String? ovk;
  final String? fromAccount;
  final String? toAmount;
  final String? transparentToAddress;
  final String shieldedTRC20ContractAddress;
  final String? ask;
  final String? nsk;

  /// wallet/createshieldedcontractparameters
  @override
  TronHTTPMethods get method =>
      TronHTTPMethods.createshieldedcontractparameters;

  @override
  Map<String, dynamic> toJson() {
    return {
      'ovk': ovk,
      'from_amount': fromAccount,
      'to_amount': toAmount,
      'transparent_to_address': transparentToAddress,
      'shielded_TRC20_contract_address': shieldedTRC20ContractAddress,
      'ask': ask,
      'nsk': nsk
    };
  }

  @override
  bool get visible => true;
}
