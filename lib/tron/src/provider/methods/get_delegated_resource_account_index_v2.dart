import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// In Stake2.0, query the resource delegation index by an account.
/// Two lists will return, one is the list of addresses the account has delegated its resources(toAddress),
/// and the other is the list of addresses that have delegated resources to the account(fromAddress).
/// [developers.tron.network](https://developers.tron.network/reference/getdelegatedresourceaccountindexv2-1).
class TronRequestGetDelegatedResourceAccountIndexV2
    extends TronRequest<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetDelegatedResourceAccountIndexV2(
      {required this.value, this.visible = true});

  /// account address
  final TronAddress value;
  @override
  final bool visible;

  /// wallet/getdelegatedresourceaccountindexv2
  @override
  TronHTTPMethods get method =>
      TronHTTPMethods.getdelegatedresourceaccountindexv2;
  @override
  Map<String, dynamic> toJson() {
    return {'value': value.toAddress(visible), 'visible': visible};
  }

  @override
  String toString() {
    return 'TronRequestGetDelegatedResourceAccountIndexV2{${toJson()}}';
  }
}
