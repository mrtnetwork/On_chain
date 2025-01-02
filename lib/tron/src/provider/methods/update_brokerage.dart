import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Update the witness's brokerage setting.
/// [developers.tron.network](https://developers.tron.network/reference/wallet-updatebrokerage).
class TronRequestUpdateBrokerage
    extends TronRequest<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestUpdateBrokerage(
      {required this.ownerAddress,
      required this.brokerage,
      this.visible = true});

  /// Super representative's account address
  final TronAddress ownerAddress;

  /// The brokerage ratio of the super representative, for example: 20 means 20%, 100 means 100%
  final int brokerage;

  @override
  final bool visible;

  /// wallet/updateBrokerage
  @override
  TronHTTPMethods get method => TronHTTPMethods.updateBrokerage;

  @override
  Map<String, dynamic> toJson() {
    return {
      'owner_address': ownerAddress.toAddress(visible),
      'brokerage': brokerage,
      'visible': visible
    };
  }

  @override
  String toString() {
    return 'TronRequestUpdateBrokerage{${toJson()}}';
  }
}
