import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';

/// Return the object data for a list of objects
/// [sui documation](https://docs.sui.io/sui-api-ref#sui_multigetobjects)
class SuiRequestMultiGetObjects extends SuiRequest<
    List<SuiApiGetDynamicFieldObjectResponse>, List<Map<String, dynamic>>> {
  const SuiRequestMultiGetObjects({required this.objectIds, this.options});

  /// The IDs of the queried objects
  final List<String> objectIds;

  /// Options for specifying the content to be returned
  final SuiApiObjectDataOptions? options;

  @override
  String get method => 'sui_multiGetObjects';

  @override
  List<dynamic> toJson() {
    return [objectIds, options?.toJson()];
  }

  @override
  List<SuiApiGetDynamicFieldObjectResponse> onResonse(
      List<Map<String, dynamic>> result) {
    return result
        .map((e) => SuiApiGetDynamicFieldObjectResponse.fromJson(e))
        .toList();
  }
}
