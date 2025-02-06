import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';

/// Return the validator APY
/// [sui documation](https://docs.sui.io/sui-api-ref#suix_getvalidatorsapy)
class SuiRequestGetValidatorsApy
    extends SuiRequest<SuiApiValidatorsApy, Map<String, dynamic>> {
  const SuiRequestGetValidatorsApy();

  @override
  String get method => 'suix_getValidatorsApy';

  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  SuiApiValidatorsApy onResonse(Map<String, dynamic> result) {
    return SuiApiValidatorsApy.fromJson(result);
  }
}
