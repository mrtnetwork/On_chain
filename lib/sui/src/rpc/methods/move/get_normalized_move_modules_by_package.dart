import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';

/// Return structured representations of all modules in the given package
/// [sui documation](https://docs.sui.io/sui-api-ref#sui_getnormalizedmovemodulesbypackage)
class SuiRequestGetNormalizedMoveModulesByPackage extends SuiRequest<
    Map<String, SuiApiMoveNormalizedModule>, Map<String, dynamic>> {
  const SuiRequestGetNormalizedMoveModulesByPackage({required this.package});

  final String package;
  @override
  String get method => 'sui_getNormalizedMoveModulesByPackage';

  @override
  List<dynamic> toJson() {
    return [package];
  }

  @override
  Map<String, SuiApiMoveNormalizedModule> onResonse(
      Map<String, dynamic> result) {
    return result
        .map((k, v) => MapEntry(k, SuiApiMoveNormalizedModule.fromJson(v)));
  }
}
