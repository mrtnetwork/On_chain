import 'package:on_chain/sui/src/rpc/core/core.dart';

/// Return the first four bytes of the chain's genesis checkpoint digest.
/// [sui documation](https://docs.sui.io/sui-api-ref#sui_getchainidentifier)
class SuiRequestGetChainIdentifier extends SuiRequest<String, String> {
  const SuiRequestGetChainIdentifier();

  @override
  String get method => 'sui_getChainIdentifier';

  @override
  List<dynamic> toJson() {
    return [];
  }
}
