import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/aptos/src/exception/exception.dart';
import 'package:on_chain/aptos/src/provider/constant/constants.dart';
import 'package:on_chain/aptos/src/provider/utils/utils.dart';

enum AptosRequestType {
  fullnode(0),
  graphQl(1);

  final int value;
  const AptosRequestType(this.value);
  static AptosRequestType fromValue(int? value) {
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw ItemNotFoundException(name: "AptosRequestType"),
    );
  }
}

abstract class AptosRequest<RESULT, RESPONSE>
    extends BaseServiceRequest<RESULT, RESPONSE, AptosRequestDetails> {
  AptosRequest();
  @override
  RequestMethod get requestMethod => RequestMethod.get;

  abstract final String method;

  List<String> get pathParameters => [];
  Map<String, String?> get queryParameters => {};

  @override
  AptosRequestDetails buildRequest(int requestID) {
    final pathParams = AptosProviderUtils.extractParams(method);
    if (pathParams.length != pathParameters.length) {
      throw DartAptosPluginException(
        'Invalid Path Parameters.',
        details: {
          'pathParams': pathParameters.length.toString(),
          'ExceptedPathParametersLength': pathParams.length.toString(),
        },
      );
    }
    String params = method;
    for (int i = 0; i < pathParams.length; i++) {
      params = params.replaceFirst(pathParams[i], pathParameters[i]);
    }
    return AptosRequestDetails(
      requestID: requestID,
      path: params,
      responseEncoding: ServiceReponseEncoding.fromType<RESPONSE>(),
      api: AptosRequestType.fullnode,
    );
  }
}

abstract class AptosPostRequest<RESULT, RESPONSE>
    extends AptosRequest<RESULT, RESPONSE> {
  abstract final Object body;

  Map<String, String>? get headers => null;

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  AptosRequestDetails buildRequest(int requestID) {
    final request = super.buildRequest(requestID);
    return request.copyWith(
      bodyBytes: switch (body) {
        List<int> body => body,
        _ => null,
      },
      bodyString: switch (body) {
        List<int> _ => null,
        _ => StringUtils.fromJson(body),
      },
      headers: headers ?? ServiceConst.defaultPostHeaders,
      requestMethod: requestMethod,
      responseEncoding: ServiceReponseEncoding.fromType<RESPONSE>(),
    );
  }
}

abstract class AptosGraphQLRequest<RESULT, RESPONSE>
    extends AptosRequest<RESULT, RESPONSE> {
  Map<String, dynamic> get queryVariables => {};

  Map<String, String>? get headers => null;

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  AptosRequestDetails buildRequest(int requestID) {
    final Map<String, dynamic> body = {
      "query": method,
      "variables": queryVariables,
    };
    return AptosRequestDetails(
      requestID: requestID,
      requestMethod: RequestMethod.post,
      path: '',
      api: AptosRequestType.graphQl,
      headers: headers ?? ServiceConst.defaultPostHeaders,
      bodyString: StringUtils.fromJson(body),
      errorStatusCodes: AptosProviderConst.graphQlErrorStatusCodes,
      responseEncoding: ServiceReponseEncoding.map,
    );
  }
}

class AptosRequestDetails extends BaseServiceRequestParams {
  final AptosRequestType api;

  const AptosRequestDetails({
    required super.requestID,
    required super.path,
    required super.responseEncoding,
    super.headers = const {},
    super.successStatusCodes = AptosProviderConst.successStatusCodes,
    super.errorStatusCodes = AptosProviderConst.errorStatusCodes,
    super.requestMethod = RequestMethod.get,
    super.bodyBytes,
    super.bodyString,
    required this.api,
  }) : super(network: BlockchainNetwork.aptos);
  factory AptosRequestDetails.deserialize({List<int>? bytes, CborObject? obj}) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: BlockchainNetwork.aptos.identifier,
      cborBytes: bytes,
      cborObject: obj,
    );
    return AptosRequestDetails(
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
      api: AptosRequestType.fromValue(values.rawValueAt(9)),
    );
  }
  AptosRequestDetails copyWith({
    int? requestID,
    String? path,
    RequestMethod? requestMethod,
    Map<String, String>? headers,
    List<int>? bodyBytes,
    String? bodyString,
    ServiceReponseEncoding? responseEncoding,
    List<int>? errorStatusCodes,
    List<int>? successStatusCodes,
    AptosRequestType? api,
  }) {
    return AptosRequestDetails(
      requestID: requestID ?? this.requestID,
      headers: headers ?? this.headers,
      path: path ?? this.path,
      responseEncoding: responseEncoding ?? this.responseEncoding,
      requestMethod: requestMethod ?? this.requestMethod,
      bodyString: bodyString ?? this.bodyString,
      errorStatusCodes: errorStatusCodes ?? this.errorStatusCodes,
      bodyBytes: bodyBytes ?? this.bodyBytes,
      successStatusCodes: successStatusCodes ?? this.successStatusCodes,
      api: api ?? this.api,
    );
  }

  @override
  Uri encodeUrl(String uri) {
    if (api == AptosRequestType.graphQl) {
      return Uri.parse(uri);
    }
    String url = uri;
    if (url.endsWith('/')) {
      url = url.substring(0, url.length - 1);
    }

    return Uri.parse('$url${path ?? ''}');
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'path': path,
      'body': bodyString ?? BytesUtils.tryToHexString(bodyBytes),
    };
  }

  @override
  List<int>? encodeBody({ServiceProtocol protocol = ServiceProtocol.http}) {
    assert(protocol.isHttp, "Unsupported porotcol");
    return super.encodeBody(protocol: protocol);
  }

  @override
  SerializationIdentifier get serializationIdentifier =>
      BlockchainNetwork.aptos.identifier;

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
    api.value.toCbor(),
  ];
}
