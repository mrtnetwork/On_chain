import 'package:on_chain/tron/address/tron_address.dart';
import 'package:on_chain/tron/provider/core/request.dart';
import 'package:on_chain/tron/provider/methods/request_methods.dart';

/// Update the origin_energy_limit parameter of a smart contract
/// [developers.tron.network](https://developers.tron.network/reference/wallet-updateenergylimit).
class TronRequestUpdateEnergyLimit
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestUpdateEnergyLimit(
      {required this.ownerAddress,
      required this.contractAddress,
      required this.originEnergyLimit,
      this.permissionId,
      this.visible = true});

  /// Transaction creator address
  final TronAddress ownerAddress;

  /// The address of the contract to be modified
  final TronAddress contractAddress;

  /// The maximum energy the creator sets. The greatest amount of energy the creator consumes during contract execution or creation process.
  final int originEnergyLimit;

  /// for multi-signature use
  final int? permissionId;
  @override
  final bool visible;

  /// wallet/updateenergylimit
  @override
  TronHTTPMethods get method => TronHTTPMethods.updateenergylimit;

  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress,
      "contract_address": contractAddress,
      "origin_energy_limit": originEnergyLimit,
      "Permission_id": permissionId,
      "visible": visible
    };
  }

  @override
  String toString() {
    return "TronRequestUpdateEnergyLimit{${toJson()}}";
  }
}
