import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';

/// Return the argument types of a Move function, based on normalized Type.
/// [sui documation](https://docs.sui.io/sui-api-ref#sui_getmovefunctionargtypes)
class SuiRequestGetMoveFunctionArgTypes
    extends SuiRequest<List<SuiApiMoveFunctionArgType>, List<dynamic>> {
  const SuiRequestGetMoveFunctionArgTypes(
      {required this.package, required this.module, required this.function});

  final String package;
  final String module;
  final String function;
  @override
  String get method => 'sui_getMoveFunctionArgTypes';

  @override
  List<dynamic> toJson() {
    return [package, module, function];
  }

  @override
  List<SuiApiMoveFunctionArgType> onResonse(List<dynamic> result) {
    return result.map((e) => SuiApiMoveFunctionArgType.fromJson(e)).toList();
  }
}
