import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';

/// Represents the details of an Sui JSON-RPC request.
class SuiRequestDetails extends BaseServiceRequestParams {
  const SuiRequestDetails({
    required super.requestID,
    required super.headers,
    required super.type,
    required this.method,
    required this.jsonBody,
  });

  /// The Sui method name for the request.
  final String method;

  /// The JSON-formatted string containing the request parameters.
  final Map<String, dynamic> jsonBody;

  @override
  List<int>? body() {
    return StringUtils.encode(StringUtils.fromJson(jsonBody));
  }

  @override
  Map<String, dynamic> toJson() {
    return {'body': jsonBody, 'method': method, 'type': type.name};
  }

  @override
  Uri toUri(String uri) {
    return Uri.parse(uri);
  }
}

/// An abstract class representing Sui JSON-RPC requests with generic response types.
abstract class SuiRequest<RESULT, SERVICERESPONSE>
    extends BaseServiceRequest<RESULT, SERVICERESPONSE, SuiRequestDetails> {
  const SuiRequest({this.pagination});

  final SuiApiRequestPagination? pagination;

  /// The Sui method associated with the request.
  abstract final String method;

  /// Converts the request parameters to a JSON representation.
  List<dynamic> toJson();

  /// Converts the request parameters to a [SuiRequestDetails] object.
  @override
  SuiRequestDetails buildRequest(int requestID) {
    final List<dynamic> inJson = toJson();
    // inJson.removeWhere((v) => v == null);

    return SuiRequestDetails(
        requestID: requestID,
        jsonBody: ServiceProviderUtils.buildJsonRPCParams(
            requestId: requestID, method: method, params: inJson),
        method: method,
        headers: ServiceConst.defaultPostHeaders,
        type: requestType);
  }

  @override
  RequestServiceType get requestType => RequestServiceType.post;
}
