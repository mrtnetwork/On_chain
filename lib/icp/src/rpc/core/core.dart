import 'package:blockchain_utils/blockchain_utils.dart';

class ICPRequestDetails extends BaseServiceRequestParams {
  const ICPRequestDetails({
    required super.requestID,
    required String super.path,
    required super.responseEncoding,
    required super.headers,

    super.successStatusCodes,
    super.errorStatusCodes,
    required super.requestMethod,
    super.bodyBytes,
  }) : super(network: BlockchainNetwork.icp, bodyString: null);
  factory ICPRequestDetails.deserialize({List<int>? bytes, CborObject? obj}) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: BlockchainNetwork.icp.identifier,
      cborBytes: bytes,
      cborObject: obj,
    );
    return ICPRequestDetails(
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
      path: values.rawValueAt(6),
      requestID: values.rawValueAt(7),
    );
  }
  ICPRequestDetails copyWith({
    int? requestID,
    String? path,
    RequestMethod? requestMethod,
    Map<String, String>? headers,
    List<int>? bodyBytes,
    ServiceReponseEncoding? responseEncoding,
    List<int>? errorStatusCodes,
    List<int>? successStatusCodes,
  }) {
    return ICPRequestDetails(
      requestID: requestID ?? this.requestID,
      headers: headers ?? this.headers,
      path: path ?? this.path ?? '',
      responseEncoding: responseEncoding ?? this.responseEncoding,
      requestMethod: requestMethod ?? this.requestMethod,
      errorStatusCodes: errorStatusCodes ?? this.errorStatusCodes,
      bodyBytes: bodyBytes ?? this.bodyBytes,
      successStatusCodes: successStatusCodes ?? this.successStatusCodes,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'body': BytesUtils.toHexString(bodyBytes ?? []),
      'id': requestID,
      'type': requestMethod.name,
    };
  }

  @override
  Uri encodeUrl(String uri) {
    if (uri.endsWith("/")) {
      uri = uri.substring(0, uri.length - 1);
    }
    return Uri.parse("$uri/$path");
  }

  @override
  SerializationIdentifier get serializationIdentifier =>
      BlockchainNetwork.icp.identifier;

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
    path?.toCbor(),
    requestID.toCbor(),
  ];
}

abstract class ICPRequest<RESULT>
    extends BaseServiceRequest<RESULT, List<int>, ICPRequestDetails> {
  const ICPRequest();

  String get path;

  Future<List<int>?> body() async => null;
  Map<String, String>? get headers => null;

  @override
  Future<ICPRequestDetails> buildRequest(int requestID) async {
    return ICPRequestDetails(
      requestID: requestID,
      responseEncoding: ServiceReponseEncoding.binary,
      headers: headers ?? ServiceConst.defaultCborHeaders,
      path: path,
      requestMethod: requestMethod,

      bodyBytes: await body(),
    );
  }

  @override
  RequestMethod get requestMethod => RequestMethod.post;
  @override
  RESULT onResponse(List<int> result);
}
