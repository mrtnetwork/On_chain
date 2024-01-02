import 'package:on_chain/tron/address/tron_address.dart';
import 'package:on_chain/tron/models/parsed_request/parsed_contract_request.dart';
import 'package:on_chain/tron/provider/core/request.dart';
import 'package:on_chain/tron/provider/methods/request_methods.dart';

/// Deploys a contract. Returns TransactionExtention, which contains an unsigned transaction.
/// [developers.tron.network](https://developers.tron.network/reference/wallet-deploycontract).
class TronRequestDeployContract
    extends TVMRequestParam<ParsedContractRequest, Map<String, dynamic>> {
  TronRequestDeployContract(
      {required this.abi,
      required this.byteCode,
      this.feeLimit,
      this.originEnergyLimit,
      required this.ownerAddress,
      required this.name,
      this.callValue,
      this.consumeUserResourcePercent,
      this.permissionId,
      this.parameter,
      this.visible = true});

  /// Smart Contract's Application Binary Interface
  final List<Map<String, dynamic>> abi;

  /// The compiled contract's identifier, used to interact with the Virtual Machine.
  final String byteCode;

  /// Maximum TRX consumption, measured in SUN (1 TRX = 1,000,000 SUN).
  final int? feeLimit;

  /// The max energy which will be consumed by the owner in the process of execution or creation of the contract,
  /// is an integer which should be greater than 0.
  final int? originEnergyLimit;

  /// Contract owner address
  final TronAddress ownerAddress;

  /// Contract name
  final String name;

  /// Amount of TRX transferred with this transaction, measured in SUN (1TRX = 1,000,000 SUN)
  final int? callValue;

  /// The same as User Pay Ratio. The percentage of resources specified for users who use this contract.
  /// This field accepts integers between [0, 100]. If it is 0, it means the user does not consume
  /// resources until the developer resources are exhausted. However, it is strongly recommended
  /// to set the value between 1 and 99 (inclusive). This is prevent the contract developer
  /// from potential malicious infinite loop time out attacks.
  final int? consumeUserResourcePercent;
  final int? permissionId;

  /// Parameter passed to the constructor of the contract.
  /// Call the virtual machine format of the parameter [1, 2],
  /// use the js tool provided by remix, convert the parameter
  /// array [1, 2] called by the contract caller into the parameter format required by the virtual machine.
  final String? parameter;
  @override
  final bool visible;

  @override
  TronHTTPMethods get method => TronHTTPMethods.deploycontract;

  @override
  Map<String, dynamic> toJson() {
    return {
      "abi": abi,
      "bytecode": byteCode,
      "feeimit": feeLimit,
      "parameter": parameter,
      "origin_energy_limit": originEnergyLimit,
      "owner_address": ownerAddress,
      "name": name,
      "call_value": callValue,
      "consume_user_resource_percent": consumeUserResourcePercent,
      "permission_id": permissionId,
      "visible": visible
    };
  }

  @override
  ParsedContractRequest onResonse(result) {
    return ParsedContractRequest.fromJson(result);
  }

  @override
  String toString() {
    return "TronRequestDeployContract{${toJson()}}";
  }
}
