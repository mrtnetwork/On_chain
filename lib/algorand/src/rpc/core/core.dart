import 'package:blockchain_utils/blockchain_utils.dart';

class AlgoRequestDetails extends BaseServiceRequestParams {
  final ServiceReponseEncoding finalResponseEncoding;
  final AlgoApi api;
  const AlgoRequestDetails({
    required super.requestID,
    super.path,
    required super.responseEncoding,
    required super.headers,
    required this.finalResponseEncoding,
    super.successStatusCodes,
    super.errorStatusCodes,
    required super.requestMethod,
    super.bodyBytes,
    super.bodyString,
    required this.api,
  }) : super(network: BlockchainNetwork.algorand);
  factory AlgoRequestDetails.deserialize({List<int>? bytes, CborObject? obj}) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: BlockchainNetwork.algorand.identifier,
      cborBytes: bytes,
      cborObject: obj,
    );
    return AlgoRequestDetails(
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
      finalResponseEncoding: ServiceReponseEncoding.fromValue(
        values.rawValueAt(9),
      ),
      api: AlgoApi.fromValue(values.rawValueAt(10)),
    );
  }
  AlgoRequestDetails copyWith({
    int? requestID,
    String? path,
    RequestMethod? requestMethod,
    Map<String, String>? headers,
    List<int>? bodyBytes,
    String? bodyString,
    ServiceReponseEncoding? responseEncoding,
    List<int>? errorStatusCodes,
    List<int>? successStatusCodes,
    ServiceReponseEncoding? finalResponseEncoding,
    AlgoApi? api,
  }) {
    return AlgoRequestDetails(
      requestID: requestID ?? this.requestID,
      headers: headers ?? this.headers,
      path: path ?? this.path,
      responseEncoding: responseEncoding ?? this.responseEncoding,
      requestMethod: requestMethod ?? this.requestMethod,
      bodyString: bodyString ?? this.bodyString,
      errorStatusCodes: errorStatusCodes ?? this.errorStatusCodes,
      bodyBytes: bodyBytes ?? this.bodyBytes,
      successStatusCodes: successStatusCodes ?? this.successStatusCodes,
      finalResponseEncoding:
          finalResponseEncoding ?? this.finalResponseEncoding,
      api: api ?? this.api,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'path': path,
      'body': bodyString ?? BytesUtils.tryToHexString(bodyBytes),
      'id': requestID,
      'type': requestMethod.name,
      "api": api.name,
    };
  }

  @override
  Uri encodeUrl(String uri) {
    String url = uri;
    if (url.endsWith('/')) {
      url = url.substring(0, url.length - 1);
    }
    return Uri.parse('$url${path ?? ''}');
  }

  @override
  List<int>? encodeBody({ServiceProtocol protocol = ServiceProtocol.http}) {
    if (!protocol.isHttp) {
      throw const BuError(
        DefaultErrorType.unsupported,
        'Unsupported protocol. Only HTTP is supported by this service.',
      );
    }
    return super.encodeBody(protocol: protocol);
  }

  @override
  SerializationIdentifier get serializationIdentifier =>
      BlockchainNetwork.algorand.identifier;

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
    finalResponseEncoding.value.toCbor(),
    api.value.toCbor(),
  ];
}

enum RequestFormat { msgpack }

enum AlgoApi {
  rest(0),
  indexer(1);

  final int value;
  const AlgoApi(this.value);
  static AlgoApi fromValue(int? value) {
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                'Invalid AlgoApi value.',
                details: {'value': '$value'},
              ),
    );
  }
}

/// An abstract class representing Algorand REST requests with generic response types.
abstract class AlgoRestRequest<RESULT, SERVICERESPONSE>
    extends BaseServiceRequest<RESULT, SERVICERESPONSE, AlgoRequestDetails> {
  const AlgoRestRequest();

  String get path;

  List<int>? body() => null;

  RequestFormat? get responseFormat => null;

  Map<String, String?> get queryParameters => {};
  @override
  AlgoRequestDetails buildRequest(int requestID) {
    final body = this.body();
    String? path = this.path;
    final queryParameters = Map<String, String>.from(
      this.queryParameters.notNullValue,
    );
    if (queryParameters.isNotEmpty) {
      path = Uri(path: path, queryParameters: queryParameters).toString();
    }
    return AlgoRequestDetails(
      requestID: requestID,
      responseEncoding: switch (responseFormat) {
        RequestFormat.msgpack => ServiceReponseEncoding.binary,
        _ => ServiceReponseEncoding.fromType<SERVICERESPONSE>(),
      },
      headers: ServiceConst.defaultPostHeaders,
      finalResponseEncoding: ServiceReponseEncoding.fromType<SERVICERESPONSE>(),
      path: path,
      requestMethod: requestMethod,
      api: AlgoApi.rest,
      bodyBytes: body,
    );
  }

  @override
  RequestMethod get requestMethod => RequestMethod.get;
  @override
  RESULT onResponse(SERVICERESPONSE result);
}

/// An abstract class representing Algorand REST requests with generic response types.
abstract class AlgoIndexerRequest<RESULT, SERVICERESPONSE>
    extends BaseServiceRequest<RESULT, SERVICERESPONSE, AlgoRequestDetails> {
  const AlgoIndexerRequest();

  String get path;

  Map<String, String?> get queryParameters => {};
  @override
  AlgoRequestDetails buildRequest(int requestID) {
    String? path = this.path;
    final queryParameters = Map<String, String>.from(
      this.queryParameters.notNullValue,
    );
    if (queryParameters.isNotEmpty) {
      path = Uri(path: path, queryParameters: queryParameters).toString();
    }
    final encoding = ServiceReponseEncoding.fromType<SERVICERESPONSE>();
    return AlgoRequestDetails(
      requestID: requestID,
      responseEncoding: encoding,
      headers: ServiceConst.defaultPostHeaders,
      finalResponseEncoding: encoding,
      api: AlgoApi.indexer,
      path: path,
      requestMethod: requestMethod,
    );
  }

  @override
  RequestMethod get requestMethod => RequestMethod.get;
  @override
  RESULT onResponse(SERVICERESPONSE result);
}
