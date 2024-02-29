import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Edit the URL of the witness's official website.
/// [developers.tron.network](https://developers.tron.network/reference/updatewitness).
class TronRequestUpdateWitness
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestUpdateWitness(
      {required this.ownerAddress,
      this.updateUrl,
      this.permissionId,
      this.visible = true});

  /// Owner address
  final TronAddress ownerAddress;

  /// Website url
  final String? updateUrl;

  /// for multi-signature use
  final int? permissionId;
  @override
  final bool visible;

  /// wallet/updatewitness
  @override
  TronHTTPMethods get method => TronHTTPMethods.updatewitness;

  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress,
      "update_url": updateUrl,
      "Permission_id": permissionId,
      "visible": visible
    };
  }

  @override
  String toString() {
    return "TronRequestUpdateWitness{${toJson()}}";
  }
}
