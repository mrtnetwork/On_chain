import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';

/// Return the protocol config table for the given version number.
/// If the version number is not specified, If none is specified,
/// the node uses the version of the latest epoch it has processed.
/// [sui documation](https://docs.sui.io/sui-api-ref#sui_getprotocolconfig)
class SuiRequestProtocolConfig
    extends SuiRequest<SuiApiProtocolConfig, Map<String, dynamic>> {
  const SuiRequestProtocolConfig({this.version});

  /// An optional protocol version specifier.
  /// If omitted, the latest protocol config table for the node will be returned.
  final String? version;

  @override
  String get method => 'sui_getProtocolConfig';

  @override
  List<dynamic> toJson() {
    return [version];
  }

  @override
  SuiApiProtocolConfig onResonse(Map<String, dynamic> result) {
    return SuiApiProtocolConfig.fromJson(result);
  }
}
