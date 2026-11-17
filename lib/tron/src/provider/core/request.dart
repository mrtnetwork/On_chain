import 'package:blockchain_utils/blockchain_utils.dart';

enum TronProviderApi {
  fullnode(0),
  grpc(1);

  final int value;
  const TronProviderApi(this.value);

  static TronProviderApi fromValue(int? value) {
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid Tron provider API value.",
              ),
    );
  }
}

abstract class TronRequest<
  RESULT,
  RESPONSE,
  R extends BaseTronServiceRequestParams
>
    extends IServiceRequest<RESULT, RESPONSE, R> {}

abstract class TronFullNodeRequest<RESULT, RESPONSE>
    extends BaseServiceRequest<RESULT, RESPONSE, TronFullNodeRequestDetails> {
  const TronFullNodeRequest();

  /// Indicates whether the address is visible.
  bool? get visible => null;

  /// method for the request.
  String? get path => null;
  Map<String, String?> get queryParameters => {};

  Map<String, dynamic>? body() => null;

  /// Converts the request parameters to [TronFullNodeRequestDetails] with a unique identifier.
  @override
  TronFullNodeRequestDetails buildRequest(int requestID) {
    String? path = this.path;
    if (queryParameters.isNotEmpty) {
      Map<String, dynamic> parameters = {};
      for (final i in queryParameters.entries) {
        final value = i.value;
        if (value == null) continue;
        if (value.contains(",")) {
          parameters[i.key] = value.split(",");
        } else {
          parameters[i.key] = value;
        }
      }
      path = Uri(path: path, queryParameters: parameters).toString();
    }
    List<int>? encodeBody() {
      if (requestMethod.isGet) return null;
      final body = this.body();
      if (body == null) return null;
      return StringUtils.encodeJson(
        body,
        options: JsonEncodeOptions(bigIntEncoding: BigIntEncoding.intOrString),
      );
    }

    final Map<String, String> headers =
        requestMethod.isPost ? ServiceConst.defaultPostHeaders : {};
    final body = encodeBody();
    return TronFullNodeRequestDetails(
      requestID: requestID,
      path: path,
      bodyBytes: body,
      headers: headers,
      requestMethod: requestMethod,
      responseEncoding: ServiceReponseEncoding.fromType<RESPONSE>(),
      method: this.path ?? '',
    );
  }

  @override
  RequestMethod get requestMethod => RequestMethod.post;
}

abstract class BaseTronServiceRequestParams implements IServiceRequestParams {
  final TronProviderApi api;
  const BaseTronServiceRequestParams(this.api);
  factory BaseTronServiceRequestParams.deserialize({
    List<int>? bytes,
    CborObject? obj,
  }) {
    final CborTagValue tag = CborTagSerializable.decode(
      cborBytes: bytes,
      cborObject: obj,
    );
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: BlockchainNetwork.tron.identifier,
      cborObject: tag,
    );
    final type = TronProviderApi.fromValue(values.rawValueAt(0));
    return switch (type) {
      TronProviderApi.fullnode => TronFullNodeRequestDetails.deserialize(
        obj: tag,
      ),
      TronProviderApi.grpc => TronGrpcRequestDetails.deserialize(obj: tag),
    };
  }
  @override
  SerializationIdentifier get serializationIdentifier =>
      BlockchainNetwork.tron.identifier;
}

class TronFullNodeRequestDetails extends BaseServiceRequestParams
    implements BaseTronServiceRequestParams {
  @override
  TronProviderApi get api => TronProviderApi.fullnode;
  final String method;
  const TronFullNodeRequestDetails({
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
  factory TronFullNodeRequestDetails.deserialize({
    List<int>? bytes,
    CborObject? obj,
  }) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: BlockchainNetwork.tron.identifier,
      cborBytes: bytes,
      cborObject: obj,
    );
    return TronFullNodeRequestDetails(
      headers: values
          .mapAt<CborStringValue, CborStringValue>(1)
          .map((k, v) => MapEntry(k.value, v.value)),
      requestMethod: RequestMethod.fromValue(values.rawValueAt(2)),
      responseEncoding: ServiceReponseEncoding.fromValue(values.rawValueAt(3)),
      successStatusCodes:
          values
              .listAt<CborIntValue>(4)
              .map((e) => e.value)
              .toList()
              .emptyAsNull,
      errorStatusCodes:
          values
              .listAt<CborIntValue>(5)
              .map((e) => e.value)
              .toList()
              .emptyAsNull,
      bodyBytes: values.rawValueAt(6),
      bodyString: values.rawValueAt(7),
      path: values.rawValueAt(8),
      requestID: values.rawValueAt(9),
      method: values.rawValueAt(10),
    );
  }
  TronFullNodeRequestDetails copyWith({
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
    return TronFullNodeRequestDetails(
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
    return Uri.parse(ServiceProviderUtils.joinPathWithRoot([uri, path ?? '']));
  }

  @override
  SerializationIdentifier get serializationIdentifier =>
      BlockchainNetwork.tron.identifier;

  @override
  List<CborObject?> get serializationItems => [
    api.value.toCbor(),
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

abstract class TronGrpcRequest<RESULT>
    extends IGRPCServiceRequest<RESULT, TronGrpcRequestDetails>
    implements TronRequest<RESULT, List<int>, TronGrpcRequestDetails> {
  const TronGrpcRequest();
  String get method;

  List<int> toBuffer();

  @override
  TronGrpcRequestDetails buildRequest(int _) {
    return TronGrpcRequestDetails(buffer: toBuffer(), requestMethod: method);
  }
}

class TronGrpcRequestDetails extends BaseTronServiceRequestParams
    with CborTagSerializable
    implements BaseGRPCServiceRequestParams {
  final String requestMethod;
  final BuBytes buffer;

  TronGrpcRequestDetails({
    required List<int> buffer,
    required this.requestMethod,
  }) : buffer = buffer.asImmutableBytes,
       super(TronProviderApi.grpc);
  factory TronGrpcRequestDetails.deserialize({
    List<int>? bytes,
    CborObject? obj,
  }) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: BlockchainNetwork.tron.identifier,
      cborBytes: bytes,
      cborObject: obj,
    );
    return TronGrpcRequestDetails(
      buffer: values.rawValueAt(1),
      requestMethod: values.rawValueAt(2),
    );
  }

  @override
  String method() {
    return requestMethod;
  }

  @override
  BuBytes toBuffer() {
    return buffer;
  }

  @override
  List<CborObject?> get serializationItems => [
    api.value.toCbor(),
    CborBytesValue(buffer),
    requestMethod.toCbor(),
  ];

  @override
  Uri encodeUrl(String uri) {
    return Uri.parse(uri);
  }
}
