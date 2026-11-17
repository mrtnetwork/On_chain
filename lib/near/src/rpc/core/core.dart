import 'package:blockchain_utils/blockchain_utils.dart';

class NearRequestDetails extends BaseServiceRequestParams {
  final String method;
  const NearRequestDetails({
    required super.requestID,
    super.path,
    required super.responseEncoding,
    required super.headers,
    required this.method,
    super.successStatusCodes,
    super.errorStatusCodes = const [400],
    required super.requestMethod,
    super.bodyBytes,
    super.bodyString,
  }) : super(network: BlockchainNetwork.near);
  factory NearRequestDetails.deserialize({List<int>? bytes, CborObject? obj}) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: BlockchainNetwork.near.identifier,
      cborBytes: bytes,
      cborObject: obj,
    );
    return NearRequestDetails(
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
  NearRequestDetails copyWith({
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
    return NearRequestDetails(
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
      'body': bodyString,
      'id': requestID,
      'type': requestMethod.name,
    };
  }

  @override
  Uri encodeUrl(String uri) {
    return Uri.parse(uri);
  }

  @override
  SerializationIdentifier get serializationIdentifier =>
      BlockchainNetwork.near.identifier;

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

/// An abstract class representing Near JSON-RPC requests with generic response types.
abstract class NearNodeRequest<RESULT, SERVICERESPONSE>
    extends BaseServiceRequest<RESULT, SERVICERESPONSE, NearRequestDetails> {
  const NearNodeRequest();

  String get method;

  dynamic params();

  @override
  NearRequestDetails buildRequest(int requestID) {
    return NearRequestDetails(
      requestID: requestID,
      responseEncoding: responseEncoding,
      headers: ServiceConst.defaultPostHeaders,
      method: method,
      requestMethod: requestMethod,

      bodyString: StringUtils.fromJson(
        ServiceProviderUtils.buildJsonRPCParams(
          requestId: requestID,
          method: method,
          params: params(),
        ),
      ),
    );
  }

  @override
  RequestMethod get requestMethod => RequestMethod.post;
  @override
  RESULT onResponse(SERVICERESPONSE result);

  ServiceReponseEncoding get responseEncoding => ServiceReponseEncoding.map;
}
