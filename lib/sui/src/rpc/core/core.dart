import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/sui/src/rpc/core/request.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';

class SuiRequestDetails extends BaseServiceRequestParams
    implements BaseSuiServiceRequestParams {
  @override
  SuiProviderApi get api => SuiProviderApi.jsonRpc;
  final String method;
  const SuiRequestDetails({
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
  }) : super(network: BlockchainNetwork.sui);
  factory SuiRequestDetails.deserialize({List<int>? bytes, CborObject? obj}) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: BlockchainNetwork.sui.identifier,
      cborBytes: bytes,
      cborObject: obj,
    );
    return SuiRequestDetails(
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
  SuiRequestDetails copyWith({
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
    return SuiRequestDetails(
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
  List<int>? encodeBody({ServiceProtocol protocol = ServiceProtocol.http}) {
    if (!protocol.isHttp) {
      throw const BuError(
        DefaultErrorType.unsupported,
        "Unsupported protocol.",
      );
    }
    return super.encodeBody(protocol: protocol);
  }

  @override
  SerializationIdentifier get serializationIdentifier =>
      BlockchainNetwork.sui.identifier;

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

/// An abstract class representing Sui JSON-RPC requests with generic response types.
abstract class SuiRequest<RESULT, SERVICERESPONSE>
    extends BaseServiceRequest<RESULT, SERVICERESPONSE, SuiRequestDetails> {
  const SuiRequest({this.pagination});

  final SuiApiRequestPagination? pagination;

  /// The Sui method associated with the request.
  abstract final String method;

  /// Converts the request parameters to a JSON representation.
  List<dynamic> toJson();

  /// Converts the request parameters to a [SuiRequestDetails] object.
  @override
  SuiRequestDetails buildRequest(int requestID) {
    final List<dynamic> inJson = toJson();
    return SuiRequestDetails(
      requestID: requestID,
      bodyString: StringUtils.fromJson(
        ServiceProviderUtils.buildJsonRPCParams(
          requestId: requestID,
          method: method,
          params: inJson,
        ),
      ),
      method: method,
      headers: ServiceConst.defaultPostHeaders,
      responseEncoding: ServiceReponseEncoding.map,
      requestMethod: requestMethod,
    );
  }

  @override
  RequestMethod get requestMethod => RequestMethod.post;
}
