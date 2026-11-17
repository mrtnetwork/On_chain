// icp_http_status.dart
// Path: GET /api/v2/status
// Response type name: ICPHttpStatusResponse

import 'package:blockchain_utils/encoding/encoding.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'icp_http_base.dart';

// assume you have JsonParser + extension methods

class ICPHttpStatusResponse extends ICPHttpResponse {
  final List<int>? rootKey; // blob
  final String? replicaHealthStatus; // optional implementation field

  const ICPHttpStatusResponse({this.rootKey, this.replicaHealthStatus});

  factory ICPHttpStatusResponse.deserialize(List<int> bytes) {
    final content = CborObject.deserialize(bytes);
    final json = JsonParser.valueEnsureAsMap<String, dynamic>(
      content.getValue(),
    );
    return ICPHttpStatusResponse.fromJson(json);
  }

  factory ICPHttpStatusResponse.fromJson(Map<String, dynamic> json) {
    return ICPHttpStatusResponse(
      rootKey: json.valueAsBytes('root_key'),
      replicaHealthStatus: json.valueAsString('replica_health_status'),
    );
  }

  @override
  CborTagValue toCbor() {
    final map = <CborObject, CborObject>{};
    if (rootKey != null) {
      map[CborStringValue('root_key')] = CborBytesValue(rootKey!);
    }
    if (replicaHealthStatus != null) {
      map[CborStringValue('replica_health_status')] = CborStringValue(
        replicaHealthStatus!,
      );
    }
    return CborTagValue(CborMapValue.definite(map), [55799]);
  }
}
