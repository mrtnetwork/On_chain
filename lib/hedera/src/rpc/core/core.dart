import 'package:blockchain_utils/api/api.dart';

import 'package:blockchain_utils/encoding/encoding.dart';
import 'package:blockchain_utils/helper/extensions/extensions.dart';
import 'package:blockchain_utils/chain/types/network.dart';
import 'package:blockchain_utils/service/service.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/exception/onchain_error.dart';

abstract class HederaRequest<
  RESULT,
  RESPONSE,
  R extends BaseHederaServiceRequestParams
>
    extends IServiceRequest<RESULT, RESPONSE, R> {}

/// An abstract class representing request parameters for Hedera API calls.
abstract class HederaMirrorRequest<RESULT, RESPONSE>
    extends BaseServiceRequest<RESULT, RESPONSE, HederaMirrorRequestDetails>
    implements HederaRequest<RESULT, RESPONSE, HederaMirrorRequestDetails> {
  const HederaMirrorRequest();
  String? get path;

  List<int>? body() => null;

  Map<String, String?> get queryParameters => {};

  Map<String, String> get headers => {};

  /// Converts the request parameters to [HederaMirrorRequestDetails] with a unique identifier.
  @override
  HederaMirrorRequestDetails buildRequest(int id) {
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
    return HederaMirrorRequestDetails(
      requestID: id,
      path: path,
      requestMethod: requestMethod,
      bodyBytes: requestMethod.isPost ? body() : null,
      responseEncoding: ServiceReponseEncoding.map,
      headers: headers,
    );
  }

  @override
  RequestMethod get requestMethod => RequestMethod.get;
}

abstract class HederaGrpcRequest<RESULT>
    extends IGRPCServiceRequest<RESULT, HederaGrpcRequestDetails>
    implements HederaRequest<RESULT, List<int>, HederaGrpcRequestDetails> {
  const HederaGrpcRequest();
  String get method;

  List<int> toBuffer();

  @override
  HederaGrpcRequestDetails buildRequest(int _) {
    return HederaGrpcRequestDetails(buffer: toBuffer(), requestMethod: method);
  }
}

enum HederaProviderApi {
  mirror(0),
  grpc(1);

  final int value;
  const HederaProviderApi(this.value);

  static HederaProviderApi fromValue(int? value) {
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw OnChainErrors.hederaPlugin(
                "HederaProviderApi.fromValue",
                reason: "Invalid Hedera provider API value.",
                details: {"value": "$value"},
              ),
    );
  }
}

abstract class BaseHederaServiceRequestParams implements IServiceRequestParams {
  final HederaProviderApi api;
  const BaseHederaServiceRequestParams(this.api);
  factory BaseHederaServiceRequestParams.deserialize({
    List<int>? bytes,
    CborObject? obj,
  }) {
    final CborTagValue tag = CborTagSerializable.decode(
      cborBytes: bytes,
      cborObject: obj,
    );
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: BlockchainNetwork.hedera.identifier,
      cborObject: tag,
    );
    final type = HederaProviderApi.fromValue(values.rawValueAt(0));
    return switch (type) {
      HederaProviderApi.mirror => HederaMirrorRequestDetails.deserialize(
        obj: tag,
      ),
      HederaProviderApi.grpc => HederaGrpcRequestDetails.deserialize(obj: tag),
    };
  }
  @override
  SerializationIdentifier get serializationIdentifier =>
      BlockchainNetwork.hedera.identifier;
}

class HederaMirrorRequestDetails extends BaseServiceRequestParams
    implements BaseHederaServiceRequestParams {
  @override
  final HederaProviderApi api = HederaProviderApi.mirror;
  const HederaMirrorRequestDetails({
    required super.requestID,
    required super.path,
    required super.responseEncoding,
    super.requestMethod = RequestMethod.get,
    super.errorStatusCodes = const [400, 404, 500],
    super.headers = const {},
    super.bodyBytes,
  }) : super(bodyString: null, network: BlockchainNetwork.hedera);

  factory HederaMirrorRequestDetails.deserialize({
    List<int>? bytes,
    CborObject? obj,
  }) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: BlockchainNetwork.hedera.identifier,
      cborBytes: bytes,
      cborObject: obj,
    );
    return HederaMirrorRequestDetails(
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
  HederaMirrorRequestDetails copyWith({
    int? requestID,
    String? path,
    Map<String, String>? headers,
    ServiceReponseEncoding? responseEncoding,
    RequestMethod? requestMethod,
    List<int>? bodyBytes,
    List<int>? errorStatusCodes,
  }) {
    return HederaMirrorRequestDetails(
      requestID: requestID ?? this.requestID,
      headers: headers ?? this.headers,
      path: path ?? this.path,
      responseEncoding: responseEncoding ?? this.responseEncoding,
      requestMethod: requestMethod ?? this.requestMethod,
      bodyBytes: bodyBytes ?? this.bodyBytes,
      errorStatusCodes: errorStatusCodes ?? this.errorStatusCodes,
    );
  }

  @override
  Uri encodeUrl(String uri) {
    if (uri.endsWith("/")) {
      uri = uri.substring(0, uri.length - 1);
    }
    return Uri.parse("$uri${path ?? ''}");
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'path': path,
      'body': bodyString ?? BytesUtils.tryToHexString(bodyBytes),
      "api": api.name,
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
      BlockchainNetwork.hedera.identifier;
}

class HederaGrpcRequestDetails extends BaseHederaServiceRequestParams
    with CborTagSerializable
    implements BaseGRPCServiceRequestParams {
  final String requestMethod;
  final BuBytes buffer;

  HederaGrpcRequestDetails({
    required List<int> buffer,
    required this.requestMethod,
  }) : buffer = buffer.asImmutableBytes,
       super(HederaProviderApi.grpc);
  factory HederaGrpcRequestDetails.deserialize({
    List<int>? bytes,
    CborObject? obj,
  }) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: BlockchainNetwork.hedera.identifier,
      cborBytes: bytes,
      cborObject: obj,
    );
    return HederaGrpcRequestDetails(
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
