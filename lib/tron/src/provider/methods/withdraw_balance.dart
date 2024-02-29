import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// Super Representative or user withdraw rewards, usable every 24 hours.
/// Super representatives can withdraw the balance from the account allowance into the account balance,
/// Users can claim the voting reward from the SRs and deposit into his account balance.
/// [developers.tron.network](https://developers.tron.network/reference/withdrawbalance).
class TronRequestWithdrawBalance
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestWithdrawBalance({required this.ownerAddress, this.visible = true});

  /// Super representative or user address
  final TronAddress ownerAddress;
  @override
  final bool visible;

  /// wallet/withdrawbalance
  @override
  TronHTTPMethods get method => TronHTTPMethods.withdrawbalance;

  @override
  Map<String, dynamic> toJson() {
    return {"owner_address": ownerAddress, "visible": visible};
  }

  @override
  String toString() {
    return "TronRequestWithdrawBalance{${toJson()}}";
  }
}
