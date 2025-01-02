import 'package:blockchain_utils/service/service.dart';
import 'package:blockchain_utils/utils/string/string.dart';
import 'package:on_chain/tron/src/provider/methods/request_methods.dart';

/// An abstract class representing request parameters for TVM (Tron Virtual Machine) API calls.
abstract class TronRequest<RESULT, RESPONSE>
    extends BaseServiceRequest<RESULT, RESPONSE, TronRequestDetails> {
  /// Indicates whether the address is visible.
  bool? get visible => null;

  /// method for the request.
  abstract final TronHTTPMethods method;

  /// Converts the request parameters to a JSON format.
  Map<String, dynamic> toJson();

  /// Converts the request parameters to [TronRequestDetails] with a unique identifier.
  @override
  TronRequestDetails buildRequest(int requestID) {
    final inJson = toJson();
    inJson.removeWhere((key, value) => value == null);
    return TronRequestDetails(
        requestID: requestID,
        path: method.uri,
        jsonBody: inJson,
        headers: ServiceConst.defaultPostHeaders,
        type: requestType);
  }

  @override
  RequestServiceType get requestType => method.requestType;
}

/// Represents the details of a Tron network request.
class TronRequestDetails extends BaseServiceRequestParams {
  /// Constructs a new [TronRequestDetails] instance with the specified parameters.
  const TronRequestDetails({
    required super.requestID,
    required super.headers,
    required super.type,
    required this.path,
    required this.jsonBody,
  });

  /// method for the request.
  final String path;

  /// Request parameters encoded as a JSON-formatted string.
  final Map<String, dynamic> jsonBody;
  String toBody({bool bigIntAsString = false}) {
    final Map<String, BigInt> replace = {};
    int id = 0;
    String bodyString = StringUtils.fromJson(
      jsonBody,
      toEncodable: (object) {
        if (object is! BigInt) return object.toString();
        if (object.isValidInt) {
          return object.toInt();
        }
        if (bigIntAsString) return object.toString();
        final n = '${id++}#${object.toString()}';
        replace[n] = object;

        return n;
      },
    );
    for (final i in replace.entries) {
      bodyString = bodyString.replaceFirst('"${i.key}"', '${i.value}');
    }
    return bodyString;
  }

  @override
  List<int>? body() {
    return StringUtils.encode(toBody());
  }

  @override
  Uri toUri(String uri) {
    if (uri.endsWith('/')) return Uri.parse('$uri$path');
    return Uri.parse('$uri/$path');
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': requestID,
      'pathParameters': path,
      'body': StringUtils.tryToJson(toBody(bigIntAsString: true)),
      'type': type.name
    };
  }
}
