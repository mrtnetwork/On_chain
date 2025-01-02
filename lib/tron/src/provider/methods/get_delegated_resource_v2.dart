import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// In Stake2.0, query the detail of resource share delegated from fromAddress to toAddress
/// [developers.tron.network](https://developers.tron.network/reference/getdelegatedresourcev2).
class TronRequestGetDelegatedResourceV2
    extends TronRequest<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetDelegatedResourceV2(
      {required this.fromAddress,
      required this.toAddress,
      this.visible = true});

  /// resource from address
  final TronAddress fromAddress;

  /// resource to address
  final TronAddress toAddress;
  @override
  final bool visible;

  /// wallet/getdelegatedresourcev2
  @override
  TronHTTPMethods get method => TronHTTPMethods.getdelegatedresourcev2;

  @override
  Map<String, dynamic> toJson() {
    return {
      'fromAddress': fromAddress.toAddress(visible),
      'toAddress': toAddress.toAddress(visible),
      'visible': visible
    };
  }

  @override
  String toString() {
    return 'TronRequestGetDelegatedResourceV2{${toJson()}}';
  }
}
