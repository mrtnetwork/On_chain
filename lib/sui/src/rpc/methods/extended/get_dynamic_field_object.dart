import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';

/// Return the dynamic field object information for a specified object
/// [sui documation](https://docs.sui.io/sui-api-ref#suix_getdynamicfieldobject)
class SuiRequestGetDynamicFieldObject extends SuiRequest<
    SuiApiGetDynamicFieldObjectResponse, Map<String, dynamic>> {
  /// The owner's Sui address
  const SuiRequestGetDynamicFieldObject(
      {required this.parentObjectId, required this.name});

  /// The ID of the queried parent object
  final String parentObjectId;

  /// The Name of the dynamic field
  final SuiApiDynamicFieldName name;

  @override
  String get method => 'suix_getDynamicFieldObject';

  @override
  List<dynamic> toJson() {
    return [parentObjectId, name.toJson()];
  }

  @override
  SuiApiGetDynamicFieldObjectResponse onResonse(Map<String, dynamic> result) {
    return SuiApiGetDynamicFieldObjectResponse.fromJson(result);
  }
}
