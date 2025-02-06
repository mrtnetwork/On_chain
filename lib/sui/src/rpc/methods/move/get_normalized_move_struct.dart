import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';

/// Return a structured representation of Move struct
/// [sui documation](https://docs.sui.io/sui-api-ref#sui_getnormalizedmovestruct)
class SuiRequestGetNormalizedMoveStruct
    extends SuiRequest<SuiApiMoveNormalizedStruct, Map<String, dynamic>> {
  const SuiRequestGetNormalizedMoveStruct(
      {required this.package,
      required this.moduleName,
      required this.structName});

  final String package;
  final String moduleName;
  final String structName;
  @override
  String get method => 'sui_getNormalizedMoveStruct';

  @override
  List<dynamic> toJson() {
    return [package, moduleName, structName];
  }

  @override
  SuiApiMoveNormalizedStruct onResonse(Map<String, dynamic> result) {
    return SuiApiMoveNormalizedStruct.fromJson(result);
  }
}
