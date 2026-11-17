import 'package:blockchain_utils/blockchain_utils.dart';

enum OctezApiType {
  shell(0),
  mempool(1),
  ushuaia(2),
  rollup(3);

  final int value;
  const OctezApiType(this.value);
  static OctezApiType fromValue(int? value) {
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid Octez API type.",
              ),
    );
  }
}

abstract class BaseOctezRequest<RESULT, RESPONSE>
    extends BaseServiceRequest<RESULT, RESPONSE, OctezRequestDetails> {
  const BaseOctezRequest(this.api);
  final OctezApiType api;

  String? get path;

  dynamic body() => null;
  Map<String, String?> get queryParameters => {};

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  /// Converts the request parameters to [OctezRequestDetails] with a unique identifier.
  @override
  OctezRequestDetails buildRequest(int id) {
    List<int>? encodeBody() {
      if (requestMethod.isGet) return null;
      final body = this.body();
      if (body == null) return null;
      if (body is String) return StringUtils.encode(StringUtils.fromJson(body));
      if (body is List<int>) return body;
      return StringUtils.encodeJson(body);
    }

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
    final Map<String, String> headers =
        requestMethod.isPost ? ServiceConst.defaultPostHeaders : {};
    final body = encodeBody();
    return OctezRequestDetails(
      requestID: id,
      path: path,
      requestMethod: requestMethod,
      bodyBytes: body,
      responseEncoding: ServiceReponseEncoding.fromType<RESPONSE>(),
      headers: headers,
      api: api,
    );
  }
}

/// Request parameters for Octez (Tezos) REST calls.
abstract class OctezShellRequest<RESULT, RESPONSE>
    extends BaseOctezRequest<RESULT, RESPONSE> {
  const OctezShellRequest() : super(OctezApiType.shell);
}

abstract class OctezMempoolRequest<RESULT, RESPONSE>
    extends BaseOctezRequest<RESULT, RESPONSE> {
  const OctezMempoolRequest() : super(OctezApiType.mempool);
}

abstract class OctezUshuaiaRequest<RESULT, RESPONSE>
    extends BaseOctezRequest<RESULT, RESPONSE> {
  const OctezUshuaiaRequest() : super(OctezApiType.ushuaia);
}

abstract class OctezRollupRequest<RESULT, RESPONSE>
    extends BaseOctezRequest<RESULT, RESPONSE> {
  const OctezRollupRequest() : super(OctezApiType.rollup);
}

/// Request-scoped parameters for Octez (Tezos) REST calls.
abstract class BaseOctezServiceRequestParams
    implements BaseServiceRequestParams {
  final OctezApiType api;
  const BaseOctezServiceRequestParams(this.api);
  factory BaseOctezServiceRequestParams.deserialize({
    List<int>? bytes,
    CborObject? obj,
  }) {
    final CborTagValue tag = CborTagSerializable.decode(
      cborBytes: bytes,
      cborObject: obj,
    );
    return OctezRequestDetails.deserialize(obj: tag);
  }
  @override
  SerializationIdentifier get serializationIdentifier =>
      BlockchainNetwork.tezos.identifier;
}

class OctezRequestDetails extends BaseServiceRequestParams
    implements BaseOctezServiceRequestParams {
  @override
  final OctezApiType api;
  const OctezRequestDetails({
    required super.requestID,
    super.path,
    required super.responseEncoding,
    super.requestMethod = RequestMethod.get,
    super.errorStatusCodes,
    super.headers = const {},
    required this.api,
    super.bodyBytes,
  }) : super(bodyString: null, network: BlockchainNetwork.tezos);

  factory OctezRequestDetails.deserialize({List<int>? bytes, CborObject? obj}) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: BlockchainNetwork.tezos.identifier,
      cborBytes: bytes,
      cborObject: obj,
    );
    return OctezRequestDetails(
      api: OctezApiType.fromValue(values.rawValueAt(0)),
      headers: values
          .mapAt<CborStringValue, CborStringValue>(1)
          .map((k, v) => MapEntry(k.value, v.value)),
      responseEncoding: ServiceReponseEncoding.fromValue(values.rawValueAt(2)),
      path: values.rawValueAt(3),
      requestID: values.rawValueAt(4),
      requestMethod: RequestMethod.fromValue(values.rawValueAt(5)),
      bodyBytes: values.rawValueAt(6),
      errorStatusCodes:
          values
              .listAt<CborIntValue>(7)
              .map((e) => e.value)
              .toList()
              .emptyAsNull,
    );
  }
  OctezRequestDetails copyWith({
    int? requestID,
    String? path,
    Map<String, String>? headers,
    ServiceReponseEncoding? responseEncoding,
    RequestMethod? requestMethod,
    List<int>? bodyBytes,
    List<int>? errorStatusCodes,
    OctezApiType? api,
  }) {
    return OctezRequestDetails(
      requestID: requestID ?? this.requestID,
      headers: headers ?? this.headers,
      path: path ?? this.path,
      responseEncoding: responseEncoding ?? this.responseEncoding,
      requestMethod: requestMethod ?? this.requestMethod,
      bodyBytes: bodyBytes ?? this.bodyBytes,
      errorStatusCodes: errorStatusCodes ?? this.errorStatusCodes,
      api: api ?? this.api,
    );
  }

  @override
  Uri encodeUrl(String uri) {
    final path = this.path;
    if (path == null) return Uri.parse(uri);
    return Uri.parse(ServiceProviderUtils.joinPathWithRoot([uri, path]));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'api': api.name,
      'path': path,
      'body': bodyString ?? BytesUtils.tryToHexString(bodyBytes),
    };
  }

  @override
  List<CborObject?> get serializationItems => [
    api.value.toCbor(),
    CborMapValue.definite(
      headers.map((k, v) => MapEntry(CborStringValue(k), CborStringValue(v))),
    ),
    responseEncoding.value.toCbor(),
    path?.toCbor(),
    requestID.toCbor(),
    requestMethod.value.toCbor(),
    bodyBytes?.toCborBytes(),
    CborTagSerializable.listFromDynamic(
      errorStatusCodes?.map((e) => CborIntValue(e)).toList() ?? [],
    ),
  ];

  @override
  SerializationIdentifier get serializationIdentifier =>
      BlockchainNetwork.tezos.identifier;
}
