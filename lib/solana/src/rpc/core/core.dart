import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';

class ResultWithContext<T> {
  const ResultWithContext({required this.result, required this.context});
  final T result;
  final Context? context;
}

class SolanaRequestDetails extends BaseServiceRequestParams {
  const SolanaRequestDetails({
    required super.requestID,
    super.path,
    required super.responseEncoding,
    required super.headers,
    required this.method,
    super.successStatusCodes,
    super.errorStatusCodes,
    super.requestMethod = RequestMethod.post,
    super.bodyBytes,
    super.bodyString,
  }) : super(network: BlockchainNetwork.solana);
  factory SolanaRequestDetails.deserialize({
    List<int>? bytes,
    CborObject? obj,
  }) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: BlockchainNetwork.solana.identifier,
      cborBytes: bytes,
      cborObject: obj,
    );
    return SolanaRequestDetails(
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
  SolanaRequestDetails copyWith({
    int? requestID,
    String? path,
    RequestMethod? requestMethod,
    Map<String, String>? headers,
    List<int>? bodyBytes,
    String? bodyString,
    ServiceReponseEncoding? responseEncoding,
    List<int>? errorStatusCodes,
    List<int>? successStatusCodes,
    SolanaRequestDetails? api,
    String? method,
  }) {
    return SolanaRequestDetails(
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

  /// The Ethereum method name for the request.
  final String method;

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
    assert(protocol.isHttp, "Unsupported protocol.");
    return super.encodeBody(protocol: protocol);
  }

  @override
  SerializationIdentifier get serializationIdentifier =>
      BlockchainNetwork.solana.identifier;

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

/// An abstract class representing Solana JSON-RPC requests with generic response types.
abstract class SolanaRequest<RESULT, SERVICERESPONSE>
    extends BaseServiceRequest<RESULT, SERVICERESPONSE, SolanaRequestDetails> {
  const SolanaRequest({this.minContextSlot, this.commitment, this.encoding});

  /// The Solana method associated with the request.
  abstract final String method;

  /// The desired commitment level for the request.
  final Commitment? commitment;

  /// The minimum context slot for the request.
  final MinContextSlot? minContextSlot;

  /// The encoding format of the data.
  final SolanaRequestEncoding? encoding;

  /// Converts the request parameters to a JSON representation.
  List<dynamic> toJson();

  /// Converts the request parameters to a [SolanaRequestDetails] object.
  @override
  SolanaRequestDetails buildRequest(int requestID) {
    final List<dynamic> inJson = toJson();
    inJson.removeWhere((v) => v == null);

    return SolanaRequestDetails(
      requestID: requestID,
      bodyString: StringUtils.fromJson(
        ServiceProviderUtils.buildJsonRPCParams(
          requestId: requestID,
          method: method,
          params: inJson,
        ),
      ),
      responseEncoding: ServiceReponseEncoding.map,
      method: method,
      headers: ServiceConst.defaultPostHeaders,
      requestMethod: requestMethod,
    );
  }

  @override
  RequestMethod get requestMethod => RequestMethod.post;
}
