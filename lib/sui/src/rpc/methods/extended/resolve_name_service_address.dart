import 'package:on_chain/sui/src/rpc/core/core.dart';

/// Return the resolved address given resolver and name
/// [sui documation](https://docs.sui.io/sui-api-ref#suix_resolvenameserviceaddress)
class SuiRequestResolveNameServiceAddress extends SuiRequest<String, String> {
  const SuiRequestResolveNameServiceAddress(this.name);

  /// The name to resolve
  final String name;
  @override
  String get method => 'suix_resolveNameServiceAddress';

  @override
  List<dynamic> toJson() {
    return [name];
  }
}
