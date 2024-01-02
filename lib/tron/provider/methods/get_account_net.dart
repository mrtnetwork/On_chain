import 'package:on_chain/tron/address/tron_address.dart';
import 'package:on_chain/tron/provider/core/request.dart';
import 'package:on_chain/tron/provider/methods/request_methods.dart';

/// Query bandwidth information.
/// [developers.tron.network](https://developers.tron.network/reference/getaccountnet).
class TronRequestGetAccountNet
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetAccountNet({required this.address, this.visible = true});

  /// Account address
  final TronAddress address;
  @override
  final bool visible;

  @override
  TronHTTPMethods get method => TronHTTPMethods.getaccountnet;

  @override
  Map<String, dynamic> toJson() {
    return {"address": address, "visible": visible};
  }
}
