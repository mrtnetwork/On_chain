import 'package:on_chain/sui/src/address/address/address.dart';
import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';

/// Return the resolved names given address, if multiple names are resolved, the first one is the primary name.
/// [sui documation](https://docs.sui.io/sui-api-ref#suix_resolvenameservicenames)
class SuiRequestResolveNameServiceNames extends SuiRequest<
    SuiApiResolveNameServiceNamesResponse, Map<String, dynamic>> {
  const SuiRequestResolveNameServiceNames(
      {required this.address, super.pagination});

  /// The address to resolve
  final SuiAddress address;
  @override
  String get method => 'suix_resolveNameServiceNames';

  @override
  List<dynamic> toJson() {
    return [address.address, ...pagination?.toJson() ?? []];
  }

  @override
  SuiApiResolveNameServiceNamesResponse onResonse(Map<String, dynamic> result) {
    return SuiApiResolveNameServiceNamesResponse.fromJson(result);
  }
}
