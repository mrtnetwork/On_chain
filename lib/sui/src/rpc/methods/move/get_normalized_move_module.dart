import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';

/// Return a structured representation of Move module
/// [sui documation](https://docs.sui.io/sui-api-ref#sui_getnormalizedmovemodule)
class SuiRequestGetNormalizedMoveModule
    extends SuiRequest<SuiApiMoveNormalizedModule, Map<String, dynamic>> {
  const SuiRequestGetNormalizedMoveModule(
      {required this.package, required this.moduleName});

  final String package;
  final String moduleName;
  @override
  String get method => 'sui_getNormalizedMoveModule';

  @override
  List<dynamic> toJson() {
    return [package, moduleName];
  }

  @override
  SuiApiMoveNormalizedModule onResonse(Map<String, dynamic> result) {
    return SuiApiMoveNormalizedModule.fromJson(result);
  }
}
