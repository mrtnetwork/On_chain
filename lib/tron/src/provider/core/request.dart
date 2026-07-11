import 'package:blockchain_utils/blockchain_utils.dart';
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
      bodyString: _toBody(inJson),
      headers: ServiceConst.defaultPostHeaders,
      requestMethod: requestMethod,
      responseEncoding: ServiceReponseEncoding.fromType<RESPONSE>(),
      method: method.uri.split("/").lastOrNull ?? '',
    );
  }

  static String _toBody(
    Map<String, dynamic> json, {
    bool bigIntAsString = false,
  }) {
    final Map<String, BigInt> replace = {};
    int id = 0;
    String bodyString = StringUtils.fromJson(
      json,
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
  RequestMethod get requestMethod => method.requestType;
}

class TronRequestDetails extends BaseServiceRequestParams {
  final String method;
  const TronRequestDetails({
    required super.requestID,
    super.path,
    required super.responseEncoding,
    required super.headers,
    required this.method,
    super.successStatusCodes,
    super.errorStatusCodes,
    required super.requestMethod,
    super.bodyBytes,
    super.bodyString,
  }) : super(network: BlockchainNetwork.tron);
  factory TronRequestDetails.deserialize({List<int>? bytes, CborObject? obj}) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: BlockchainNetwork.tron.identifier,
      cborBytes: bytes,
      cborObject: obj,
    );
    return TronRequestDetails(
      headers: values
          .mapAt<CborStringValue, CborStringValue>(0)
          .map((k, v) => MapEntry(k.value, v.value)),
      requestMethod: RequestMethod.fromValue(values.rawValueAt(1)),
      responseEncoding: ServiceReponseEncoding.fromValue(values.rawValueAt(2)),
      successStatusCodes:
          values
              .listAt<CborIntValue>(3)
              .map((e) => e.value)
              .toList()
              .emptyAsNull,
      errorStatusCodes:
          values
              .listAt<CborIntValue>(4)
              .map((e) => e.value)
              .toList()
              .emptyAsNull,
      bodyBytes: values.rawValueAt(5),
      bodyString: values.rawValueAt(6),
      path: values.rawValueAt(7),
      requestID: values.rawValueAt(8),
      method: values.rawValueAt(9),
    );
  }
  TronRequestDetails copyWith({
    int? requestID,
    String? path,
    RequestMethod? requestMethod,
    Map<String, String>? headers,
    List<int>? bodyBytes,
    String? bodyString,
    ServiceReponseEncoding? responseEncoding,
    List<int>? errorStatusCodes,
    List<int>? successStatusCodes,
    String? method,
  }) {
    return TronRequestDetails(
      requestID: requestID ?? this.requestID,
      headers: headers ?? this.headers,
      path: path ?? this.path,
      responseEncoding: responseEncoding ?? this.responseEncoding,
      requestMethod: requestMethod ?? this.requestMethod,
      bodyString: bodyString ?? this.bodyString,
      errorStatusCodes: errorStatusCodes ?? this.errorStatusCodes,
      bodyBytes: bodyBytes ?? this.bodyBytes,
      successStatusCodes: successStatusCodes ?? this.successStatusCodes,
      method: method ?? this.method,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'method': method,
      'body': bodyString ?? BytesUtils.tryToHexString(bodyBytes),
      'id': requestID,
      'type': requestMethod.name,
    };
  }

  @override
  Uri encodeUrl(String uri) {
    if (uri.endsWith('/')) return Uri.parse('$uri${path ?? ''}');
    return Uri.parse('$uri/${path ?? ''}');
  }

  @override
  SerializationIdentifier get serializationIdentifier =>
      BlockchainNetwork.tron.identifier;

  @override
  List<CborObject?> get serializationItems => [
    CborMapValue.definite(
      headers.map((k, v) => MapEntry(CborStringValue(k), CborStringValue(v))),
    ),
    requestMethod.value.toCbor(),
    responseEncoding.value.toCbor(),
    CborTagSerializable.listFromDynamic(
      successStatusCodes?.map((e) => CborIntValue(e)).toList() ?? [],
    ),
    CborTagSerializable.listFromDynamic(
      errorStatusCodes?.map((e) => CborIntValue(e)).toList() ?? [],
    ),
    bodyBytes?.toCborBytes(),
    bodyString?.toCbor(),
    path?.toCbor(),
    requestID.toCbor(),
    method.toCbor(),
  ];
}
