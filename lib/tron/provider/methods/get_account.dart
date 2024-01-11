import 'package:on_chain/tron/address/tron_address.dart';
import 'package:on_chain/tron/provider/core/request.dart';
import 'package:on_chain/tron/provider/methods/request_methods.dart';
import 'package:on_chain/tron/provider/models/account_info.dart';

/// Query information about an account, including TRX balance, TRC-10 balances, stake information and vote information and permissions etc.
/// [developers.tron.network](https://developers.tron.network/reference/account-getaccount).
class TronRequestGetAccount
    extends TVMRequestParam<TronAccountModel?, Map<String, dynamic>> {
  TronRequestGetAccount({required this.address, this.visible = true});

  /// address
  final TronAddress address;
  @override
  final bool visible;

  @override
  TronHTTPMethods get method => TronHTTPMethods.getaccount;

  @override
  Map<String, dynamic> toJson() {
    return {"address": address, "visible": visible};
  }

  @override
  TronAccountModel? onResonse(result) {
    if (result.isEmpty) {
      return null;
    }
    return TronAccountModel.fromJson(result);
  }

  @override
  String toString() {
    return "TronRequestGetAccount{${toJson()}}";
  }
}
