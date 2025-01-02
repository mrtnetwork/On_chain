import 'package:on_chain/solidity/contract/fragments.dart';
import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/smart_contract/trigger_smart_contract.dart';
import 'package:on_chain/tron/src/models/parsed_request/parsed_contract_request.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';
import 'package:blockchain_utils/utils/utils.dart';

/// Returns TransactionExtention, which contains the unsigned Transaction
/// [developers.tron.network](https://developers.tron.network/reference/triggersmartcontract).
class TronRequestTriggerSmartContract
    extends TronRequest<ParsedSmartContractRequest, Map<String, dynamic>> {
  factory TronRequestTriggerSmartContract.fromContract(
      TriggerSmartContract contract,
      {int? permissionId,
      BigInt? feeLimit}) {
    return TronRequestTriggerSmartContract._(
        ownerAddress: contract.ownerAddress,
        contractAddress: contract.contractAddress,
        data: contract.data == null
            ? null
            : BytesUtils.toHexString(contract.data!),
        callTokenValue: contract.callTokenValue,
        callValue: contract.callValue,
        tokenId: contract.tokenId,
        permissionId: permissionId,
        feeLimit: feeLimit);
  }
  factory TronRequestTriggerSmartContract.fromMethod({
    required TronAddress ownerAddress,
    required TronAddress contractAddress,
    required AbiFunctionFragment function,
    required List<dynamic> params,
    final BigInt? feeLimit,
    final int? permissionId,
    String? parameter,
    BigInt? callValue,
    BigInt? callTokenValue,
    BigInt? tokenId,
    bool visible = true,
  }) {
    final rawBytes = function.encode(params, true);

    return TronRequestTriggerSmartContract._(
        ownerAddress: ownerAddress,
        contractAddress: contractAddress,
        callTokenValue: callTokenValue,
        callValue: callValue,
        data: rawBytes.isEmpty ? null : BytesUtils.toHexString(rawBytes),
        fragment: function,
        tokenId: tokenId,
        visible: visible,
        permissionId: permissionId,
        feeLimit: feeLimit);
  }
  factory TronRequestTriggerSmartContract({
    required TronAddress ownerAddress,
    required TronAddress contractAddress,
    String? functionSelector,
    String? parameter,
    String? data,
    BigInt? callValue,
    BigInt? callTokenValue,
    BigInt? tokenId,
    BigInt? feeLimit,
    int? permissionId,
    bool visible = true,
  }) {
    return TronRequestTriggerSmartContract._(
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
  TronRequestTriggerSmartContract._(
      {required this.ownerAddress,
      required this.contractAddress,
      this.feeLimit,
      this.permissionId,
      this.functionSelector,
      this.parameter,
      AbiFunctionFragment? fragment,
      this.data,
      this.callValue,
      this.callTokenValue,
      this.tokenId,
      this.visible = true})
      : _fragment = fragment;

  /// Address that triggers the contract
  final TronAddress ownerAddress;

  /// Contract address
  final TronAddress contractAddress;

  /// Function call, must not be left blank
  final String? functionSelector;

  /// Parameter encoding needs to be in accordance with the ABI rules,
  /// the rules are more complicated, users can use the ethers library to encode,For details,
  ///  please refer to the document-Guide-Smart Contract-Best Practice-Parameter Encoding and Decoding.
  final String? parameter;

  /// The data for interacting with smart contracts,
  /// including the contract function and parameters.
  /// You can choose to use this field, or you can choose to use function_selector
  /// and parameter for contract interaction. When both of data and function_selector exist,
  /// function_selector is preferred
  final String? data;

  /// Amount of TRX transferred with this transaction, measured in SUN (1 TRX = 1,000,000 SUN).
  final BigInt? callValue;

  /// Amount of TRC10 token transferred with this transaction
  final BigInt? callTokenValue;

  /// TRC10 token id
  final BigInt? tokenId;

  /// Maximum TRX consumption, measured in SUN (1 TRX = 1,000,000 SUN).
  final BigInt? feeLimit;

  /// for multi-signature
  final int? permissionId;
  final AbiFunctionFragment? _fragment;
  @override
  final bool visible;

  /// wallet/triggersmartcontract
  @override
  TronHTTPMethods get method => TronHTTPMethods.triggersmartcontract;

  @override
  Map<String, dynamic> toJson() {
    return {
      'owner_address': ownerAddress.toAddress(visible),
      'contract_address': contractAddress.toAddress(visible),
      'function_selector': functionSelector,
      'parameter': parameter,
      'data': data,
      'call_value': callValue,
      'call_token_value': callTokenValue,
      'token_id': tokenId,
      'visible': visible,
      'feeimit': feeLimit,
      'Permission_id': permissionId
    };
  }

  @override
  ParsedSmartContractRequest onResonse(result) {
    return ParsedSmartContractRequest.fromJson(result, _fragment);
  }

  @override
  String toString() {
    return 'ParsedSmartContractRequest{${toJson()}}';
  }
}
