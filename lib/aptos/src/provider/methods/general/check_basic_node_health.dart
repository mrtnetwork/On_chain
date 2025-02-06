import 'package:on_chain/aptos/src/provider/methods/methods/methods.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';

/// By default this endpoint just checks that it can get the latest ledger info and then returns 200.
/// If the duration_secs param is provided, this endpoint will return a 200 if the following condition is true:`
/// server_latest_ledger_info_timestamp >= server_current_time_timestamp - duration_secs`
/// [aptos documation](https://aptos.dev/en/build/apis/fullnode-rest-api-reference)
class AptosRequestCheckBasicNodeHealth
    extends AptosRequest<String, Map<String, dynamic>> {
  AptosRequestCheckBasicNodeHealth({this.durationSecs});

  /// Threshold in seconds that the server can be behind to be considered healthy If not provided,
  /// the healthcheck will always succeed
  final int? durationSecs;

  @override
  String get method => AptosApiMethod.checkBasicNodeHealth.url;

  @override
  Map<String, String?> get queryParameters =>
      {"duration_secs": durationSecs?.toString()};

  @override
  String onResonse(Map<String, dynamic> result) {
    return result["message"];
  }
}
