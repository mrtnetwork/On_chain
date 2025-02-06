import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';

class ResultWithContext<T> {
  const ResultWithContext({required this.result, required this.context});
  final T result;
  final Context? context;
}

/// Represents the details of an Solana JSON-RPC request.
class SolanaRequestDetails extends BaseServiceRequestParams {
  const SolanaRequestDetails({
    required super.requestID,
    required super.headers,
    required super.type,
    required this.method,
    required this.jsonBody,
  });

  /// The Solana method name for the request.
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

/// An abstract class representing Solana JSON-RPC requests with generic response types.
abstract class SolanaRequest<RESULT, SERVICERESPONSE>
    extends BaseServiceRequest<RESULT, SERVICERESPONSE, SolanaRequestDetails> {
  const SolanaRequest({this.minContextSlot, this.commitment, this.encoding});

  /// The Solana method associated with the request.
  abstract final String method;

  /// The desired commitment level for the request.
  final Commitment? commitment;

  /// The minimum context slot for the request.
  final MinContextSlot? minContextSlot;

  /// The encoding format of the data.
  final SolanaRequestEncoding? encoding;

  /// Converts the request parameters to a JSON representation.
  List<dynamic> toJson();
  // /// A validation property (not used in this implementation).
  // String? get validate => null;

  // /// Converts a dynamic response to the generic type [T].
  // T onResonse(dynamic result) {
  //   return result as T;
  // }

  /// Converts the request parameters to a [SolanaRequestDetails] object.
  @override
  SolanaRequestDetails buildRequest(int requestID) {
    final List<dynamic> inJson = toJson();
    inJson.removeWhere((v) => v == null);

    return SolanaRequestDetails(
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
