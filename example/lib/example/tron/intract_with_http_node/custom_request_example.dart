import 'package:example/example/tron/provider_service/provider_service.dart';
import 'package:on_chain/on_chain.dart';

// ignore: camel_case_types
class TronRequestGetAccountBalance_
    extends TronRequest<String, Map<String, dynamic>> {
  TronRequestGetAccountBalance_({required this.address, this.visible = true});

  /// address
  final TronAddress address;
  @override
  final bool visible;

  @override
  TronHTTPMethods get method => TronHTTPMethods.getaccount;

  @override
  Map<String, dynamic> toJson() {
    return {"address": address.toAddress(visible), "visible": visible};
  }

  @override
  String onResonse(result) {
    if (result.isEmpty) return "0.0";
    if (!result.containsKey("balance")) return "0.0";

    return TronHelper.fromSun(BigInt.from(result["balance"]));
  }
}

void main() async {
  /// create your http provider u can see example in /// ../htt_service/tron_http_service.dart

  /// intialize user provider with correct http url
  final rpc = TronProvider(TronHTTPProvider(url: "https://api.trongrid.io"));

  /// create custom class for request
  /// for example we want to get only trx balance of account [TronRequestGetAccountBalance]

  /// get account balance
  // ignore: unused_local_variable
  final balance = await rpc.request(TronRequestGetAccountBalance_(
      address: TronAddress("TMcbQBuj5ATtm9feRiMp6QRd587hT7HHyU")));
}
