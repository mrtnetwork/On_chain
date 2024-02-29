import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Update the consume_user_resource_percent parameter of a smart contract
/// [developers.tron.network](https://developers.tron.network/reference/wallet-updatesetting).
class TronRequestUpdateSetting
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestUpdateSetting(
      {required this.ownerAddress,
      required this.contractAddress,
      required this.consumeUserResourcePercent,
      this.permissionId,
      this.visible = true});

  /// Transaction creator address
  final TronAddress ownerAddress;

  /// The address of the contract to be modified
  final TronAddress contractAddress;

  /// Consume user's resource percentage. It should be an integer between [0, 100]. if 0, means it does not consume user's resource until the developer's resource has been used up
  final int consumeUserResourcePercent;

  /// for multi-signature use
  final int? permissionId;
  @override
  final bool visible;

  /// wallet/updatesetting
  @override
  TronHTTPMethods get method => TronHTTPMethods.updatesetting;

  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress,
      "contract_address": contractAddress,
      "consume_user_resource_percent": consumeUserResourcePercent,
      "Permission_id": permissionId,
      "visible": visible
    };
  }

  @override
  String toString() {
    return "TronRequestUpdateSetting{${toJson()}}";
  }
}
