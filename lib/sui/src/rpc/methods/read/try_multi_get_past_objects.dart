import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';

/// Note there is no software-level guarantee/SLA that objects with past
/// versions can be retrieved by this API, even if the object and version exists/existed.
/// The result may vary across nodes depending on their pruning policies.
/// Return the object information for a specified version
/// [sui documation](https://docs.sui.io/sui-api-ref#sui_trymultigetpastobjects)
class SuiRequestTryMultiGetPastObjects
    extends SuiRequest<List<SuiApiObjectRead>, List<Map<String, dynamic>>> {
  const SuiRequestTryMultiGetPastObjects(
      {required this.pastObjects, this.options});

  /// A vector of object and versions to be queried
  final List<SuiApiGetPastObjectRequest> pastObjects;

  /// Options for specifying the content to be returned
  final SuiApiObjectDataOptions? options;

  @override
  String get method => 'sui_tryMultiGetPastObjects';

  @override
  List<dynamic> toJson() {
    return [pastObjects.map((e) => e.toJson()).toList(), options?.toJson()];
  }

  @override
  List<SuiApiObjectRead> onResonse(List<Map<String, dynamic>> result) {
    return result.map((e) => SuiApiObjectRead.fromJson(e)).toList();
  }
}
