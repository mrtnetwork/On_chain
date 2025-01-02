import 'package:on_chain/ethereum/src/models/block_tag.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

/// Represents the details of an Ethereum JSON-RPC request.
class EthereumRequestDetails extends BaseServiceRequestParams {
  const EthereumRequestDetails({
    required super.requestID,
    required super.type,
    required super.headers,
    required this.method,
    required this.jsonBody,
  });

  /// The Ethereum method name for the request.
  final String method;

  /// The JSON-formatted string containing the request parameters.
  final Map<String, dynamic> jsonBody;

  @override
  List<int>? body() {
    return StringUtils.encode(StringUtils.fromJson(jsonBody));
  }

  @override
  Map<String, dynamic> toJson() {
    return {'method': method, 'body': jsonBody, 'id': requestID, 'type': type};
  }

  @override
  Uri toUri(String uri) {
    return Uri.parse(uri);
  }
}

/// An abstract class representing Ethereum JSON-RPC requests with generic response types.
abstract class EthereumRequest<RESULT, SERVICERESPONSE>
    extends BaseServiceRequest<RESULT, SERVICERESPONSE,
        EthereumRequestDetails> {
  const EthereumRequest({this.blockNumber});

  // The Ethereum method associated with the request.
  abstract final String method;

  /// Converts the request parameters to a JSON representation.
  List<dynamic> toJson();

  final BlockTagOrNumber? blockNumber;

  /// Converts a dynamic response to a BigInt, handling hexadecimal conversion.
  static BigInt onBigintResponse(dynamic result) {
    if (result == '0x') return BigInt.zero;
    return BigInt.parse(StringUtils.strip0x(result), radix: 16);
  }

  /// Converts a dynamic response to an integer, handling hexadecimal conversion.
  static int onIntResponse(dynamic result) {
    if (result == '0x') return 0;
    return int.parse(StringUtils.strip0x(result), radix: 16);
  }

  /// Converts the request parameters to a [EthereumRequestDetails] object.
  @override
  EthereumRequestDetails buildRequest(int requestId) {
    var inJson = toJson();
    inJson.removeWhere((v) => v == null);
    inJson = inJson.map((e) {
      if (e is BlockTagOrNumber) return e.toJson();
      return e;
    }).toList();
    return EthereumRequestDetails(
        requestID: requestId,
        jsonBody: ServiceProviderUtils.buildJsonRPCParams(
            requestId: requestId, method: method, params: inJson),
        method: method,
        headers: ServiceConst.defaultPostHeaders,
        type: requestType);
  }

  @override
  RequestServiceType get requestType => RequestServiceType.post;
}
