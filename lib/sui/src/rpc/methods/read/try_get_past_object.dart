import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';

/// Note there is no software-level guarantee/SLA that objects with past
/// versions can be retrieved by this API, even if the object and version exists/existed.
/// The result may vary across nodes depending on their pruning policies.
/// Return the object information for a specified version
/// [sui documation](https://docs.sui.io/sui-api-ref#sui_trygetpastobject)
class SuiRequestTryGetPastObject
    extends SuiRequest<SuiApiObjectRead, Map<String, dynamic>> {
  const SuiRequestTryGetPastObject(
      {required this.objectId, required this.version, this.options});

  /// The ID of the queried object
  final String objectId;

  /// The version of the queried object. If None, default to the latest known version
  final String version;

  /// Options for specifying the content to be returned
  final SuiApiObjectDataOptions? options;

  @override
  String get method => 'sui_tryGetPastObject';

  @override
  List<dynamic> toJson() {
    return [objectId, version, options?.toJson()];
  }

  @override
  SuiApiObjectRead onResonse(Map<String, dynamic> result) {
    return SuiApiObjectRead.fromJson(result);
  }
}
