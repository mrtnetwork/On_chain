import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';

/// Return a structured representation of Move function
/// [sui documation](https://docs.sui.io/sui-api-ref#sui_getnormalizedmovefunction)
class SuiRequestGetNormalizedMoveFunction
    extends SuiRequest<SuiApiMoveNormalizedFunction, Map<String, dynamic>> {
  const SuiRequestGetNormalizedMoveFunction(
      {required this.package,
      required this.moduleName,
      required this.functionName});

  final String package;
  final String moduleName;
  final String functionName;
  @override
  String get method => 'sui_getNormalizedMoveFunction';

  @override
  List<dynamic> toJson() {
    return [package, moduleName, functionName];
  }

  @override
  SuiApiMoveNormalizedFunction onResonse(Map<String, dynamic> result) {
    return SuiApiMoveNormalizedFunction.fromJson(result);
  }
}
