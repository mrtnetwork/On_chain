import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';

/// Update the origin_energy_limit parameter of a smart contract
class UpdateEnergyLimitContract extends TronBaseContract {
  /// Create a new [UpdateEnergyLimitContract] instance by parsing a JSON map.
  factory UpdateEnergyLimitContract.fromJson(Map<String, dynamic> json) {
    return UpdateEnergyLimitContract(
      ownerAddress: TronAddress(json["owner_address"]),
      contractAddress: TronAddress(json["contract_address"]),
      originEnergyLimit: BigintUtils.tryParse(json["origin_energy_limit"]),
    );
  }

  /// Create a new [UpdateEnergyLimitContract] instance with specified parameters.
  UpdateEnergyLimitContract(
      {required this.ownerAddress,
      required this.contractAddress,
      this.originEnergyLimit});

  factory UpdateEnergyLimitContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return UpdateEnergyLimitContract(
        ownerAddress: TronAddress.fromBytes(decode.getField(1)),
        contractAddress: TronAddress.fromBytes(decode.getField(2)),
        originEnergyLimit: decode.getField(3));
  }

  /// Account address
  final TronAddress ownerAddress;

  /// Contract address
  final TronAddress contractAddress;

  /// Adjusted upper limit of energy provided by smart contract deployers in one transaction
  final BigInt? originEnergyLimit;

  @override
  List<int> get fieldIds => [1, 2, 3];

  @override
  List get values => [ownerAddress, contractAddress, originEnergyLimit];

  /// Convert the [UpdateEnergyLimitContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress.toString(),
      "contract_address": contractAddress.toString(),
      "origin_energy_limit": originEnergyLimit?.toString(),
    }..removeWhere((key, value) => value == null);
  }

  /// Convert the [UpdateEnergyLimitContract] object to its string representation.
  @override
  String toString() {
    return "UpdateEnergyLimitContract{${toJson()}}";
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.updateEnergyLimitContract;
}
