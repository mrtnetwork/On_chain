import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// GetNextMaintenanceTime
/// Returns the timestamp of the next voting time in milliseconds.
/// [developers.tron.network](https://developers.tron.network/reference/getnextmaintenancetime).
class TronRequestGetNextMaintenanceTime
    extends TVMRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  TronRequestGetNextMaintenanceTime();

  /// wallet/getnextmaintenancetime
  @override
  TronHTTPMethods get method => TronHTTPMethods.getnextmaintenancetime;

  @override
  Map<String, dynamic> toJson() {
    return {};
  }

  @override
  String toString() {
    return "TronRequestGetNextMaintenanceTime{${toJson()}}";
  }
}
