import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';

/// Return the list of dynamic field objects owned by an object.
/// [sui documation](https://docs.sui.io/sui-api-ref#suix_getdynamicfields)
class SuiRequestGetDynamicFields
    extends SuiRequest<SuiApiGetDynamicFieldsResponse, Map<String, dynamic>> {
  const SuiRequestGetDynamicFields(
      {required this.parentObjectId, super.pagination});

  /// The ID of the queried parent object
  final String parentObjectId;

  @override
  String get method => 'suix_getDynamicFields';

  @override
  List<dynamic> toJson() {
    return [parentObjectId, ...pagination?.toJson() ?? []];
  }

  @override
  SuiApiGetDynamicFieldsResponse onResonse(Map<String, dynamic> result) {
    return SuiApiGetDynamicFieldsResponse.fromJson(result);
  }
}
