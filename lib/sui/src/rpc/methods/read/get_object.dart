import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';

/// Return the object information for a specified object
/// [sui documation](https://docs.sui.io/sui-api-ref#sui_getobject)
class SuiRequestGetObject
    extends SuiRequest<SuiApiObjectResponse, Map<String, dynamic>> {
  const SuiRequestGetObject({required this.objectId, this.options});

  /// The ID of the queried object
  final String objectId;

  /// Options for specifying the content to be returned
  final SuiApiObjectDataOptions? options;

  @override
  String get method => 'sui_getObject';

  @override
  List<dynamic> toJson() {
    return [objectId, options?.toJson()];
  }

  @override
  SuiApiObjectResponse onResonse(Map<String, dynamic> result) {
    return SuiApiObjectResponse.fromJson(result);
  }
}
