import 'package:on_chain/solidity/contract/fragments.dart';
import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/parsed_request/parsed_contract_request.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

/// Invoke the readonly function (modified by the view or pure modifier) of a contract for contract data query;
/// or Invoke the non-readonly function of a contract for predicting whether
/// the transaction can be successfully executed and estimating the energy consumption;
/// or estimate the energy consumption of contract deployment
/// [developers.tron.network](https://developers.tron.network/reference/triggerconstantcontract).
class TronRequestTriggerConstantContract
    extends TVMRequestParam<ParsedSmartContractRequest, Map<String, dynamic>> {
  factory TronRequestTriggerConstantContract.fromMethod({
    required TronAddress ownerAddress,
    required TronAddress contractAddress,
    required AbiFunctionFragment function,
    required List<dynamic> params,
    String? parameter,
    BigInt? callValue,
    BigInt? callTokenValue,
    BigInt? tokenId,
    bool visible = true,
  }) {
    final rawBytes = function.encode(params, true);

    return TronRequestTriggerConstantContract._(
        ownerAddress: ownerAddress,
        contractAddress: contractAddress,
        callTokenValue: callTokenValue,
        callValue: callValue,
        data: rawBytes.isEmpty ? null : BytesUtils.toHexString(rawBytes),
        fragment: function,
        tokenId: tokenId,
        visible: visible);
  }
  factory TronRequestTriggerConstantContract({
    required TronAddress ownerAddress,
    required TronAddress contractAddress,
    String? functionSelector,
    String? parameter,
    String? data,
    BigInt? callValue,
    BigInt? callTokenValue,
    BigInt? tokenId,
    bool visible = true,
  }) {
    return TronRequestTriggerConstantContract._(
        ownerAddress: ownerAddress,
        contractAddress: contractAddress,
        functionSelector: functionSelector,
        parameter: parameter,
        callTokenValue: callTokenValue,
        callValue: callValue,
        data: data,
        fragment: null,
        tokenId: tokenId,
        visible: visible);
  }
  TronRequestTriggerConstantContract._(
      {required this.ownerAddress,
      required this.contractAddress,
      this.functionSelector,
      this.parameter,
      AbiFunctionFragment? fragment,
      this.data,
      this.callValue,
      this.callTokenValue,
      this.tokenId,
      this.visible = true})
      : _fragment = fragment;

  /// Owner address that triggers the contract.
  final TronAddress ownerAddress;

  /// Smart contract address
  final TronAddress contractAddress;

  /// Function call, must not be left blank.
  final String? functionSelector;

  /// Parameter encoding needs to be in accordance with the ABI rules,
  /// the rules are more complicated, users can use the ethers library
  /// to encode,For details, please refer to the document-Guide-Smart
  /// Contract-Best Practice-Parameter Encoding and Decoding.
  final String? parameter;

  /// The bytecode of the contract or the data for interacting with smart contracts,
  /// including the contract function and parameters. You can choose to use this field,
  /// or you can choose to use function_selector and parameter for contract interaction.
  ///  When both of data and function_selector exist, function_selector is preferred
  final String? data;

  /// Amount of TRX transferred to the contract with this transaction, the unit is sun. This field may be used when estimating energy consumption.
  final BigInt? callValue;

  /// Amount of TRC10 token transferred with this transaction
  final BigInt? callTokenValue;

  /// TRC10 token id
  final BigInt? tokenId;
  @override
  final bool visible;
  final AbiFunctionFragment? _fragment;

  /// wallet/triggerconstantcontract
  @override
  TronHTTPMethods get method => TronHTTPMethods.triggerconstantcontract;

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
  ParsedSmartContractRequest onResonse(result) {
    return ParsedSmartContractRequest.fromJson(result, _fragment);
  }
}
