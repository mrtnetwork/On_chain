import 'package:on_chain/tron/address/tron_address.dart';
import 'package:on_chain/tron/provider/core/request.dart';
import 'package:on_chain/tron/provider/methods/request_methods.dart';

/// Estimate the energy required for the successful execution of smart contract transactions or deploying a contract.
/// [developers.tron.network](https://developers.tron.network/reference/wallet-deploycontract).
class TronRequestEstimateEnergy
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestEstimateEnergy(
      {required this.ownerAddress,
      required this.contractAddress,
      required this.functionSelector,
      required this.parameter,
      this.data,
      this.callValue,
      this.callTokenValue,
      this.tokenId,
      this.visible = true});

  /// Owner address that triggers the contract
  final TronAddress ownerAddress;

  /// Smart contract address
  final TronAddress contractAddress;

  /// Function call, must not be left blank.
  final String functionSelector;

  /// Parameter encoding needs to be in accordance with the ABI rules, the rules are more complicated, users can use the ethers library to encode,For details,
  /// please refer to the document-Guide-Smart Contract-Best Practice-Parameter Encoding and Decoding.
  final String parameter;

  /// The bytecode of the contract or the data for interacting with smart contracts,
  /// including the contract function and parameters. You can choose to use this field, or you can choose to use function_selector and parameter for contract interaction. When both of data and function_selector exist, function_selector is preferred
  final String? data;

  /// Amount of TRX transferred with this transaction, measured in SUN (1 TRX = 1,000,000 SUN).
  final BigInt? callValue;

  /// Amount of TRC10 token transferred with this transaction
  final BigInt? callTokenValue;

  /// TRC10 token id
  final BigInt? tokenId;

  @override
  final bool visible;

  /// wallet/estimateenergy
  @override
  TronHTTPMethods get method => TronHTTPMethods.estimateenergy;

  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress,
      "contract_address": contractAddress,
      "function_selector": functionSelector,
      "parameter": parameter,
      "data": data,
      "call_value": callValue,
      "call_token_value": callTokenValue,
      "token_id": tokenId,
      "visible": visible
    };
  }

  @override
  String toString() {
    return "TronRequestEstimateEnergy{${toJson()}}";
  }
}
